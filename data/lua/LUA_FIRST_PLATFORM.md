# CCB Lua-first Platform v1 / CCB Lua-first 平台 v1

Status: accepted architecture specification for the sole CCB Lua Platform.
Implementation status is recorded in `ai/lua-first-roadmap.yml`; runtime
behaviour is proved by `src/lua_platform_*` and test source, not by this page.

状态：CCB 唯一 Lua Platform 的已接受架构规范。实现状态记录在
`ai/lua-first-roadmap.yml`；运行时事实以 `src/lua_platform_*` 和测试源码为准，本文不
把设计说明当作实现证明。

## Purpose / 目标

Platform Lua is the native authoring model for CCB core content and Mods. It
lets authors compose ordinary Lua functions, modules, native domain objects,
generation-safe handles, named tasks, and persistent state. Public operations
are shaped around game domains instead of parser keys.

Platform Lua 是 CCB 核心内容和 Mod 的原生创作模型。作者使用普通 Lua 函数、模块、原生
领域对象、代际安全句柄、命名任务和持久化状态组合行为；公开操作围绕游戏领域设计，
不暴露旧解析器的键名结构。

## Authoring boundary / 创作边界

For author-facing content, Lua is the only executable content language. All
new behaviour, policies, conditions, effects, and workflows enter through the
Platform contract; EOC is not a second behaviour system. One isolated Lua
state per Mod is an ownership and failure boundary, not a second runtime or a
second public API.

Static JSON may remain when it is passive, schema-validatable data. Such JSON
and Lua builders enter the same typed C++ content model; the distinction is
whether the source carries executable behaviour, not whether the source file
has a particular extension. The existing C++ JSON parser and EOC runner are
retained as private compatibility infrastructure for the C++ core and old
Mods while they still have consumers. No new Platform surface may depend on
them. The EOC runner is removable only after an inventory and reference audit
proves that EOC references have reached zero; retaining the parser for passive
or engine-owned JSON is not a failure of the Lua-first direction.

面向作者的内容只有 Lua 一种可执行语言。新的行为、策略、条件、效果和 workflow 都必须
进入 Platform 契约；EOC 不是第二套行为系统。每个 Mod 一个隔离 Lua state 只是 owner 和
故障边界，不是第二个 runtime 或第二套公开 API。

只要 JSON 是静态、被动且可由 Schema 校验，就可以长期保留。这样的 JSON 与 Lua builder
进入同一个类型化 C++ 内容模型；边界在于内容是否携带可执行行为，而不在于文件扩展名。
现有 C++ JSON parser 和 EOC runner 在仍被本体或旧 Mod 使用时作为私有兼容基础设施保留，
Platform 新接口不得依赖它们。只有语料和引用审计证明 EOC 引用归零后，才可以删除 EOC
runner；保留被动或引擎内部 JSON parser 不违背 Lua-first 方向。

## One runtime and one public entry / 唯一运行时与入口

Platform v1 is the only supported Lua runtime, loader, state model, and public
authoring contract. A Mod receives one package-local `ccb` table from:

```lua
local ccb = require("ccb")
```

The loader installs that table in `package.loaded["ccb"]` and provides a
root-local module resolver. It does not create a global `game` table, a second
authoring entry, or a compatibility namespace. The Platform may own one Lua
state per loaded Mod for isolation; those states are all instances of this
same Platform runtime and share no alternate public contract.

Platform v1 是唯一受支持的 Lua 运行时、加载器、状态模型和作者契约。Mod 通过
`require("ccb")` 获得包内 `ccb` 表。加载器只注册 `package.loaded["ccb"]` 并提供根目录内
模块解析，不创建全局 `game` 表、第二个作者入口或兼容命名空间。为隔离 Mod，Platform
可以为每个已加载 Mod 持有一个 Lua state；这些 state 都属于同一个 Platform 运行时，
不存在另一套公开契约。

The authoritative public declaration is
`data/lua/types/ccb_platform_v1.d.lua`. The public root contains the following
stable groups:

- `ccb.content` — transactional native definitions and content builders;
- `ccb.runtime` — named handlers, lifecycle hooks, synchronous callbacks, and
  persistent task policies;
- `ccb.services` — generation-checked world, character, item, creature, NPC,
  vehicle, map, weather, mission, faction, time, and presentation services;
- `ccb.state`, `ccb.tasks`, and `ccb.presentation` — bounded persistent and
  author-facing runtime support.

