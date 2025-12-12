# TouchDesigner Auto-Restart Monitor Script

# Configuration
$touchDesignerPath = "C:\Program Files\Derivative\TouchDesigner.2023.11600\bin\TouchDesigner.exe"  # Default TD install path
$projectFile = "C:\Users\LXT\Desktop\NewProject.toe"  # CHANGE THIS to your .toe file path
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

# Function to check if TouchDesigner is responding
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

# Main monitoring loop
while ($true) {
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    
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
        Write-Host "$timestamp : TD Running - PID: $($process.Id) | CPU: $cpuUsage | Memory: $memoryMB MB" -ForegroundColor DarkGray
    }
    
    # Wait for the specified interval
    Start-Sleep -Seconds $checkInterval
}