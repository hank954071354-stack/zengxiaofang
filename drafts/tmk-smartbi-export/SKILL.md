---
name: tmk-smartbi-export
description: Export and split the overseas TMK booking form from SmartBI/BI using the report `益智海外用户销售明细_末次渠道`. Use when Codex needs to 拉TMK表, 导出TMK表单, 按港澳/大海外拆分海外 TMK 数据, or apply the rule `末次渠道时间结束 = 执行日 T-5` while keeping `末次渠道时间开始` at the system default value.
---

# TMK SmartBI Export

Use this skill to pull the overseas TMK form directly from SmartBI, then filter and split it into team files for TMK follow-up.

## Workflow

1. Confirm this is a live BI export task, not a request to analyze an already-finalized file.
2. Prefer the Chrome-based SmartBI export flow for downloads. Do not rely on the Codex in-app browser for SmartBI file exports.
3. Run the bundled export script with SmartBI credentials and an exporter script that exposes `export_simple_report_with_browser(...)`.
4. Keep `末次渠道时间结束` at execution day `T-5`.
5. Leave `末次渠道时间开始` unchanged in BI and read the actual default start date from the export result.
6. Use the bundled TMK filter script to:
   - remove rows that are already claimed, booked, assigned to the excluded TMK, or already signed
   - add `团队归属`
   - split output into `港澳团队` and `大海外团队`
7. Report the output files and summary stats back to the user.

## Quick Start

Run the Python wrapper:

```powershell
python scripts\export_tmk.py --exporter-script "D:\path\to\smartbi_browser_export.py" --output-dir "D:\path\to\TMK输出目录" --json
```

Or use the PowerShell helper:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\run_tmk_export.ps1 -ExporterScript "D:\path\to\smartbi_browser_export.py" -OutputDir "D:\path\to\TMK输出目录"
```

Read [references/setup-and-usage.md](references/setup-and-usage.md) for configuration, environment variables, and examples.

## Bundled Scripts

- `scripts/export_tmk.py`: SmartBI export wrapper for this TMK workflow
- `scripts/filter_tmk.py`: TMK filtering and team split logic
- `scripts/run_tmk_export.ps1`: Windows helper for one-step execution

## Output Rules

The skill expects the source report `益智海外用户销售明细_末次渠道` and produces:

- `益智海外用户销售明细_末次渠道_YYYYMMDD_raw.xlsx`
- `益智海外用户销售明细_末次渠道_YYYYMMDD_raw_团队归属处理.xlsx`
- `M月D日-M月D日TMK表-港澳团队.xlsx`
- `M月D日-M月D日TMK表-大海外团队.xlsx`

## TMK Business Rules

Filter out rows where any of the following is true:

- `当前CC名称` is not empty
- `最近一次体验课约课时间` is not empty
- `最近一次分发tmk姓名 = 林凤兰`
- `首签金额` is not empty

Assign `团队归属` with these rules:

- `渠道一级分类 = 投放` and `区域等级 = 港澳` -> `港澳CC`
- `渠道一级分类 = 投放` and `区域等级 in [澳洲, 北美, 欧洲, 亚洲, 海外其他]` -> `大海外CC`
- `渠道一级分类 = 海外港澳商务` -> `港澳CC`
- `渠道一级分类 in [海外商务, 海外Local商务, 其他]` -> `大海外CC`

## Notes

- This skill is designed so the TMK logic is self-contained, but the SmartBI browser exporter remains an external dependency because teams may already have their own maintained exporter entrypoint.
- If the SmartBI environment blocks network access inside a sandboxed Codex session, switch to an approved Chrome/CLI execution path rather than changing the TMK logic.
