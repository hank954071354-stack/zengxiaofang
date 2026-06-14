# Repo Governance

This repository is the GitHub-safe layer of the local work directory, not the work directory itself.

## Allowed content

- `SKILL.md` packages and their `references/` and `scripts/`
- SOPs that explain repeatable work without bundling raw outputs
- Helper scripts that process local private files
- Onboarding guides, repo rules, and upload checklists
- Desensitized examples and fake data

## Blocked content

- Raw `.xls`, `.xlsx`, `.csv`, `.tsv` exports
- Filled reward workbooks, OA upload files, and BI download artifacts
- `会话记录` and `恢复的会话记录`
- Screenshots, browser profiles, caches, cookies, tokens, and secrets
- Temporary download folders and generated report folders

## Packaging rules

1. Put reusable operational workflows under `skills/`.
2. Put scripts that still depend on local private assets under `projects/`.
3. Put historical-but-useful material that is not yet ready as a skill under `drafts/`.
4. Keep root files minimal: `README.md`, `.gitignore`, example config, and high-signal docs only.

## Review checklist before push

- `git status --short`
- `git diff --cached`
- `rg -n -i "(password|token|cookie|secret|private key|SMARTBI_PASSWORD|ghp_)" .`
- Confirm no new raw workbook or export files are staged

## This cleanup

This governed version intentionally removes:

- tracked Excel workbooks
- tracked chat-history backups
- stale root SOP copies and rollback backups

Those source materials remain in the local work directories, not in this repository.
