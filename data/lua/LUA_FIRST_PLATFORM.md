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
state per Mod separates ownership and ordinary Lua globals; it is not process
isolation, crash containment, a second runtime, or a second public API.

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
进入 Platform 契约；EOC 不是第二套行为系统。每个 Mod 一个独立 Lua state 用于区分 owner 和普通全局变量，
不代表进程隔离或崩溃隔离，也不是第二个 runtime 或第二套公开 API。

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
Mod-local module resolver. Under the accepted trusted-code policy, ordinary
Lua/package and native module loading also remain available; these are module
mechanisms, not alternative game-authoring APIs. It does not create a global
`game` table, a second
authoring entry, or a compatibility namespace. The Platform may own one Lua
state per loaded Mod for isolation; those states are all instances of this
same Platform runtime and share no alternate public contract.

Platform v1 是唯一受支持的 Lua 运行时、加载器、状态模型和作者契约。Mod 通过
`require("ccb")` 获得包内 `ccb` 表。加载器只注册 `package.loaded["ccb"]` 并提供根目录内
模块解析；按已采纳的可信代码契约，也允许普通 Lua/package 与原生模块加载。这些是模块
加载机制，不是另一套游戏创作 API。不创建全局 `game` 表、第二个作者入口或兼容命名空间。为隔离 Mod，Platform
可以为每个已加载 Mod 持有一个 Lua state；这些 state 都属于同一个 Platform 运行时，
不存在另一套公开契约。

The authoritative public declaration is
`data/lua/types/ccb_platform_v1.d.lua`. The public root contains the following
stable groups:

- `ccb.content` — transactional native definitions and content builders;
- `ccb.runtime` — named handlers, lifecycle hooks, synchronous callbacks, and
  persistent task policies;
- `ccb.dialogue` — typed dialogue topics, responses, and extensions;
- `ccb.services` — generation-checked world, character, item, creature, NPC,
  vehicle, map, weather, mission, faction, time, and presentation services;
- `ccb.state`, `ccb.tasks`, and `ccb.presentation` — bounded persistent and
  author-facing runtime support.

公开 LuaLS 声明是 `data/lua/types/ccb_platform_v1.d.lua`。公共根表稳定地分为
`ccb.content`（事务化原生定义）、`ccb.runtime`（命名 handler、生命周期 hook、同步回调和
持久任务）、`ccb.dialogue`（类型化对话与扩展）、`ccb.services`（代际安全的世界、角色、物品、地图、天气、任务等领域服务），
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

## Trust, libraries, and resource policy / 信任、库与资源契约

Accepted on 2026-09-06: Platform Mods are trusted executable code chosen by the
player, regardless of author or source. CCB does not promise to protect the
player's system from them. This is one Platform contract, not separate
restricted and unrestricted runtime tiers.

- Expose the complete bundled Lua standard library, including `io`, `os`,
  `debug`, and ordinary `load`, `loadfile`, `dofile`, and `package` facilities.
  Preserve `require("ccb")` as the stable game API and prefer local modules
  without making the Mod root a security boundary for other loading paths.
- Permit external Lua modules and native dynamic libraries where the host
  platform supports them. Native extensions are executable code with the game
  process's privileges; authors own OS, architecture, Lua ABI, and dependency
  compatibility. This does not create a stable ABI for internal C++ objects.
- Keep per-Mod Lua states for namespacing and ownership. A state is not a
  thread, a process sandbox, or protection against a native crash.
- Do not impose mandatory global Lua instruction or memory budgets by default.
  Profiling, diagnostics and explicitly enabled developer limits may assist
  debugging. Bounded queries, persistent data formats, valid parameters and
  handle/lifecycle checks in supported `ccb` services remain API correctness
  requirements, not a security boundary against trusted code.
- Present a clear execution-risk notice before first executing downloaded Mod
  code, including executable `mod.lua` metadata discovery. Selection to trust
  code is not a per-API permission dialog, and catalog inclusion is not a
  security guarantee. Record this as an integration requirement, not a claim
  that a launcher or game notice already exists.
