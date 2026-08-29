# Lua-first EOC capability workflow / Lua-first EOC 能力流程

Status: active implementation workflow for the sole Lua-first Platform.

状态：唯一 Lua-first Platform 的当前开发流程。

## Objective / 当前目标

Close the Platform runtime, native domain services, and migration boundaries
before moving shipped JSON/EOC content. This is capability replacement, not
syntax replacement. Lua uses ordinary functions, modules, control flow,
typed handles, snapshots, named tasks, synchronous hooks, and domain services.

先闭合 Platform 运行时、原生领域服务和迁移边界，再迁移已发布的 JSON/EOC 语料。这里追求
能力替代而不是语法复刻；Lua 使用普通函数、模块、控制流、类型化句柄、snapshot、命名
任务、同步 hook 和领域服务。

Never add a JSON loader, EOC runner, legacy key tree, raw legacy object, or
hidden compatibility call. If a shape is not proven safe and bounded, the
migrator emits an explicit TODO and the ledger keeps it unverified or planned.

不得新增 JSON loader、EOC runner、旧键树、旧对象或隐藏兼容调用。无法证明安全且有界的形状
必须由迁移器输出明确 TODO，账本保持 unverified 或 planned。

## Domain batch unit / 领域批次单位

The unit of work is one coherent author workflow, not one selector. A complete
batch contains, as applicable:

- native `src/lua_platform_*` implementation and lifecycle boundary;
- LuaLS declarations in `data/lua/types/ccb_platform_v1.d.lua`;
- bounded migration output in `tools/migrate_lua_first.py`;
- regression-test source in `tests/lua_platform_test.cpp` or the matching
  Platform test;
- status-specific ledger evidence and a short architecture note.

实现单位是一个完整的作者工作流，而不是单个 selector。批次应同步包含原生
`src/lua_platform_*` 实现、LuaLS 声明、`tools/migrate_lua_first.py` 的有界迁移输出、
Platform 测试源码、状态对应的账本证据和必要的架构说明。

Recommended domains are character identity/health, inventory and item use,
map and world, NPC/creature, vehicle, mission/faction, weather/time,
dialogue/presentation, and persistent tasks. Group related conditions and
effects in one domain so the author workflow is composable.

## Implementation sprint / 开发冲刺规则

Until every source batch in the current roadmap is closed, the loop is limited
to:

- exact `rg` search and small-window source/document reads;
- `apply_patch` edits to implementation, declarations, test source, and
  checkpoint files;
- compact diff/path inspection;
- recording unresolved capability boundaries.

The loop must not run a C++ build, Catch2, Python suite, checker, generator,
full public-contract refresh, ledger refresh, documentation-registry refresh,
or full JSON/EOC corpus audit. Do not use a passing old output as evidence for
the renamed or newly edited source.

在当前 roadmap 的所有源码批次闭合前，只能做精确 `rg`、小窗口读取、`apply_patch`、路径/diff
检查和 checkpoint 记录。不得运行 C++ 编译、Catch2、Python 套件、checker、generator、
完整 public contract 刷新、ledger 刷新、documentation registry 刷新或全量 JSON/EOC 语料
审计。旧输出的通过结果不能作为重命名或新修改源码的证据。

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

## Final acceptance gate / 最终验收门禁

After all source batches are complete, run one gate in this order:

1. Generate the Platform native inventory, Platform v1 public contract, and
   Platform synchronization coverage.
2. Run the Platform LuaLS, native-inventory, public-contract, coverage, CMake,
   and tool-source checks selected by `ai/test-matrix.yml`.
3. Run one low-memory C++ build when native source changed.
4. Run one broad `[lua][platform]` Catch2 process, including relevant disabled
   and Mod-manager checks when routed.
5. Audit the real JSON/EOC inventories once and update remaining TODOs.
6. Refresh the generated replacement ledger, documentation registry, and
   migration reports only after their source inputs are final; inspect the
   final diff.

The three Platform references and generated reports are absent or stale during
the implementation sprint by design. A failure gets one focused diagnostic;
after repair return to the same gate instead of declaring a partial pass.

所有源码批次完成后只执行一次总门禁：先生成 Platform native inventory、Platform v1 public
contract 和同步 coverage；再运行 LuaLS/native/contract/coverage/CMake/工具检查；源码变化时
做一次低内存构建；运行一次 broad `[lua][platform]` Catch2；审计一次真实 JSON/EOC 语料；
最后刷新 ledger、documentation registry、迁移报告并检查 diff。开发冲刺期间三个 Platform
reference 和生成报告缺失或陈旧是有意状态。失败只能做一次聚焦诊断，修复后回到同一总门禁。

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
