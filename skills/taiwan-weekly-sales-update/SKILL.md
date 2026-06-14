---
name: taiwan-weekly-sales-update
description: Update the Taiwan weekly sales Feishu document from SmartBI data. Use when Codex needs to refresh 台湾周会, 打卡数据, 核心数据, BY CC 数据, 分批次前置漏斗, or 人均分发观测 modules in the recurring Taiwan weekly sales workflow.
---

# Taiwan Weekly Sales Update

Use this skill for the recurring Taiwan weekly sales document where modules must be updated in order and formatting matters.

## Workflow

1. Read `references/sop.md`.
2. Re-identify the current embedded sheets from the live document instead of trusting stale IDs.
3. Export each SmartBI module with the date rules in the SOP.
4. Write only the target module area and preserve formatting.
5. Read back key rows, merged cells, and summary text after each update.

## Resource

- `references/sop.md`: end-to-end module order, report paths, formatting rules, and validation checklist
