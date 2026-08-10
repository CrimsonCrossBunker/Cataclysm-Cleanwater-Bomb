# CCB Lua-first Platform v1 / CCB Lua 优先平台 v1

Status: accepted long-term architecture; implementation is tracked in
`ai/lua-first-roadmap.yml`.

状态：已接受的长期架构方向；实际实现进度以 `ai/lua-first-roadmap.yml` 为准。

## Purpose / 目标

Lua-first Platform v1 is the target authoring model for CCB core content and
Mods.  It is intended to let an author define metadata, items, recipes,
vehicles, creatures, world generation, dialogue, missions, UI, and runtime
behaviour without authoring JSON or EOC.

Platform v1 is not a spelling change for JSON or EOC.  Lua code should use
functions, modules, native objects, normal control flow, composition, named
tasks, and persistent state.  New public APIs must be shaped around the game
domain, not around legacy parser keys.

Lua-first Platform v1 是 CCB 核心内容与 Mod 的目标创作模型。最终作者应能在不编写
JSON 或 EOC 的情况下定义 Mod 元数据、物品、配方、载具、怪物、地图生成、对话、
任务、UI 与运行时行为。

Platform v1 不是把 JSON/EOC 换一种拼写。Lua 应使用函数、模块、原生对象、普通控制
流、组合、命名任务和持久状态；公共 API 应围绕游戏领域设计，而不是复刻旧解析器键。

## Current boundary / 当前边界

The current implemented contract is Lua API v5.  It starts after JSON data is
finalized and primarily queries or controls objects already defined by C++ and
JSON.  It remains supported while Platform v1 is built, but it must not be
described as if Lua-first static content already exists.

The checked inventories currently contain 190 JSON top-level object types,
275 canonical EOC condition keys, and 310 canonical EOC effect keys.  These
inventories are migration denominators, not a list of Lua APIs to reproduce.

当前已实现的契约是 Lua API v5。它在 JSON 数据 finalize 之后启动，主要查询或控制由
C++/JSON 已经定义的对象。Platform v1 建设期间继续支持 v5，但不得把尚未实现的静态
Lua 内容能力写成现状。

当前受检清单包含 190 个 JSON 顶层类型、275 个规范 EOC condition 键和 310 个规范
EOC effect 键。它们是迁移分母，不是要逐项复制的 Lua API 清单。

## Zero-configuration discovery / 零配置发现

A minimal Platform v1 Mod has one required convention: a `main.lua` at the Mod
root.  No `lua/` directory, `manifest.json`, or `modinfo.json` is required.

```text
my_mod/
└── main.lua
```

Defaults are derived without configuration:

- the directory name is the Mod id and display name (a hybrid root inherits
  its sole stable legacy id when no Platform id is supplied);
- dependencies are empty;
- the platform version is 1;
- `main.lua` is the content and runtime registration entry point.

Subdirectories such as `content/`, `runtime/`, `lib/`, and `tests/` are author
choices.  Templates may recommend them, but the loader must not require them.
Local `require` searches the Mod root for `?.lua` and `?/init.lua`; trusted
scripts cannot redirect this helper through `package.path`, and module names
containing traversal or path separators are rejected.  Full-library scripts
can still perform explicit filesystem or native loading, which remains inside
the trusted-code boundary rather than the portable module contract.

最小 Platform v1 Mod 只约定根目录存在 `main.lua`。不强制 `lua/` 目录，也不需要
`manifest.json` 或 `modinfo.json`。目录名默认同时作为 Mod ID 与显示名，依赖默认为
空，Platform 版本默认为 1。`content/`、`runtime/`、`lib/`、`tests/` 等目录只属于
作者的组织选择，模板可以推荐，引擎不能强制。
本地 `require` 只解析 Mod 根目录内的 `?.lua` 与 `?/init.lua`，不接受路径穿越，且不被
脚本修改后的 `package.path` 重定向。可信脚本仍可显式使用文件和原生加载能力，但这不
属于可移植模块契约。

### Optional `mod.lua` / 可选高级元数据

An advanced Mod may add root `mod.lua`.  It returns a native
`ccb.ModDefinition` and may override the stable id, display name, version,
dependencies, core flag, or entry point.  The entry point defaults to
`main.lua` and must remain inside the packaged Mod root.

The Mod manager executes `mod.lua` while scanning installed Mods.  Platform v1
is therefore a trusted in-process extension system: placing a Mod in a scanned
directory may execute code before the player enables it.  User-facing Mod
screens and documentation must state this prominently.

高级 Mod 可以增加根目录 `mod.lua`，返回原生 `ccb.ModDefinition`，用于覆盖稳定 ID、
显示名、版本、依赖、核心 Mod 标记或入口路径。扫描安装目录时就会执行 `mod.lua`。
因此 Platform v1 是可信的进程内扩展系统：把 Mod 放进扫描目录本身就可能执行代码，
不必等到玩家启用。Mod UI 与文档必须醒目说明这一点。

The implemented bootstrap constructor is imported with `require("ccb")`:

```lua
local ccb = require("ccb")

return ccb.ModDefinition {
    id = "my_mod",
    name = "My Mod",
    version = "1.0.0",
    dependencies = { "dda" },
    entry = "main.lua",
}
```

`ModDefinition` is native userdata, not a metadata-shaped Lua table.  Its
current LuaLS contract is `data/lua/types/ccb_platform_v1.d.lua`.  Returning a
plain table, an empty or `#`-containing id, a self dependency, a duplicate id,
duplicate or non-dense dependency entries, over-limit metadata, or an entry
outside the Mod root rejects the Platform candidate.  A hybrid
root may attach Platform code to exactly one legacy `MOD_INFO`.  An omitted
Platform id inherits that stable legacy id; an explicit Platform id must agree
with it.

Rejected pure-Platform candidates remain visible in the installed-Mod catalog
under their directory id with a bounded diagnostic and cannot be enabled.  A
hybrid Mod with malformed optional Platform metadata keeps its legacy content
available while showing the rejected-entry reason; discovery failures are not
left only in the debug log.  If that directory id is already occupied, the
catalog assigns the rejected diagnostic entry a deterministic
`_lua_platform_rejected_N` suffix so neither candidate is hidden.

A build compiled without Lua support applies the same rule without executing
`mod.lua`: pure Platform roots remain visible and unavailable, while a hybrid
root keeps its legacy content and records that its optional Platform entry is
disabled.  This prevents a world from accepting a Mod that can only fail later
during data loading.

未启用 Lua 的构建不会执行 `mod.lua`，但采用相同规则：纯 Platform 根目录仍显示为
不可用；混合根目录保留旧内容，只记录可选 Platform 入口被禁用，避免直到世界数据
加载时才失败。

已实现的引导构造器通过 `require("ccb")` 导入。`ModDefinition` 是原生 userdata，
不是模仿 JSON 的 Lua table；当前 LuaLS 契约位于
`data/lua/types/ccb_platform_v1.d.lua`。普通 table、空 ID、含 `#` 的 ID、自依赖、
重复 ID、逃逸 Mod 根目录的入口都会被拒绝。混合 Mod 根目录只能包含一个旧
`MOD_INFO`；省略 Platform ID 时继承该稳定旧 ID，显式填写时则必须与旧 ID 一致。
被拒绝的纯 Platform 候选仍会以目录 ID 出现在已安装 Mod 列表中，显示有界错误且不可
启用；混合 Mod 的可选 Platform 元数据无效时，旧内容仍可使用并显示拒绝原因，不会只
把失败藏在调试日志里。如果目录 ID 已被占用，诊断项会使用确定性的
`_lua_platform_rejected_N` 后缀，避免任一候选被静默隐藏。

## Trust model / 信任模型

Platform v1 opens the complete bundled Lua 5.4 standard libraries, including
`io`, `os`, `debug`, coroutines, dynamic loading, and normal package support.
It does not use the v5 capability sandbox.  An enabled or discovered Platform
Mod runs with the game process privileges and can read files, start processes,
or load native code where the host platform permits it.

This choice maximizes extension power but removes an untrusted distribution
boundary.  The official API still defines portable behaviour; host-specific
I/O, processes, native modules, and side effects cannot be rolled back and may
not work on every platform.

Interactive Mod selection asks for explicit confirmation before adding any
new Platform Mod, including trusted Platform dependencies pulled in by a
non-Lua selection.  Rebuilding an already selected Mod order does not prompt.
This consent protects entry execution; it cannot undo the documented fact that
`mod.lua` may already execute during discovery.

Platform v1 开放捆绑 Lua 5.4 的完整标准库，包括 `io`、`os`、`debug`、协程、动态
加载和普通 package 支持，不沿用 v5 capability 沙箱。脚本与游戏进程权限相同；这种
选择换取最大扩展能力，但不再提供“不可信 Mod”安全边界。文件、进程和原生模块副作用
无法事务回滚，也不保证跨平台可用。