- Report ordinary Lua errors with context and perform supported cleanup, but
  do not promise safe interruption of arbitrary loops/native calls, crash
  containment, or rollback of external filesystem/process side effects.

2026-09-06 已采纳：所有来源的 Mod 均按玩家选择运行的可信代码处理；CCB 不承诺保护玩家系统，
不划分两套受限/无限制运行时。开放完整 Lua 标准库、文件/系统/调试能力、外部 Lua 模块和
平台支持的原生动态库；`require("ccb")` 仍是稳定游戏接口，本地模块优先不是安全边界。
原生扩展作者负责系统、架构、Lua ABI 与依赖适配，引擎内部 C++ ABI 不因此成为稳定公开契约。
每 Mod 独立 state 只用于命名与 owner 隔离，不能隔离崩溃。默认不设全局执行指令或内存配额；
可提供自愿启用的诊断限制。`ccb` 的分页、有界数据格式、参数、句柄和生命周期校验继续保留。
首次执行下载的 Mod 代码前应明确告知风险，包含会执行代码的 `mod.lua` 发现阶段，不对每次
API 调用弹权限窗口。此告知是待落实的集成要求，不代表现有启动器已实现。普通 Lua 错误应可
定位与清理，但不承诺无限循环/原生调用可安全中断，也不承诺崩溃隔离或外部副作用回滚。

Implementation checkpoint (2026-09-06): `initialize_state` still uses a
standard-library whitelist, removes `io`/`os`/`debug` and native package loaders,
and restricts module resolution to the Mod root. Full-library and external/native
loading support is **accepted, pending implementation and runtime acceptance**.
The roadmap's `platform-hardening` entry now tracks this trust-policy transition
and reliability/diagnostics work; old sandbox and mandatory-budget plans are
superseded. This documentation update changes no running permissions.

实现断点：当前加载器仍使用白名单并移除系统库与原生加载入口，因此完整标准库与外部/原生模块
加载是**已采纳、待实现和运行验证**。roadmap 的 `platform-hardening` 改为跟踪此策略切换及
可靠性/诊断；旧沙盒和默认强制配额计划作废。本次文档修改不改变运行中的权限。

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

`ccb.content.extend_item_group(definition)` accepts a newly built `ItemGroup`
as an entry-only patch to an existing group of the same collection/distribution
kind. It preserves native entries and contributions from earlier Mods, keeps
the target's ammo/magazine defaults unchanged, and fingerprints the extension.
Candidate rollback restores the previous entry boundary. `edit_item_group`
instead clones a definition staged earlier by the same Mod; it is not a way
to extend a native group or another Mod's group.

`ccb.content.extend_item_group(definition)` 将新建的 `ItemGroup` 作为纯条目补丁，
追加到同类的既有物品组中，保留原生内容和更早 Mod 的条目，不改变弹药/弹匣默认概率。
追加内容参与指纹计算，候选事务回滚时恢复原有条目边界。`edit_item_group` 只克隆本 Mod
此前暂存的定义，不能代替这种跨 Mod 或原生物品组的扩展。

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

Mapgen callbacks may stage bounded static NPC and global zone requests with
`ScriptMapgenContext:queue_npc` and `queue_zone` (128 of each per callback).
They validate IDs and current-OMT coordinates without spawning external objects.
Failed callbacks discard the requests. After the map transaction commits, native
publication installs zones first, then NPCs with native unique-ID deduplication.
Publication is a post-commit phase, not part of submap rollback; native publication
errors are logged and do not turn a committed primary map into a fallback map.
Immediate `place_npc`, `place_zone`, vehicle and other external mutations remain
unavailable inside the callback. Ordinary runtime service writes remain blocked.
`ScriptMapgenContext:set_item_faction` is a map-only ownership operation: it
updates ground stacks and their contents inside the current OMT and participates
in submap rollback. It does not assign vehicle or vehicle-cargo ownership.

