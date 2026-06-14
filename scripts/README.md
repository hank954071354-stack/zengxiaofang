# Scripts

Keep only repo-maintenance scripts here.

- `prepare_public_snapshot.ps1`: regenerate a text-only sanitized snapshot from a local work root
- `daily_desensitized_push.ps1`: helper wrapper for snapshot + commit + push

When using these scripts from this repository clone, pass the source work directory explicitly. Do not assume the repo's parent directory is the correct raw-work root.
