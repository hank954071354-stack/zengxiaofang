# Zengxiaofang Work Skills Repo

This private repository curates reusable AI work assets from `D:\工作\曾晓芳` into a governed GitHub structure. It is for SOPs, skill packages, helper scripts, and onboarding material that can be reused safely without turning the repo into a raw work dump.

## What belongs here

- Reusable `SKILL.md` packages under `skills/`
- SOP references, templates, and helper scripts
- Governance docs, onboarding docs, and upload rules
- Project scripts that are still useful even when their private Excel inputs stay local

## What does not belong here

- Raw BI exports, CRM exports, or backend downloads
- Filled `.xls` / `.xlsx` workbooks and generated result files
- Chat history backups, restored conversations, screenshots, or browser traces
- Passwords, tokens, cookies, private keys, and `.env` files

## Current layout

```text
docs/       governance, onboarding, desensitized upload notes
drafts/     historical or not-yet-packaged assets
projects/   reusable scripts that still depend on local private inputs
scripts/    repo maintenance helpers
skills/     curated skill packages with SKILL.md + references/scripts
```

## Curation rules

1. Keep the repository private unless a separately sanitized public version is created.
2. Only commit logic, instructions, templates, and desensitized examples.
3. If a workflow still needs real local workbooks, keep the script and document the dependency instead of uploading the workbook.
4. When moving material in from the local work root, review it against [docs/repo-governance.md](docs/repo-governance.md) first.

## Current curated skills

- `channel-friday-halfweek`
- `taiwan-weekly-sales-update`
- `overseas-sales-daily-meeting`
- `referral-m0-m1-reward`
- `team-git-github-governance`

## Maintenance

- Desensitized upload guidance: [docs/github-desensitized-upload.md](docs/github-desensitized-upload.md)
- Repo governance checklist: [docs/repo-governance.md](docs/repo-governance.md)
- VIPTHINK onboarding reference: [docs/onboarding/vipthink-p0-skills-employee-onboarding-guide-20260611.md](docs/onboarding/vipthink-p0-skills-employee-onboarding-guide-20260611.md)
