# 团队 Git/GitHub 规范与快速上手手册

本文档面向不熟悉 Git/GitHub 的团队成员，目标是让每个人都能稳定完成版本管理、上传、协作和安全检查。它也服务于本项目的周报扫描场景：每名成员维护一个清晰、可扫描、可复盘的 GitHub 仓库。

## 1. 先给结论

团队默认采用“私有仓库优先、分支开发、PR 合并、半自动上传、上传前安全检查”的方式。

不要把 GitHub 当网盘用。GitHub 用来保存代码、文档、模板、可复用流程和脱敏示例，不用来保存业务原始数据、客户资料、账号信息、聊天记录、导出报表、密钥和临时大文件。

推荐日常流程：

```text
开始工作
  -> 拉取最新版本
  -> 新建分支
  -> 修改文件
  -> 本地自查
  -> 暂存文件
  -> 提交 commit
  -> 上传 push
  -> 发起 Pull Request
  -> 代码/安全检查
  -> 合并到主分支
```

对新人来说，可以先使用 GitHub Desktop 或 VS Code 的 Source Control 面板。熟练后再使用命令行。

## 2. 适用范围

适用于以下场景：

- 团队成员第一次使用 Git/GitHub。
- 团队项目需要做版本管理。
- 成员需要把本地代码、文档、模板上传到 GitHub。
- 项目需要被周报系统扫描 GitHub 增量。
- 仓库准备公开、分享、交付或纳入团队规范管理。

不适用于以下场景：

- 把 GitHub 当作业务数据备份盘。
- 上传账号密码、API Key、Cookie、Token、私钥。
- 上传客户、学生、家长、供应商、订单、营收、成本、合同、报价等原始业务数据。
- 上传未经脱敏的 BI、CRM、飞书、钉钉、浏览器、网盘、邮件或后台系统导出内容。

## 3. 基础概念

### 3.1 Git 是什么

Git 是本地版本管理工具。它记录每次修改，让你可以知道谁在什么时候改了什么，也能在出错时回到历史版本。

### 3.2 GitHub 是什么

GitHub 是远程仓库平台。可以把本地 Git 仓库上传到 GitHub，方便团队协作、备份、评审和自动扫描。

### 3.3 必须理解的 10 个词

| 词 | 中文理解 | 团队里的用法 |
| --- | --- | --- |
| Repository / repo | 仓库 | 一个项目的版本管理空间 |
| Clone | 克隆 | 把 GitHub 仓库下载到本地 |
| Commit | 提交 | 给一批修改打快照并写说明 |
| Push | 上传 | 把本地 commit 上传到 GitHub |
| Pull | 拉取 | 把 GitHub 最新内容同步到本地 |
| Branch | 分支 | 独立开发线，避免直接改主线 |
| main | 主分支 | 稳定版本，默认不直接乱改 |
| Pull Request / PR | 合并请求 | 请求把分支内容合并到主分支 |
| Merge | 合并 | PR 通过后进入主分支 |
| Conflict | 冲突 | 两个人改了同一处，需要人工选择 |

## 4. 团队角色与权限

### 4.1 新成员

新成员默认只需要会做 5 件事：

1. 克隆仓库到本地。
2. 每天开始前拉取最新版本。
3. 在自己的分支上修改。
4. 提交并上传。
5. 发起 PR，等待审核后合并。

### 4.2 项目负责人

项目负责人负责：

- 创建仓库或确认仓库归属。
- 设置仓库可见性，默认 private。
- 配置分支保护规则。
- 审核 PR。
- 判断哪些内容可以公开。
- 维护 README、`.gitignore`、示例配置和安全说明。

### 4.3 安全/发布审核人

在仓库公开、首次上传、大批量上传或涉及业务材料时，需要有人做发布审核：

- 检查是否有密钥、账号、Cookie、Token。
- 检查是否有客户、学生、家长、供应商等隐私数据。
- 检查是否有合同、报价、订单、营收、成本、策略等业务敏感信息。
- 检查截图、日志、报表、导出文件是否已脱敏。
- 检查 README 是否能说明项目，但不暴露内部细节。

Teddy 本机已有两份发布规则，应作为最终门禁：

