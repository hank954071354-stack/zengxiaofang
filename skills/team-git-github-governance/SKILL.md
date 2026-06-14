---
name: team-git-github-governance
description: Govern a work repository before GitHub upload by checking structure, safety, and collaboration hygiene. Use when Codex needs to clean up a repo, decide what should be committed, improve README and `.gitignore`, or guide a teammate through safe private GitHub workflow.
---

# Team Git GitHub Governance

Use this skill to decide what should live in a private work repo, what must stay local, and how to structure commits so the repo remains reusable instead of turning into a backup dump.

## Workflow

1. Review the repository shape and identify reusable assets versus raw outputs.
2. Move reusable workflows into stable directories such as `skills/`, `docs/`, `scripts/`, and `projects/`.
3. Remove tracked secrets, chat backups, raw exports, and generated workbooks.
4. Tighten `.gitignore`, README, and safety notes.
5. Run a final staged diff review before push.

## Resource

- `references/team-git-github-governance.md`: detailed governance rules, onboarding patterns, and safety checklists
