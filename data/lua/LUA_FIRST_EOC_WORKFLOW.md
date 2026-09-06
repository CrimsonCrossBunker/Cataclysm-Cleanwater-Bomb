# Lua-first EOC capability workflow / Lua-first EOC 能力流程

Status: active workflow for the sole `require("ccb")` / Platform v1 system.
状态：唯一 `require("ccb")` / Platform v1 系统的当前开发流程。

## Objective / 当前目标

Work on one complete author workflow at a time, in this order:

1. Fix runtime blockers that prevent loading, playing, saving, or reloading.
2. Close and verify composable native domain capabilities needed to replace EOC.
3. Migrate shipped behaviour after capability acceptance; remove the EOC runner
   only when an exact reference audit proves its references are zero.

Lua is the sole executable authoring language. Passive schema-validatable JSON
may remain. Do not add public JSON loaders, EOC runners, legacy key trees, or
hidden compatibility calls; the transitional EOC path stays private.

每次只推进一个完整作者工作流：先修复加载、游玩、存档与重载阻塞，再补齐并验证替代 EOC
所需的领域能力，通过能力验收后迁移现有行为。精确引用审计证明 EOC 引用归零后才删除 runner。
静态 JSON 可以保留；Lua 是唯一可执行作者语言。不得新增公开 JSON loader、EOC runner、
旧键树或隐藏兼容调用。过渡期的旧 EOC 执行路径仍是私有兼容基础设施。

`ai/lua-first-roadmap.yml` retains milestone evidence; it is not a checklist to
repeat on every change. PR 664's foundation gate is historical scope. Optional
helpers, internationalization, and author tooling enter a batch when an actual
workflow needs them; they are not prerequisites for every Lua change.

roadmap 保留历史里程碑证据，不作为每次修改的待办清单。PR 664 的基础设施总验收属于历史范围。
可选 helper、国际化与作者工具按实际需求进入批次，不再成为每轮 Lua 开发的前置目标。

The accepted trust/library/resource policy is defined in
`LUA_FIRST_PLATFORM.md`. Reliability work means correct errors, lifecycle and
native API semantics; it does not restore a security sandbox or mandatory
runtime quotas. Track full-library/module-loader implementation separately from
accepting that policy.

信任、标准库和资源策略统一见架构契约；可靠性工作围绕错误、生命周期与原生接口正确性展开，
不恢复安全沙盒或默认强制运行配额。契约采纳与完整标准库/模块加载的实现验收分别记录。

## One domain batch / 单个领域批次

A batch records its author-visible result, affected files, unresolved boundary,
and acceptance evidence in one compact checkpoint. Include native implementation,
LuaLS declarations, relevant regression tests, and migration output when affected.
Use ordinary Lua functions and typed domain services, not selector-shaped APIs.
Do not create another progress tracker or update generated counts after each edit.

批次只记录作者可用结果、涉及文件、未解决边界和验收证据；同步修改受影响的实现、LuaLS 声明、
回归测试与迁移输出。用普通 Lua 和类型化领域服务组合行为，不按 selector 逐个复刻 API。
不另建进度系统，不在每次编辑后刷新生成统计。

## Validation / 验证流程

`ai/test-matrix.yml` lists available checks. Select them for the changed inputs;
it does not require every listed command for every Lua task.

| Change / 修改 | Batch acceptance / 批次验收 |
| --- | --- |
| Lua contract or its Python tools / Lua 契约及其 Python 工具 | Run the single contract suite below; it includes live repository checks and negative cases / 运行下方统一套件，包含真实仓库校验与反例 |
| Native Lua behaviour / 原生 Lua 行为 | Build once and run one matching Catch2 process; include lifecycle, saves and handles when affected / 一次构建、一个匹配的 Catch2 进程，按影响覆盖生命周期、存档和句柄 |
| Disabled-build integration / 禁用构建集成 | Add the disabled-build route when build inputs or disabled paths change / 构建输入或禁用路径变化时增加禁用构建验收 |
| Migration or real content / 迁移器或真实内容 | Check changed migration shapes and load affected content / 检查受影响的迁移形状并加载对应内容 |
| Workflow or prose only / 仅流程或说明 | Check affected metadata, links and workflow syntax / 检查相关元数据、链接与工作流语法 |

