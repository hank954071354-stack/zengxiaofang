param(
    [string]$SourceRoot = "",
    [string]$RemoteUrl = "https://github.com/hank954071354-stack/zengxiaofang.git",
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$prepareScript = Join-Path $PSScriptRoot "prepare_public_snapshot.ps1"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git is not installed or is not available in PATH. Install Git for Windows first, then reopen PowerShell."
}

Set-Location $repoRoot

if ([string]::IsNullOrWhiteSpace($SourceRoot)) {
    throw "SourceRoot is required in this repo copy. Example: -SourceRoot 'D:\\工作\\曾晓芳'"
}

powershell.exe -ExecutionPolicy Bypass -File $prepareScript -SourceRoot $SourceRoot

if (-not (Test-Path -LiteralPath (Join-Path $repoRoot ".git"))) {
    git init
    git branch -M $Branch
}

$remote = git remote
if ($remote -notcontains "origin") {
    git remote add origin $RemoteUrl
}

git add -A

$status = git status --porcelain
if (-not $status) {
    Write-Host "No public changes to upload."
    exit 0
}

$message = "Daily desensitized update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $message

try {
    git pull --rebase origin $Branch
}
catch {
    Write-Host "Pull skipped or failed. Continuing with push attempt."
}

git push -u origin $Branch