在 Mod 选择界面首次加入任何 Platform Mod 时会明确确认，包括由普通 Mod 间接拉入的
Platform 依赖；仅重建已经选择的顺序不会重复询问。这个确认保护入口加载，但不能撤销
前述 `mod.lua` 可能已在发现阶段执行的事实。

## Loading lifecycle / 加载生命周期

The target lifecycle is:

1. Discover a root `main.lua` or optional `mod.lua`.
2. Resolve metadata and dependency order.
3. Begin one data-load transaction.
4. Load legacy JSON for a hybrid Mod, when present.
5. Execute the Platform entry and stage native content definitions.
6. Run normal global finalization over legacy and staged native definitions.
7. Commit the prepared Platform states only after finalization succeeds.
8. Make registered runtime handlers active after `world_ready`.

A full world replacement dispatches `shutdown` and retires the previous
Platform states before the engine unloads their finalized native registries.
An in-place save reload that deliberately keeps the same data registries may
reuse the active states and dispatch `world_ready` again.

All active runtimes become readable before dependency-ordered `world_ready`
callbacks begin, so an early dependency can synchronously publish to later
Mods without observing a false not-ready state.  `shutdown` runs in reverse
dependency order, allowing dependents to retire before the services they use.

Top-level code may create content and register handlers.  Access to live map,
character, or world state is invalid until the world is ready.  A failed data
load never enters a playable partially finalized state, although trusted
external side effects cannot be undone.

Runtime hot reload executes the entry in a candidate state.  If the static
content fingerprint is unchanged, runtime registrations can be swapped.  If
content changed, the reload reports `requires_full_data_reload` rather than
mutating finalized registries in place.

The runtime-only swap preserves typed character/world state, named tasks, and
task ids, as well as the per-Mod gameplay random stream.  It dispatches
`shutdown` to retiring states, retires their handles, then dispatches
`world_ready` with `reloaded = true` to replacements.  It does not reload
sidecars or advance the world generation.  Entry failure or a changed
fingerprint leaves the active states untouched.

目标生命周期依次为：发现入口、解析依赖、开始数据事务、按需加载旧 JSON、执行 Lua
并暂存原生定义、统一 finalize、成功后提交 Platform state，最后在 `world_ready` 后
激活运行时 handler。
完整切换世界时，会在引擎卸载旧原生注册表之前先派发 `shutdown` 并销毁旧 Platform
state；明确复用同一批数据注册表的存档内快速重载则可以保留 state，并再次派发
`world_ready`。
所有 runtime 会先统一进入可读状态，再按依赖顺序执行 `world_ready`，因此前置依赖同步
发布事件时不会把后续 Mod 误判成未就绪；`shutdown` 则按逆依赖顺序执行，让依赖方先于
它所使用的服务退出。
顶层代码可以创建内容和注册回调，但世界就绪前不能访问实时地图或角色。静态内容指纹
改变时拒绝局部热重载，并要求完整数据重载。
运行时热替换还会保留每个 Mod 的玩法随机流，避免仅修改 handler 代码就意外重置
随机序列。

### Current implementation boundary / 当前实现边界

The current implementation branch now has code for discovery, dependency
metadata, one full-library state per Mod, root-local `require`, candidate
prepare/apply/commit/discard, native foundational catalogs plus item and recipe
staging, named item-use
handlers, lifecycle and native game events, typed character/world state,
serializable named tasks and payload migrations, synchronous native hooks,
generation-safe shared domain services, Lua-aware Mod copying, and zero-JSON
templates.  It also includes visible rejected-metadata diagnostics,
fingerprint-gated runtime-only hot reload, and callback-only native
presentation primitives.
Native item/recipe injection has an undo log; candidate failure restores those
registries in reverse Mod/load order as well as preserving the previous active
Lua states.  This also permits a later dependency-ordered Mod to use explicit
`replace` against content added earlier in the same candidate.  Commit is
also gated on a post-finalize retention check, so a recipe removed by global
consistency finalization cannot silently leave a partially active Platform
candidate.  Trusted filesystem, process, and native-module side effects remain
outside that transaction.

This code is deliberately still marked **implemented but unverified**.  No
compile, test, formatter, declaration check, or ledger check has run since the
owner requested implementation through phase 5 before validation.  The exact
replacement ledger contains 775 dispositions; its generated summary is the
authoritative count.  The implemented-but-unverified static slice now covers
Mod metadata, tool qualities, skill display categories, skills, vitamins,
JSON flags, damage types, materials, proficiency categories, proficiencies,
weapon categories, item categories, recipe categories, ammunition types,
reusable requirements, recipe groups, scent types, speed descriptions,
harvest-drop types, harvest lists, behavior trees, monster attacks, effect
types, weakpoint sets, field types, item groups, sub-body parts, body parts,
anatomies, body graphs, monsters, morale types, disease types, monster flags,
mutation types, monster species, field emissions, monster factions, construction categories,
mutation categories, terrain/furniture connection groups, construction groups,
vehicle-part locations,
vehicle-part categories, mood-face tables, damage-info presentation orders,
named colors, rotatable-symbol groups, ASCII-art definitions, limb-score
definitions, the global hit-range configuration, bash-damage profiles,
clothing modifications, overmap land-use codes, overmap-vision profiles,
overmap-location predicates, profession groups, weighted map-extra
collections, vehicle groups, fault groups, explosion-light recipes, ammunition-effect recipes,
addiction types, character modifiers, start locations, climbing aids,
weather types, scores, the global mutation-overlay order, zone types, speech pools, end screens, nested recipe categories, attack vectors, magic types,
movement modes, items, and
recipes.  The hit range is deliberately a replace-only singleton because it
configures one engine-wide table rather than an id-addressed catalog.  Clothing
modifiers use composable scaling dimensions rather than exposing the legacy
object shape.  Attack vectors rebuild anatomical substitutions from authored
limbs and contact surfaces, making repeated finalization idempotent.  This
remains far short of complete static-domain coverage.

Overmap-vision profiles use an ordered Lua sequence of `appearance` and
`blend_adjacent` operations.  The sequence directly expresses vague,
outline, and detail views without exporting the legacy `levels` object shape;
native validation caps it at the engine's three partial-vision stages.

Magic types are intentionally not a field-for-field export of legacy
`magic_type`.  Resource choice, casting restrictions, book limits, and default
failure fractions are native definition data.  Progression, casting
experience, failure chance, dynamic failure fractions, and failed-cast effects
are named Lua policies.  Numeric policies receive bounded payloads and must
return values in their native domains; failed-cast policies receive a
generation-checked caster handle.  Missing handlers, callback errors, stale
worlds, and recursion beyond the common Platform limit are isolated.  A later
replacement owns the entire policy slot, so an earlier callback cannot leak
through.  Lua-authored magic types create neither jmath formula references nor
failure EOCs.

Movement modes are native definitions with numeric exertion and multiplier
values plus one composable message bundle for each steed context (`none`,
`animal`, and `mech`).  The Platform surface does not expose the legacy
field-name matrix.  Registry refresh clears and rebuilds speed ordering and
cycle links, so repeated global finalization and transaction rollback are
idempotent.

Selection groups use small semantic builders instead of exposing legacy list
shapes.  Overmap locations compose terrain ids and terrain flags; profession
groups add professions; map-extra, vehicle, and fault groups add one stable id
with a positive weight at a time.  Duplicate members are rejected, references
are checked against native registries, and replacement owns the whole group so
old members cannot leak through a later layer.

Explosion lights are composed as an ordered color/alpha ramp plus wave,
duration, screen-shake, and optional shockwave components.  Lua authors do not
manage the legacy two-color compatibility fields; the native recipe receives
the completed ramp and renderer-independent numeric parameters directly.

Ammunition effects compose field bursts, trails, direct and area character
effects, blasts, shrapnel, engine primitives, spells, and an optional named
Lua impact policy.  The policy receives generation-checked source/target
handles, impact coordinates, and dealt damage.  Lua-authored effects never
store or invoke EOCs; the extractor turns a legacy `eoc` member into an
explicit rewrite TODO instead of preserving the old dispatcher.

Addiction types keep their display text and optional craving-morale reference
as native definition data.  Every Lua-authored type supplies one named
`tick_policy`; the callback receives a generation-checked character handle,
intensity, and remaining sated turns and returns whether it produced an
observable effect.  The native definition contains neither a builtin selector
nor an EOC id.

