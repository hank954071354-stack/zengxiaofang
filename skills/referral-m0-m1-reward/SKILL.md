---
name: referral-m0-m1-reward
description: Generate the monthly referral M0/M1 registration reward workbook from a SmartBI export and update the OA upload sheets. Use when Codex needs to handle 转介绍M0-1注册奖励, 邀请带量奖励, or monthly referral reward issuance for CC 手推 / 深服 flows.
---

# Referral M0 M1 Reward

Use this skill when the user needs the monthly M0/M1 referral reward flow rerun with a fresh SmartBI export and an OA workbook.

## Workflow

1. Read `references/sop.md`.
2. Export the raw SmartBI detail with the exact date and filter rules from the SOP.
3. Update the OA workbook sheets in order: raw detail, hit detail, stats, reward detail, and upload sheet.
4. Keep the historical payout formula unless the user explicitly changes the business rule.
5. Validate totals, empty recommender IDs, and month labels before delivery.

## Resource

- `references/sop.md`: export rules, naming, filters, payout logic, and final validation checklist