公开 LuaLS 声明是 `data/lua/types/ccb_platform_v1.d.lua`。公共根表稳定地分为
`ccb.content`（事务化原生定义）、`ccb.runtime`（命名 handler、生命周期 hook、同步回调和
持久任务）、`ccb.services`（代际安全的世界、角色、物品、地图、天气、任务等领域服务），
以及 `ccb.state`、`ccb.tasks`、`ccb.presentation` 等运行时支持。

## Mod discovery / Mod 发现

A minimal Mod has one root-level `main.lua`:

```text
my_mod/
└── main.lua
```

An optional root-level `mod.lua` may return `ccb.ModDefinition { ... }` for
explicit metadata and dependencies. The directory name and `main.lua` are the
defaults. `content/`, `runtime/`, `lib/`, and `tests/` are author choices;
templates may recommend them but the loader never requires them. A Platform
Mod does not require a `lua/` directory, `manifest.json`, `modinfo.json`, or
JSON/EOC author files.

最小 Mod 只需要根目录的 `main.lua`。可选的根目录 `mod.lua` 可以返回
`ccb.ModDefinition { ... }`，用于显式元数据和依赖；目录名和 `main.lua` 是默认值。
`content/`、`runtime/`、`lib/`、`tests/` 只是作者的组织选择，模板可以推荐但加载器不
强制。Platform Mod 不需要 `lua/`、`manifest.json`、`modinfo.json` 或 JSON/EOC 作者文件。

The local `require` helper resolves only safe module names inside the Mod root
(`?.lua` and `?/init.lua`). It rejects traversal and path escape. This is a
module boundary, not a sandbox promise: bundled Platform Lua is trusted code
and its native operations remain bounded by C++ validation.

## Loading and lifecycle / 加载与生命周期

The Platform lifecycle is a single transaction around the native engine:

1. discover root entries and parse optional native metadata;
2. resolve dependencies and create candidate Platform states;
3. run `main.lua` while static definitions are staged in `ccb.content`;
4. validate references, apply inheritance/patch operations, finalize native
   registries, and retain only a valid candidate;
5. commit the candidate atomically or roll it back in reverse registration
   order;
6. expose world-ready services and run named lifecycle/task policies;
7. retire states and invalidate their handles on shutdown or world replacement.

World and runtime generations are checked together with an opaque owner
identity. A handle copied within its owner remains a value, but it cannot be
used after owner retirement, runtime replacement, world replacement, or an
invalidated transaction. Raw C++ pointers, lifetime owners, and internal
generation counters are never part of the Lua contract.

Platform 生命周期围绕原生引擎形成一条事务链：发现入口、解析依赖、创建候选 state、在
`ccb.content` 中暂存定义、校验引用并 finalize、成功后原子提交或逆序回滚、进入
world-ready 后提供服务，最后在退出或世界替换时使旧句柄失效。句柄访问同时校验
owner 身份、runtime 代次和 world 代次；C++ 裸指针、owner 和内部代次计数器不属于 Lua
契约。

Runtime code may be swapped only when the static content fingerprint is
unchanged. A changed content fingerprint requires a full data reload. Runtime
replacement preserves only the state explicitly defined by Platform lifecycle
and persistence rules; external filesystem or process side effects are trusted
code responsibilities and are not silently rolled back.

## Native content model / 原生内容模型

`ccb.content` is a pure-Lua native typed builder and registrar surface, not a
JSON key mirror or raw JSON pass-through. Domain-specific typed option tables
are valid inputs when the corresponding builder declares and validates them;
they are not generic legacy objects for a later loader. A domain builder has a
stable id, bounded scalar inputs, typed references, and explicit transaction
ownership. The registrar design supports the following operations where the
domain requires them:

- add a new definition;
- replace or extend an earlier definition with clear ownership;
- delete only an entry owned by the current transaction;
- resolve references in deterministic dependency order;
- finalize caches and derived relationships once;
- undo every mutation in reverse order on candidate failure.

Complex registrar work is still an implementation milestone. Until a domain's
source, declaration, migration shape, test source, and documentation are
closed, its ledger disposition remains unverified or bounded. Unsupported
inheritance, dynamic references, implicit defaults, or side effects become
classified migration TODOs rather than hidden parser calls. A registrar may
share the typed C++ storage and finalization pipeline with passive JSON, but
that implementation reuse never changes the Lua authoring contract into a JSON
loader.