- `E:\Projects\active\GitHub\PUBLICATION_RULES.md`
- `E:\Projects\active\GitHub\PUBLISH_CHECKLIST.md`

## 5. 仓库创建规范

### 5.1 仓库默认可见性

默认创建 private 仓库。只有满足以下条件时才考虑 public：

- 项目目标适合公开复用。
- README 已经写成公开安全版本。
- 示例数据是假的、脱敏的或公开来源。
- `.env`、密钥、真实配置和原始业务数据没有进入 Git。
- 发布清单已检查通过。

### 5.2 仓库命名

推荐命名：

```text
业务方向-用途-技术或形态
```

示例：

```text
ai-weekly-report
course-content-tools
bi-report-exporter
crm-data-cleaning-demo
```

不要使用过度暴露业务细节的名称，例如：

```text
2026某客户续费策略
某校区真实转化数据
内部报价系统备份
```

### 5.3 本地项目位置

Teddy 的长期项目统一放在：

```text
E:\Projects\active
```

团队成员如果没有统一盘符，可以按同样逻辑建立一个固定目录，例如：

```text
D:\Projects\active
```

不要把正式项目散落在桌面、下载目录、微信/钉钉/飞书缓存目录或临时目录里。

## 6. 本地一次性准备

### 6.1 安装工具

新人优先安装：

- Git。
- GitHub Desktop。
- VS Code。

可选安装：

- GitHub CLI。
- Cursor、Codex 或其他开发工具。

### 6.2 配置 Git 身份

每台电脑只需要配置一次：

```powershell
git config --global user.name "你的英文名或姓名拼音"
git config --global user.email "你的 GitHub 邮箱"
```

检查配置：

```powershell
git config --global --list
```

注意：这里的邮箱会出现在提交记录里。不要使用不该公开的私人邮箱；如果仓库可能公开，优先使用 GitHub 提供的隐私邮箱或公司允许公开的邮箱。

### 6.3 登录 GitHub

推荐新人使用 GitHub Desktop 登录 GitHub，省去命令行认证问题。

如果使用命令行，可以选择：

- SSH Key。
- GitHub CLI 登录。
- Personal Access Token。

安全要求：

- Token 只保存到系统凭据管理器，不写进项目文件。
- Token 不发到聊天工具。
- Token 不截图。
- Token 不写进 `.env` 以外的任何文件。
- `.env` 也不能进入 Git。

## 7. 新人快速上手流程

### 7.1 第一次加入已有仓库

负责人先给成员仓库访问权限。

成员操作：

1. 打开 GitHub Desktop。
2. 选择 Clone repository。
3. 选择团队仓库。
4. 本地路径选择固定项目目录，例如 `E:\Projects\active\仓库名`。
5. 克隆完成后，用 VS Code 打开项目。
6. 先不要改文件，先确认 README 能看懂。

命令行方式：

```powershell
cd E:\Projects\active
git clone [URL]
cd 仓库名
```

### 7.2 每天开始工作

先同步最新版本：

```powershell
git pull
```

GitHub Desktop 中点击 Fetch origin，然后点击 Pull origin。

不要在很久没同步的仓库里直接改文件，否则容易产生冲突。

### 7.3 开始一个新任务

新建分支：

```powershell
git switch -c feature/你的名字-任务简写
```

分支命名示例：

```text
feature/teddy-weekly-report-template
fix/liya-github-scan-error
docs/zhangsan-onboarding-guide
```

分支类型：

| 类型 | 用途 |
| --- | --- |
| `feature/` | 新功能 |
| `fix/` | 修复问题 |
| `docs/` | 文档修改 |
| `chore/` | 配置、依赖、清理 |
| `data/` | 示例数据或脱敏数据 |

### 7.4 修改文件

修改时遵守：

- 一次只做一个明确任务。
- 不顺手改无关文件。
- 不上传临时文件。
- 不把真实业务数据放进项目。
- 需要示例时使用 fake data 或 `example` 文件。

### 7.5 查看修改

命令行：

```powershell
git status
git diff
```

GitHub Desktop：