Character modifiers keep only their stable id, description, and combination
operation as native definition data.  Their value comes from one named Lua
evaluator receiving a generation-checked character handle and optional skill
id.  This replaces both the legacy builtin switch and the fixed limb-score
formula shape, allowing ordinary Lua modules to share richer calculations.

Start locations compose overmap-terrain selectors, mapgen parameters, flags,
and city/z placement intervals one operation at a time.  Climbing aids compose
an availability predicate, descent presentation, physical cost, and optional
deployed furniture.  Neither surface exposes inheritance or legacy nested
object shapes; reusable Lua constructors provide author-side templates.

Weather types keep presentation, physical modifiers, duration, prerequisites,
animation, and passive character effects as native definition data.  Their
eligibility is one named Lua condition receiving a bounded weather sample with
temperature, humidity, pressure, wind, time, and absolute location.  The
weather selector calls that policy directly and consults the old condition
tree only for non-Platform definitions.  Lua-authored weather stores no
condition tree, jmath reference, or EOC id; the extractor preserves static
data and emits explicit rewrites for all legacy behaviour.

Scores are native id-to-event-statistic definitions with an optional display
format.  Lua authors reference the statistic by stable id and do not construct
or pass a legacy score object.

Mutation-overlay ordering is a native engine-wide singleton composed with
`OverlayOrder:mutation(id, order)`.  Authors work with one stable mutation id
at a time instead of the legacy `overlay_ordering` array shape.  `add` requires
every key to be new, `replace` requires every key to exist, and transactional
rollback restores or erases each key in reverse order.

Zone types are native id-addressed definitions containing their display field,
presentation text, visibility, and personal-ownership policy.  Lua authors use
`content.ZoneType` directly; the historical `LOOT_ZONE` selector name and JSON
loader are not part of the Platform surface.

Speech is authored as one `SpeechPool` per stable speaker label, with ordered
`line(text, volume)` composition.  This keeps random selection in the native
consumer while replacing the legacy repetition of multi-speaker JSON objects;
the extractor groups all source lines by speaker before emitting Lua.

End screens keep picture, priority, positioned text, and final-input label as
native data.  Selection is a named Lua condition receiving a generation-safe
character handle; Lua-authored screens store no legacy condition tree, and
the UI falls back to that tree only for non-Platform definitions.

Activity types keep native scheduling, interruption, resumption, exertion,
distraction, fetching, fire-refuelling, and auto-needs policy as static data.
Turn and completion behaviour are named Lua policies receiving a
generation-checked character handle plus a bounded activity snapshot.  A
policy may cancel the activity or update only its native move budget and small
legacy state fields; restoring positive moves during completion extends the
activity.  Lua-authored activity types store neither `do_turn_eoc` nor
`completion_eoc`, and the player-activity dispatcher invokes those old EOCs
only for non-Platform definitions.  Existing native actors and C++ handlers
remain composable implementation primitives rather than public legacy APIs.

Help topics use stable Lua-first ids, player-facing titles, and composable
paragraphs.  Authors may choose an explicit global display order or omit it to
append deterministically in Mod load order.  The public surface does not
expose the loader's source-offset bookkeeping or a JSON message array.

Snippet categories are weighted native text pools.  `content.add` contributes
new entries to an existing category while `content.replace` deliberately owns
the whole pool, so multiple Mods can extend common vocabulary without copying
it.  Named entries may declare one named Lua `on_examine` policy receiving the
snippet/category/item ids and a generation-checked character handle.
Lua-authored snippets never populate the legacy EOC table, and item
description discovery falls back to the old examine EOC only for non-Platform
snippets.

Playlists are native ordered track collections with an optional shuffle
policy.  Every track uses a soundpack-relative, traversal-safe path and a
bounded native volume.  The registry remains transactional even in builds
without SDL sound, while playback naturally remains a platform capability.

Monster species are native inheritance bundles for monster flags, anger/fear/
placate triggers, footsteps, descriptive text, and bleed fields.  Lua authors
compose each relation with `flag`, `anger`, `fear`, and `placate`; they do not
construct the legacy trigger arrays.  Monster factions use one direct
`attitude(kind, target)` operation per relation plus an optional base faction.
Finalization clears and rebuilds explicit, inherited, and compact attitude
caches, so candidate replacement and rollback cannot retain relations from a
discarded layer.

Field emissions use a native static fallback plus an optional named Lua
`profile` policy.  The policy runs once per emission decision and returns the
complete field, intensity, quantity, and chance tuple; it receives the stable
emission id, bubble-map position, and immutable fallback profile.  Returning
nil, a callback failure, or an unavailable runtime keeps the native fallback.
Lua-authored emissions store fixed native values rather than creating
`str_or_var`, jmath, a condition tree, or an EOC.  A later static replacement
owns the callback slot and cannot expose an older layer's policy.

```lua
local emission = ccb.content.Emission {
    id = "emit_custom_smoke",
    field = "fd_smoke",
    intensity = 2,
    quantity = 10,
    chance = 50,
}
emission:profile("dynamic_smoke_profile") -- optional
ccb.content.add(emission)
```

字段排放由一份原生静态 fallback 和可选的命名 Lua `profile` 策略组成。每次排放只进入
Lua 一次，策略一次性返回 field、强度、数量和概率，并收到稳定排放 ID、现实气泡地图格
位置及只读 fallback。返回 nil、回调失败或 runtime 尚未就绪时继续使用 fallback。
Lua 定义的排放只保存固定原生数值，不创建 `str_or_var`、jmath、condition tree 或 EOC；
后加载的静态 replacement 也会完整接管策略槽，旧层回调不会穿透。

Harvest lists are native `harvest_list` and `harvest_entry` objects composed
with `Harvest:drop`, `item_flag`, and `item_fault`.  Each drop names an item or,
when its harvest-drop category is declared as a group, an existing native item
group.  Base and skill-scaled intervals, maximum quantity, mass share,
leftovers, and butchery requirements are validated before apply.  Empty lists
remain valid for native sentinels such as `null` and `exempt`.  Candidate items,
flags, and harvest-drop types may be referenced in the same transaction; item
groups, faults, and butchery requirements remain checked native dependencies.
The registrar writes the native factory directly and participates in retention,
fingerprinting, and inverse rollback without constructing a JSON object.

```lua
local harvest = ccb.content.Harvest {
    id = "custom_harvest",
    message = "You recover useful material.",
    leftovers = "ruined_chunks",
    butchery_requirements = "default",
}
harvest:drop {
    output = "meat",
    category = "flesh",
    base_minimum = 1,
    base_maximum = 4,
    skill_maximum = 0.5,
    maximum = 20,
    mass_ratio = 0.25,
}
harvest:item_flag("meat", "FILTHY")
ccb.content.add(harvest)
```

采收表直接由原生 `harvest_list` 与 `harvest_entry` 组成，通过 `Harvest:drop`、
`item_flag` 和 `item_fault` 逐项组合。普通条目引用物品；当采收掉落分类声明为 group 时，
条目引用已有的原生 item group。基础/技能缩放区间、最大数量、尸体质量比例、残留物和
屠宰需求都会在 apply 前校验；`null`、`exempt` 这类原生哨兵仍可使用空采收表。同一事务
声明的物品、flag 与采收掉落分类可以直接引用，item group、fault 和屠宰需求则保持为
受检的原生依赖。注册器直接写原生目录并进入保留检查、指纹和逆序回滚，不构造 JSON 对象。

Behavior trees are native `behavior::node_t` graphs.  Lua composes stable child
ids and native traversal strategies, while named Lua policies can decide a
condition or utility score at tick time.  A policy receives the behavior id,
an authored argument, the subject kind, and a generation-safe subject handle;
it returns one boolean or finite number.  Missing handlers, a runtime that is
not world-ready, callback errors, and recursion-limit failures safely become a
false condition or zero score.  Native predicates remain available through
explicit `when_native` and `score_native` composition for migration, but no
JSON loader, condition tree, jmath expression, or EOC runner is retained.

```lua
local forage = ccb.content.Behavior {
    id = "custom_forage_goal",
    goal = "forage",
}
forage:when("can_forage_now", "nearby", false)
forage:score("forage_utility", "food")
ccb.content.add(forage)

local root = ccb.content.Behavior {
    id = "custom_ai_root",
    strategy = "utility",
}
root:child("custom_forage_goal")
ccb.content.add(root)
```

行为树直接构造成原生 `behavior::node_t` 图。Lua 使用稳定子节点 ID 与原生遍历策略组合
结构，并可在每次 tick 时用命名 Lua policy 决定条件或 utility 分数。policy 收到行为 ID、
作者参数、主体类型和代际安全主体句柄，分别返回一个布尔值或有限数值；handler 缺失、
runtime 尚未 world-ready、回调报错或递归超限时安全退化为 false/0。迁移核心行为时仍可通过
显式 `when_native`、`score_native` 组合已有 C++ 谓词，但不会保留 JSON loader、condition
tree、jmath 或 EOC runner。

