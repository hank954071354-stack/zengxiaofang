---
name: channel-friday-halfweek
description: Update the Friday half-week Feishu channel report from SmartBI data, especially referral and sales-side modules. Use when Codex needs to update 周五半周会, 半周会, 转介绍达成情况, 销售侧, 资源周期, or related channel-weekly tables and summaries from a current Feishu document.
---

# Channel Friday Halfweek

Use this skill when the user gives a current half-week meeting doc link or asks to refresh the recurring Friday channel meeting package.

## Workflow

1. Read `references/sop.md` before touching the document.
2. Treat the current Feishu document as the source of truth and re-identify target tables at run time.
3. Prefer SmartBI CLI or Chrome-backed export for downloads.
4. Preserve template formatting, formulas, merged cells, and summary areas.
5. Read back key cells after each write.

## Referral-only flow

If the user only asks for the referral section, use `references/referral-template.md` to gather the minimum inputs and reuse the bundled scripts when they fit the exported workbook shape.

## Bundled resources

- `references/sop.md`: full operational SOP
- `references/referral-template.md`: minimal handoff template for referral updates
- `scripts/generate_friday_referral.py`: build regional referral workbook and notes from a downloaded export
- `scripts/build_friday_clipboard.py`: format generated referral workbook content for clipboard or HTML paste workflows
