# Lua-first EOC capability workflow / Lua-first EOC 能力流程

Status: active implementation workflow for the sole Lua-first Platform.

状态：唯一 Lua-first Platform 的当前开发流程。

## Objective / 当前目标

Close the Platform runtime, native domain services, and migration boundaries
for the PR scope. Lua is the only executable authoring language and the sole
behaviour system; this is capability replacement, not syntax replacement. Lua
uses ordinary functions, modules, control flow, typed handles, snapshots,
named tasks, synchronous hooks, and domain services. Passive,
schema-validatable JSON may remain and is loaded into the same typed C++
content model as Lua definitions.

先闭合本 PR 范围内的 Platform 运行时、原生领域服务和迁移边界。Lua 是唯一可执行作者语言
和唯一行为系统；这里追求能力替代而不是语法复刻。静态、被动且可由 Schema 校验的 JSON
可以保留，并与 Lua 定义进入同一个类型化 C++ 内容模型。

Never add a new public JSON loader, EOC runner, legacy key tree, raw legacy
object, or hidden compatibility call. The existing C++ JSON parser and EOC
runner remain private compatibility infrastructure for the C++ core and old
Mods during the transition; new Platform code does not depend on them. Delete
the EOC runner only after an exact reference audit proves that EOC references
are zero. If a shape is not proven safe and bounded, the migrator emits an
explicitly classified TODO and the ledger keeps it unverified or planned.

不得新增公开 JSON loader、EOC runner、旧键树、旧对象或隐藏兼容调用。过渡期间，现有 C++
JSON parser 和 EOC runner 作为本体及旧 Mod 的私有兼容基础设施保留，Platform 新代码不得
依赖它们；只有精确引用审计证明 EOC 引用归零后才可删除 runner。无法证明安全且有界的形状
必须由迁移器输出明确分类的 TODO，账本保持 unverified 或 planned。

## Domain batch unit / 领域批次单位

The unit of work is one coherent author workflow, not one selector or the whole
inventory. A capability-closure batch contains, as applicable:

- native `src/lua_platform_*` implementation and lifecycle boundary;
- LuaLS declarations in `data/lua/types/ccb_platform_v1.d.lua`;
- bounded migration output in `tools/migrate_lua_first.py`;
- regression-test source in `tests/lua_platform_test.cpp` or the matching
  Platform test;
- status-specific ledger evidence and a short architecture note.

实现单位是一个完整的作者工作流，而不是单个 selector 或整个语料。能力闭合批次应同步包含原生
`src/lua_platform_*` 实现、LuaLS 声明、`tools/migrate_lua_first.py` 的有界迁移输出、
Platform 测试源码、状态对应的账本证据和必要的架构说明。

Recommended domains are character identity/health, inventory and item use,
map and world, NPC/creature, vehicle, mission/faction, weather/time,
dialogue/presentation, and persistent tasks. Group related conditions and
effects in one domain so the author workflow is composable.

## Implementation sprint / 开发冲刺规则

Until every source batch required for the core Platform closure milestone in the
current roadmap is closed, the loop is limited to:

- exact `rg` search and small-window source/document reads;
- `apply_patch` edits to implementation, declarations, test source, and
  checkpoint files;
- compact diff/path inspection;
- recording unresolved capability boundaries.

The loop must not run a C++ build, Catch2, Python suite, checker, generator,
full public-contract refresh, ledger refresh, documentation-registry refresh,
or full JSON/EOC corpus audit. Do not use a passing old output as evidence for
the renamed or newly edited source.

在当前 roadmap 中核心 Platform 闭合所需的源码批次闭合前，只能做精确 `rg`、小窗口读取、
`apply_patch`、路径/diff 检查和 checkpoint 记录。不得运行 C++ 编译、Catch2、Python 套件、
checker、generator、完整 public contract 刷新、ledger 刷新、documentation registry 刷新或
全量 JSON/EOC 语料审计。旧输出的通过结果不能作为重命名或新修改源码的证据。

## Honest status vocabulary / 诚实状态口径

- `primitive_available_unverified`: native building blocks exist; no
  selector-level replacement claim is made.
- `bounded_implemented_unverified`: named real shapes have source,
  declaration, migration, test source, and documentation evidence; other
  legal shapes remain outside the claim.
