# VIPTHINK P0 核心技能员工接入手册

生成日期：2026-06-11  
适用范围：VIPTHINK 内部员工使用 `team-tools-hub` 查找、优化、上传、更新、复用 AI 工具或代码项目  
默认仓库：`VIPTHINK/team-tools-hub`  
证据边界：`command_verified` + `repo_file_verified`

## 一句话结论

员工需要一次性安装 3 个 P0 核心技能，但日常只需要调用：

```text
vipthink-tools-hub-assistant
```

另外两个技能是后台协作能力：

- `vipthink-tool-quality-reviewer`：负责工具体检、复用准备度、风险和缺口判断。
- `github-project-packager`：负责补齐资产、整理上传包、PR / merge 流程。

员工不需要理解三者边界；默认把 `vipthink-tools-hub-assistant` 当作唯一入口。

## 当前远端版本快照

本手册生成时，已复核 `VIPTHINK/team-tools-hub` 的 `main` 分支：

```text
main commit: fa6ca21d94f3cc7dd557d15a5d4095475fddf4e3
vipthink-tools-hub-assistant: 0.1.12-bootstrap
github-project-packager: 0.2.14
vipthink-tool-quality-reviewer: 0.1.3
```

重要规则：上面只是本手册生成时的快照，不是永久版本源。员工安装、更新、自检和上传前检查时，一律以 GitHub 仓库 `VIPTHINK/team-tools-hub` 的 `main` 分支中各技能目录的 `VERSION` 文件为准：

```text
通用&基建tools仓库/规范化工具/vipthink-tools-hub-assistant/VERSION
通用&基建tools仓库/规范化工具/github-project-packager/VERSION
通用&基建tools仓库/规范化工具/vipthink-tool-quality-reviewer/VERSION
```

如果本手册、本机版本和 GitHub `main` 上的 `VERSION` 不一致，以 GitHub `main` 为准。

| 技能 | 员工是否直接调用 | 作用 |
| --- | --- | --- |
| `vipthink-tools-hub-assistant` | 是，唯一日常入口 | 找已有工具、优化工具、上传/更新工具、工具交接、使用反馈、版本自检 |
| `vipthink-tool-quality-reviewer` | 否 | 后台评估：可理解性、可运行性、可复核性、复用准备度、风险、最小迭代建议 |
| `github-project-packager` | 否 | 后台打包发布：整理 `README.md`、`project-meta.json`、安全清单、replay、目录索引、PR / merge 流程 |

## 接入前准备

员工第一次接入时，先把下面这段发给 Codex、TRAE、OpenClaw、Claude Code 或其他 AI coding 工具。员工只需要填写中文姓名，不要预填 GitHub 用户名；GitHub 用户名由 `gh CLI` 读取后展示确认。

```text
请帮我完成 VIPTHINK P0 skills 接入准备。

我的姓名是：<中文姓名>

请按顺序处理：

1. 判断我的电脑系统是 Windows、macOS 还是 Linux。
2. 检查本机是否能运行：
   - git --version
   - gh --version
3. 如果 git 或 gh 缺失，告诉我缺少什么，并给出当前系统对应安装方式；在我确认前不要执行安装。
4. 检查 GitHub CLI 是否已登录：
   - gh auth status
5. 如果没有登录，引导我登录 GitHub。
6. 登录后读取当前 GitHub 用户名：
   - gh api user --jq '.login'
7. 展示给我确认：
   当前 GitHub CLI 登录账号是：<login>。这是你准备用于 VIPTHINK 的 GitHub 账号吗？
8. 检查仓库访问：
   - gh repo view VIPTHINK/team-tools-hub --json nameWithOwner,viewerPermission,url
9. 如果能访问仓库，再继续安装 3 个 P0 skills。
10. 如果不能访问仓库，尤其返回 404 / Repository not found：
    - 不要下载 ZIP。
    - 不要猜仓库名。
    - 输出权限修复包给管理员。

不要读取或打印 token、cookie、password、private key。
```

权限修复包格式：

```text
员工姓名：
当前 GitHub CLI login：
失败命令：
失败现象：
判断：
管理员下一步：
```

私有仓库无权限时，GitHub 可能返回 `404` 或 `Repository not found`。这通常表示当前 CLI 凭据没有访问权，不要据此改仓库名或下载 ZIP。

## 安装方式

### 推荐方式：统一安装 / 更新脚本