- 左侧看 changed files。
- 逐个点开文件看差异。
- 确认没有误改、误删、误传。

### 7.6 提交 commit

推荐提交格式：

```text
类型: 做了什么
```

示例：

```text
docs: add team GitHub onboarding workflow
fix: handle empty GitHub scan result
feature: add weekly report ROI section
chore: update ignore rules for local reports
```

一次 commit 应该表达一件事。不要写：

```text
update
改了一下
最终版
111
```

命令行：

```powershell
git add 文件路径
git commit -m "docs: add team GitHub onboarding workflow"
```

如果确认全部修改都该提交：

```powershell
git add -A
git commit -m "docs: add team GitHub onboarding workflow"
```

注意：`git add -A` 会把删除、新增、修改都加入提交，必须先看 `git status`。

### 7.7 上传 push

第一次上传新分支：

```powershell
git push -u origin 当前分支名
```

之后上传：

```powershell
git push
```

GitHub Desktop 中点击 Push origin。

## 8. Pull Request 规范

### 8.1 什么时候发 PR

满足以下条件再发 PR：

- 本地能正常运行或文档能正常打开。
- 自己看过 changed files。
- commit message 可读。
- 没有 `.env`、密钥、原始数据、截图泄露。
- README 或相关文档已同步更新。

### 8.2 PR 标题

格式：

```text
类型: 简短说明
```

示例：

```text
docs: add GitHub onboarding workflow
fix: repair Feishu upload fallback
feature: add token ROI summary
```

### 8.3 PR 描述模板

复制以下模板：

```markdown
## 变更内容

- 

## 验证方式

- [ ] 本地运行通过
- [ ] 文档已检查
- [ ] 关键流程已手动测试

## 安全检查

- [ ] 没有 `.env`、Token、Cookie、密钥、私钥
- [ ] 没有客户/学生/家长/供应商等隐私数据
- [ ] 没有合同、报价、订单、营收、成本、策略等敏感业务数据
- [ ] 示例数据均为 fake data、脱敏数据或公开数据
- [ ] 截图、日志、报表、导出文件已确认安全

## 是否需要负责人决策

- [ ] 不需要
- [ ] 需要，原因：
```

### 8.4 审核人看什么

审核人优先看风险，而不是只看代码风格：

- 这次修改是否符合任务目标。
- 是否把无关文件带进来了。
- 是否会破坏现有流程。
- 是否缺少必要说明或测试。
- 是否包含安全隐患。
- 是否适合合并到主分支。

## 9. 半自动上传流程

团队不推荐“无脑自动上传”。推荐“半自动上传”：

```text
自动列出变更
  -> 自动扫描高风险关键词和高风险文件
  -> 人工确认
  -> 自动提交
  -> 自动上传
```

这样既能降低新人操作门槛，也避免把敏感内容直接推到 GitHub。

### 9.1 最小命令版

适合熟悉命令行的人：

```powershell
git status --short
git diff
git add -A
git diff --cached --name-only
git diff --cached
git commit -m "docs: update workflow"
git push
```

关键点：提交前必须看 `git diff --cached`。

### 9.2 新人安全版

新人可以按这个顺序做：

1. 打开 GitHub Desktop。
2. 点击 Fetch origin / Pull origin。
3. 修改文件。
4. 回到 GitHub Desktop。
5. 逐个查看 changed files。
6. 如果看到 `.env`、导出表格、截图、日志、大文件，先问负责人。
7. 写 summary。
8. 点击 Commit。
9. 点击 Push origin。
10. 在 GitHub 页面创建 PR。

### 9.3 自动上传脚本建议

如需做团队脚本，脚本必须内置这些门禁：

- 当前目录必须是 Git 仓库。
- 必须先显示即将上传的文件清单。
- 检测到 `.env`、密钥、Cookie、Token、私钥、证书时直接阻止。
- 检测到 `data/raw`、`exports`、`downloads`、`screenshots`、`.zip`、`.xlsx`、`.csv` 等敏感或易泄露文件时提醒人工确认。
- push 前必须要求人工输入确认。
- 默认 push 到当前分支，不自动合并 main。
- 不自动创建 public 仓库。
- 不自动修改仓库可见性。