`ccb.content` 是纯 Lua 原生类型化 builder/registrar，而不是 JSON key 镜像或 raw JSON
透传。只要相应 builder 声明并校验，领域化的类型化 option table 就可以作为输入；它们
不是交给旧 loader 的通用旧对象。定义具有稳定 id、有界标量、类型化引用和明确事务 owner；
按领域需要支持 add、replace/extend、owned delete、确定性引用顺序、finalize 和逆序 undo。
复杂 registrar 仍是实现里程碑；在源码、声明、迁移形状、测试源码和文档闭合前，账本只能
标记未验证或 bounded。未支持的继承、动态引用、隐式默认值和副作用必须转为分类明确的
TODO。实现可以与被动 JSON 共用类型化 C++ 存储和 finalize 管线，但不能因此把 Lua 契约
变成 JSON loader，也不能直接接受 `JsonObject` 或 raw JSON pass-through。

## Domain services / 领域服务

The current Platform surface is organized by native responsibility rather than
legacy selector names. Important service families include:

- identity and snapshots for characters, creatures, NPCs, items, vehicles,
  missions, zones, and world locations;
- bounded inventory, equipment, item-use, crafting, recipes, requirements,
  mutations, bionics, skills, proficiencies, martial arts, effects, and needs;
- map, overmap, weather, time, factions, camps, hordes, gates, mapgen, and
  world information;
- dialogue, activities, interactions, hooks, named tasks, messages, and
  presentation callbacks.

Each service documents read/write phase, bounds, return envelope, lifetime
guards, and failure behavior. Read operations require a readable active
Platform context. Mutations require the correct transaction or runtime phase.
Callbacks receive typed payloads and handles, not arbitrary engine objects.

领域服务按原生职责组织，而不是按旧 selector 命名，覆盖身份与 snapshot、角色/生物/NPC/
物品/载具/任务/区域、背包与 crafting、地图与天气、时间与派系、对话、活动、hook、持久
任务和 presentation。每个服务都应说明读写阶段、边界、返回 envelope、生命周期保护和
失败行为；回调接收类型化 payload 与句柄，不接收任意引擎对象。

## Behaviour instead of EOC / 用 Lua 行为表达能力

Lua expresses conditions, effects, branching, loops, composition, and policy
with ordinary code over Platform services. A native service can expose a
bounded operation such as a snapshot query or a typed mutation; it must not
recreate an EOC key tree, a JSON loader, or an opaque runner.

The active capability workflow is
`data/lua/LUA_FIRST_EOC_WORKFLOW.md`. Work is grouped into coherent domain
capability batches, not a promise to migrate the whole inventory. A bounded
disposition means named real shapes work; it does not mean the selector,
domain, or corpus is complete. A primitive disposition means native building
blocks exist; it is not migration parity. Only the final semantic gate may
promote a disposition to verified.

The legacy C++ JSON parser and EOC runner remain private compatibility paths for
core and old-Mod definitions during the transition. Platform definitions do
not call them. When the last EOC reference is gone, the runner can be deleted;
that deletion is a separate retirement gate and does not require deleting all
passive, schema-validated JSON.

Lua 使用 Platform 服务表达条件、效果、分支、循环和策略。原生服务可以提供有界 snapshot
查询或类型化变更，但不能重建 EOC 键树、JSON loader 或不透明 runner。EOC 能力工作遵循
`data/lua/LUA_FIRST_EOC_WORKFLOW.md`，按完整领域能力批次推进，而不是承诺迁移整个语料。
bounded 只表示明确的真实形状可用，不表示 selector、领域或语料已完成；primitive 只表示
原生积木存在；只有最终语义门禁可以提升为 verified。

过渡期间，现有 C++ JSON parser 和 EOC runner 作为本体及旧 Mod 定义的私有兼容路径保留，
Platform 定义不会调用它们。最后一个 EOC 引用消失后才进入 runner 删除门禁；这不要求删除
所有静态、可由 Schema 校验的 JSON。

## Migration TODO taxonomy / 迁移 TODO 分类

Every migration TODO carries one primary category and a source location:

- `auto_fix` — the required Platform API already exists, but the migrator does
  not generate the correct Lua shape yet; fix the migrator/output rather than
  adding a new core capability;
- `manual_rewrite` — an author or maintainer must express the workflow in
  ordinary Lua because there is no safe mechanical translation;
- `platform_gap` — the required typed native service, registrar, or lifecycle
  boundary does not exist yet; only this category drives Platform core work;