优先使用仓库级 bootstrap。它适合本机旧版 assistant 还不知道新安装脚本的情况。

从 `team-tools-hub` 仓库根目录运行：

```bash
python3 通用&基建tools仓库/规范化工具/install_vipthink_p0_skills.py --yes
```

Windows:

```bash
py -3 通用&基建tools仓库/规范化工具/install_vipthink_p0_skills.py --yes
```

如果已经在 `vipthink-tools-hub-assistant` skill 根目录，也可以运行：

```bash
python3 scripts/install_or_update_p0_skills.py --yes
```

只读预览：

```bash
python3 scripts/install_or_update_p0_skills.py --dry-run --yes
```

只检查本机版本、不复制文件：

```bash
python3 scripts/install_or_update_p0_skills.py --check-only --yes
```

高风险动作前的严格自检：

```bash
python3 scripts/install_or_update_p0_skills.py --check-only --strict --yes
```

如果本机已有 `team-tools-hub` checkout，可以指定仓库路径：

```bash
python3 scripts/install_or_update_p0_skills.py --repo-path /path/to/team-tools-hub --yes
```

如果当前 AI 工具不是 Codex，或团队给 Claude Code / TRAE / OpenClaw 配了不同技能目录，必须指定目标目录：

```bash
python3 scripts/install_or_update_p0_skills.py --target-skills-dir /path/to/skills --yes
```

也可以使用环境变量：

```bash
VIPTHINK_SKILLS_DIR=/path/to/skills python3 scripts/install_or_update_p0_skills.py --yes
```

### 兼容方式：让 Codex 帮你安装

在 Codex 里可以这样说：

```text
请从 VIPTHINK/team-tools-hub 的 通用&基建tools仓库/规范化工具 目录安装或更新 3 个 P0 skills：

1. vipthink-tools-hub-assistant
2. vipthink-tool-quality-reviewer
3. github-project-packager

请优先使用 install_vipthink_p0_skills.py 或 install_or_update_p0_skills.py，不要手工 rsync 当作主路径。
安装后请读取 3 个本机 VERSION，并与 GitHub main 上对应 VERSION 对齐。
如果不一致，先升级本机 skill，再提示我重新打开当前 AI 工具。
```

### 不推荐：手工复制

手工 `rsync` 只作为脚本不可用时的管理员兜底，不作为员工主路径。原因：

- 容易漏掉 `VERSION`、`test-prompts.json` 或 `references/`。
- 不能自动备份旧版本。
- 不能产出 `tool_installed` receipt。
- 不适合 Claude Code / TRAE / OpenClaw 的自定义目标目录。

## 安装成功后检查什么

安装脚本应至少完成：

- 读取 GitHub `main` 的 3 个 P0 skill 最新版本。
- 读取本机目标技能目录里的 3 个 `VERSION`。
- 判断每个 skill 是 `current`、`stale`、`missing`、`updated`、`success`、`failed` 或 `latest_missing`。
- 旧版目录先备份，再更新。
- 检查 3 个 `SKILL.md` 和 `VERSION` 存在。
- 对每个 P0 skill 输出或上报 `tool_installed` receipt。

receipt 语义：

```text
install_self_check：整体安装 / 自检启动信号。
tool_installed：每个 P0 skill 的安装 / 版本状态。
skill_name：vipthink-tools-hub-assistant / vipthink-tool-quality-reviewer / github-project-packager。
skill_version：员工本机当前 VERSION；缺失时为 missing。
tool_version：GitHub main 最新 VERSION。
result：current / stale / missing / updated / success / failed / latest_missing。
```

如果更新成功，员工需要重新打开当前 AI 工具。Codex 用户建议重新打开 Codex 或开启新对话，因为当前会话可能仍持有旧的 `SKILL.md` metadata。

## 日常怎么用

### 找已有工具

```text
调用 vipthink-tools-hub-assistant，帮我查一下 team-tools-hub 里有没有工具能解决这个需求：
<描述你的需求、输入、输出、业务场景>
```

助手应该把候选分成：

- 完全可解决
- 部分可解决
- 可参考
- 不建议使用
- 需要新建

先查已有工具，不要重复造轮子。

### 优化自己的工具

```text
调用 vipthink-tools-hub-assistant，帮我优化这个本地工具，让其他同事能看懂、能运行、能复核。
本地路径：<项目路径>
```

