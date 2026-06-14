# GitHub Desensitized Upload Workflow

Note: this document preserves the original local staging workflow under `D:\工作\曾晓芳\5-Github`. In this repository clone, pass explicit source paths when reusing the helper scripts.

This repository is the public upload area for work summaries and reusable methods.

Raw files under `D:\工作\曾晓芳` may include private business data, account traces, BI exports, screenshots, logs, browser profiles, and spreadsheets. Do not upload that directory directly.

## Safe Workflow

1. Generate a public snapshot:

```powershell
powershell.exe -ExecutionPolicy Bypass -File "D:\工作\曾晓芳\5-Github\scripts\prepare_public_snapshot.ps1"
```

2. Review the public upload list:

```text
D:\工作\曾晓芳\5-Github\public_snapshot\_manifest.md
```

3. Review the local skip details if needed:

```text
D:\工作\曾晓芳\5-Github\private\skipped_files_last_run.txt
```

4. Only upload the contents of `D:\工作\曾晓芳\5-Github`.

## Daily Automatic Upload

After Git for Windows is installed and GitHub login is ready, use this script in Windows Task Scheduler:

```powershell
powershell.exe -ExecutionPolicy Bypass -File "D:\工作\曾晓芳\5-Github\scripts\daily_desensitized_push.ps1"
```

The daily script regenerates the public snapshot first, then commits and pushes only the GitHub repository folder.

## What The Script Includes

- Text-based work notes and reusable scripts.
- Markdown, TXT, Python, PowerShell, YAML, JSON, MJS, and HTML files.
- Only files smaller than 1 MB.

## What The Script Skips

- Excel, CSV, TSV, PPT, images, logs, databases, compressed files, and executables.
- `downloads`, `exports`, `smartbi_exports`, `outputs`, `.chrome*`, `.tools`, `private`, `secrets`, browser caches, and chat history folders.
- The GitHub repository folder itself, to avoid recursively copying upload files.

## Automatic Redaction

The script replaces common sensitive content with placeholders:

- Email addresses.
- Mainland China mobile phone numbers.
- Mainland China ID card numbers.
- Passwords, tokens, secrets, API keys, authorization headers, and cookies.
- URLs.
- Local user paths.
- The local person's name in the workspace path.

The full skipped-file list is stored under `private/`, which is ignored by Git and should not be uploaded.

## Manual Review Checklist

Before pushing, open `_manifest.md` and sample a few included files. Confirm that:

- No customer, student, employee, or supplier names are exposed.
- No raw BI, CRM, order, revenue, cost, refund, contract, or quotation data is exposed.
- No screenshots or exported tables are included.
- No login, cookie, token, or private URL remains.