- `semantic_choice` — the old shape permits more than one intentional native
  interpretation and a human must choose the desired behaviour.

TODOs are boundary records, not completion records or a progress score. A
smaller TODO count can hide a lossy rewrite, while a larger count can be honest
evidence of bounded coverage. Platform closure is judged by the source,
declaration, tests, documentation, and safety boundary of each capability
batch; no milestone requires TODOs to reach zero.

每个迁移 TODO 都带一个主分类和源位置：`auto_fix` 表示所需 Platform API 已存在，但迁移器
尚未生成正确的 Lua 形状，应修复迁移器/输出而不是增加核心能力；`manual_rewrite` 是作者或维护者必须用普通 Lua 重写的工作流；`platform_gap` 表示所需
的类型化 native service、registrar 或生命周期边界尚不存在，只有这一类会驱动 Platform 核心
开发；`semantic_choice` 表示旧形状存在多个有意的原生解释，必须由人选择行为。

TODO 是边界记录，不是完成记录或进度分数。更少的 TODO 可能意味着有损重写，更多的 TODO 反而可能是
诚实的有界覆盖。Platform 是否闭合要看每个能力批次的源码、声明、测试、文档和安全边界，
任何里程碑都不要求 TODO 归零。

## Tools and evidence / 工具与证据

The source of current Platform references is deliberately small:

- `data/lua/types/ccb_platform_v1.d.lua` — LuaLS contract;
- `src/lua_platform_*.cpp` and `.h` — native registrations and lifecycle;
- `data/lua/reference/ccb_platform_*.schema.json` — explicit schemas;
- `tools/lua_api/generate_platform_native_inventory.py` and its checker;
- `tools/lua_api/generate_platform_contract.py` and its checker;
- `tools/lua_api/generate_platform_coverage.py` and its checker;
- `tools/agent/generate_lua_first_replacement_ledger.py` — real JSON/EOC
  disposition source;
- `tools/migrate_lua_first.py` and `tests/lua_platform_test.cpp` — migration
  and semantic evidence sources.

The generated Platform references, ledger, documentation registry, and
migration reports are outputs. They are not hand-edited evidence and are
refreshed together at the final acceptance gate.

当前 Platform 参考资料只来自 LuaLS 声明、`lua_platform_*` 原生注册、Platform schema、
Platform 工具、迁移器和测试源码。Platform reference、账本、文档 registry 与迁移报告都
是生成输出，不手工编辑，统一留到最终门禁刷新。

Cached gate results may be reused while the inputs relevant to that gate remain
unchanged. Once a change touches a relevant input, the final gate must be run
again; this documentation batch claims no current gate result.

相关输入未变化时可以复用缓存的门禁结果；一旦修改触及相关输入，就必须重新回到最终门禁。
本次文档批次不声称任何当前门禁结果。

## Development sprint and acceptance / 开发冲刺与验收

Before all core source batches required by PR 664 are closed, the implementation
loop permits focused read-only search, narrow source reads, test-source edits,
and compact checkpoints. It does not run a C++ build, Catch2, Python suite,
checker, generator, full contract refresh, ledger refresh, or full JSON/EOC
audit.

The final gate runs once, in dependency order: generate the Platform native
inventory, public contract, and synchronization coverage; run applicable
Platform checkers and tool tests; perform one low-memory build; run one broad
Platform Catch2 process; classify the real JSON/EOC inventories once; then
inspect the final diff. This gate accepts the core Platform infrastructure and
generic capability scope named by the roadmap. It does not require migrating
all core JSON/EOC content, deleting passive JSON, reducing TODOs to zero, or
closing any independent follow-on capability batch. A failure receives one
focused diagnostic and returns to the same gate after repair.

在 PR 664 所需的核心源码批次闭合前，只允许精确搜索、小窗口读取、测试源码修改和
checkpoint；不运行编译、Catch2、Python 套件、checker、generator、完整契约刷新、账本刷新或
全量 JSON/EOC 审计。最终门禁只运行一次，按生成 reference、运行 Platform 检查和工具测试、
一次低内存构建、一次 broad Platform Catch2、一次真实语料分类、最终 diff 的顺序执行。
该门禁只验收 roadmap 指定的核心 Platform 基础设施和通用能力，不要求迁移全部本体 JSON/EOC、
删除静态 JSON、把 TODO 降到零或闭合任何独立的后续能力批次。失败只做一次聚焦诊断，修复后
回到同一总门禁。