Connection groups are stable native ids allocated before terrain and furniture
definitions consume their compact bit positions.  The transaction preserves a
replaced group's position and rolls back newly appended ids in reverse order.
Mutation categories keep threshold, vitamin, player-facing, and starting-trait
removal policy as native data; Lua authors work with semantic names such as
`threshold_minimum` and `base_removal_cost_multiplier` rather than abbreviated
loader keys.

Nested recipe categories are native recipe entries composed from stable recipe
ids with `NestedRecipeCategory:recipe(id)`.  Name, description, crafting
category, subcategory, and numeric activity level remain native data; Lua does
not construct the legacy `nested_category_data` list shape.

当前实现分支已经写入发现、依赖元数据、每 Mod 独立完整标准库 state、根目录本地
`require`、候选 prepare/apply/commit/discard、原生基础目录及物品/配方事务、命名物品行为、
生命周期与原生游戏事件、角色/世界状态、可序列化命名任务、Lua Mod 复制和零 JSON
模板；同时加入了任务 payload 迁移、同步原生 Hook 与代次安全的共享领域 service。
原生物品/配方注入有逆向恢复日志，候选失败时不仅保留旧 Lua state，也恢复本次
注入的定义；跨 Mod 叠加严格按加载顺序应用、按逆序回滚，因此后加载 Mod 可以显式
`replace` 同一候选中先加载的定义。commit 还必须通过 finalize 后的保留检查，避免被全局一致性检查剔除的
配方造成部分候选悄悄生效。文件、进程和原生模块的外部副作用仍无法回滚。

这些代码目前仍统一标为**已实现但未验证**：按负责人要求，阶段 5 收口前没有运行
编译、测试、格式、声明或账本检查。775 项的分类数字以生成账本 summary 为准，不在本文
手工复制。当前静态切片包括 Mod 元数据、工具质量、技能显示分类、技能、维生素、JSON
flag、伤害类型、材质、熟练度分类、熟练度、武器分类、物品分类、配方分类、弹药
类型、可复用制作需求、配方组、气味类型、速度描述、采收掉落类型、采收表、行为树、
怪物攻击、效果类型、弱点集、场类型、物品组、子身体部位、身体部位、解剖、身体图、
怪物、士气类型、疾病类型、怪物 flag、怪物物种、怪物阵营、突变类型、突变分类、
地形/家具连接组、建造分类、建造组、载具部件位置、
物品与配方；它仍远未
达到静态内容全面覆盖。当前切片还包括载具部件分类、心情表情表、伤害信息显示顺序、
命名颜色、可旋转符号组、ASCII 图、肢体评分和全局命中距离配置。命中距离配置刻意只
允许显式 `replace`：它是一张引擎全局表，不是假装拥有普通对象 ID 的目录。当前切片还
包括 bash 伤害配置、服装改造和大地图土地用途；服装数值使用可组合的厚度/覆盖率缩放
维度，而不是公开旧 JSON 对象形状。大地图视野配置使用有序的 `appearance` 与
`blend_adjacent` 组合序列，直接表示模糊、轮廓和细节三个阶段，不公开旧 `levels` 对象
形状。攻击向量也已纳入原生构造器；相似肢体和接触面每次
都从作者输入重建，因此重复 finalize 不会不断追加派生项。魔法类型也已纳入：能量来源、
施法限制、书本等级和默认失败比例是原生定义；等级/经验互算、施法经验、失败率、动态失败
比例与失败副作用则是命名 Lua 策略。数值策略只接收有界 payload 并必须返回对应原生值域，
失败副作用接收代次安全的施法者 handle；缺失 handler、回调错误、过期世界和递归上限都被
隔离。后加载 replacement 独占策略槽，旧层回调不会穿透。Lua 定义不会创建 jmath 公式引用，
也不会生成 failure EOC。移动模式使用原生数值强度/倍率，并为 `none`、`animal`、`mech`
三个坐骑上下文分别组合一组消息，不公开旧式字段名矩阵。目录刷新会先清空再重建速度排序
和循环链接，因此重复全局 finalize 与事务回滚保持幂等。
大地图位置使用地形 id 与地形 flag 逐项组合；职业组逐项加入职业；地图额外内容、载具和
故障组逐项加入“稳定 id + 正权重”。这些 API 不公开旧数组形状，拒绝重复成员，按原生目录
检查引用，并让后加载 replacement 完整拥有组内容，旧层成员不会穿透。
爆炸光效则由有序颜色/透明度关键帧，以及波形、持续时间、屏幕震动和可选冲击波组件
构成；Lua 作者不需要感知旧式双颜色兼容字段，原生光效直接接收完整色带与数值参数。
弹药效果使用字段爆发、轨迹、直接/范围角色效果、爆炸、破片、引擎原语、法术和可选的
命名 Lua 命中策略进行组合。策略接收代次安全的来源/目标 handle、命中坐标和实际伤害；
Lua 定义不会保存或调用 EOC，迁移器遇到旧 `eoc` 时只生成明确的 Lua 重写 TODO。
成瘾类型保留原生显示文本和可选 craving morale 引用，每个 Lua 定义必须提供一个命名
`tick_policy`。回调接收代次安全的角色 handle、强度和剩余满足回合，并返回本次 tick
是否产生可见效果；原生定义中既没有 builtin 选择器，也没有 EOC id。
角色修正器只把稳定 id、说明和组合操作保留为原生定义数据，数值由一个命名 Lua evaluator
计算；payload 包含代次安全的角色 handle 和可选技能 id。这同时取代旧 builtin 分派和固定
肢体评分公式形状，让普通 Lua 模块能够共享更丰富的计算逻辑。
起始位置逐项组合大地图地形选择器、mapgen 参数、flag 与城市/z 轴放置区间；攀爬辅助则
组合可用条件、下降交互、身体成本及可选部署家具。两者都不公开继承或旧嵌套对象形状，
作者侧模板由普通 Lua 构造函数复用。
天气类型把显示、物理修正、持续时间、前置天气、动画和角色被动效果作为原生定义数据；
是否满足天气条件则由一个命名 Lua policy 判断。payload 只含有界的温度、湿度、气压、
风、时间和绝对位置快照。天气选择器直接调用该 policy，只有非 Platform 天气才会回退
旧 condition tree。Lua 天气不保存 condition tree、jmath 引用或 EOC id；迁移器只搬运
可确定的静态数据，并对旧行为生成明确的 Lua 重写 TODO。
分数定义则直接把稳定 score id 关联到原生 event-statistic id，并可提供显示格式；Lua
作者不创建或传递旧 score 对象。
突变覆盖显示顺序使用一个原生全局 singleton，并通过
`OverlayOrder:mutation(id, order)` 逐项组合。作者不接触旧 `overlay_ordering` 数组形状；
`add` 要求每个 key 尚不存在，`replace` 要求每个 key 已存在，事务回滚按逆序逐项恢复
或删除。
区域类型是原生按 id 寻址的定义，直接包含显示 field、说明文字、可见性和个人所有权
策略。Lua 作者使用 `content.ZoneType`；旧 `LOOT_ZONE` selector 名称和 JSON loader 都不
属于 Platform API。
语音按稳定 speaker label 定义为 `SpeechPool`，再用有序的 `line(text, volume)` 逐条组合。
原生消费端仍负责随机选择，但 Lua 不再重复旧式多 speaker JSON 对象；迁移器会先按
speaker 汇总所有来源行，再生成 Lua。
结束画面把图片、优先级、定位文字和最终输入标签保留为原生数据；选择逻辑是接收代次安全
角色 handle 的命名 Lua condition。Lua 画面不保存旧 condition tree，UI 也只为非
Platform 定义回退旧树。
活动类型把原生计时、打断、恢复、活动强度、干扰忽略、取物、添柴与自动需求策略保留为
静态数据；每回合和完成行为则使用命名 Lua policy。回调收到代次安全的角色 handle 和有界
活动快照，只能取消活动或更新原生 moves 预算及少量旧活动状态字段；完成回调把
`moves_left` 恢复为正数即可延长活动。Lua 定义既不保存 `do_turn_eoc`，也不保存
`completion_eoc`，player-activity 分派器只为非 Platform 定义调用旧 EOC。已有原生 actor
和 C++ handler 仍可作为可组合实现原语，但不是公开的旧接口。
帮助主题使用稳定 Lua-first id、显示标题和逐段组合的正文。作者可以显式指定全局显示顺序，
也可以省略顺序，让主题按 Mod 加载顺序确定性追加；公开 API 不暴露旧 loader 的来源偏移
记账，也不要求构造 JSON messages 数组。
Snippet 分类是带权重的原生文本池。`content.add` 向已有分类贡献新条目，
`content.replace` 才明确接管整个池，因此多个 Mod 无需复制公共词库即可扩展它。命名条目
可以绑定一个命名 Lua `on_examine` policy，payload 包含 snippet、分类、物品类型 id 和代次
安全角色 handle。Lua snippet 永远不写入旧 EOC 表；物品描述发现也只为非 Platform
snippet 回退旧 examine EOC。
播放列表是带可选 shuffle 策略的原生有序音轨集合；每条音轨只能使用相对当前音效包、禁止
目录穿越的路径和有界原生音量。即使构建未启用 SDL sound，定义注册与事务仍然存在，实际
播放则自然取决于平台能力。
嵌套配方分类仍是原生 recipe 条目，但通过 `NestedRecipeCategory:recipe(id)` 逐项组合稳定
配方 id。名称、说明、制作分类、子分类和数值活动强度保留为原生数据，Lua 不构造旧
`nested_category_data` 列表形状。

