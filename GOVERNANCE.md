# CCB governance / CCB 治理

## Authority model / 权威模型

| Subject | Authoritative source |
| --- | --- |
| Runtime behaviour | CCB source and tests |
| JSON/Lua/API contracts | Schemas, LuaLS declarations, registrations, generated inventories |
| Build and validation | CI, CMake, Makefile, Gradle, repository validators |
| Contribution and governance | `AGENTS.md`, `CONTRIBUTING.md`, this file |
| Developer explanation | CCB-Docs |
| Player entry point | CCB website |
| Game-data lookup | CCB-GUIDE |

CCB-Docs never overrides a repository contract.  A conflicting page must be
marked stale and corrected against its listed source paths.

CCB-Docs 不覆盖仓库契约。发生冲突时，必须按页面列出的源码路径核对，将页面
标记为 stale 并修复。

## Responsible human

AI-assisted contributions and bot-authored pull requests are allowed.  Naming
the tool or model is optional.  Every pull request must name a Responsible
human who:

- understands the change and reviews the final diff;
- owns the reported test results;
- verifies licenses and external provenance;
- answers review questions and follows the change through merge or closure.

允许 AI 辅助及机器人创建 PR，不强制披露工具或模型。每个 PR 必须指定一名
Responsible human，负责理解修改、审查最终差异、确认测试、许可证、外部来源
并回答审阅问题。

## Cross-repository documentation protocol

1. A source PR declares documentation impact, related CCB-Docs PR, affected
   document IDs, and generated-reference impact.
2. A dependent docs PR may be prepared early, but remains draft and records the
   source PR/head commit.
3. After source merge, refresh the docs PR to the final commit, regenerate the
   catalog outputs, and rerun checks before human merge.
4. Enforcement is staged in `ai/docs-impact.yml`; a mapping becomes required
   only after its referenced documentation and default-branch checks are ready.

The Lua, JSON, and EOC documentation stacks may declare `bilingual_draft` while
their dependent pull requests are under review.  That state is auditable
provenance for a stacked Draft PR, not permission to merge enforcement early.
Before this enforcement reaches `master`, every mapped page must be refreshed
to the merged source commit and promoted according to the CCB-Docs catalog
policy.  Ordinary content and unrelated documentation fixes remain advisory.

Translation debt is enforced in CCB-Docs against the changed bilingual pair or
the same high-risk subsystem only.  Nightly automation may report global debt,
but neither source drift nor an overdue unrelated translation may make all
pull requests fail.

## Legacy documentation paths / 旧文档路径

When a legacy `doc/...` page is migrated in a later phase, its old repository
path remains permanently available as a lightweight bilingual moved stub.  The
old body may be removed six calendar months after migration, but the stub must
retain the stable document ID and current CCB-Docs URL so historical PRs,
issues, forks, and external links do not become dead ends.

后续迁移 `doc/...` 页面时，旧路径必须永久保留轻量双语 moved stub。迁移六个
自然月后可以删除旧正文，但 stub 必须保留稳定文档 ID 和最新地址。

## Repository-setting gate / 仓库设置门槛

The desired rules live in `ai/repository-settings.target.yml`.  They are not
automatically applied.  One Responsible human is sufficient; the currently
confirmed maintainer is `LYHGLYTX`.  A sole maintainer's own pull request must
not require a second or non-author approval, so the target approval count
remains zero and last-pusher approval remains disabled.  CI check names must
first succeed on the default branch.  Bots cannot replace the Responsible
human, approve their own work, or enable auto-merge.

一名 Responsible human 即可；当前确认的维护者是 `LYHGLYTX`。唯一维护者自己
创建的 PR 不得要求第二人或非作者批准，因此目标批准数保持为 0，也不启用最后
推送者之外的批准要求。必需检查仍须先在默认分支稳定成功；机器人不能取代
Responsible human、批准自己的修改或启用自动合并。

## Administrator checklist / 管理员清单

- Confirm the Responsible human account and its repository permissions.
- Keep the approval count at zero while one maintainer owns and authors pull requests.
- Confirm each intended required check has a stable, successful default-branch run.
- Configure CCB-Docs Pages to use GitHub Actions only after its CI is green.
- Grant scheduled issue/PR automation the minimum token permissions.
- Apply protection settings manually and record the date and operator.
- Never describe a repository setting as active merely because this file or a
  workflow was merged.