```sh
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

The suite calls the LuaLS, native-inventory, public-contract, synchronization,
and CMake checks. Their individual CLI commands remain available for diagnosis;
do not run all five again before or after the suite.

统一套件已执行 LuaLS、原生清单、公开契约、同步覆盖和 CMake 校验。各 CLI 保留用于定位问题，
不要在统一套件前后再重复运行五个检查器。

During implementation, write tests with the code. Use focused Python tests or
syntax checks when useful; defer C++ builds, broad suites and generated refreshes
to batch acceptance. A broad `[lua][platform]` run already includes
`[playable_mvp]`; do not run that subset again on the same binary and inputs.
Tool-only or documentation-only changes do not need a game build.

开发时测试随代码编写，按需执行聚焦 Python 测试或语法检查；C++ 构建、宽测试与生成刷新留到
批次验收。`[lua][platform]` 已包含 `[playable_mvp]`，相同程序和输入不重复运行子集。
只改工具或文档无需编译游戏。

Refresh generated outputs only when their declared inputs change, in dependency
order (native inventory, public contract, synchronization coverage). Ledger,
registry and migration reports follow the inputs of their generators listed in
`ai/generated-files.yml`.
Full corpus audits belong to corpus migration, parity claims, or EOC removal,
not every domain fix. Never hand-edit generated files.

只在声明的输入变化时刷新生成输出，按原生清单、公开契约、同步覆盖的依赖顺序执行。
ledger、registry 与迁移报告按 `ai/generated-files.yml` 指定生成器的输入决定是否刷新。全量语料
审计用于语料迁移、完整替代声明或删除 EOC，不是每个领域修复的固定步骤。禁止手改生成文件。

Reuse passing evidence while its inputs and build configuration remain unchanged.
After a failure, diagnose narrowly and rerun the affected gate after the fix.
Report exactly what ran and what remains unverified.

相关输入和构建配置不变时复用已通过证据；失败后聚焦定位，修复后重跑受影响门禁。
明确报告实际执行内容和仍未验证的部分。

## Completion and migration boundaries / 完成度与迁移边界

- `planned`: no bounded implementation claim / 尚无有界实现声明。
- `primitive_available_unverified`: native building blocks only / 只有原生积木，不代表 selector 替代完成。
- `bounded_implemented_unverified`: named shapes have implementation, declarations,
  migration and test source; other legal shapes remain outside the claim / 仅明确形状有实现、声明、迁移与测试源码。
- `implemented_unverified`: source exists, semantic acceptance is pending / 已有源码，语义验收未完成。
- `*_verified`: requires native behaviour and real JSON/EOC evidence for the exact
  claimed scope / 必须有对应范围的原生行为与真实语料证据。

Keep migration TODOs classified with a source location: `auto_fix` (existing API,
fix the migrator), `manual_rewrite` (ordinary Lua rewrite), `platform_gap` (missing
native capability), or `semantic_choice` (human intent needed). Only
`platform_gap` drives new Platform core capabilities.

迁移 TODO 保留源位置及四类分类：`auto_fix` 修迁移器、`manual_rewrite` 用普通 Lua 重写、
`platform_gap` 补原生能力、`semantic_choice` 明确人的意图。只有 `platform_gap` 驱动新增核心能力。
里程碑、符号、同步覆盖、TODO 数量和少量示例都不能换算为 EOC 完成率；源码已写、实际验证和
语料迁移必须分别报告。架构说明与 roadmap 不能替代源码、测试和验收证据。
