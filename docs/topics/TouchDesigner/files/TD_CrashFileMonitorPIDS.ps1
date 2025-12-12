# TouchDesigner Auto-Restart Monitor Script (Multi-Instance)

# Configuration
$touchDesignerPath = "C:\Program Files\Derivative\TouchDesigner.2023.11600\bin\TouchDesigner.exe"
$checkInterval = 10  # Check every 10 seconds

# Tracked instances: [ProcessId] = @{ProjectFile, PerformMode, LastSeen}
$trackedInstances = @{}

Write-Host "================================" -ForegroundColor Cyan
Write-Host "TouchDesigner Auto-Restart Monitor" -ForegroundColor Cyan
Write-Host "Multi-Instance Support" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host "TD Path: $touchDesignerPath" -ForegroundColor White
Write-Host "Check Interval: $checkInterval seconds" -ForegroundColor White
Write-Host "--------------------------------" -ForegroundColor Cyan
Write-Host "This script will monitor ALL TouchDesigner instances" -ForegroundColor Yellow
Write-Host "and restart any that crash with their original project files." -ForegroundColor Yellow
Write-Host "Press Ctrl+C to stop monitoring" -ForegroundColor Yellow
Write-Host ""

# Function to get command line arguments for a process
function Get-ProcessCommandLine {
    param($processId)
    
    try {
        $wmi = Get-WmiObject Win32_Process -Filter "ProcessId = $processId"
        return $wmi.CommandLine
    }
    catch {
        return $null
    }
}

# Function to parse project file from command line
function Get-ProjectFileFromCommandLine {
    param($commandLine)
    
    if (-not $commandLine) { return $null }
    
    # Look for .toe file in command line
    if ($commandLine -match '"([^"]+\.toe)"') {
        return $matches[1]
    }
    elseif ($commandLine -match '\s([^\s]+\.toe)') {
        return $matches[1]
    }
    
    return $null
}

# Function to check if process is in perform mode
function Test-PerformMode {
    param($commandLine)
    
    if (-not $commandLine) { return $false }
    return $commandLine -match '-perform'
}

