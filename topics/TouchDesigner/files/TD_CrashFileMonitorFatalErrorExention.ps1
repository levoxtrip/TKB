# TouchDesigner Auto-Restart Monitor Script

# Configuration
$touchDesignerPath = "C:\Program Files\Derivative\TouchDesigner\bin\TouchDesigner.exe"  # Default TD install path
$projectFile = "C:\Path\To\Your\Project.toe"  # CHANGE THIS to your .toe file path
$processName = "TouchDesigner"  # Process name in Task Manager
$checkInterval = 10  # Check every 10 seconds
$performMode = $false  # Set to $true to launch in perform mode

# Build launch arguments
$arguments = @()
if ($projectFile -ne "") {
    $arguments += "`"$projectFile`""
}
if ($performMode) {
    $arguments += "-perform"
}

# Don't add window mode arguments - let TD handle this internally

$argString = $arguments -join " "

Write-Host "================================" -ForegroundColor Cyan
Write-Host "TouchDesigner Auto-Restart Monitor" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host "TD Path: $touchDesignerPath" -ForegroundColor White
Write-Host "Project: $projectFile" -ForegroundColor White
Write-Host "Perform Mode: $performMode" -ForegroundColor White
Write-Host "Check Interval: $checkInterval seconds" -ForegroundColor White
Write-Host "--------------------------------" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop monitoring" -ForegroundColor Yellow
Write-Host ""

# Function to check if TouchDesigner is responding and check for crash dialogs
function Test-ProcessResponding {
    param($processName)
    
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process) {
        # Check if the process is responding (not frozen)
        if ($process.Responding -eq $false) {
            return $false
        }
        return $true
    }
    return $false
}

# Function to check for and close error dialogs
function Close-ErrorDialogs {
    # Check for common TouchDesigner error dialog windows
    $errorWindows = @(
        "Fatal Error",
        "TouchDesigner Error", 
        "TouchDesigner has stopped working",
        "Microsoft Visual C++ Runtime Library",
        "Assertion Failed",
        "CrashAutoSave"
    )
    
    foreach ($title in $errorWindows) {
        # Use Windows Forms to find and close dialog boxes
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
            # Send WM_CLOSE message to close the window
            [Win32]::PostMessage($window, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null
            return $true
        }
    }
    return $false
}

# Main monitoring loop
while ($true) {
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    
    # First, check for error dialogs
    $hadErrorDialog = Close-ErrorDialogs
    
    # Check if TouchDesigner process exists
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    
    if (-not $process) {
        Write-Host "$timestamp : TouchDesigner is not running. Starting..." -ForegroundColor Red
        
        try {
            if ($argString) {
                Start-Process -FilePath $touchDesignerPath -ArgumentList $argString
            } else {
                Start-Process -FilePath $touchDesignerPath
            }
            Write-Host "$timestamp : TouchDesigner started successfully" -ForegroundColor Green
            
            # Give TD time to fully load
            Write-Host "$timestamp : Waiting for TouchDesigner to initialize..." -ForegroundColor Gray
            Start-Sleep -Seconds 5
        }
        catch {
            Write-Host "$timestamp : Failed to start TouchDesigner - $_" -ForegroundColor Red
        }
    }
    elseif ($hadErrorDialog) {
        # If we closed an error dialog, kill TD and restart
        Write-Host "$timestamp : Fatal error detected. Force closing TouchDesigner..." -ForegroundColor Red
        
        try {
            Stop-Process -Name $processName -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
            
            # Check if crash dump file exists and log it
            $crashDumpPath = "$env:TEMP\TouchDesignerCrash*.dmp"
            if (Test-Path $crashDumpPath) {
                Write-Host "$timestamp : Crash dump found at $crashDumpPath" -ForegroundColor Yellow
            }
            
            # Restart TouchDesigner
            if ($argString) {
                Start-Process -FilePath $touchDesignerPath -ArgumentList $argString
            } else {
                Start-Process -FilePath $touchDesignerPath
            }
            Write-Host "$timestamp : TouchDesigner restarted after fatal error" -ForegroundColor Green
            Start-Sleep -Seconds 5
        }
        catch {
            Write-Host "$timestamp : Error handling crashed process - $_" -ForegroundColor Red
        }
    }
    elseif ($process.Responding -eq $false) {
        Write-Host "$timestamp : TouchDesigner is not responding (frozen). Restarting..." -ForegroundColor Yellow
        
        # Kill the frozen process
        try {
            Stop-Process -Name $processName -Force
            Start-Sleep -Seconds 2
            
            # Restart TouchDesigner
            if ($argString) {
                Start-Process -FilePath $touchDesignerPath -ArgumentList $argString
            } else {
                Start-Process -FilePath $touchDesignerPath
            }
            Write-Host "$timestamp : TouchDesigner restarted after freeze" -ForegroundColor Green
            Start-Sleep -Seconds 5
        }
        catch {
            Write-Host "$timestamp : Error handling frozen process - $_" -ForegroundColor Red
        }
    }
    else {
        # TouchDesigner is running normally
        $cpuUsage = [math]::Round($process.CPU, 2)
        $memoryMB = [math]::Round($process.WorkingSet64 / 1MB, 2)
        
        # Check MainWindowTitle to see if there might be a hidden error
        if ($process.MainWindowTitle -like "*Error*" -or $process.MainWindowTitle -like "*Fatal*") {
            Write-Host "$timestamp : Possible error window detected in title: $($process.MainWindowTitle)" -ForegroundColor Yellow
        } else {
            Write-Host "$timestamp : TD Running - PID: $($process.Id) | CPU: $cpuUsage | Memory: $memoryMB MB" -ForegroundColor DarkGray
        }
    }
    
    # Wait for the specified interval
    Start-Sleep -Seconds $checkInterval
}