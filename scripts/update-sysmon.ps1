param (
    [string]$ConfigUrl,
    [string]$SysmonPath = "C:\Program Files\Sysmon"
)

# Create log directory if it doesn't exist
if (!(Test-Path "$SysmonPath")) {
    New-Item -ItemType Directory -Path "$SysmonPath" -Force
}

# Download the latest configuration
Invoke-WebRequest -Uri $ConfigUrl -OutFile "$env:TEMP\sysmon_config.xml"

# Apply the new configuration
& "$SysmonPath\sysmon.exe" -c "$env:TEMP\sysmon_config.xml"

# Log the update
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path "$SysmonPath\update_log.txt" -Value "$timestamp - Updated Sysmon configuration"

Write-Output "Sysmon configuration updated successfully"