助手会在后台使用 `vipthink-tool-quality-reviewer`，检查：

- 是否讲清楚工具解决什么问题。
- 是否有入口命令和依赖说明。
- 是否有 sample input / sample output。
- 是否能 replay。
- 是否有 `project-meta.json`。
- 是否有安全清单。
- 是否存在复用准备度缺口。

复用准备度评分不等于业务价值评分。业务价值需要单独判断。

### 上传或更新工具到公司仓库

```text
调用 vipthink-tools-hub-assistant，帮我把这个项目上传到 team-tools-hub。
我的姓名是：<姓名>
本地路径是：<项目路径>
这个工具解决的问题是：<一句话说明>
```

默认上传目标：

```text
VIPTHINK/team-tools-hub/分团队代码仓库/<团队>/<姓名>/<项目名>/
```

除非员工明确指定其他 GitHub 仓库、个人仓库、public / open-source repo、非 VIPTHINK 仓库，或明确说“不进 team-tools-hub”，否则默认进入公司 `team-tools-hub`。

## 上传前会检查什么

新版规则：员工上传不依赖本地 telemetry config、ingest token 或 Cloudflare action-check。

上传准入只看这些：

| 检查项 | 目的 | 失败码 |
| --- | --- | --- |
| 本机工具链 | 确认 `git` 和 `gh` 可运行 | `git_missing` / `github_cli_missing` |
| GitHub 身份 | 确认本机当前 GitHub 账号 | `github_identity_not_available` |
| 仓库访问 | 确认能访问 `VIPTHINK/team-tools-hub` | `github_repo_access_failed` |
| `TEAM_ROSTER.md` 归属 | 确认 GitHub 账号匹配到唯一员工 | `roster_identity_not_found` |
| 姓名 / 团队 / 目录一致 | 防止传到错误员工目录 | `roster_identity_mismatch` |
| 本人目录 | 默认只能传到本人目录 | `target_path_not_owned` |
| P0 skill 版本 | 高风险动作前确认 3 个 P0 skill 为 GitHub 最新 | `core_skill_update_required` |
| 基础资产 | 确保别人能看懂、能运行、能复核 | `minimum_asset_gate_failed` |
| 敏感信息 | 阻断 token、密码、cookie、private key 等凭证类秘密 | `secret_scan_failed` |

以下情况不应该阻断员工上传：

- 未配置 telemetry endpoint。
- 没有本地 ingest token。
- Cloudflare usage 上报失败。
- `report_usage_event.py` 执行失败。

这些只记录 warning，例如：

```text
telemetry_not_configured
usage_report_skipped
```

## 如果提示需要升级

上传、更新仓库、打包、评估或交接写入前，如果本机 P0 skill 不是最新版，助手应该暂停当前动作，并用员工可理解的话提示：

```text
上传暂时停一下：你的 VIPTHINK 上传助手需要升级。

为什么要升级：新版会先保护你的本地项目，避免上传工具时误改你正在使用的文件。

请回复：确认升级
我会自动帮你更新。更新完成后，请重新打开你正在使用的 AI 工具；如果你用的是 Codex，就重新打开 Codex 或开启一个新对话，然后继续上传。
```

员工回复 `确认升级` 后，助手应执行安装脚本。更新成功后，不要立刻继续高风险动作；先要求员工重新打开当前 AI 工具，再继续。

## 正式运行目录保护

上传、更新仓库、打包、补资产、评估写入、工具交接写入或 GitHub mutation 前，助手必须区分：

```text
source_path：员工本地原项目，默认只读。
staging_path：为上传、包装、补资产创建的副本，可写。
target_path：VIPTHINK/team-tools-hub 内目标路径。
```

如果 `source_path` 是正式运行目录，例如：

- `~/.codex/skills/`
- Claude Code / TRAE / OpenClaw 的 skill 目录
- 生产脚本目录
- 正在使用的业务项目
- 用户明确说“正式项目 / 正在用 / 不能影响本地运行”

默认规则是：

```text
source_mutation_allowed=false
staging_required=true
```

没有确认 `staging_path` 前，不得修改源目录，不得在源目录生成 `README.md`、`project-meta.json`、`REPLAY.md`、`TOOL_REVIEW.md`、`CHANGELOG.md` 或脚本文件。

