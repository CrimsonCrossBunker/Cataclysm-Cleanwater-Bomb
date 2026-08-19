# Lua-first EOC Capability Workflow / Lua-first EOC 能力开发流程

Status: active implementation and acceptance workflow for Lua-first EOC
capability parity.

状态：Lua-first EOC 能力等价工作的当前开发与验收流程。

## Immediate objective / 当前目标

Finish Lua as a standalone Mod authoring runtime that can express every
behaviour available through EOC.  Complete that capability surface before
migrating or deleting shipped JSON and EOC content.

先把 Lua 完善为独立的 Mod 创作运行时，使开发者无需 EOC 也能表达 EOC 可实现的全部
行为；完成能力面以后，再逐步迁移或删除本体与 Mod 中现有的 JSON/EOC 语料。

This is capability parity, not syntax parity.  Use normal Lua control flow,
functions, modules, persistent tasks, synchronous hooks, generation-safe
typed handles, and domain services.  Do not add EOC-key-shaped APIs, legacy
condition/effect trees, JSON loaders, EOC runners, or hidden compatibility
adapters to make a migration appear complete.

这里追求能力等价，而不是语法复刻。应使用普通 Lua 控制流、函数、模块、持久任务、
同步 hook、代际安全 typed handle 与领域服务；不得新增 EOC 键名式 API、旧 condition/
effect 树、JSON loader、EOC runner 或隐藏兼容层来伪造完成度。

Progress decisions come from actual C++ registration and lifecycle points,
Lua bindings and declarations, tests, and audits of real `data/**/*.json`
objects.  Roadmaps and prose help navigation but cannot prove coverage.

进度判断必须来自实际 C++ 注册与生命周期入口、Lua 绑定与声明、测试，以及真实
`data/**/*.json` 语料审计；roadmap 和说明文档只能帮助导航，不能证明覆盖率。

## Unit of work / 工作单元

The unit of implementation is a capability-domain batch, not an individual
legacy selector.  A batch should close a coherent author workflow such as:

- character health, pain, needs, vitamins, morale, and related mutation;
- inventory queries, stable item handles, bulk iteration, and item mutation;
- map and location queries plus typed terrain, furniture, field, and spawn
  mutation;
- NPC, monster, vehicle, faction, mission, spell, or persistent-task
  workflows.

实现单位是“能力领域批次”，不是单个旧 selector。例如，一个批次应完整闭合角色状态、
物品栏、地图位置、NPC/怪物/载具、任务/法术或持久任务中的一个开发者工作流。能由普通
Lua 表达的 `if`、数学、循环与函数调用不得被拆成对应的原生 selector API。

A batch includes native implementation, capability checks, LuaLS declarations,
migration output where applicable, and regression-test code.  Tests are
written with the implementation even though their execution is deferred.

一个批次同时包含原生实现、能力校验、LuaLS 声明、适用的迁移输出和回归测试代码。
测试代码随实现一起编写，但延后执行。

## High-throughput implementation loop / 高吞吐开发循环

During implementation:

1. Audit the real engine boundary and representative corpus shapes once for
   the domain.
2. Implement the complete domain batch continuously.
3. Keep declarations, migrator code, ledger evidence, and tests synchronized
   in the working tree.
4. Use read-only inspection and cheap diff checks as needed.
5. Do not compile C++, start Catch2, run the complete Python suites, regenerate
   every inventory, or repeat the corpus audit after each selector or edit.

开发过程中先审计一次真实边界和代表性语料，然后连续完成整个领域。声明、迁移器、账本
证据和测试代码保持同步，但不得为每个 selector 或小改动重复编译 C++、启动 Catch2、
运行完整 Python 套件、重新生成全部清单或反复扫描语料。

An early check is an exception.  Use it only when it is necessary to resolve
an otherwise uncertain native signature/lifetime/safety boundary, when the
user explicitly asks for it, or when diagnosing a failure already observed at
an acceptance gate.  Report the exception instead of silently returning to a
per-edit validation loop.

只有在无法通过源码检查解决原生签名、生命周期或安全边界疑问，用户明确要求，或者正在
定位验收失败时，才提前执行检查；不得无声地退回“每改一点就验证”的旧流程。

## Batch acceptance gate / 批次验收门禁

Run the acceptance gate after the requested milestone or coherent domain batch
is complete, and before commit, push, PR handoff, or a completion claim.

在请求的里程碑或完整领域批次结束后、提交或宣称完成之前，集中执行验收。

Acceptance order:

1. Regenerate affected checked-in contracts once.
2. Start one incremental low-memory C++ build when native code changed.
3. Run applicable Python contract/tool suites once; they may run in parallel
   with the build when they do not write the same generated files.
4. Run one broad Catch2 process that contains the affected Platform tests.
5. Audit the real EOC corpus once and record remaining capability gaps.
6. Run `git diff --check` and inspect the final tracked diff.

Recommended low-memory build for the current Linux workspace:

```sh
make -j6 NOOPT=1 DEBUGSYMS= BACKTRACE=0 ASTYLE=0 LINTJSON=0 LOCALIZE=0 \
  BUILD_PREFIX=ccb-lua-accept- tests
```

Run the broad Platform gate directly:

```sh
./tests/ccb-lua-accept-cata_test '[lua][platform]'
```

Do not run every focused filter before this broad gate.  A focused filter is
used only after the broad process fails, to diagnose and repair the failure.
After a repair, rerun the necessary focused filter and then the broad gate once
for final acceptance.  Multiple affected focused filters should be combined
into one Catch2 process whenever possible so game data is loaded only once.

不要在完整门禁之前逐个运行聚焦过滤器。只有完整进程失败后，才用聚焦过滤器定位和修复；
修复后先确认对应聚焦测试，再为最终验收重跑一次完整门禁。若必须覆盖多个聚焦标签，应尽量
合并到同一个 Catch2 进程，避免重复加载游戏数据。

Use `ai/test-matrix.yml` to select additional final gates.  Lua-disabled,
Android, CMake, JSON, localization, and broader `[lua]` validation are scoped
gates, not automatic requirements for every Lua-first batch.  Run them only
when the changed paths or behaviour actually require them.

`ai/test-matrix.yml` 用于选择额外的最终门禁。Lua-disabled、Android、CMake、JSON、
本地化以及更广的 `[lua]` 套件都是按影响范围触发的检查，不是每个 Lua-first 批次的固定
步骤。已经通过且其证据文件未再变化的门禁不得无意义重跑。

## Completion reporting / 完成报告

At handoff, state exactly:

- which capability-domain batch was closed;
- which source, declarations, migration support, and tests were added;
- which acceptance commands actually ran and their results;
- which expensive or platform-specific gates were skipped and why;
- what real corpus shapes remain unsupported.

Never equate a generated-ledger status, public-symbol percentage, successful
compilation, or a few converted examples with complete EOC capability parity.

交付时必须准确列出已闭合的领域、源码/声明/迁移器/测试改动、实际执行的验收及结果、
跳过的昂贵或平台专用门禁及原因，以及真实语料仍不支持的形状。不得把账本状态、公共符号
百分比、成功编译或少量转换样例误报为完整 EOC 能力等价。