推荐脚本交互逻辑：

```text
1. 显示当前仓库、分支、远程地址
2. 显示所有待提交文件
3. 执行关键词扫描
4. 执行敏感文件名扫描
5. 要求输入 commit message
6. 要求输入 YES 确认
7. git add
8. git commit
9. git push
10. 输出 PR 链接或下一步提示
```

## 10. `.gitignore` 标准

每个仓库都应该有 `.gitignore`。至少包含：

```gitignore
# Secrets
.env
.env.*
!.env.example
*.pem
*.key
*.p12
*.pfx
*.crt
*.cer
*.token
*.secret

# Local config
config/local.*
config/private.*
secrets/

# Dependencies and build outputs
node_modules/
__pycache__/
.pytest_cache/
dist/
build/
.next/
.venv/
venv/

# Generated or local reports
reports/private/
reports/tmp/
*.log

# Raw business data and exports
data/raw/
exports/
downloads/
private/
*.xlsx
*.xls
*.csv
*.tsv
*.zip
*.7z
*.rar

# OS/editor
.DS_Store
Thumbs.db
.idea/
.vscode/settings.json
```

如果项目确实需要提交 CSV 或 Excel 示例，必须放 fake data，并用清晰命名：

```text
examples/sample-members.csv
examples/fake-weekly-data.xlsx
```

不要把真实导出数据通过修改 `.gitignore` 的方式硬塞进仓库。

## 11. 安全分级

### 11.1 永远不能上传

- 密码、API Key、Token、Cookie、私钥、证书、恢复码。
- `.env` 文件。
- 真实客户、学生、家长、供应商、合作方信息。
- 身份证、护照、手机号、住址、银行卡、医疗或其他隐私信息。
- 合同、报价、订单、支付、营收、利润、成本、内部策略。
- 飞书、钉钉、BI、CRM、后台系统的原始导出。
- 未脱敏截图、录屏、浏览器导出、聊天记录。

### 11.2 上传前必须审核

- 工作流文档中出现真实团队、客户、学校、供应商、市场或内部工具名称。
- 报表、仪表盘、分析输出、运营报告。
- PDF、PPT、Word、Excel、截图、录屏。
- 配置文件中的组织 ID、租户 ID、bucket 名称、Webhook URL、内部路径。
- 日志、错误报告、调试信息、AI 对话记录。

### 11.3 通常可以上传

- 通用代码。
- 项目 README。
- 脱敏后的架构说明。
- `.env.example`。
- `config.example.*`。
- fake data。
- 公共数据来源的示例。
- 不含业务隐私的流程模板和检查清单。

## 12. 上传前安全检查命令

### 12.1 看即将提交的文件

```powershell
git status --short
git diff --cached --name-only
```

### 12.2 搜索密钥和账号风险

```powershell
rg -n -i "(token|secret|password|passwd|cookie|api[_-]?key|access[_-]?key|client[_-]?secret|private key|BEGIN [A-Z ]*PRIVATE KEY|webhook|bearer)" .
```

### 12.3 搜索业务敏感词

```powershell
rg -n -i "(身份证|护照|银行卡|手机号|电话|客户|学生|家长|合同|报价|收入|营收|利润|成本|转化|订单|支付|内部|机密|供应商|渠道|账号|密码)" .
```

### 12.4 使用发布审计脚本

如果是在 Teddy 本机准备公开仓库，优先使用：

```powershell
python E:\Projects\active\GitHub\tools\publication_audit.py --local .
```

如果脚本提示高风险，先修复或脱敏，不要继续上传。

## 13. 公开仓库发布流程

公开仓库风险更高，因为 Git 历史很难彻底抹除。公开前必须按以下流程：

1. 确认仓库是否真的需要 public。
2. 完整阅读 `PUBLICATION_RULES.md`。
3. 执行 `PUBLISH_CHECKLIST.md`。
4. 检查 `.gitignore`。
5. 检查完整文件列表。
6. 检查 staged diff。
7. 搜索密钥和业务敏感词。
8. 运行发布审计脚本。
9. 必要时建立一个干净的 public 版本仓库，而不是把 private 仓库直接改 public。
10. 由负责人最终确认。