只有员工单独明确确认“允许修改源项目”，并列出精确文件范围，才可以改源目录。只说“准备上传 / 包装一下 / 走发布”不等于允许修改源项目运行文件。

## 上传前建议准备的资料

为了减少来回补资料，建议员工准备：

- 工具解决什么问题。
- 谁会用。
- 输入文件是什么格式。
- 输出文件是什么格式。
- 怎么运行。
- 依赖什么环境。
- 是否有可给公司内部同事看的样例输入。
- 是否有样例输出。
- 是否包含私人 token、账号密码、cookie、`.env` 或 private key。
- 是否正在从正式运行目录上传，是否需要 staging copy。

如果没有样例，助手会提示补 `samples/input/` 和 `samples/output/`。没有样例的工具很难复用和复核。

## 资产文件说明

员工上传到公司仓库的工具，通常需要这些文件：

| 文件 / 目录 | 解决的问题 |
| --- | --- |
| `README.md` | 让别人看懂工具用途、安装方式、运行方式、输入输出 |
| `project-meta.json` | 让工具能被注册表、搜索和治理系统识别 |
| `PUBLIC_SAFE_CHECKLIST.md` | 说明是否含凭证类秘密、内部资料可见范围和使用边界 |
| `REPLAY.md` | 让别人能复核工具是否能跑通 |
| `TOOL_REVIEW.md` | 记录复用准备度、风险、缺口和改进建议 |
| `CHANGELOG.md` | 记录版本变化 |
| `requirements.txt` / `pyproject.toml` / `package.json` | 说明代码依赖 |
| `samples/input/` | 提供输入样例 |
| `samples/output/` | 提供输出证据 |
| `docs/` | 放业务口径、字段说明、流程说明 |
| `tests/` / `evals/` | 放自动测试、手动检查清单或 prompt 回归 |

公司私密仓库内，业务解释材料、样例结构、可复跑输入输出默认优先保留；只阻断凭证类秘密。

## 什么不能上传

以下内容必须移除或脱敏：

- `.env`
- 私人 API token
- GitHub token
- cookie
- session
- password
- certificate
- private key
- 个人公开账号登录信息
- 未授权第三方源码或素材

以下内容在公司私密仓库内可以保留，但要说明来源和使用边界：

- 业务字段说明。
- 内部系统名称或 URL。
- 公司内部导出样例。
- 内部报表截图。
- 可复跑的 sample input / sample output。

## 不要做什么

- 不要直接调用 `github-project-packager` 上传。
- 不要直接调用 `vipthink-tool-quality-reviewer` 做正式上传。
- 不要把工具传到其他同事目录。
- 不要把个人项目直接传到 `通用&基建tools仓库/`。
- 不要把个人项目直接传到职能 Agent 仓库。
- 不要在聊天里发送 token、cookie、密码或私钥。
- 不要把 `~/.codex/skills/` 写成所有 AI 工具的唯一安装路径。
- 不要把 telemetry 失败解释成上传失败。

如果确实需要进入通用工具仓库或职能 Agent 仓库，由管理员走单独晋升流程。

## 常见问题

### 1. 我已经能访问仓库，但助手说 telemetry 未配置，能不能继续上传？

可以继续。

telemetry 只是 best-effort 使用记录，不是员工上传准入。只要 GitHub 身份、仓库访问、`TEAM_ROSTER.md` 归属、本人目录、P0 版本、基础资产和敏感信息检查通过，就可以继续。

### 2. 为什么要安装 3 个技能，但日常只调用 1 个？

为了降低员工认知成本。

员工只调用 `vipthink-tools-hub-assistant`。它会自动路由到后台 reviewer 和 packager。

### 3. 我想上传到自己的个人 GitHub 仓库怎么办？

必须明确说明：

```text
不要上传到 team-tools-hub。我要上传到 <owner>/<repo>。
```

否则默认按公司 `team-tools-hub` 处理。

### 4. 我想把项目放进通用工具仓库怎么办？

普通员工不要直接上传到通用工具仓库。

先上传到本人目录。后续由管理员根据复用证据、风险、维护责任和业务适配情况决定是否晋升。

### 5. 我离职、转岗或工具要交接怎么办？

调用：

```text
vipthink-tools-hub-assistant，帮我做工具资产交接。
```

助手会进入 `handover_tool_assets` 流程，整理 owner、backup owner、运行方式、样例、风险和后续维护建议。

### 6. 我用的不是 Codex，能不能用？