- `implemented_unverified`: the Platform source path exists but the final
  semantic gate has not proved the relevant real inventory.
- `*_verified`: allowed only after the final semantic gate records native
  behavior and real JSON/EOC evidence for that exact disposition.
- `planned`: no bounded implementation claim exists yet.

- `primitive_available_unverified`：只有原生积木存在，不代表 selector 替代完成。
- `bounded_implemented_unverified`：明确的真实形状有源码、声明、迁移、测试源码和文档证据，
  其他合法形状不在声明内。
- `implemented_unverified`：Platform 源码路径存在，但相关真实语料尚未经过最终语义门禁。
- `*_verified`：只有最终语义门禁记录了该 disposition 的原生行为和真实 JSON/EOC 证据后才可用。
- `planned`：尚无 bounded 实现声明。

Ledger totals, public-symbol counts, generated synchronization counts, or a
small converted example never mean complete EOC capability.

账本总数、公开符号数量、生成同步数量或少量转换样例都不能代表 EOC 能力完整。

## Migration TODO taxonomy / 迁移 TODO 分类

Every TODO has one primary category and a source location:

- `auto_fix`: the required Platform API already exists, but the migrator does
  not generate the correct Lua shape yet; fix the migrator/output rather than
  adding a new core capability;
- `manual_rewrite`: an author or maintainer must express the workflow in
  ordinary Lua;
- `platform_gap`: a typed native service, registrar, or lifecycle boundary is
  missing. Only this category drives Platform core development;
- `semantic_choice`: the legacy shape has multiple intentional native
  interpretations and needs a human decision.

The category is part of the migration record, not a priority shortcut. TODOs
are boundary records, not completion records, and their counts are never a
completion metric. A capability closes when its stated source, declaration,
migration shape, test source, documentation, and safety boundary are closed.
Remaining TODOs may be preserved for later batches.

每个 TODO 都带一个主分类和源位置：`auto_fix` 表示所需 Platform API 已存在，但迁移器尚未生成
正确的 Lua 形状，应修复迁移器/输出而不是增加核心能力；`manual_rewrite` 是作者或维护者必须用普通 Lua 表达的 workflow；`platform_gap` 表示缺少类型化
native service、registrar 或生命周期边界，只有这一类会驱动 Platform 核心开发；
`semantic_choice` 表示旧形状存在多种有意的原生解释，需要人做选择。

分类是迁移记录的一部分，不是绕过优先级的捷径。TODO 是边界记录，不是完成记录，数量永远不是
完成指标。能力只有在其声明的源码、声明、迁移形状、测试源码、文档和安全边界闭合后才算完成；
剩余 TODO 可以留给后续批次。

## Final acceptance gate / 最终验收门禁

After all core source batches required by PR 664 are complete, run one gate in
this order:

1. Generate the Platform native inventory, Platform v1 public contract, and
   Platform synchronization coverage.
2. Run the Platform LuaLS, native-inventory, public-contract, coverage, CMake,
   and tool-source checks selected by `ai/test-matrix.yml`.
3. Run one low-memory C++ build when native source changed.
4. Run one broad `[lua][platform]` Catch2 process, including relevant disabled
   and Mod-manager checks when routed.
5. Classify the real JSON/EOC inventory entries once, preserving the four TODO
   categories and recording any remaining references to the legacy runner.
6. Refresh the generated replacement ledger, documentation registry, and
   migration reports only after their source inputs are final; inspect the
   final diff.

The three Platform references and generated reports are absent or stale during
the implementation sprint by design. A failure gets one focused diagnostic;
after repair return to the same gate instead of declaring a partial pass. This
gate accepts the core Platform foundation and generic capability scope named by
the roadmap; it does not require all core JSON/EOC content to migrate, passive
JSON to disappear, TODOs to reach zero, the EOC runner to be removed early, or
any independent follow-on capability batch to close. Follow-on batches have
their own scoped evidence and acceptance records.

