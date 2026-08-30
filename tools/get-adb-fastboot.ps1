<#
Download and install adb.exe and fastboot.exe into this tools/ folder.
Usage (from repository root):
  PowerShell -NoProfile -ExecutionPolicy Bypass -File .\tools\get-adb-fastboot.ps1
This script does NOT auto-run; run it manually when ready.
#>

$ErrorActionPreference = 'Stop'

$zipUrl = 'https://dl.google.com/android/repository/platform-tools-latest-windows.zip'
$tempZip = Join-Path $env:TEMP 'platform-tools-latest-windows.zip'
$extractDir = Join-Path $env:TEMP 'platform-tools-extract'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host "Downloading platform-tools from $zipUrl ..."
Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip -UseBasicParsing

if (Test-Path $extractDir) { Remove-Item -Recurse -Force $extractDir }
Expand-Archive -Path $tempZip -DestinationPath $extractDir -Force

$platformToolsDir = Join-Path $extractDir 'platform-tools'
$adbSrc = Join-Path $platformToolsDir 'adb.exe'
$fastbootSrc = Join-Path $platformToolsDir 'fastboot.exe'

if (!(Test-Path $adbSrc) -or !(Test-Path $fastbootSrc)) {
    Write-Error "Expected adb.exe and fastboot.exe not found in the archive. Aborting."
    Remove-Item -Force $tempZip -ErrorAction SilentlyContinue
    exit 1
}

Write-Host "Copying adb and fastboot to $scriptDir ..."
Copy-Item -Path $adbSrc -Destination (Join-Path $scriptDir 'adb.exe') -Force
Copy-Item -Path $fastbootSrc -Destination (Join-Path $scriptDir 'fastboot.exe') -Force

# Cleanup
Remove-Item -Force $tempZip -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force $extractDir -ErrorAction SilentlyContinue

Write-Host "Done. adb.exe and fastboot.exe are in: $scriptDir"
Write-Host "Run '.\tools\adb.exe devices' to verify a working ADB binary."