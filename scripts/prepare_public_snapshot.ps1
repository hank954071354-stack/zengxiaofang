param(
    [string]$SourceRoot = "",
    [string]$DestinationRoot = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$workspaceRoot = Split-Path -Parent $repoRoot

if ([string]::IsNullOrWhiteSpace($SourceRoot)) {
    $SourceRoot = $workspaceRoot
}

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    $DestinationRoot = Join-Path $repoRoot "public_snapshot"
}

$sourcePath = (Resolve-Path -LiteralPath $SourceRoot).Path
$destinationParent = Split-Path -Parent $DestinationRoot
$personName = [regex]::Unescape("\u66fe\u6653\u82b3")
$shortName = [regex]::Unescape("\u5c0f\u82b3")
$chatHistory = [regex]::Unescape("\u4f1a\u8bdd\u8bb0\u5f55")
$restoredChatHistory = [regex]::Unescape("\u6062\u590d\u7684\u4f1a\u8bdd\u8bb0\u5f55")

if (-not (Test-Path -LiteralPath $destinationParent)) {
    New-Item -ItemType Directory -Path $destinationParent | Out-Null
}

if (Test-Path -LiteralPath $DestinationRoot) {
    Remove-Item -LiteralPath $DestinationRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $DestinationRoot | Out-Null

$allowedExtensions = @(
    ".md",
    ".txt",
    ".py",
    ".ps1",
    ".yaml",
    ".yml",
    ".json",
    ".mjs",
    ".html"
)

$blockedPathParts = @(
    "\5-Github\",
    "\.git\",
    "\.tools\",
    "\.chrome",
    "\smartbi_exports\",
    "\downloads\",
    "\exports\",
    "\outputs\",
    "\private\",
    "\secrets\",
    "\$chatHistory\",
    "\$restoredChatHistory\",
    "\__pycache__\",
    "\node_modules\"
)

$blockedNamePatterns = @(
    "cookie",
    "token",
    "secret",
    "password",
    "passwd",
    "login",
    "credential",
    "history",
    "local state",
    "web data",
    "account"
)

function Test-IsBlockedPath {
    param([string]$FullName)

    $normalized = $FullName.ToLowerInvariant()
    foreach ($part in $blockedPathParts) {
        if ($normalized.Contains($part.ToLowerInvariant())) {
            return $true
        }
    }

    $leaf = (Split-Path -Leaf $FullName).ToLowerInvariant()
    foreach ($pattern in $blockedNamePatterns) {
        if ($leaf.Contains($pattern)) {
            return $true
        }
    }

    return $false
}

function ConvertTo-SafeFileName {
    param([string]$Name)

    $safe = $Name
    $safe = $safe -replace [regex]::Escape($personName), "ColleagueA"
    $safe = $safe -replace [regex]::Escape($shortName), "ColleagueA"
    $safe = $safe -replace "Hank Ho", "User"
    $safe = $safe -replace "hank954071354-stack", "github-user"
    return $safe
}

function ConvertTo-DesensitizedText {
    param([string]$Text)

    $value = $Text

    $value = $value -replace "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}", "[EMAIL]"
    $value = $value -replace "(?<!\d)1[3-9]\d{9}(?!\d)", "[PHONE]"
    $value = $value -replace "(?<!\d)\d{17}[\dXx](?!\d)", "[ID_CARD]"
    $value = $value -replace "(?i)(password|passwd|pwd|token|secret|api[_-]?key|access[_-]?key)\s*[:=]\s*['""]?[^'""\s,;]+", '$1=[REDACTED]'
    $value = $value -replace "(?i)(authorization|cookie)\s*[:=]\s*['""]?[^'""\r\n]+", '$1=[REDACTED]'
    $value = $value -replace "https?://[^\s)""']+", "[URL]"
    $value = $value -replace "github\.com/hank954071354-stack", "github.com/github-user"
    $escapedSource = [regex]::Escape($sourcePath)
    $value = $value -replace $escapedSource, "[LOCAL_WORK_DIR]"
    $value = $value -replace "C:\\Users\\[^\\\r\n]+", "[USER_HOME]"
    $value = $value -replace [regex]::Escape($personName), "ColleagueA"
    $value = $value -replace [regex]::Escape($shortName), "ColleagueA"
    $value = $value -replace "Hank Ho", "User"
    $value = $value -replace "hank954071354-stack", "github-user"

    return $value
}

$copied = New-Object System.Collections.Generic.List[string]
$skipped = New-Object System.Collections.Generic.List[string]

Get-ChildItem -LiteralPath $sourcePath -Recurse -File -Force | ForEach-Object {
    $file = $_
    $relative = $file.FullName.Substring($sourcePath.Length).TrimStart("\")

    if (Test-IsBlockedPath -FullName $file.FullName) {
        $safeSkipped = (($relative -split "\\") | ForEach-Object { ConvertTo-SafeFileName $_ }) -join "\"
        $skipped.Add("$safeSkipped`tblocked path")
        return
    }

    if ($allowedExtensions -notcontains $file.Extension.ToLowerInvariant()) {
        $safeSkipped = (($relative -split "\\") | ForEach-Object { ConvertTo-SafeFileName $_ }) -join "\"
        $skipped.Add("$safeSkipped`tblocked extension")
        return
    }

    if ($file.Length -gt 1MB) {
        $safeSkipped = (($relative -split "\\") | ForEach-Object { ConvertTo-SafeFileName $_ }) -join "\"
        $skipped.Add("$safeSkipped`ttoo large for public text snapshot")
        return
    }

    $safeRelativeParts = $relative -split "\\"
    $safeRelative = ($safeRelativeParts | ForEach-Object { ConvertTo-SafeFileName $_ }) -join "\"
    $target = Join-Path $DestinationRoot $safeRelative
    $targetDir = Split-Path -Parent $target

    if (-not (Test-Path -LiteralPath $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    try {
        $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    }
    catch {
        $safeSkipped = (($relative -split "\\") | ForEach-Object { ConvertTo-SafeFileName $_ }) -join "\"
        $skipped.Add("$safeSkipped`tnot readable as UTF-8 text")
        return
    }

    $safeContent = ConvertTo-DesensitizedText -Text $content
    Set-Content -LiteralPath $target -Value $safeContent -Encoding UTF8
    $copied.Add($safeRelative)
}

$manifestPath = Join-Path $DestinationRoot "_manifest.md"
$privateReviewDir = Join-Path $repoRoot "private"
$privateSkippedPath = Join-Path $privateReviewDir "skipped_files_last_run.txt"

if (-not (Test-Path -LiteralPath $privateReviewDir)) {
    New-Item -ItemType Directory -Path $privateReviewDir -Force | Out-Null
}

$skipped | Sort-Object | Set-Content -LiteralPath $privateSkippedPath -Encoding UTF8

$skipSummary = $skipped |
    ForEach-Object {
        $parts = $_ -split "`t", 2
        if ($parts.Count -eq 2) { $parts[1] } else { "unknown" }
    } |
    Group-Object |
    Sort-Object Count -Descending

$manifest = @()
$manifest += "# Public Snapshot Manifest"
$manifest += ""
$manifest += "Generated at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$manifest += ""
$manifest += "Source: [LOCAL_WORK_DIR]"
$manifest += ""
$manifest += "## Included Files"
$manifest += ""
if ($copied.Count -eq 0) {
    $manifest += "- None"
}
else {
    $copied | Sort-Object | ForEach-Object { $manifest += "- $_" }
}
$manifest += ""
$manifest += "## Skipped Summary"
$manifest += ""
if ($skipped.Count -eq 0) {
    $manifest += "- None"
}
else {
    $skipSummary | ForEach-Object { $manifest += "- $($_.Name): $($_.Count)" }
    $manifest += ""
    $manifest += "Full skipped-file details are saved locally under `private/skipped_files_last_run.txt`; this private review file is not for GitHub upload."
}

Set-Content -LiteralPath $manifestPath -Value ($manifest -join [Environment]::NewLine) -Encoding UTF8

Write-Host "Public snapshot created:"
Write-Host $DestinationRoot
Write-Host "Included files: $($copied.Count)"
Write-Host "Skipped files: $($skipped.Count)"