## Native object model / 原生对象模型

Platform-exported C++ types expose every bindable public field, method, and
operator.  Private and protected members retain normal C++ access rules.
Exported types are explicit; JSON loaders, EOC parsers, and other legacy
infrastructure are not export roots.

Native references carry an owner and generation check.  Access after object
destruction, world replacement, content commit, or runtime replacement raises
a Lua error instead of dereferencing a stale pointer.  Native modules loaded
by a trusted Mod can bypass this boundary and are outside the compatibility
guarantee.

Static definitions are real native staging objects.  The target content API
provides explicit `add`, `replace`, and transactional `edit` operations.
Duplicate ids are errors unless replacement or editing is requested.  Normal
Lua functions, loops, modules, constructors, and cloning replace JSON
`copy-from` and inheritance syntax.

Platform 导出的 C++ 类型公开全部可绑定的 public 字段、方法与运算符；private 和
protected 仍遵守 C++ 规则。原生引用带 owner/代次检查，owner 消失、世界切换、内容
提交或 runtime 替换后访问会抛 Lua 错误。静态定义使用真实的原生 staging 对象，
通过显式 `add`、`replace`、事务性 `edit` 提交；普通 Lua 组合取代 JSON `copy-from`。

### Implemented native vertical slice / 已编码的原生纵向切片

The phase-2/3 code exposes constructors on the Mod-local `ccb.content` table.
They return native userdata, not tables accepted by a generic loader.  `add`
rejects an existing id, `replace` requires one, and `edit_item`/`edit_recipe`
clone a definition staged earlier by the same Mod in the current candidate.
Registering the clone with `ccb.content.edit` replaces that earlier staged
value while preserving its original add-or-replace intent.  This makes edits
ordinary Lua module composition and gives cold load, full reload, and
fingerprint-gated hot reload the same semantics.
Cross-Mod layers are validated and applied in dependency order, and the whole
candidate rolls back in reverse order.  Recipe component and tool alternative
groups are bounded dense one-based arrays, so holes or metadata keys cannot be
silently interpreted as native requirements.

The same transaction owns the foundational registries required by upper
content layers: `ToolQuality`, `SkillDisplay`, `Skill`, `Vitamin`, `JsonFlag`,
`DamageType`, `Material`, `ProficiencyCategory`, `Proficiency`,
`WeaponCategory`, `ItemCategory`, `RecipeCategory`, `AmmunitionType`,
`ScentType`, `SpeedDescription`, `HarvestDropType`, `Harvest`, `Behavior`,
`MonsterAttack`, `EffectType`, `WeakpointSet`, `FieldType`, `ItemGroup`,
`SubBodyPart`, `BodyPart`, `Anatomy`, `BodyGraph`, `Monster`, `MoraleType`,
`DiseaseType`, `MonsterFlag`, `MutationType`, `Species`, `Emission`, `MonsterFaction`,
`ConnectGroup`, `MutationCategory`, `ConstructionCategory`, `ConstructionGroup`, `VehiclePartLocation`,
`VehiclePartCategory`, `MoodFace`,
`DamageInfoOrder`, `NamedColor`, `RotatableSymbol`, `OvermapLocation`,
`ProfessionGroup`, `MapExtraCollection`, `VehicleGroup`, `FaultGroup`,
`ExplosionLight`, `AmmoEffect`, `AddictionType`, `CharacterModifier`,
`StartLocation`, `ClimbingAid`, `WeatherType`, and `Score`.
The transaction also owns reusable `Requirement` graphs and lets recipes
compose them by id and multiplier without reparsing legacy data.  Native
`RecipeGroup` definitions organize those recipes for camp/building workflows.
They are applied before items and recipes, so an
item may reference a quality, flag, or material authored earlier in the same
candidate, and a material may reference candidate damage types and vitamins.
Every registrar participates in explicit add/replace/edit semantics,
post-finalize retention checks, the static hot-reload fingerprint, and reverse
rollback.  The native transaction uses concrete-id factory erase and snapshot
restore operations; it never calls a JSON loader.

Damage-type behaviour uses `DamageTypeDefinition:on_hit` and `on_damage` with
named Platform handlers instead of `onhit_eocs` or `ondamage_eocs`.  Payloads
contain generation-safe source/target handles, the stable damage id, body-part
id, and pre/post-mitigation amounts.  A later replacement owns the callback
slot even when it deliberately leaves it empty, preventing an earlier Mod's
handler from leaking through.

```lua
local ccb = require("ccb")

ccb.runtime.handler("activate", function(context)
    local uses = ccb.state.character.get("uses", 0) + 1
    ccb.state.character.set("uses", uses)
    context:message("Lua activation #" .. uses)
    return 0
end, 1)

local item = ccb.content.Item {
    id = "example_token",
    name = "example token",
    description = "A native Lua-defined item.",
    symbol = "*",
}
item:mass_grams(25)
item:volume_ml(10)
item:material("steel", 1)
item:on_use("activate", "Activate token")
ccb.content.add(item)

local recipe = ccb.content.Recipe {
    id = "example_token",
    result = "example_token",
    duration_moves = 500,
}
recipe:component("scrap", 1)
recipe:tool_any {
    { id = "hammer", count = 1 },
    { id = "rock", count = 1 },
}
ccb.content.add(recipe)
```

An item-use handler receives a native `ItemUseContext`.  Its `character` and
`item` properties are generation-checked `GameHandle` values, and `position`
is an immutable `TripointCoord` tagged as reality-bubble map-square (`bub` /
`ms`).  The context itself expires as soon as the callback returns; copied
handles remain usable only while their runtime generation, world generation,
and native object are all still valid.  `player_name`, `item_id`, `charges`,
and `message` are convenience members, not substitutes for the typed handles.

物品 handler 收到原生 `ItemUseContext`。其中 `character` 与 `item` 是带运行时/世界
代次检查的 `GameHandle`，`position` 是标记为现实气泡地图格（`bub` / `ms`）的不可变
`TripointCoord`。回调返回后 context 本身立即失效；复制出的 handle 也只有在运行时
代次、世界代次与原生对象都仍有效时才能继续使用。

The full declarations are in `data/lua/types/ccb_platform_v1.d.lua`.  The
complete executable template is under `data/lua/templates/complete/`, and
`python3 tools/create_lua_mod.py TARGET --template complete` copies it only
into an absent or empty target.  Generated files are author-owned and never
updated in place.

阶段 2/3 代码在每个 Mod 自己的 `ccb.content` 上提供构造器，返回的是原生 userdata，
不是交给通用 loader 的 table。`add` 禁止隐式覆盖，`replace` 要求目标已存在；
`edit_item`/`edit_recipe` 克隆本 Mod 在当前候选事务中更早暂存的定义，修改后再显式交给
`ccb.content.edit`，并保留原来的 add/replace 意图。因此 Lua 模块组合在冷启动、完整
重载和受指纹保护的热重载中使用同一套语义。完整声明、纯 Lua 样板和不覆盖作者文件的
脚手架路径如上。配方的组件/工具备选组也必须是有界、从 1 开始且无空洞的数组，不能把
额外元数据键静默当成原生需求。