推荐策略：

```text
内部真实仓库 private
  -> 复制出公开安全版本
  -> 删除真实数据和敏感配置
  -> 补充 fake examples
  -> 公开 public 版本
```

不要为了省事把承载真实业务过程的 private 仓库直接切成 public。

## 14. 本项目周报扫描场景

本项目会扫描成员的 GitHub 仓库，用于生成团队周报。为了让扫描结果稳定，成员仓库应遵守：

- 每名成员登记一个主要 GitHub 仓库。
- 仓库保持活跃，不要频繁换地址。
- 如果仓库改名或迁移，及时更新成员登记表和本地缓存。
- commit message 要能看出做了什么。
- 产出物尽量放在清晰目录，例如 `skills/`、`docs/`、`scripts/`、`mcp/`、`examples/`。
- 不要把周报系统不能公开或不能扫描的私密数据放进仓库。

推荐仓库结构：

```text
repo-name/
  README.md
  docs/
  scripts/
  skills/
  examples/
  config.example.yaml
  .env.example
  .gitignore
```

## 15. 常见错误与处理

### 15.1 忘记 pull 就开始改

表现：push 时提示远程有更新，或者出现冲突。

处理：

```powershell
git pull --rebase
```

如果看不懂冲突，不要乱点接受全部。把冲突文件发给负责人或让 Codex 辅助解释。

### 15.2 把 `.env` 提交了但还没 push

处理：

```powershell
git restore --staged .env
git rm --cached .env
```

然后确认 `.gitignore` 里有：

```gitignore
.env
.env.*
!.env.example
```

再重新 commit。

### 15.3 密钥已经 push 到 GitHub

立即处理：

1. 立刻撤销或轮换密钥。
2. 通知负责人。
3. 不要只删除文件再提交，因为历史里仍可能存在。
4. 评估是否需要清理 Git 历史。
5. 如果是 public 仓库，按事故处理，不要继续扩散链接。

### 15.4 提交了大文件

如果还没 push：

```powershell
git restore --staged 文件路径
```

如果已经 push：

- 先判断是否敏感。
- 敏感则按安全事故处理。
- 非敏感但太大，考虑 Git LFS 或从历史清理。

### 15.5 不小心改了主分支

如果还没提交：

```powershell
git switch -c feature/你的名字-任务简写
```

如果已经提交但没 push，可以新建分支保留提交，再让负责人处理主分支。

### 15.6 出现冲突

不要盲目选择全部保留自己的版本。先弄清楚：

- 你的改动是什么。
- 别人的改动是什么。
- 两边是否都要保留。
- 合并后文件是否还能运行。

处理完冲突后：

```powershell
git add 冲突文件
git rebase --continue
```

如果不确定，停止操作并找负责人。

## 16. 新人一页纸流程

每天照着做：

```text
1. 打开项目
2. Pull 最新版本
3. 新建自己的分支
4. 修改文件
5. 看 changed files
6. 确认没有 .env、密钥、业务数据、截图、导出表格
7. 写清楚 commit message
8. Commit
9. Push
10. 发 PR
11. 等审核
12. 合并后删除分支
```

记住三条红线：

```text
不传密钥
不传真实业务数据
不把 GitHub 当网盘
```

## 17. 负责人仓库初始化清单

新建团队仓库后，负责人检查：

- [ ] 仓库默认 private。
- [ ] README 已说明项目用途、运行方式、配置方式和数据边界。
- [ ] 有 `.gitignore`。
- [ ] 有 `.env.example` 或 `config.example.*`。
- [ ] 真实配置不在仓库内。
- [ ] 示例数据是 fake data 或脱敏数据。
- [ ] main 分支受保护。
- [ ] 至少 1 人审核后才能合并 PR。
- [ ] 禁止 force push 到 main。
- [ ] 大文件和导出目录已忽略。
- [ ] 周报扫描所需仓库地址已登记。

## 18. 建议的 GitHub 仓库设置

推荐设置：