可以，但不要照抄 `~/.codex/skills/`。

这里的 `skill` 指 VIPTHINK 内部可复用工作流包，不等同于 Codex 专属 Skills。Claude Code、TRAE、OpenClaw 或其他 AI coding 工具应使用团队实际配置目录，或通过 `--target-skills-dir` / `VIPTHINK_SKILLS_DIR` 指定。

## 给员工的标准开场白

安装完成并重新打开 AI 工具后，可以直接这样使用：

```text
调用 vipthink-tools-hub-assistant。
我想上传一个工具到 team-tools-hub。
我的姓名是：<姓名>
项目路径是：<本地路径>
工具用途是：<一句话说明>
请先检查有没有已有工具能解决，再帮我补齐必要材料并准备上传。
```

如果只是找工具：

```text
调用 vipthink-tools-hub-assistant。
我想找一个能解决 <需求> 的工具。
输入是 <输入>，希望输出 <输出>，业务场景是 <场景>。
```

如果只是更新本机 P0 skills：

```text
请帮我检查并更新 VIPTHINK P0 skills。
如果本机版本低于 VIPTHINK/team-tools-hub main，请用 install_vipthink_p0_skills.py 或 install_or_update_p0_skills.py 更新。
更新后请输出 3 个本机 VERSION 和 GitHub main VERSION 的对照，并提醒我重新打开当前 AI 工具。
```

## 管理员补充

管理员需要维护：

- GitHub org / repo / team 权限。
- `分团队代码仓库/TEAM_ROSTER.md`。
- 新员工目录。
- 离职、转岗和 GitHub 账号变更。
- 通用工具仓库和职能 Agent 仓库的晋升规则。
- P0 installer / self-check 输出合同。
- 第二 owner 和支持兜底机制。

员工入口不负责：

- 判断工具是否晋升通用工具。
- 判断工具是否进入职能 Agent。
- 做人员排名或绩效评价。
- 作废离职员工权限。
- 组织级审计、删除、权限收回。

## 执行助手复核清单

每次员工安装、更新、自检或上传前，执行助手应重新复核 GitHub `main` 和本机安装版本。推荐命令：

```text
gh api user --jq '.login'
gh repo view VIPTHINK/team-tools-hub --json nameWithOwner,defaultBranchRef,viewerPermission,url
gh api repos/VIPTHINK/team-tools-hub/commits/main --jq '.sha'
gh api -H 'Accept: application/vnd.github.raw' 'repos/VIPTHINK/team-tools-hub/contents/通用&基建tools仓库/规范化工具/vipthink-tools-hub-assistant/VERSION?ref=main'
gh api -H 'Accept: application/vnd.github.raw' 'repos/VIPTHINK/team-tools-hub/contents/通用&基建tools仓库/规范化工具/github-project-packager/VERSION?ref=main'
gh api -H 'Accept: application/vnd.github.raw' 'repos/VIPTHINK/team-tools-hub/contents/通用&基建tools仓库/规范化工具/vipthink-tool-quality-reviewer/VERSION?ref=main'
python3 scripts/install_or_update_p0_skills.py --check-only --strict --yes
```

复核结论必须当场输出，不要引用本文档里的历史版本号作为当前最新版。若任一 P0 skill 缺少 `VERSION`、无法和 GitHub 最新版本比对、或本机版本落后，应先更新本机 skill，再继续上传、更新、打包、评估或交接写入。

## 本次优化说明

相对 2026-06-10 版，本版主要调整：

- 保留“不写死永久版本号”的规则，同时增加 2026-06-11 的远端版本快照和 commit evidence。
- 把手工 `rsync` 降级为兜底方式，主路径改为 `install_vipthink_p0_skills.py` / `install_or_update_p0_skills.py`。
- 补充 `--check-only --strict --yes`、`--target-skills-dir`、`VIPTHINK_SKILLS_DIR`、Windows `py -3`。
- 补充首次接入时的 `git_missing`、`github_cli_missing`、GitHub login 确认和仓库访问失败处理。
- 明确 `telemetry` 失败不阻断员工上传。
- 补充正式运行目录默认只读、需要 staging copy 的规则。
- 补充跨工具说明，避免把 VIPTHINK workflow package 误讲成 Codex-only skill。
- 补充 `tests/` / `evals/` 和依赖声明作为代码型工具的资产要求。