同一事务还直接管理上层内容依赖的基础目录：工具质量、技能显示分类、技能、维生素、
JSON flag、伤害类型、材质、熟练度分类、熟练度、武器分类、物品分类、配方分类和
弹药类型、气味类型、速度描述、采收掉落类型、采收表、行为树、怪物攻击、效果类型、
弱点集、场类型、物品组、子身体部位、身体部位、解剖、身体图、怪物、士气类型、
疾病类型、怪物 flag、怪物物种、字段排放、怪物阵营、突变类型、突变分类、地形/家具连接组、
建造分类、建造组、载具部件位置、载具部件分类、心情表情表、伤害信息显示顺序、
命名颜色、可旋转符号组，以及可由配方按 id 和倍数组合的
`Requirement` 需求图，以及供营地/建筑流程
组织配方的 `RecipeGroup`。它们先于物品/配方
应用，因此同一候选中声明的质量、flag、
材质、伤害类型与维生素可被后续对象引用；所有目录都进入 add/replace/edit、finalize 后
保留检查、热重载指纹和逆序回滚。伤害类型的命中/受伤行为绑定命名 Lua handler，不暴露
`onhit_eocs`、`ondamage_eocs` 或 EOC runner。

## Behaviour instead of EOC / 用 Lua 行为取代 EOC

Platform v1 uses a small set of orthogonal primitives:

- native object methods and domain services for validated mutations;
- ordinary Lua expressions and query methods for conditions;
- typed events for observations;
- synchronous hooks for decisions, vetoes, or transformations;
- named handlers for definition-owned callbacks;
- named persistent tasks for delayed or recurring work;
- serializable character/world state for durable data;
- Lua libraries built on these primitives for workflows and state machines.

An EOC parser handler should be traced to the underlying game operation.  That
operation is extracted into a shared C++ service used by both the legacy EOC
adapter and the Lua binding.  Platform v1 must not publish one Lua function per
EOC key, `run_eoc`, alpha/beta aliases, or a recurrence DSL.

Platform v1 使用少量正交原语：原生对象方法与领域 service、普通 Lua 条件、类型化
event、同步 Hook、命名 handler、命名持久任务、可序列化角色/世界状态，以及在其上
编写的 workflow/state-machine 库。EOC handler 应追踪到背后的通用游戏操作，抽成旧
EOC 适配层与 Lua binding 共用的 C++ service，而不是逐键复制 Lua API。

The implemented Platform state now installs the shared native domains under
`ccb.services`: immutable ids/units/coordinates/time, generation-checked
handles, characters, creatures, effects, bionics, mutations, skills,
proficiencies, vitamins, addictions, needs, martial arts, items, inventory,
vehicles, NPCs, factions, camps, zones, spells, missions, recipes, crafting,
map/world/overmap/hordes, weather, statistics, variables, sound, targeting,
spawning, followers, and relocation.  These are shared C++ implementations,
not calls into a v5 Lua state.  Platform deliberately does not install the v5
EOC table, authored JSON registry, or capability surface.  Reads require
`world_ready`; mutations additionally require an active Platform callback.

当前 Platform state 已在 `ccb.services` 下安装上述原生领域服务。它们共享的是 C++
实现，不会调用另一个 v5 Lua state；Platform 明确不安装 v5 的 EOC table、作者 JSON
registry 或 capability 表。读取要求世界已就绪，修改还要求当前处于 Platform 回调。

`ccb.runtime.hook(native_name, handler_id)` attaches a named handler to the
checked synchronous native-hook catalog.  Callback payload creatures, items,
vehicles, missions, and talkers cross the boundary only as generation-bound
handles or detached values.  Boolean vetoes and structured `allow`, `handled`,
`text`, `result`, `results`, and `entries` fields are accepted only when that
native hook declares the corresponding result contract.  Platform handlers
compose in Mod dependency order with the existing native dispatcher.  String
result lists and menu-entry lists are bounded dense one-based arrays; invalid
shared mutation or returned data discards only that handler's candidate result
and preserves the aggregate produced by earlier handlers.

`ccb.runtime.hook` 将命名 handler 接到受检的同步 Hook 目录；payload 中的活对象只以
代次绑定 handle 或快照跨界。只有 Hook 契约声明过的否决、文本、替换值或菜单结果才会
生效，Platform handler 按 Mod 依赖顺序与原生 dispatcher 合成。字符串结果与菜单项必须
是有界、从 1 开始且无空洞的数组；无效的共享修改或返回值只丢弃当前 handler 的候选
结果，不会抹掉此前 handler 的聚合结果。

Player-facing interaction is a separate top-level domain rather than an EOC
effect spelling.  Inside an active callback, `ccb.presentation.notice`,
`confirm`, `choose`, and `input_text` provide bounded native dialogs.  Choice
ids are stable values independent from labels, cancellation returns `nil`, and
input sizes, duplicate ids, and non-dense choice arrays are rejected before UI
opens.  A choice list must use consecutive integer keys starting at one; extra
string keys or holes are an error rather than silently ignored content.  Mods
compose these primitives with ordinary Lua functions, coroutines, handlers,
and state machines.

面向玩家的交互使用独立的 `ccb.presentation` 领域，而不是照抄 EOC effect 键。活动
回调内可调用 `notice`、`confirm`、`choose` 与 `input_text`；选项的稳定 ID 与显示文本
分离，取消返回 nil，打开界面前会检查数量、大小、重复 ID，以及列表是否为从 1 开始
且没有空洞的连续整数数组；额外字符串键也会被拒绝。复杂流程由普通 Lua 函数、协程、
handler 和状态机组合。

### Creature content as a native graph / 原生怪物内容图

Creature content is a graph of native definitions, not a JSON-shaped table
passed through a compatibility loader.  Lua constructs each native staging
object directly and composes it with ordinary functions and modules.  No part
of this path calls a JSON loader or EOC runner.

怪物内容是一张原生定义图，不是交给兼容 loader 的 JSON 形状 table。Lua 直接构造每个
原生暂存对象，再用普通函数与模块组合；这条路径的任何部分都不会调用 JSON loader 或
EOC runner。

The important dependency edges are:

- `EffectType` feeds `WeakpointSet`, `FieldType`, and Monster regeneration
  modifiers;
- `SubBodyPart` and `BodyPart` feed `Anatomy`, `BodyGraph`, and body-targeted
  field effects;
- `ItemGroup`, `Behavior`, `MonsterAttack`, and `WeakpointSet` feed `Monster`.

关键依赖关系是：`EffectType` 供弱点、场效果与怪物再生修正引用；`SubBodyPart` 和
`BodyPart` 供解剖、身体图与按身体部位施加的场效果引用；`ItemGroup`、`Behavior`、
`MonsterAttack` 与 `WeakpointSet` 最终组成 `Monster`。

Cross-references inside one candidate transaction are validated together, then
applied in native dependency order rather than source-file order.  If any
apply, finalization, or post-finalize retention check fails, every applied
candidate definition is rolled back in reverse order and the previous runtime
remains active.  Replacement and rollback also rebuild Behavior goal pointers,
body-part similarity/finalization caches, and the Monster hallucination cache,
so those derived views cannot retain candidate pointers.

同一候选事务里的交叉引用会先统一验证，再按原生依赖顺序而不是源码顺序应用。如果任一
apply、finalize 或 finalize 后保留检查失败，所有已应用的候选定义都会逆序回滚，旧
runtime 继续保持活动。替换与回滚还会重建 Behavior goal 指针、身体部位相似/终结缓存
和怪物幻觉候选缓存，避免派生视图残留候选指针。

`MonsterAttack` stores a named Lua policy, never a closure or EOC reference in
the native definition.  Its payload contains a generation-safe attacker handle
and either a generation-safe target handle or `nil` when no target exists.  A
missing handler, a runtime that is not ready, a Lua error, recursion-limit
failure, or a non-boolean return value safely resolves to `false`.  The
`GEN_DORMANT` Monster flag is currently rejected because it creates a derived
pseudo-monster for which the transaction does not yet have a safe rollback
model.

`MonsterAttack` 在原生定义中只保存命名 Lua policy，不保存闭包或 EOC 引用。payload
携带有代次检查的攻击者 handle；没有目标时 `target` 为 `nil`，否则也是有代次检查的
handle。handler 缺失、runtime 未就绪、Lua 报错、递归超限或返回值不是 boolean 时，
攻击会安全退化为 `false`。当前明确拒绝怪物 flag `GEN_DORMANT`，因为它会创建派生伪
怪物，而事务还没有能安全回滚该派生对象的模型。

The following complete composition uses only native Platform builders.  It
also demonstrates a same-transaction cycle: the field declares immunity for
the Monster that is staged later, while the Monster refers back to definitions
staged throughout the candidate.

下面的完整组合只使用原生 Platform builder。它也展示同事务交叉引用：场类型先声明对
稍后暂存的怪物免疫，而怪物再引用候选中此前暂存的各类定义。

