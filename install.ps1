param(
    [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

$source = Join-Path $PSScriptRoot "config.toml"
$codexDir = Join-Path $HOME ".codex"
$target = Join-Path $codexDir "config.toml"
$rulesDir = Join-Path $codexDir "rules"
$defaultRules = Join-Path $rulesDir "default.rules"

if (-not (Test-Path -LiteralPath $source)) {
    throw "Source config not found: $source"
}

New-Item -ItemType Directory -Force -Path $codexDir | Out-Null

if ((Test-Path -LiteralPath $target) -and -not $NoBackup) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backup = "$target.bak-$timestamp"
    Copy-Item -LiteralPath $target -Destination $backup
    Write-Host "Backed up existing config to $backup"
}

Copy-Item -LiteralPath $source -Destination $target -Force
Write-Host "Installed Codex config to $target"

if (Test-Path -LiteralPath $defaultRules) {
    if (-not $NoBackup) {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $rulesBackup = "$defaultRules.bak-$timestamp"
        Copy-Item -LiteralPath $defaultRules -Destination $rulesBackup
        Write-Host "Backed up existing approval rules to $rulesBackup"
    }

    Remove-Item -LiteralPath $defaultRules -Force
    Write-Host "Removed approval prefix rules from $defaultRules"
}