## PR 664 boundary / PR 664 边界

The reasonable endpoint for PR 664 is the core Platform foundation and generic
capability closure: one Platform v1 runtime and `ccb` contract, a typed content
model and registrars, lifecycle and handle/identity safety, reusable generic
domain services, and an honest migration boundary. Passive schema-validatable
JSON may remain in the shared typed C++ model, and the EOC runner remains a
private legacy path until an exact audit proves that its references are zero.
Core and bundled content migration remains a later consumer of the Platform.
Runtime hardening, optional standard helpers, author-facing internationalization,
and cookbook/console/author-experience work are high-priority follow-on batches;
none is a prerequisite for closing or merging PR 664.

PR 664 的合理终点是核心 Platform 基础设施和通用能力闭合：唯一 Platform v1 runtime 与
`ccb` 契约、类型化内容模型和 registrar、生命周期与句柄/身份安全、可复用的通用领域服务，
以及诚实的迁移边界。静态且可由 Schema 校验的 JSON 可以保留在共享的类型化 C++ 模型中；
EOC runner 作为私有旧路径保留，直到精确审计证明 EOC 引用归零。核心与捆绑内容迁移是
Platform 的后续消费者。runtime hardening、可选标准库 helper、面向作者的国际化以及
cookbook/console/作者体验是高优先级后续批次，都不是 PR 664 闭合或合并的前置条件。

## Follow-on capability batches / 后续能力批次

The roadmap keeps the following high-priority work independently trackable
rather than treating it as a frozen Platform v1 contract: the current
standard-library whitelist slice as incremental hardening, broader runtime
hardening, shared standard helpers, author-facing internationalization, and
cookbook/console/author experience. The whitelist changes are useful in this
PR, but they do not claim that memory budgets, callback instruction limits,
process isolation, or the wider hardening batch is complete; the broader items
remain planned or recommended follow-ons.

The names `ccb.std.collections`, `ccb.std.ui`, `ccb.std.inspect`, and
`ccb.std.text` are recommended candidates for a future shared-helper design
only. No `ccb.std` namespace, sub-namespace, or helper name is a frozen public
contract; any such design gets its own declarations, tests, documentation, and
acceptance record. The follow-on batches continue to use the sole
`require("ccb")` entrypoint and typed model if implemented, but none is a
dependency of `platform-capability-closure` or `final-acceptance-gate`.

roadmap 会把以下高优先级工作独立跟踪，而不是把它们冻结为 Platform v1 契约：当前标准库
白名单切片作为增量 hardening、更广泛的 runtime hardening、共享标准库 helper、面向作者的
国际化，以及 cookbook/console/作者体验。白名单修改对本 PR 有价值，但不能据此声称内存预算、
callback 指令限制、进程隔离或更广泛的 hardening 批次已经完成；其余项目仍是 planned 或
recommended 后续批次。

`ccb.std.collections`、`ccb.std.ui`、`ccb.std.inspect`、`ccb.std.text` 只是未来共享 helper
设计的推荐候选；没有任何 `ccb.std` 命名空间、子命名空间或 helper 名称是冻结的公开契约。
后续如实现，应各自补充声明、测试、文档和验收记录。后续批次如实现，继续使用唯一
`require("ccb")` 入口和类型化模型，但都不是 `platform-capability-closure` 或
`final-acceptance-gate` 的依赖。

## Templates, examples, and maintenance / 模板、样例与维护

`data/lua/templates/minimal/` and `complete/` are authoring scaffolds. The
bundled `data/mods/Lua_First_Example/` is a runnable root-`main.lua` example;
it demonstrates a vertical slice, not whole-platform completion. Templates
may suggest `content/`, `runtime/`, and local modules but must not turn those
suggestions into loader requirements.

Changes to discovery, lifecycle, native registrations, declarations, schema,
migration behavior, or roadmap status update this specification and the
affected CCB-Docs ids. Source and tests remain authoritative; prose never
promotes a planned capability into a shipped one.

`data/lua/templates/minimal/`、`complete/` 是创作脚手架，内置
`data/mods/Lua_First_Example/` 是根目录 `main.lua` 的可运行纵向样例，不代表整个平台完成。
模板只能建议目录结构，不能把建议变成加载器要求。发现、生命周期、原生注册、声明、
schema、迁移行为或 roadmap 状态变化时同步更新本文和对应 CCB-Docs id；源码与测试始终
优先于说明文案。