`ccb.presentation.canvas` runs a bounded frame callback in the native ImGui
window system, using registered tileset sprites rather than a second UI runtime.
It requires a ready world and an active runtime callback; no renderer means
`false` without invoking Lua drawing or charging for an interaction. Logical
canvas dimensions are 1..2048 pixels, scaled together to fit the display. Each
frame permits 4096 primitives and its context is invalidated on return, including
errors. Canvases cannot nest. They use real time without advancing game turns.
`allow_quit=false` requires the Mod to provide its own close control. Callback
failures close the window and propagate to the caller. Optional canvas music and
`ccb.presentation.play_sound` reuse native audio with canonical asset paths
confined to the owning Mod; temporary music is restored when the canvas exits.

Native barter UI and service payments are available through
`ccb.services.trade.open(npc, buyer, cost, title)` and `pay(npc, buyer, cost)`.
They require explicit live parties and reject any buyer other than the active
avatar; no removed dialogue-context purchase helpers or implicit avatar aliases
are restored. `order_price(npc, buyer, item_id, count)` is a read-only quote for
made-to-order goods using `npc_trading::trading_price_for_order`. Lua must
revalidate the price before payment and explicitly handle inventory delivery.
This is not a reservation of existing Items; existing-stock transfers continue
to use the exact-Item `quote/get/commit` API.

领域服务按原生职责组织，而不是按旧 selector 命名，覆盖身份与 snapshot、角色/生物/NPC/
物品/载具/任务/区域、背包与 crafting、地图与天气、时间与派系、对话、活动、hook、持久
任务和 presentation。每个服务都应说明读写阶段、边界、返回 envelope、生命周期保护和
失败行为；回调接收类型化 payload 与句柄，不接收任意引擎对象。

## Persistence, tasks, and failure semantics / 持久化、任务与失败语义

- Persist explicit serializable state and stable entity identities, not live
  handles, functions, C++ pointers, or arbitrary Lua globals. Exact scopes,
  accepted value types and payload bounds are defined in LuaLS and native code.
- Persistent tasks refer to named handlers and versioned payloads. On reload,
  resolve identities into fresh handles; unavailable entities, missing handlers
  and payload migrations follow the documented retry/failure policy.
- Native service results, optional values, errors, snapshots and cursors follow
  each declared signature. A detached snapshot is not a writable engine object;
  tokens/cursors can expire and must not be reused after their stated lifetime.
- Content registration rollback is not a universal gameplay transaction.
  Multi-step world operations are atomic only where the API explicitly promises
  it. Files, processes and native extension side effects remain author-owned.

持久化只保存明确可序列化的数据与稳定身份，不保存活句柄、函数、指针或任意全局变量；作用域、
类型与边界以 LuaLS/源码为准。持久任务绑定命名 handler 与版本化 payload，重载后重新解析
句柄，缺失实体/handler 与 payload 迁移遵循各自失败或重试约定。结果、快照和游标按具体签名
使用；快照不是可写引擎对象，失效 token 不可复用。内容注册回滚不等于任意世界操作有事务，
只有接口明确声明的操作才保证原子性；外部文件、进程和原生扩展副作用不在回滚承诺内。

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

Generated references, ledger, documentation registry, and migration reports are
outputs, never hand-edited evidence. Refresh them only when their declared
inputs change. Validation cadence, current priorities, and completion reporting
are defined once in [the EOC capability workflow](LUA_FIRST_EOC_WORKFLOW.md).

Platform reference、账本、文档 registry 与迁移报告是生成输出，禁止手改；只在声明的输入
变化时刷新。当前优先级、验证流程与完成度口径统一见 [EOC 能力流程](LUA_FIRST_EOC_WORKFLOW.md)。

PR 664's foundation scope and later capabilities retain their evidence in
`ai/lua-first-roadmap.yml`. They are not recurring prerequisites for every
change. Optional standard helpers, internationalization and author tools remain
separate needs. Proposed `ccb.std` helper names are not frozen public contracts;
any future implementation uses the sole `require("ccb")` entrypoint.

PR 664 的基础设施范围和后续能力证据保留在 roadmap，不作为每轮修改的重复前置条件。
可选标准 helper、国际化与作者工具按需求独立推进；候选 `ccb.std` 名称不是冻结公开契约，
未来实现仍使用唯一 `require("ccb")` 入口。

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