# Function to close error dialogs
function Close-ErrorDialogs {
    $errorWindows = @(
        "Fatal Error",
        "TouchDesigner Error", 
        "TouchDesigner has stopped working",
        "Microsoft Visual C++ Runtime Library",
        "Assertion Failed",
        "CrashAutoSave"
    )
    
    $foundDialog = $false
    foreach ($title in $errorWindows) {
        Add-Type @"
            using System;
            using System.Runtime.InteropServices;
            public class Win32 {
                [DllImport("user32.dll")]
                public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
                [DllImport("user32.dll")]
                public static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
            }
"@ -ErrorAction SilentlyContinue
        
        $window = [Win32]::FindWindow($null, $title)
        if ($window -ne [IntPtr]::Zero) {
            Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') : Found error dialog: $title - Closing it..." -ForegroundColor Yellow
            [Win32]::PostMessage($window, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null
            $foundDialog = $true
        }
    }
    return $foundDialog
}

# Function to restart a TouchDesigner instance
function Restart-TouchDesignerInstance {
    param($projectFile, $performMode)
    
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    
    $arguments = @()
    if ($projectFile -and (Test-Path $projectFile)) {
        $arguments += "`"$projectFile`""
        Write-Host "$timestamp : Restarting with project: $projectFile" -ForegroundColor Green
    }
    else {
        Write-Host "$timestamp : Restarting TouchDesigner (no project file)" -ForegroundColor Green
    }
    
    if ($performMode) {
        $arguments += "-perform"
        Write-Host "$timestamp : Perform mode enabled" -ForegroundColor Green
    }
    
    try {
        if ($arguments.Count -gt 0) {
            $argString = $arguments -join " "
            Start-Process -FilePath $touchDesignerPath -ArgumentList $argString
        }
        else {
            Start-Process -FilePath $touchDesignerPath
        }
        
        Start-Sleep -Seconds 5
        return $true
    }
    catch {
        Write-Host "$timestamp : Failed to restart TouchDesigner - $_" -ForegroundColor Red
        return $false
    }
}

# Main monitoring loop
while ($true) {
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    
    # Check for error dialogs first
    $hadErrorDialog = Close-ErrorDialogs
    
    # Get all currently running TouchDesigner processes
    $currentProcesses = @(Get-Process -Name "TouchDesigner" -ErrorAction SilentlyContinue)
    $currentPids = $currentProcesses | ForEach-Object { $_.Id }
    
    # Update tracked instances with current processes
    foreach ($proc in $currentProcesses) {
        if (-not $trackedInstances.ContainsKey($proc.Id)) {
            # New instance detected - add to tracking
            $commandLine = Get-ProcessCommandLine -processId $proc.Id
            $projectFile = Get-ProjectFileFromCommandLine -commandLine $commandLine
            $performMode = Test-PerformMode -commandLine $commandLine
            
            $trackedInstances[$proc.Id] = @{
                ProjectFile = $projectFile
                PerformMode = $performMode
                LastSeen = Get-Date
                Responding = $true
            }
            
            $projectInfo = if ($projectFile) { $projectFile } else { "No project file" }
            Write-Host "$timestamp : New TD instance detected - PID: $($proc.Id) | $projectInfo" -ForegroundColor Cyan
        }
        else {
            # Update last seen time
            $trackedInstances[$proc.Id].LastSeen = Get-Date
            $trackedInstances[$proc.Id].Responding = $proc.Responding
        }
        
        # Check if frozen
        if ($proc.Responding -eq $false) {
            Write-Host "$timestamp : TD PID $($proc.Id) is frozen. Force closing..." -ForegroundColor Yellow
            
            $instanceInfo = $trackedInstances[$proc.Id]
            Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
            
            # Restart with same parameters
            Restart-TouchDesignerInstance -projectFile $instanceInfo.ProjectFile -performMode $instanceInfo.PerformMode
            
            # Remove from tracking (will be re-added when new process starts)
            $trackedInstances.Remove($proc.Id)
        }
        else {
            # Display status
            try {
                $cpuValue = if ($proc.CPU) { $proc.CPU } else { 0 }
                $cpuUsage = [math]::Round($cpuValue, 2)
                $memoryMB = [math]::Round($proc.WorkingSet64 / 1MB, 2)
                
                $projectInfo = if ($trackedInstances[$proc.Id].ProjectFile) { 
                    Split-Path $trackedInstances[$proc.Id].ProjectFile -Leaf 
                } else { 
                    "No project" 
                }
                
                Write-Host "$timestamp : TD PID: $($proc.Id) | $projectInfo | CPU: $cpuUsage | Memory: $memoryMB MB" -ForegroundColor DarkGray
            }
            catch {
                Write-Host "$timestamp : Error reading process info for PID $($proc.Id)" -ForegroundColor Red
            }
        }
    }
    
    # Check for crashed instances (tracked but no longer running)
    $trackedPids = @($trackedInstances.Keys)
    foreach ($processId in $trackedPids) {
        if ($processId -notin $currentPids) {
            # Instance crashed or closed
            $instanceInfo = $trackedInstances[$processId]
            $timeSinceLastSeen = (Get-Date) - $instanceInfo.LastSeen
            
            # Only restart if it disappeared within the last check interval + buffer
            if ($timeSinceLastSeen.TotalSeconds -lt ($checkInterval + 5)) {
                $projectInfo = if ($instanceInfo.ProjectFile) { $instanceInfo.ProjectFile } else { "No project file" }
                Write-Host "$timestamp : TD instance crashed - PID: $processId | $projectInfo" -ForegroundColor Red
                
                # Restart the instance
                Restart-TouchDesignerInstance -projectFile $instanceInfo.ProjectFile -performMode $instanceInfo.PerformMode
            }
            
            # Remove from tracking
            $trackedInstances.Remove($processId)
        }
    }
    
    # If error dialog was found, force close all TD instances and restart them
    if ($hadErrorDialog) {
        Write-Host "$timestamp : Fatal error dialog detected. Restarting all instances..." -ForegroundColor Red
        
        $instancesToRestart = @()
        foreach ($processId in $trackedInstances.Keys) {
            $instancesToRestart += $trackedInstances[$processId]
        }
        
        # Force close all
        Stop-Process -Name "TouchDesigner" -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 3
        
        # Restart all instances
        foreach ($instance in $instancesToRestart) {
            Restart-TouchDesignerInstance -projectFile $instance.ProjectFile -performMode $instance.PerformMode
            Start-Sleep -Seconds 2  # Stagger restarts slightly
        }
        
        $trackedInstances.Clear()
    }
    
    # Display summary
    if ($currentProcesses.Count -eq 0 -and $trackedInstances.Count -eq 0) {
        Write-Host "$timestamp : No TouchDesigner instances running or tracked" -ForegroundColor Yellow
    }
    
    Start-Sleep -Seconds $checkInterval
}