- Default branch: `main`
- Visibility: 默认 private
- Pull requests: squash merge 或 merge commit 二选一，团队统一
- Branch protection: main 分支必须 PR 合并
- Required review: 至少 1 人
- Actions permissions: 仅在需要时开启
- Secret scanning: 如果账号支持，开启
- Dependabot: 代码项目可开启

不推荐：

- 所有人直接 push main。
- 为了方便把仓库设成 public。
- 把 Token 放在 README、代码或配置里。
- 给所有成员 admin 权限。

## 19. 团队培训安排

建议用 60 分钟完成第一次培训：

| 时间 | 内容 |
| --- | --- |
| 10 分钟 | Git/GitHub 是什么，为什么不用网盘 |
| 10 分钟 | 仓库、commit、push、pull、branch、PR 概念 |
| 15 分钟 | GitHub Desktop 实操：clone、修改、commit、push |
| 10 分钟 | PR 与审核流程 |
| 10 分钟 | 安全红线和 `.gitignore` |
| 5 分钟 | Q&A 和常见错误 |

培训作业：

1. 每个人 clone 一个练习仓库。
2. 新建自己的分支。
3. 修改 `docs/practice.md`。
4. 提交并 push。
5. 发 PR。
6. 审核别人的 PR。

## 20. 可复制给 Codex 的团队 Skill 草案

如果要让 Codex 在团队项目中自动套用本规范，可以把下面内容做成 Codex skill。建议先作为草案使用，不直接安装到全局，等团队跑通后再放入 `[USER_HOME]\.codex\skills`。

```markdown
---
name: team-git-github-governance
description: Use when helping Teddy's team create, clone, upload, review, publish, or manage Git/GitHub repositories; enforce private-by-default repository management, PR workflow, safe semi-automatic upload, and business/security publication checks.
---

# Team Git/GitHub Governance

Use Chinese by default.

Before any GitHub upload, repository publication, team repository scan, or release preparation:

1. Treat private repository as the default.
2. Read the project README/AGENTS/MEMORY/PROJECT files when present.
3. For Teddy's machine, reference `E:\Projects\active\GitHub\PUBLICATION_RULES.md` and `E:\Projects\active\GitHub\PUBLISH_CHECKLIST.md`.
4. Never recommend blind automatic upload. Use guarded semi-automatic upload: show changed files, scan risks, ask confirmation, then commit/push.
5. Block `.env`, secrets, tokens, cookies, private keys, certificates, raw business data, private exports, screenshots with account data, logs with credentials, and large unrelated files.
6. Prefer GitHub Desktop or VS Code Source Control for beginners.
7. Prefer branch + PR + review; do not push directly to main unless the user explicitly asks and the risk is low.
8. When publishing publicly, recommend sanitized public version rather than making a real internal private repo public.
9. Keep output actionable: exact next commands, checklist, and what to verify.

For team onboarding, provide:

- one-page beginner flow
- setup checklist
- commit/branch/PR naming examples
- `.gitignore` baseline
- upload safety checklist
- common error recovery steps
```

## 21. 决策面板

如果团队要正式落地这套流程，需要负责人决定以下事项：

### D1: 仓库可见性默认策略

- A. 默认 private，只在发布审核后 public。推荐。
- B. 项目负责人自行决定 private/public。
- C. 默认 public，只靠成员自觉检查。

推荐 A。风险最低，也符合团队业务安全要求。

### D2: 新人上传方式

- A. GitHub Desktop 为主，命令行为辅。推荐。
- B. VS Code Source Control 为主。
- C. 全员命令行。

推荐 A。新人上手最快，误操作成本较低。

### D3: 自动上传策略

- A. 半自动上传，上传前必须显示文件和安全扫描。推荐。
- B. 完全自动上传，只要本地变化就 push。
- C. 禁止自动脚本，全靠人工。

推荐 A。它能提高效率，但仍保留人工确认门禁。

### D4: 公开仓库策略

- A. 内部真实仓库 private，另建脱敏 public 版本。推荐。
- B. private 仓库审完后直接改 public。
- C. 不允许任何 public 仓库。

推荐 A。既能分享成果，又降低历史记录泄露风险。

可直接回复：

```text
同意 D1A、D2A、D3A、D4A，按这个流程推进团队落地。
```