```lua
local ccb = require("ccb")

local effect = ccb.content.EffectType {
    id = "lua_creature_effect",
    name = "Lua creature effect",
    description = "Applied by native Lua creature content.",
    maximum_intensity = 2,
}
effect:reduced_description("A reduced Lua creature effect.")
ccb.content.add(effect)

local weakpoints = ccb.content.WeakpointSet {
    id = "lua_creature_weakpoints",
}
weakpoints:weakpoint {
    id = "core",
    name = "core",
    coverage = 100,
    good = true,
}
weakpoints:armor_multiplier("core", "bash", 0.5)
weakpoints:damage_multiplier("core", "bash", 1.5)
weakpoints:effect("core", {
    effect = "lua_creature_effect",
    chance = 25,
    duration_min_turns = 1,
    duration_max_turns = 3,
})
ccb.content.add(weakpoints)

local drops = ccb.content.ItemGroup {
    id = "lua_creature_drops",
    kind = "distribution",
}
drops:item("rock", 100)
ccb.content.add(drops)

local surface = ccb.content.SubBodyPart {
    id = "lua_creature_core_surface",
    name = "core surface",
    parent = "lua_creature_core",
}
surface:location_under("lua_creature_core_surface")
surface:unarmed_damage("bash", 1)

local body = ccb.content.BodyPart {
    id = "lua_creature_core",
    name = "core",
    main_part = "lua_creature_core",
    connected_to = "lua_creature_core",
    hit_size = 1,
    hit_difficulty = 1,
    base_health = 20,
}
body:sub_part("lua_creature_core_surface")
body:limb_type("torso")
body:armor("bash", 1)
body:unarmed_damage("bash", 2)
ccb.content.add(surface)
ccb.content.add(body)

local anatomy = ccb.content.Anatomy {
    id = "lua_creature_anatomy",
}
anatomy:part("lua_creature_core")
ccb.content.add(anatomy)

local graph = ccb.content.BodyGraph {
    id = "lua_creature_graph",
    parent_body_part = "lua_creature_core",
}
graph:row("C")
graph:part("C", {
    body_parts = { "lua_creature_core" },
    sub_body_parts = { "lua_creature_core_surface" },
    selected_color = "light_red",
    display_symbol = "C",
})
ccb.content.add(graph)

local field = ccb.content.FieldType {
    id = "fd_lua_creature",
    phase = "gas",
}
field:intensity {
    name = "Lua creature mist",
    symbol = "%",
    color = "light_blue",
}
field:effect(1, {
    effect = "lua_creature_effect",
    duration_min_turns = 1,
    duration_max_turns = 2,
    body_part = "lua_creature_core",
})
field:immune_monster("mon_lua_creature")
ccb.content.add(field)

ccb.runtime.handler("lua_creature_attack", function(payload)
    if not payload.attacker:is_valid() then
        return false
    end
    if payload.target ~= nil and not payload.target:is_valid() then
        return false
    end
    return payload.attack_id == "lua_creature_attack"
end, 1)

local attack = ccb.content.MonsterAttack {
    id = "lua_creature_attack",
    cooldown = 5,
}
attack:policy("lua_creature_attack")
ccb.content.add(attack)

local behavior = ccb.content.Behavior {
    id = "lua_creature_goal",
    goal = "attack",
}
ccb.content.add(behavior)

local monster = ccb.content.Monster {
    id = "mon_lua_creature",
    name = "native Lua creature",
    plural_name = "native Lua creatures",
    description = "A Monster assembled without JSON or EOC.",
    symbol = "C",
    color = "light_blue",
    default_faction = "zombie",
    harvest = "human",
    speed_description = "DEFAULT",
    death_drops = "lua_creature_drops",
    hp = 20,
    speed = 80,
    melee_skill = 2,
}
monster:material("flesh", 1)
monster:species("ZOMBIE")
monster:armor("bash", 2)
monster:melee_damage("bash", 3, 1)
monster:attack("lua_creature_attack", 7)
monster:weakpoint_set("lua_creature_weakpoints")
monster:regeneration_modifier("lua_creature_effect", -1)
monster:goal("lua_creature_goal")
monster:anger_trigger("HURT")
ccb.content.add(monster)
```

This creature graph is currently `implemented_unverified`: native code,
LuaLS declarations, rollback/retention paths, migration extraction, and tests
exist, but the requested validation gate has not run.  It must not yet be
described as verified or production-complete.

这张怪物内容图当前状态是 `implemented_unverified`：原生代码、LuaLS 声明、回滚/保留
路径、迁移提取器与测试已经存在，但按约定尚未运行验证门，因此不能称为已验证或生产级
完成。

## Persistent execution / 持久执行

Closures, coroutine stacks, userdata, and native references are not serialized.
A durable task stores only stable data:

```text
mod_id + handler_id + due + owner + payload
```

Reload resolves `handler_id` against the new Mod state.  Missing handlers,
invalid owners, incompatible payload versions, and overdue tasks must produce
bounded diagnostics and a documented discard or migration result.  Session
coroutines remain useful but do not survive save/load.

闭包、协程调用栈、userdata 和原生引用不序列化。持久任务只保存稳定的 Mod ID、
handler ID、到期时间、owner 与 payload；重载后在新 Mod state 中重新绑定函数。

### Implemented runtime primitives / 已编码的运行时原语

Platform code registers a function once under a stable id with
`ccb.runtime.handler(id, function, payload_version)`.  `ccb.runtime.on` then
maps lifecycle names (`world_ready`, `before_save`, `after_save`, `shutdown`)
or a typed native event name (`game:<event>`) to that handler.  A Mod may bind
multiple named handlers to the same event; registration order is preserved and
registering the same event/handler pair twice is an error.  Item use actors
and persistent tasks resolve the same registry; neither stores a Lua closure
in game data or a save.

`ccb.state.character` and `ccb.state.world` store only boolean, integer,
finite-number, string, or nil values.  The engine writes internal sidecars;
Mod authors neither create nor parse their JSON representation.  A task made
with `ccb.tasks.after` stores its numeric id, handler id, absolute due turn,
character/world owner, payload version, and a flat typed payload.  Missing
handlers are preserved with a bounded diagnostic instead of losing durable
data.  A version mismatch follows the explicit chain registered with
`ccb.runtime.migrate_task_payload(handler, from, to, function)`; a missing,
cyclic, failing, or invalid migration also preserves the task for a later Mod
fix.  A multi-step chain migrates a copy and replaces the durable task only
after every step succeeds, so a late failure cannot persist a half-migrated
payload.  New tasks must use the handler's current payload version.
Overdue tasks run once at the first turn boundary after loading.  A handler may
schedule a new task to express recurrence in ordinary Lua.

Platform 代码用 `ccb.runtime.handler(id, function, payload_version)` 把函数注册到稳定
名字，再由 `ccb.runtime.on` 绑定生命周期或 `game:<event>` 原生事件。物品行为与持久
任务都按名字重新解析，不把闭包写入定义或存档。角色/世界状态只接受布尔、整数、有限
浮点、字符串和 nil；引擎自行写内部 sidecar，Mod 作者不接触其 JSON 表示。命名任务
保存 ID、handler、绝对到期回合、owner、payload version 与扁平类型化 payload；缺失
handler 会记录有界诊断并保留任务。版本不一致时只执行显式注册的
`migrate_task_payload` 迁移链；缺失、循环、失败或返回非法数据时同样保留，等待 Mod
修复。多段迁移只操作副本，全部步骤成功后才替换持久任务，因此后段失败不会留下半迁移
payload。新任务必须使用 handler 当前版本，到期任务在加载后的首个回合边界执行一次。
同一个事件可以按注册顺序绑定多个命名 handler，但同一事件与 handler 组合不能重复。

Sidecar records belonging to a currently disabled or missing Mod are retained
unchanged in the typed engine representation when other active Platform Mods
save.  Re-enabling the Mod restores its record instead of treating another
Mod's save as permission to delete it.  Malformed records still reject that
scope as a bounded unit and fall back to empty active state with a diagnostic.

暂时禁用或缺失 Mod 的 sidecar 记录会以引擎内部类型化表示保留；其他 Platform Mod
保存时不会把它顺带删除。重新启用后会恢复原记录。格式损坏时仍以整个 scope 为有界
失败单元，清空活动状态并给出诊断。

## Internal reuse and replacement boundary / 内部复用与替换边界

An early domain may privately adapt staged native definitions to the existing
loader and finalization pipeline.  This is an implementation shortcut, not a
public contract.  Every such dependency is recorded in the roadmap and is
replaced by a domain registrar or service over time.

The long-term replacement target covers author-facing core and Mod content.
Save files, settings, localization caches, generated inventories, and other
engine-owned serialization may continue to use JSON internally.  Removing
those formats does not increase Lua authoring power and is not a Platform goal.

早期领域可以在内部把暂存定义适配到现有 loader/finalize 管线，但这只是私有实现捷径，
必须在路线图记录并逐域替换。长期目标覆盖作者面对的核心与 Mod 内容；存档、设置、翻译
缓存和生成清单等引擎内部序列化不在替换目标内。