PR 664 所需的核心源码批次完成后只执行一次总门禁：先生成 Platform native inventory、
Platform v1 public contract 和同步 coverage；再运行 LuaLS/native/contract/coverage/CMake/工具
检查；源码变化时做一次低内存构建；运行一次 broad `[lua][platform]` Catch2；分类一次真实
JSON/EOC 语料并记录旧 runner 引用；最后刷新 ledger、documentation registry、迁移报告并检查
diff。开发冲刺期间三个 Platform reference 和生成报告缺失或陈旧是有意状态。该门禁只验收
roadmap 指定的核心 Platform 基础设施和通用能力，不要求迁移全部本体 JSON/EOC、删除被动
JSON、TODO 归零、提前删除 EOC runner 或闭合任何独立后续能力批次。后续批次各自维护有界的
证据和验收记录。失败只能做一次聚焦诊断，修复后回到同一总门禁。

Cached gate results may be reused while the inputs relevant to that gate remain
unchanged. Once a change touches a relevant input, return to the final gate;
this workflow records the gate to run and claims no current gate result.

相关输入未变化时可以复用缓存的门禁结果；一旦修改触及相关输入，就必须回到最终门禁。本流程
只记录待执行的门禁，不声称本次文档批次有当前门禁结果。

## PR 664 closure and follow-on batches / PR 664 闭合与后续批次

PR 664 closes at the core Platform infrastructure and generic capability
boundary: one Platform v1 runtime and public `ccb` contract, a typed content
model and registrars, lifecycle and handle/identity safety, reusable generic
domain services, and an honest migration boundary. Passive schema-validatable
JSON may remain in the shared typed C++ model, and selected content migrations
remain later consumers. The EOC runner is removed only after an exact audit
proves that EOC references are zero.

PR 664 在核心 Platform 基础设施和通用能力边界闭合：唯一 Platform v1 runtime 与公开
`ccb` 契约、类型化内容模型和 registrar、生命周期与句柄/身份安全、可复用的通用领域服务，
以及诚实的迁移边界。静态且可由 Schema 校验的 JSON 可以保留在共享的类型化 C++ 模型中，
选定的内容迁移是后续消费者。只有精确审计证明 EOC 引用归零后，才删除 EOC runner。

High-priority follow-on work remains independently tracked and is not a
prerequisite for the PR 664 closure gate: the current standard-library
whitelist slice as incremental hardening, broader runtime hardening, shared
standard helpers, author-facing internationalization, and cookbook/console/
author experience. The whitelist changes are useful in this PR, but they do
not claim that resource budgets, callback instruction limits, process isolation,
or the wider hardening batch is complete; the broader items remain planned or
recommended. Each follow-on batch gets its own scope, evidence, and acceptance
record.

高优先级后续工作继续独立跟踪，不是 PR 664 闭合门禁的前置条件：当前标准库白名单切片作为
增量 hardening、更广泛的 runtime hardening、共享标准库 helper、面向作者的国际化，以及
cookbook/console/作者体验。白名单修改对本 PR 有价值，但不代表资源预算、callback 指令限制、
进程隔离或更广泛的 hardening 批次已经完成；其余项目仍是 planned 或 recommended。每个后续
批次都有自己的范围、证据和验收记录。

The names `ccb.std.collections`, `ccb.std.ui`, `ccb.std.inspect`, and
`ccb.std.text` are recommended candidates only for a future shared-helper
design. No `ccb.std` namespace, sub-namespace, or helper name is a frozen
Platform v1 contract. If implemented, such helpers continue to use the sole
`require("ccb")` entrypoint and typed model, but they are not dependencies of
`platform-capability-closure` or `final-acceptance-gate`.

`ccb.std.collections`、`ccb.std.ui`、`ccb.std.inspect`、`ccb.std.text` 只是未来共享 helper
设计的推荐候选。没有任何 `ccb.std` 命名空间、子命名空间或 helper 名称是冻结的 Platform v1
契约。若未来实现，这些 helper 仍沿用唯一 `require("ccb")` 入口和类型化模型，但不是
`platform-capability-closure` 或 `final-acceptance-gate` 的依赖。

## Evidence routing / 证据路径

Current implementation evidence must point to:

- `src/lua_platform_*.cpp` and `.h`;
- `data/lua/types/ccb_platform_v1.d.lua`;
- Platform schemas and Platform-only tool sources;
- `tools/migrate_lua_first.py` and its tests;
- `tests/lua_platform_test.cpp` or the matching Platform test;
- the real JSON/EOC inventory entry being classified.

The architecture specification and roadmap explain intent. They cannot promote
a status or replace a source/test/gate result.