## Exact replacement ledger / 精确替代账本

`ai/lua-first-replacement-ledger.yml` is generated from the three checked
inventories and contains exactly one disposition for every JSON type, EOC
condition key, and EOC effect key.  Its statuses have strict meanings:

- `implemented_unverified`: matching Platform code and declaration exist, but
  the requested validation gate has not run;
- `primitive_available_unverified`: one or more native domain primitives exist
  without a public legacy dependency, but selector-level semantic parity has
  not been demonstrated and migration remains open;
- `planned`: a target domain/service is named, but no replacement is claimed;
- `private_adapter`: implementation currently depends on a non-public legacy
  adapter that must be removed;
- `reviewed_not_applicable`: normal Lua control flow or engine-owned
  configuration replaces no author-facing API.

The generator, schema, and exact-set checker live under `tools/agent/`.  A
selector changes status only with source, declaration, test, and documentation
evidence.  Grouping a selector under a service is architecture classification,
not proof that the service exists.

`ai/lua-first-replacement-ledger.yml` 由三份受检清单生成，每个 JSON type、EOC
condition key 和 effect key 恰好出现一次。`implemented_unverified` 表示已有代码但尚未
通过本次验证门；`primitive_available_unverified` 表示已有不依赖旧公共接口的原生积木，
但还没有逐 selector 证明等价；`planned` 只表示已确定目标而没有声称替代完成，`private_adapter` 表示
仍有不公开的旧实现依赖，`reviewed_not_applicable` 表示 Lua 控制流或引擎配置本来就不该
产生作者 API。把一项归入某个 service 只是架构分类，不能当作 service 已存在的证据。

## Migration and removal gates / 迁移与移除门槛

Legacy JSON/EOC authoring is not frozen merely because this document exists.
A domain freezes only after its Platform replacement, tooling, tests, and
documentation are usable.  Removal requires all of the following:

- every checked JSON/EOC inventory entry is mapped to a Platform domain,
  shared service, migration, or reviewed not-applicable result;
- core and bundled content targeted for removal has migrated while preserving
  stable ids and save compatibility;
- a JSON/EOC-to-Lua extraction tool produces idiomatic native-object skeletons
  and explicit TODOs instead of `run_eoc` wrappers;
- a complete zero-JSON/EOC example Mod passes discovery, load, save, reload,
  and gameplay tests;
- the deprecation window has lasted at least two stable releases and at least
  twelve months, with both conditions satisfied.

本文存在并不代表立即冻结旧作者接口。只有某个领域的 Platform 替代、工具、测试和
文档可用后，才冻结该领域的新 JSON/EOC 能力。最终移除必须同时满足完整映射、核心与
捆绑内容迁移、存档兼容、迁移工具、端到端纯 Lua Mod，以及至少两个稳定版且十二个月
的弃用窗口。

`tools/migrate_lua_first.py INPUT... --output TARGET` is the implemented
extractor.  It deterministically translates the currently native item/recipe
slice, foundational catalogs (including scent, speed-description,
harvest-drop, harvest-list, behavior-tree, monster-attack, effect-type,
weakpoint-set, field-type, item-group, sub-body-part, body-part, anatomy,
body-graph, monster, morale, disease, monster-flag, mutation-type, mutation-category,
connect-group, construction, species, emissions, monster-faction, and vehicle-part-location definitions, vehicle-part categories, mood faces,
damage-info presentation, named colors, rotatable symbols, ASCII art, limb
scores, the global hit-range configuration, bash-damage profiles, clothing
modifications, overmap land-use codes, overmap-vision profiles,
overmap locations, profession groups, map-extra collections, vehicle groups,
fault groups, explosion-light recipes, ammunition effects, addiction types, character modifiers, start locations, climbing aids, weather types, scores, the global mutation-overlay order, zone types, speech pools, end screens, nested recipe categories, attack vectors, magic types, and movement modes), and simple
event/message behaviour, emits normal Lua composition, and
writes `MIGRATION_REPORT.md` with a source location for every unresolved
field.  It accepts the comments and trailing commas used by game data;
unsupported inheritance, anonymous definitions, disassembly recipes, mixed
effects, lossy field shapes, malformed numeric shapes, and values outside the
native integer or skill ranges remain partial with explicit TODOs.  `--check`
compares an existing extraction without writing.  Normal writes stage output
before installation, and `--force` restores every previous generated file if
installation fails midway.  The tool never emits a JSON loader, EOC runner, or
raw legacy object.  Its report is an input to review, not proof of gameplay
equivalence.

`tools/migrate_lua_first.py` 是当前迁移提取器：能确定性转出已具备原生构造器的基础目录、
气味、速度描述、采收掉落类型、采收表、行为树、怪物攻击、效果类型、弱点集、场类型、
物品组、子身体部位、身体部位、解剖、身体图、怪物、士气、疾病、怪物 flag、怪物物种、
字段排放、怪物阵营、突变类型、突变分类、地形/家具连接组、建造分类、建造组、载具
部件位置、载具部件分类、心情表情、伤害信息显示顺序、命名颜色、可旋转符号、物品、
ASCII 图、肢体评分、全局命中距离配置、bash 伤害配置、服装改造、大地图土地用途、
大地图视野配置、大地图位置、职业组、地图额外内容集合、载具组、故障组、爆炸光效、弹药效果、成瘾类型、角色修正器、起始位置、攀爬辅助、天气类型、分数、全局突变覆盖显示顺序、区域类型、语音池、结束画面、嵌套配方分类、攻击向量、
魔法类型、移动模式、配方与简单事件/消息行为，其余字段全部以
带来源位置的 TODO 写入报告；`--check` 只比较
现有输出。它支持游戏数据使用的注释与尾逗号；继承、匿名定义、拆解配方、混合 effect
以及有损字段形状、畸形数字和超出原生整数/技能范围的值都会保持 partial 并写明 TODO。
普通写入先暂存再安装，`--force` 中途失败时会恢复全部旧生成文件。工具绝不会生成 JSON
loader、EOC runner 或原始旧对象，报告也
不等于玩法等价证明。

## First vertical slice and templates / 首个纵向样板与模板

The first executable slice is one zero-JSON/EOC Mod that defines an item, its
recipe, and a Lua use behaviour.  It must exercise discovery, native content,
cross-id references, a named handler, persistent state, save/load, and an
observable in-game result.

Besides the scaffold template, `data/mods/Lua_First_Example/` is a packaged
zero-JSON/EOC Mod root discovered from `main.lua`.  It is a bundled executable
fixture for the implemented item/recipe/handler slice; it is not evidence for
the remaining static domains.

Developer tooling provides `minimal` and `complete` templates plus a
scaffolding command.  Generated Mods contain no JSON and no required `lua/`
directory.  The complete template may recommend `content/`, `runtime/`, and
`tests/`, but generated files become author-owned and are never overwritten by
template updates.  Scaffolding is staged before installation, refuses files,
symlinks, or non-empty targets, and derives the zero-configuration Mod id from
the target directory name.  The complete template uses that id as its example
content namespace instead of giving every generated Mod the same item id.  A
failed final installation restores a pre-existing empty target, and a target
created or changed concurrently is preserved rather than replaced.

首个可执行样板固定为“物品 + 配方 + Lua 使用行为”的零 JSON/EOC Mod。开发工具将
提供 minimal、complete 模板和脚手架命令；生成结果不包含 JSON，也不强制 `lua/`
目录。模板只推荐组织方式，生成后文件完全归作者所有，工具不得覆盖其修改。
脚手架完成暂存后才安装，拒绝文件、符号链接和非空目标；最终安装失败时会恢复调用者原有
的空目录。目标目录名就是零配置 Mod ID，
complete 模板会用它命名空间化样例内容 ID，避免多个开发者样板互相冲突。
仓库还包含 `data/mods/Lua_First_Example/`，作为由根 `main.lua` 发现的内置纯 Lua
执行样板；它只证明当前纵向切片，不代表其余静态领域已完成。

## Maintenance rule / 维护规则

Any change to Platform discovery, lifecycle, exported native surface,
persistence, legacy dependency, or milestone status updates this document or
`ai/lua-first-roadmap.yml` and names the affected CCB-Docs ids.  Runtime source
and tests remain authoritative for implemented behaviour; planned entries must
never be presented as shipped API.

Platform 的发现、生命周期、原生导出、持久化、旧接口依赖或阶段状态变化时，必须同步
更新本文或 `ai/lua-first-roadmap.yml`，并注明受影响的 CCB-Docs 文档 ID。运行时源码
和测试始终决定已实现行为；计划项不得冒充已发布 API。
