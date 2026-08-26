# CCB Lua 0.1 平台规范 / CCB Lua 0.1 Platform Specification

Status: CCB Lua 0.1 native platform architecture; implementation is tracked in
`ai/lua-first-roadmap.yml`.

状态：CCB Lua 0.1 纯原生创作平台架构；实现进度以 `ai/lua-first-roadmap.yml` 为准。

## Purpose / 目标

CCB Lua 0.1 is the native authoring model for CCB core content and Mods.
It allows creators to define metadata, items, recipes, vehicles, creatures,
world generation, dialogue, missions, UI, and runtime behaviour directly in
pure Lua without authoring legacy JSON or EOC formats.

Lua code uses functions, modules, native objects, normal control flow,
composition, named tasks, generation-safe handles, and persistent state.
Public APIs are shaped around the game domain rather than legacy parser keys.

CCB Lua 0.1 是 CCB 核心游戏内容与 Mod 创作的原生模型。创作者直接在纯 Lua 环境中
定义 Mod 元数据、物品、配方、载具、怪物、地图生成、对话、任务、UI 与运行时行为，
告别繁复的旧数据格式。

Lua 采用函数、模块、原生对象、普通控制流、组合、命名任务、代际安全句柄和持久化
状态；公共 API 围绕游戏领域本身设计，而非复刻旧解析器键。

## Architecture & Boundaries / 架构与边界

The runtime provides modularity, transactional staging, rollback safety,
and decoupled snapshots.  Lua code receives generation-safe handles instead
of bare C++ pointers.

运行时提供模块化、事务预载（Staged）、冲突原子回滚（Rollback）与分离数据快照。
Lua 不直接接触 C++ 裸指针，全面采用代际安全句柄访问实体。

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

During initial loading, staged Monster definitions remain unfinalized until
the global pass in step 6, so world scaling and Monster adjustment are applied
exactly once.  Local Monster finalization is reserved for test or hot
environments where the dynamic data is already finalized.  Body-part and
sub-body-part similarity caches are rebuilt after global finalization, making
repeated finalization idempotent instead of appending duplicate relationships.

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
初始加载时，暂存的 Monster 定义会一直保留未 finalize 状态，直到统一 finalize 阶段，
因此世界缩放和 Monster adjustment 只会由全局流程应用一次。只有动态数据已经
finalized 的测试或热环境才会执行局部 Monster finalize；body part 和 sub-body part 的
相似关系缓存则会在全局 finalize 后重建，使重复 finalize 保持幂等而不会追加重复关系。
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

### Playable MVP v0.1 merge gate / 可玩 MVP v0.1 合并门槛

Playable MVP v0.1 is a deliberately narrow vertical slice, not a declaration
that Platform v1 replaces every JSON type or EOC selector.  It is mergeable
when one bundled zero-JSON/EOC Mod proves all of the following in the real
engine paths:

1. root `mod.lua`/`main.lua` discovery and dependency-aware Mod selection;
2. native item and recipe loading plus an observable named Lua use handler;
3. `game::save()` persistence for typed character state, typed world state,
   and a named delayed task;
4. runtime shutdown followed by full core/Mod data reload, continued item
   gameplay, restored state, and exactly-once execution of the overdue task;
5. an actionable catalog entry in a build compiled without Lua, instead of a
   Mod that appears selectable and fails only while loading a world.

The bundled `data/mods/Lua_First_Example` and the
`[playable_mvp]` integration test are the executable acceptance fixture.  The
dedicated test-matrix entries keep both Lua-enabled and Lua-disabled builds as
merge gates.  Manual desktop/Android selector and interactive presentation
checks remain separate platform follow-up work; they do not expand this MVP
into full static-domain or EOC parity.

可玩 MVP v0.1 是刻意收窄的纵向切片，并不表示 Platform v1 已经替代所有 JSON 类型或
EOC selector。它的合并门槛是：一个内置、零 JSON/EOC 的 Mod 必须通过真实引擎路径完成
根目录元数据与入口发现、依赖选择、原生物品/配方加载、命名 Lua 使用行为、
`game::save()`、角色/世界状态与延迟任务持久化；销毁 runtime 并完整重载核心和 Mod 数据
以后，物品行为和状态必须继续生效，逾期任务只能执行一次。未编译 Lua 的版本也必须在
Mod 列表中给出明确的不可用诊断，不能让玩家直到加载世界时才失败。

`data/mods/Lua_First_Example` 与 `[playable_mvp]` 集成测试是这套验收标准的可执行样例，
`ai/test-matrix.yml` 分别记录 Lua-enabled 与 Lua-disabled 门禁。桌面/Android 的人工选择器
和交互式 presentation 验证仍是独立后续工作，不能据此把 MVP 扩大解释成完整静态领域或
EOC 等价。

Validation has now started, but it does not make the whole Platform complete.
On 2026-08-11 the Linux Lua-enabled C++ test program compiled and linked, the
focused Wound/WoundFix and wound-service gates passed, and the complete
`[lua][platform]` suite passed 45 test cases with 934 assertions after adding
the bionic-summary and learned-recipe workflow.  The broader `[lua]` filter
then passed 190 matching test cases with 2706 assertions, including the
owner-identity, pre-finalize Monster, and body-cache regression coverage.  LuaLS,
public-contract, coverage, Agent-metadata, and replacement-ledger checks also
passed.  On 2026-08-12 the new bundled-Mod playable fixture passed 32
assertions through discovery, dependency-aware selection, native item/recipe
use, three real game saves, runtime shutdown, full data reload, restored typed
state, and one-time overdue task execution.  After its test-fixture cleanup was
made position-safe, the broader `[lua]` gate passed 191 cases and 2738
assertions.  A fresh build compiled without Lua also linked successfully, and
its focused Mod-manager fallback passed 13 assertions.  An Android arm64-v8a
Stable Release with Lua enabled also compiled, linked, and packaged
successfully; its unsigned APK contained `lib/arm64-v8a/libmain.so`.
Interactive desktop/Android Mod-selector and presentation checks are still
open, so only explicitly named validated slices may be treated as having
crossed their local gate.

The 2026-08-13/14 batches expanded the migrated-core vertical slice.
`data/mods/Migrated_Core/` is now a generated zero-JSON/EOC fixture covering 87
domains and 4286 fully translated entries with 0 partial skeletons and 0
TODOs.  Its per-process semantic parity gate snapshots each legacy JSON-loaded
registry before apply and compares the migrated native replacements
field-for-field inside the same cycle; the current run reaches 40700
assertions, and a catalog is promoted only on that whole-registry evidence.
The harness has repeatedly caught real semantic gaps before promotion — the
bash-damage finalize fill-in, fault-fix reverse-link re-derivation,
sub-body-part copy-from inheritance, start-location interval clamping, and
several empty-src registry insertion segfaults — so a verified catalog means
its comparison actually ran.  The creator/migrator unit suite passes all 86
cases.  A clean 2026-08-14 rebuild of the Lua-enabled test binary then ran the
complete `[lua]` filter end to end: 214 cases and 43653 assertions, all
passing, including the migrated-core parity gate.  The `landed_technique`
combat-hook failure recorded by earlier stash-based runs does not reproduce
in the clean build, so the recorded current gate is green.

The exact replacement ledger contains 775 dispositions; its generated summary
is the authoritative count.  At the 2026-08-14 regeneration the split is 53
implemented_verified, 14 bounded_implemented_verified, 14
implemented_unverified, 113 bounded_implemented_unverified, 430
primitive_available_unverified, 133 planned, 0 private_adapter, and 18
reviewed_not_applicable.  The whole-selector verified catalogs are anatomy,
attack vectors, bash-damage profiles, butchery requirements, connect groups,
construction categories and groups, damage-info ordering, disease types,
dreams, field emissions, fault groups, gates, harvest-drop types, the global
hit-range configuration, item actions, limb scores, monster flags, mutation
categories, named colors, overmap connections, overmap land-use codes,
overmap-vision profiles, the global mutation-overlay order, profession groups,
proficiency categories, recipe categories, rotatable symbols, scent types,
skills, skill-display types, monster species, speech pools, speed
descriptions, sub-body parts, vehicle color palettes, vehicle groups,
vehicle-part categories and locations, weapon categories, ammunition types,
and the checked migration and blacklist catalogs.  Bounded verified selectors
whose exercised shapes have whole-registry parity are item categories, loot
zones, clothing modifications, damage types, explosion lights, faults, JSON
flags, mood faces, morale types, movement modes, recipe groups, scenarios,
start locations, and tool qualities.  The implemented-but-unverified slice
still covers activity types, help topics, magic types, monster adjustment,
playlists, sound effects and preloads, trait groups, the remaining blacklists,
and the not-yet-sliced migration kinds.  This remains far short of complete
static-domain coverage: 430 selectors still expose only composable native
primitives, 133 remain planned, and field-level parity work continues.  The
hit range is deliberately a replace-only singleton because it configures one
engine-wide table rather than an id-addressed catalog.  Clothing modifiers use
composable scaling dimensions rather than exposing the legacy object shape.
Attack vectors rebuild anatomical substitutions from authored limbs and
contact surfaces, making repeated finalization idempotent.

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

验证已经开始，但这不表示整个平台已经完成。2026-08-11 的 Linux 本地验证成功编译并链接
Lua-enabled C++ 测试程序，Wound/WoundFix 与伤口 service 的聚焦门禁全部通过；加入
仿生摘要与已学配方工作流后，完整 `[lua][platform]` 套件以 45 个用例、934 个断言通过；
随后更广的 `[lua]` 过滤集也以 190 个匹配用例、2706 个断言通过，其中包含 owner identity、
Monster pre-finalize 与身体缓存回归覆盖。LuaLS、公开契约、覆盖率、Agent
元数据与替换账本检查同样通过。2026-08-12 新增的内置 Mod 可玩闭环以 32 个断言通过，
真实覆盖发现、依赖选择、原生物品/配方使用、三次 `game::save()`、runtime 销毁、完整数据
重载、类型化状态恢复与逾期任务单次执行；修正测试夹具的安全角色位置后，更广的 `[lua]`
门禁以 191 个用例、2738 个断言通过。全新无 Lua 构建也成功链接，其 Mod 管理器降级测试以
13 个断言通过。启用 Lua 的 Android arm64-v8a Stable Release 也已成功编译、链接并打包；
生成的未签名 APK 包含 `lib/arm64-v8a/libmain.so`。桌面/Android Mod 选择器与交互式
presentation 人工验证仍未完成，因此只有本文明确点名的已验证切片可以视为通过本地门禁。
775 项的分类数字以生成账本 summary 为准，不在本文手工复制。

2026-08-13/14 的批次继续扩大已迁移核心纵向切片：生成的
`data/mods/Migrated_Core/` 夹具现在覆盖 87 个领域、4286 个完整转换条目，0 个部分
骨架、0 个 TODO。其单进程语义 parity 门禁会在 apply 前快照每个旧 JSON 注册表，并在
同一周期内对迁移后的原生替代定义做逐字段比较；当前运行达到 40700 个断言，目录只有
拿到全注册表证据才会晋级。门禁在晋级前多次抓到真实语义缺口——bash 伤害配置的
finalize 补全、故障修复反向链接重推导、子身体部位 copy-from 继承、起始位置区间夹取，
以及多处空 src 向量注册插入导致的段错误——因此“已验证”只意味着比较真的跑过。
creator/migrator 单元套件 86 个用例全部通过。2026-08-14 干净重编译的 Lua-enabled
测试二进制随后完整跑过 `[lua]` 过滤集：214 个用例、43653 个断言全部通过，包含
migrated-core parity 门禁；早前基于 stash 的构建记录的 `landed_technique` 战斗
Hook 失败在干净构建中不再复现，当前记录的门禁为全绿。

账本当前（2026-08-14 重新生成）的分布为 53 项 implemented_verified、14 项
bounded_implemented_verified、14 项 implemented_unverified、113 项
bounded_implemented_unverified、430 项 primitive_available_unverified、133 项
planned 与 18 项 reviewed_not_applicable。完整 selector 已验证的目录包括解剖、攻击
向量、bash 伤害配置、屠宰需求、连接组、建造分类与建造组、伤害信息显示顺序、疾病类型、
梦境、字段排放、故障组、大门、采收掉落类型、全局命中距离配置、物品动作、肢体评分、
怪物 flag、突变分类、命名颜色、大地图连接、大地图土地用途、大地图视野配置、突变覆盖
显示顺序、职业组、熟练度分类、配方分类、可旋转符号、气味类型、技能、技能显示分类、
怪物物种、语音池、速度描述、子身体部位、载具调色板、载具组、载具部件分类与位置、
武器分类、弹药类型，以及受检的迁移与黑名单目录。已验证有界形状的 selector 包括物品
分类、战利品区域、服装改造、伤害类型、爆炸光效、故障、JSON flag、心情表情、士气类型、
移动模式、配方组、场景、起始位置与工具质量。已实现但未验证的切片仍覆盖活动类型、
帮助主题、魔法类型、怪物 adjustment、播放列表、环境音效与预加载、特质组、其余黑名单
与尚未切片的迁移类型。它仍远未达到静态内容全面覆盖：430 个 selector 仍只暴露可组合
原生原语，133 个仍处于 planned，逐字段等价工作仍在继续。命中距离配置刻意只允许显式
`replace`：它是一张引擎全局表，不是假装拥有普通对象 ID 的目录。服装数值使用可组合的
厚度/覆盖率缩放维度，而不是公开旧 JSON 对象形状。大地图视野配置使用有序的 `appearance` 与
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

Native references carry an owner identity and generation check.  Every
Platform Mod runtime receives a distinct opaque owner, including runtimes
created in the same reload generation.  Handles and live-object tokens retain
that owner weakly and must match the exact current owner before native
resolution.  Token equality compares the complete owner-plus-generation
identity without keeping the owner alive, so copied tokens remain equal after
shutdown while tokens from different same-generation runtimes never compare
equal.  Inactive state is explicit rather than encoded as a reserved
generation number, so every `size_t` generation value, including its maximum,
remains unambiguous.  Access after object destruction, world replacement,
content commit, runtime replacement, or crossing into another Mod runtime
raises a Lua error instead of dereferencing a stale pointer.  Native modules
loaded by a trusted Mod can bypass this boundary and are outside the
compatibility guarantee.

Static definitions are real native staging objects.  The target content API
provides explicit `add`, `replace`, and transactional `edit` operations.
`extend_item_group` appends entries to an existing native item group of the
same kind without copying or replacing entries contributed by earlier Mods.
Duplicate ids are errors unless replacement, editing, or this bounded item-group
extension is requested.  Normal Lua functions, loops, modules, constructors,
and cloning replace JSON `copy-from` and inheritance syntax.

Platform 导出的 C++ 类型公开全部可绑定的 public 字段、方法与运算符；private 和
protected 仍遵守 C++ 规则。每个 Mod runtime 都有独立且不向 Lua 暴露的 owner 身份，
即使它们处于同一重载代次也不能交换 handle 或原生活对象 token；二者都只弱引用 owner，
并在解析前同时核对精确 owner、runtime 代次与世界代次。token 相等比较使用完整的
owner 控制块身份与代次，但不会延长 owner 生命周期，所以同源副本在 runtime 关闭后仍
稳定相等，而不同的同代 runtime token 永不相等。失效状态不再占用某个代次数值，因此
包括 `size_t` 最大值在内的全部代次都不会与哨兵碰撞。owner 消失、跨 Mod runtime、
世界切换、内容提交或 runtime 替换后访问会抛 Lua 错误。静态定义使用真实的原生
staging 对象，通过显式 `add`、`replace`、事务性 `edit` 提交；`extend_item_group`
只向同类的既有原生物品组追加条目，不复制或覆盖更早 Mod 提供的条目；普通 Lua 组合取代
JSON `copy-from`。

### Implemented native vertical slice / 已编码的原生纵向切片

The phase-2/3 code exposes constructors on the Mod-local `ccb.content` table.
They return native userdata, not tables accepted by a generic loader.  `add`
rejects an existing id, `replace` requires one, and `edit_item`/`edit_recipe`
clone a definition staged earlier by the same Mod in the current candidate.
Registering the clone with `ccb.content.edit` replaces that earlier staged
value while preserving its original add-or-replace intent.  This makes edits
ordinary Lua module composition and gives cold load, full reload, and
fingerprint-gated hot reload the same semantics.
`extend_item_group` accepts a newly built `ItemGroup` as an entry-only patch;
the target must already exist and have the same collection/distribution kind.
Its append is fingerprinted and rolls back by restoring the target's prior
entry boundary.
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
`SubBodyPart`, `BodyPart`, `Wound`, `WoundFix`, `Anatomy`, `BodyGraph`, `Monster`, `MoraleType`,
`DiseaseType`, `MonsterFlag`, `MutationType`, `Species`, `Emission`, `MonsterFaction`,
`ConnectGroup`, `MutationCategory`, `ConstructionCategory`, `ConstructionGroup`, `VehiclePartLocation`,
`VehiclePartCategory`, `MoodFace`,
`DamageInfoOrder`, `NamedColor`, `RotatableSymbol`, `OvermapLocation`,
`ProfessionGroup`, `MapExtraCollection`, `VehicleGroup`, `FaultGroup`,
`ExplosionLight`, `AmmoEffect`, `AddictionType`, `CharacterModifier`,
`StartLocation`, `ClimbingAid`, `WeatherType`, `Score`, `ButcheryRequirement`, `ItemAction`, `Scenario`, `VehicleColorPalette`, `MonsterGroup`, `OvermapConnection`,
`OverlayOrder`, `ZoneType`, `SpeechPool`, `EndScreen`, `ActivityType`,
`HelpTopic`, `SnippetCategory`, `Playlist`, `NestedRecipeCategory`,
`SoundEffect`, `SoundEffectPreload`, `Technique`, `MartialArt`, `Trap`,
`Construction`, `Furniture`, `Terrain`, `Gate`, `Fault`, `FaultFix`, `Dream`,
`Achievement`, `Conduct`, `Blacklist`, `MapExtra`, `WeatherGenerator`,
`Migration`, `ShopkeeperBlacklist`, `ShopkeeperWhitelist`, and
`ShopkeeperConsumptionRates`.
The `OvermapConnection` builder stages id plus `subtype(terrain, basic_cost,
locations, orthogonal, perpendicular_crossing)` entries, mirroring the legacy
`overmap_connection` table (empty location lists are legal).
The `MonsterGroup` builder is bounded: it stages id, an optional default monster
(highest-frequency fallback), an `is_animal` switch, and `monster`/`group`
entries with weight, cost multiplier, and pack bounds; legacy gated shapes
(starts/ends/conditions/event/spawn_data) remain explicit migration TODOs.
The `VehicleColorPalette` builder stages a stable id plus `group(fuzzy_ids,
colors)` entries: fuzzy part-id prefixes map to a positional weighted color
group, mirroring the legacy `vehicle_color_palette` table.
The `Scenario` builder is bounded: it stages id, name, description, start name,
points, blacklist/extra-profession switches, reveal-locale and visibility
distance, plus `location`/`profession`/`allowed_trait`/`forced_trait`/
`forbidden_trait`/`flag`/`requirement` entries; legacy fields without a native
shape (eoc, missions, map_extra, calendar overrides, vehicles, surround
groups) remain explicit migration TODOs.
The `ItemAction` builder takes a stable id and an optional display name
(defaults to the id) and feeds the engine's item-action registry directly,
mirroring the legacy `item_action` entries.
The `ButcheryRequirement` builder takes a stable id and per-row
`requirement(speed, size, butcher, requirement_id)` entries: speed is a finite
non-negative bonus, size is one of `TINY`/`SMALL`/`MEDIUM`/`LARGE`/`HUGE`,
and butcher is one of `BLEED`/`QUICK`/`FULL`/`FIELD_DRESS`/`SKIN`/`QUARTER`/
`DISMEMBER`/`DISSECT`, mirroring the legacy `butchery_requirement` table shape.
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

`Wound` and `WoundFix` are native staging definitions, not JSON-shaped tables
passed to a compatibility loader.  A wound constructor owns `id`, native
player-visible `name`/`plural_name`/`description` text, pain and healing-turn
ranges, damage range, selection `weight`, per-part limit, and optional
required/forbidden body-part flags.  Its `damage_type`, `limb_score`, `progression`,
`require_body_part_type`, and `forbid_body_part_type` methods build typed,
deduplicated links.  Damage ranges, selection weight, and the body-part
flag/type constraints govern natural damage-selection candidates; they do not
restrict an explicit direct add through the wound service.  A wound fix owns
`id`, native player-visible name, description and success-message text,
duration in turns, and health delta; `skill`, `proficiency`,
`removes`, `adds`, and `requires` compose its native treatment graph.
These player-visible fields currently use `no_translation`; structured
localization data and author-facing localization constructors are not yet
implemented.
Proficiency time multipliers must remain positive when represented by the
native float type.  A requirement multiplier is accepted only when every
referenced component and tool count remains within the signed native integer
range after multiplication and when mergeable alternative groups still fit
that range after native consolidation; quality requirements are linked without
scaling.  Negative tool counts follow the native post-multiplication `-1`
clamp.
References within the same candidate are finalized together.  `add` requires a new id,
`replace` requires an existing id, and `edit_wound`/`edit_wound_fix` clone an
earlier same-Mod candidate for transactional `edit`.  Validation failure or a
later candidate failure restores registries, wound-to-fix links, body-part
caches, and derived requirements without a JSON loader or EOC callback.

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
`item` properties are runtime-owner- and generation-checked `GameHandle`
values, and `position`
is an immutable `TripointCoord` tagged as reality-bubble map-square (`bub` /
`ms`).  A native RAII callback lease clears both borrowed pointers and expires
the context on every exit path, including callback errors and C++ unwinding;
copied handles remain usable only while their exact runtime owner, runtime
generation, world generation, and native object are all still valid.
`player_name`, `item_id`, `charges`, and `message` are convenience members, not
substitutes for the typed handles.

物品 handler 收到原生 `ItemUseContext`。其中 `character` 与 `item` 是带精确 runtime
owner、运行时代次与世界代次检查的 `GameHandle`，`position` 是标记为现实气泡地图格
（`bub` / `ms`）的不可变 `TripointCoord`。回调返回后 context 本身立即失效；复制出的
handle 也只有在原 owner、运行时代次、世界代次与原生对象都仍有效时才能继续使用。原生
RAII 回调租约会在正常返回、Lua 报错与 C++ 栈展开的所有路径上清空借用指针并使 context
失效。

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
伤口、伤口修复、疾病类型、怪物 flag、怪物物种、字段排放、怪物阵营、突变类型、突变分类、地形/家具连接组、
建造分类、建造组、载具部件位置、载具部件分类、心情表情表、伤害信息显示顺序、
命名颜色、可旋转符号组、大地图位置、职业组、地图额外集合、载具组、故障组、
爆炸光效、弹药效果、成瘾类型、角色修正器、起始位置、攀爬辅助、天气类型、分数、
屠宰需求、物品动作、场景、载具调色板、怪物组、大地图连接、突变覆盖顺序、区域类型、
语音池、结束画面、活动类型、帮助主题、Snippet 分类、播放列表、嵌套配方分类、
环境音效与预加载、武术技巧、武术风格、陷阱、建造、家具、地形、大门、故障修复、
梦境、成就、操守、黑名单、地图附加物、天气生成器、迁移与三类商人规则，以及可由
配方按 id 和倍数组合的 `Requirement` 需求图，以及供营地/建筑流程
组织配方的 `RecipeGroup`。它们先于物品/配方
应用，因此同一候选中声明的质量、flag、
材质、伤害类型与维生素可被后续对象引用；所有目录都进入 add/replace/edit、finalize 后
保留检查、热重载指纹和逆序回滚。伤害类型的命中/受伤行为绑定命名 Lua handler，不暴露
`onhit_eocs`、`ondamage_eocs` 或 EOC runner。

`Wound` 与 `WoundFix` 也是原生暂存定义，不是送进兼容 loader 的 JSON 形状 table。
伤口构造器直接拥有 `id`、原生玩家可见的单复数名称和描述文本、疼痛/愈合回合范围、伤害范围、
抽取权重、每身体部位上限，以及可选的身体部位必需/禁止 flag；`damage_type`、
`limb_score`、`progression`、`require_body_part_type` 与
`forbid_body_part_type` 负责建立类型化且去重的关系。伤害范围、抽取权重与身体部位
flag/type 约束用于自然伤害流程的候选筛选，不限制通过伤口 service 显式指定部位的直接
添加。伤口修复直接拥有原生玩家可见的名称、描述、成功文本、耗时回合和生命值变化，
并用 `skill`、`proficiency`、`removes`、`adds`、
`requires` 组合原生治疗图。这些玩家可见字段目前通过 `no_translation` 构造；结构化
本地化数据与面向作者的本地化构造器尚未实现。熟练度耗时倍数转换成原生 `float` 后仍须
为正；需求倍数只在
所引用的每个组件和工具数量相乘后仍落在原生有符号整数区间，并且可合并备选组经原生
consolidate 后仍不越界时才会被接受；负工具数量在安全乘法后按原生规则夹到 `-1`，质量
需求不随该倍数缩放。同一候选中的引用一起 finalize；`add` 只新增、`replace` 只
替换已存在 id，`edit_wound`/`edit_wound_fix` 克隆本 Mod 更早暂存的候选后再事务性
`edit`。任一校验或后续候选失败都会恢复目录、伤口到修复的链接、身体部位缓存与派生需求，
全程不调用 JSON loader 或 EOC callback。

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
spawning, followers, relocation, and the read-only native definition snapshot
registry at `ccb.services.registry`.  These are shared C++ implementations,
not calls into a v5 Lua state.  Platform deliberately does not install the v5
EOC table, authored JSON registry, or capability surface.  Reads require
`world_ready`; mutations additionally require an active Platform callback.

当前 Platform state 已在 `ccb.services` 下安装上述原生领域服务，其中
`ccb.services.registry` 是只读的原生定义快照 registry。它们共享的是 C++ 实现，
不会调用另一个 v5 Lua state；Platform 明确不安装 v5 的 EOC table、作者 JSON registry
或 capability 表。读取要求世界已就绪，修改还要求当前处于 Platform 回调。

Coordinates embedded in definition-policy and event callback payloads are
detached plain Lua tables, not borrowed native coordinate objects and not
`TripointCoord` userdata.  Their mandatory `coordinate_space` tag makes the
native frame explicit: `bub_ms` means reality-bubble map squares, while
`abs_ms` means absolute map squares.  Authors must branch or convert at an
explicit service boundary instead of treating the two spaces as interchangeable.

定义策略与事件回调 payload 中携带的坐标是脱离原生对象的普通 Lua table，不是借用的
原生坐标对象，也不冒充 `TripointCoord` userdata。必需的 `coordinate_space` 标签明确区分
原生坐标系：`bub_ms` 表示现实气泡地图格，`abs_ms` 表示绝对地图格；两者不能隐式混用，
需要由作者在明确的 service 边界判断或转换。

`ZoneToken` also carries an unexposed runtime-owner context and native lifetime
identity in addition to its readable snapshot.  A token cannot cross into a
different Mod runtime even when both runtimes use the same numeric generation.
Deleting a zone and creating a field-for-field identical replacement does not
revive the old token; only a fresh token from the replacement can resolve it.
The identity anchor follows ordinary native copies and moves, so container
reallocation alone does not invalidate a live zone.

`ZoneToken` 除可读快照外还携带不向 Lua 暴露的 runtime owner 上下文与原生生命周期
身份；即使数值代次相同，token 也不能跨到另一个 Mod runtime。删除区域后，即使逐字段
创建完全相同的新区域，旧 token 也不会复活；只有新区域返回的新 token 才能解析它。
身份锚点会跟随原生对象的正常复制与移动，因此仅容器扩容不会误使仍存活的区域失效。

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

Dialogue hooks use Platform-native semantic fields rather than EOC positional
talkers.  `on_dialogue_start` receives `avatar`, `interlocutor`, and
`initial_topic`; `on_dialogue_option` receives `avatar`, `interlocutor`,
`current_topic`, and `selected_topic`; `on_dialogue_end` receives `avatar`,
`interlocutor`, and `last_topic`.  All three payloads add `by_radio` only when
the dialogue actually runs over radio contact and `reason` only when the
dialogue was opened with a non-empty reason string, so ordinary Lua `if
payload.by_radio` / `if payload.reason` expressions replace the legacy
`is_by_radio` and `has_reason` conditions.  Participant presence is the
payload's own `avatar` / `interlocutor` fields instead of `has_alpha` /
`has_beta`.  Platform never publishes `alpha`/`beta` aliases.  The existing
Lua API v5 dispatcher keeps its own compatibility payload unchanged and runs
before Platform, so its candidate result is visible through
`payload.results` without becoming Platform's authoring vocabulary.

Lua-owned dialogue topics may use `ccb.runtime.dialogue_topic(topic_id,
handler_id)` to render inside the native NPC dialogue window.  The named
handler receives generation-bound `avatar` and `interlocutor` handles plus the
current `topic`.  It is called with `phase = "line"` to return one non-empty
string and with `phase = "responses"` to return a bounded dense array of
`{ text = string, topic = string? }` descriptors.  This is the low-level
named-handler interface; a topic ID cannot also be registered through
`ccb.dialogue.register_topic`.

For normal authored dialogue, `ccb.dialogue.register_topic` and
`ccb.dialogue.extend_topic` use the established Lua dialogue descriptor shape:
`dynamic_line` and `responses` may be static values or functions receiving a
callback-scoped `PlatformDialogueContext`; each response may use
`on_select(context)` to change context values or override its next topic.
The context offers bounded value access plus `quote_trade_item` and
`buy_quoted_item`, which preserve native NPC order pricing, payment, and item
delivery semantics without exposing a borrowed `dialogue` pointer.  Extensions
compose with native responses in Mod dependency order and may opt into
`insert_before_standard_exits`.  Neither dialogue API publishes JSON
talk-topic objects or an EOC execution entry point.

`ccb.runtime.hook` 将命名 handler 接到受检的同步 Hook 目录；payload 中的活对象只以
代次绑定 handle 或快照跨界。只有 Hook 契约声明过的否决、文本、替换值或菜单结果才会
生效，Platform handler 按 Mod 依赖顺序与原生 dispatcher 合成。字符串结果与菜单项必须
是有界、从 1 开始且无空洞的数组；无效的共享修改或返回值只丢弃当前 handler 的候选
结果，不会抹掉此前 handler 的聚合结果。

对话 Hook 使用 Platform 自己的语义字段，不沿用 EOC 的位置式 talker：
`on_dialogue_start` 得到 `avatar`、`interlocutor`、`initial_topic`；
`on_dialogue_option` 得到 `avatar`、`interlocutor`、`current_topic`、`selected_topic`；
`on_dialogue_end` 得到 `avatar`、`interlocutor`、`last_topic`。三个 payload 都仅在
对话确实通过无线电进行时携带 `by_radio`、仅在对话以非空原因打开时携带 `reason`，
因此普通 Lua 的 `if payload.by_radio` / `if payload.reason` 表达式直接取代 legacy 的
`is_by_radio` 与 `has_reason` 条件；参与者存在性由 payload 自身的 `avatar` /
`interlocutor` 字段表达，取代 `has_alpha` / `has_beta`。Platform 不发布
`alpha`/`beta` 别名。现有 Lua API v5 dispatcher 为兼容仍保留自己的旧 payload，并先于
Platform 运行；它产生的候选结果只通过 `payload.results` 进入 Platform，不会成为新的
作者词汇。

Lua 自有对话主题可通过 `ccb.runtime.dialogue_topic(topic_id, handler_id)` 在原生 NPC
对话窗口中渲染。命名 handler 得到受代次约束的 `avatar`、`interlocutor` handle 与当前
`topic`；`phase = "line"` 时返回一个非空字符串，`phase = "responses"` 时返回有界、
从 1 开始且无空洞的 `{ text = string, topic = string? }` 数组。这是底层的命名 handler
接口；同一 topic ID 不可再通过 `ccb.dialogue.register_topic` 注册。

常规作者对话使用 `ccb.dialogue.register_topic` 与
`ccb.dialogue.extend_topic`，其 `dynamic_line` 和 `responses` 沿用既有 Lua 对话描述符
形状：既可为静态值，也可为接收回调作用域 `PlatformDialogueContext` 的函数；每个
response 可用 `on_select(context)` 修改上下文或覆盖下一主题。该上下文提供有界值访问及
`quote_trade_item` / `buy_quoted_item`，并在不暴露借用 `dialogue` 指针的前提下保持原生
NPC 订单定价、付款和物品交付语义。扩展按 Mod 依赖顺序与原生 response 合成，并可设
`insert_before_standard_exits`。两套对话 API 都不发布 JSON talk-topic 对象，也不提供
EOC 执行入口。

Dialogue predicate queries are ordinary bounded snapshots over the same
domain services instead of per-key condition functions.  A character
snapshot's `travel.has_path` reports whether the character currently follows
an overmap travel path (legacy `u_is_travelling` / `npc_is_travelling`).
`services.npcs.ai_rules(handle)` returns a structured snapshot of `aim`,
`engagement`, `cbm_recharge`, `cbm_reserve`, the enabled `allies` string list,
and a `pickup_whitelist` boolean; the legacy `u_has_pickup_list` shape is the
plain Lua expression `rules.pickup_whitelist`, and non-NPC handles fail with
`wrong_subtype` exactly like legacy non-NPC talkers returning false.
`services.creatures.can_see(observer, target)` evaluates native perception
rules for any observer creature, covering `player_see_u` with the avatar as
observer without a player-only spelling.  `services.characters.is_safe(handle)`
reports the native danger assessment for NPCs and is always true for other
characters, and `services.overmap.is_safe(position)` exposes the native
overmap safety rule; their conjunction is the legacy `u_at_safe_space`.
`services.items.snapshot(handle).rotten` is the bounded projection of the
legacy `is_rotten` item-talker condition.  The migrator emits these service
expressions, composed with plain Lua helpers, instead of a condition-table
DSL.

对话条件查询同样走领域 service 的普通有界快照，而不是逐键条件函数。角色快照的
`travel.has_path` 报告角色当前是否沿 overmap 旅行路径移动（取代 legacy 的
`u_is_travelling` / `npc_is_travelling`）。`services.npcs.ai_rules(handle)` 返回
`aim`、`engagement`、`cbm_recharge`、`cbm_reserve`、启用的 `allies` 字符串列表与
`pickup_whitelist` 布尔的结构化快照；legacy `u_has_pickup_list` 形状即普通 Lua 表达式
`rules.pickup_whitelist`，非 NPC handle 以 `wrong_subtype` 失败，与 legacy 非 NPC
talker 返回 false 的语义一致。`services.creatures.can_see(observer, target)` 对任意
观察者按原生感知规则求值，以 avatar 作观察者即覆盖 `player_see_u`，无需玩家专属拼写。
`services.characters.is_safe(handle)` 返回 NPC 的原生危险评估、其他角色恒为 true；
`services.overmap.is_safe(position)` 暴露原生 overmap 安全规则，二者合取即 legacy 的
`u_at_safe_space`。`services.items.snapshot(handle).rotten` 是 legacy `is_rotten`
物品 talker 条件的有界投影。迁移器输出的是这些 service 表达式与普通 Lua helper 的
组合，而不是条件表 DSL。

Ambient sound content uses the same transactional native definition model as
every other catalog: `ccb.content.SoundEffect` stages an `id` plus optional
`variant`, `season`, `is_indoors`, `is_night` filters and a shared `volume`,
then `:file(relative_path)` appends relative soundpack paths; a definition
with no files is invalid as an effect.  `ccb.content.SoundEffectPreload`
stages the same key without files and only preloads the variant.  Both commit
through the shared `sfx` service during finalization and roll back by erasing
the exact keys they added; they never depend on the JSON sound loader.  The
migrator expands each legacy `sound_effect` entry into one native definition
per variant and each `sound_effect_preload` entry into one native preload.

环境音效内容与其他目录一样走事务式原生定义模型：`ccb.content.SoundEffect` 暂存
`id` 以及可选的 `variant`、`season`、`is_indoors`、`is_night` 过滤与共享 `volume`，
再用 `:file(relative_path)` 追加相对于当前声音包的相对路径；没有任何文件的定义
不能作为 effect。`ccb.content.SoundEffectPreload` 暂存同样的键（不含文件），只预加载
该 variant。两者都在 finalize 时通过共享的 `sfx` service 提交，并在回滚时精确擦除
自己添加的键；它们不依赖 JSON 声音加载器。迁移器把每个 legacy `sound_effect` 条目
展开为每个 variant 一个原生定义，把每个 `sound_effect_preload` 条目展开为一个原生
预加载。

`ccb.content.Recipe` also stages practice and disassembly content through the
same transactional recipe model.  A recipe with `practice = true` registers a
practice recipe; native `practice_data`, `book_learn`, and `proficiencies`
progression stays author-owned Lua behaviour and the migrator reports those
members as explicit TODOs.  A recipe with `uncraft = true` registers into the
native disassembly dictionary under the legacy-compatible key derived from
`result`, so `services.recipes` and engine lookups such as
`recipe_dictionary::get_uncraft` resolve it without a legacy loader.  Rollback
restores both dictionaries exactly.

`ccb.content.Recipe` 同样通过事务式配方模型承载 practice 与拆解内容。带
`practice = true` 的配方注册为练习配方；原生 `practice_data`、`book_learn` 与
`proficiencies` 进阶数据由作者的 Lua 行为自行表达，迁移器把它们列为显式 TODO。
带 `uncraft = true` 的配方以 `result` 派生的 legacy 兼容键注册进原生拆解字典，`services.recipes` 与引擎查询（如 `recipe_dictionary::get_uncraft`）都能在不经过
legacy 加载器的情况下解析它。回滚会精确恢复两个字典。

`services.characters.add_wet(handle, amount)` exposes the shared native
drenching operation as a validated write: the legacy `u_add_wet` shape is the
plain service call with a bounded integer delta, and the same rain-immunity,
feather, rainproof-clothing, and warmth filters apply as in the engine's own
weather drenching.  The migrator converts proven avatar `u_add_wet` effects
and keeps unproven `npc_add_wet` shapes partial until an NPC actor context is
established.

`services.characters.add_wet(handle, amount)` 把共享的原生淋湿操作暴露为受检的写
服务：legacy `u_add_wet` 形状就是带上界整数增量的普通服务调用，雨水免疫、羽毛、
防雨衣物与保暖过滤等引擎原生淋湿规则照常生效。迁移器转换已证明 avatar 的
`u_add_wet` effect，未证明的 `npc_add_wet` 形状保持 partial，直到 NPC actor
上下文成立。

`ccb.content.Technique` stages martial-arts techniques through the same
transactional model: `id`, `name`, optional messages, the boolean delivery and
counter flags, weighting, repeat/stun/down/knockback ranges, and the `aoe`
shape are plain options, while `:flag`, `:attack_vector`, and
`:requires_skill` append bounded requirements.  Finalization inserts a native
`ma_technique` into the shared martial-arts registry with
`unarmed_allowed`/`melee_allowed`/`strictly_unarmed` requirements and the
listed skill minimums; rollback restores or erases the exact ids.  Legacy
`tech_effects`, inline `eocs`, dialogue `condition`, and `bonuses` remain
author-owned Lua behaviour and the migrator reports them as explicit TODOs
instead of duplicating their key-shaped tables.

`ccb.content.Technique` 通过同样的事务模型暂存武术技巧：`id`、`name`、可选消息、
布尔施放与反击标志、weighting、repeat/stun/down/knockback 数值范围与 `aoe` 形状
都是普通 options，`:flag`、`:attack_vector` 与 `:requires_skill` 追加有界需求。
Finalize 时把原生 `ma_technique` 插入共享武术注册表，并带上
`unarmed_allowed`/`melee_allowed`/`strictly_unarmed` 需求与所列技能下限；回滚会
精确恢复或擦除对应 id。legacy `tech_effects`、内联 `eocs`、对话 `condition` 与
`bonuses` 保持作者自有的 Lua 行为，迁移器将其列为显式 TODO，而不是逐键复制它们
的表格形状。

`ccb.content.MartialArt` stages styles through the same transactional model:
`id`, `name`, optional initiate messages, `priority`, `primary_skill`,
`learn_difficulty`, `teachable`, arm/leg block effectiveness, and the
weapon-policy booleans are plain options, while `:autolearn(skill, level)`,
`:technique(id)`, `:weapon(id)`, and `:weapon_category(id)` append bounded
membership.  Finalization inserts a native `martialart` into the shared
martial-arts registry; rollback restores or erases the exact ids.  Legacy
inline buffs and inline EOC arrays stay author-owned Lua behaviour and the
migrator reports them as explicit TODOs instead of duplicating their
key-shaped tables.

`ccb.content.MartialArt` 通过同样的事务模型暂存武术风格：`id`、`name`、可选
起手消息、`priority`、`primary_skill`、`learn_difficulty`、`teachable`、手臂/腿部
格挡效果与武器策略布尔都是普通 options，`:autolearn(skill, level)`、
`:technique(id)`、`:weapon(id)` 与 `:weapon_category(id)` 追加有界成员关系。
Finalize 时把原生 `martialart` 插入共享武术注册表；回滚精确恢复或擦除对应 id。
legacy 内联 buff 与内联 EOC 数组保持作者自有的 Lua 行为，迁移器将其列为显式
TODO，而不是逐键复制它们的表格形状。

`ccb.content.Trap` stages map traps through the same transactional model:
`id`, `name`, `color`, `symbol`, `action`, spotting/dodge/disarm difficulties,
optional memorial and trigger messages, and the benign/invisible/radius
scalars are plain options, while `:flag(id)` and `:drop(item, quantity,
charges)` append bounded membership and disassembly components.  Finalization
inserts a native `trap` into the shared trap registry; rollback restores or
erases the exact ids.  Legacy `spell_data`, inline `eocs`, `vehicle_data`, and
`map_regen` stay author-owned Lua behaviour and the migrator reports them as
explicit TODOs.

`ccb.content.Trap` 通过同样的事务模型暂存地图陷阱：`id`、`name`、`color`、
`symbol`、`action`、发现/闪避/拆除难度、可选纪念与触发消息，以及
benign/invisible/radius 等标量都是普通 options，`:flag(id)` 与
`:drop(item, quantity, charges)` 追加有界成员与拆解组件。Finalize 时把原生
`trap` 插入共享陷阱注册表；回滚精确恢复或擦除对应 id。legacy `spell_data`、
内联 `eocs`、`vehicle_data` 与 `map_regen` 保持作者自有的 Lua 行为，迁移器将其
列为显式 TODO。

`ccb.content.Construction` stages constructions through the same transactional
model: `id`, `group`, `category`, `pre_note`, `post_terrain`,
`duration_moves`, and `activity_level` are plain options, while
`:requires_skill(skill, level)`, `:using_requirement(id, multiplier)`,
`:pre_terrain(id)`, `:pre_flag(flag, force)`, and `:post_flag(flag)` append
bounded requirements.  Inline requirements become a native `ccb.content.
Requirement` staged by the same Mod and referenced through
`:using_requirement` instead of a hidden inline loader.  Finalization inserts a
native `construction` into the shared registry; rollback restores or erases
the exact ids.  Legacy inline `byproducts`, `pre_special`/`post_special`
callbacks, and `dark_craftable` stay author-owned Lua behaviour and the
migrator reports them as explicit TODOs.

`ccb.content.Construction` 通过同样的事务模型暂存建造：`id`、`group`、
`category`、`pre_note`、`post_terrain`、`duration_moves` 与 `activity_level`
都是普通 options，`:requires_skill(skill, level)`、
`:using_requirement(id, multiplier)`、`:pre_terrain(id)`、
`:pre_flag(flag, force)` 与 `:post_flag(flag)` 追加有界需求。内联需求改为同
Mod 暂存的 `ccb.content.Requirement` 并通过 `:using_requirement` 引用，而不是
隐藏的内联加载器。Finalize 时把原生 `construction` 插入共享注册表；回滚精确
恢复或擦除对应 id。legacy 内联 `byproducts`、`pre_special`/`post_special`
回调与 `dark_craftable` 保持作者自有的 Lua 行为，迁移器将其列为显式 TODO。

`ccb.content.Furniture` stages map furniture through the same transactional
model: `id`, `name`, `description`, `color`, `symbol`, a non-negative move-cost
modifier (or `-10` for impassable furniture) and required strength,
`light_emitted`, `comfort`, `max_volume_ml`, `mass_grams`,
`keg_capacity_ml`, `transparent`, open/close/lockpick transformations,
`crafting_pseudo_item`, and `deployed_item` are plain options, while
`:flag(id)` appends bounded furniture flags.  Finalization inserts a native
`furn_t` into the shared furniture registry; rollback restores or erases the
exact ids.  Legacy `bash`, `deconstruct`, `workbench`, plant data, examine
actions, and emissions stay author-owned Lua behaviour and the migrator
reports them as explicit TODOs.  A named `on_examine` handler is the one
exception: it is validated against the same runtime handler registry and is
installed through the native `iexamine_actor` chain, so normal Examine (`E`)
dispatch, character ownership, and map coordinates remain engine-owned.

`ccb.content.Furniture` 通过同样的事务模型暂存地图家具：`id`、`name`、
`description`、`color`、`symbol`、非负的移动代价修正（或用 `-10` 表示不可通行）与所需力量、`light_emitted`、
`comfort`、`max_volume_ml`、`mass_grams`、`keg_capacity_ml`、`transparent`、
开关与撬锁变换、`crafting_pseudo_item` 与 `deployed_item` 都是普通 options，
`:flag(id)` 追加有界家具标志。Finalize 时把原生 `furn_t` 插入共享家具注册表；
回滚精确恢复或擦除对应 id。legacy `bash`、`deconstruct`、`workbench`、植物
数据、examine 动作与排放保持作者自有的 Lua 行为，迁移器将其列为显式 TODO。
命名 `on_examine` 是唯一例外：它先在同一 runtime handler 注册表中校验，再经原生
`iexamine_actor` 链安装，因此常规 Examine（`E`）分发、角色归属与地图坐标仍由引擎掌管。

`ccb.content.SpriteSheet` registers a PNG relative to the owning Platform Mod,
together with bounded source-frame dimensions and stable frame ids.  Paths are
contained within the mod root and the descriptor is consumed by the existing
`mod_tileset`/`tileset_loader` atlas path; it does not create a Lua texture
cache or a separate renderer.  Reload and GPU-reset behaviour therefore stay
identical to other tileset sprites.  An optional bounded `pixelscale` (0.01 to
16, default 1) reuses native tile scaling for world rendering; Canvas callers
still choose their destination rectangle directly.

`ccb.content.SpriteSheet` 注册相对所属 Platform Mod 的 PNG，并提供有界的源帧
尺寸与稳定帧 id。路径必须位于 Mod 根目录内，描述符由既有
`mod_tileset`/`tileset_loader` 图集链消费；它不会创建 Lua 纹理缓存或第二个渲染器，
因此重载和 GPU 重置行为与其他 tileset 精灵一致。可选的有界 `pixelscale`（0.01 至
16，默认为 1）复用原生地图精灵缩放；Canvas 调用仍直接指定目标矩形。

`ccb.content.Terrain` stages map terrain through the same transactional model:
`id`, `name`, `description`, `color`, `symbol`, `move_cost`, `light_emitted`,
`comfort`, `max_volume_ml`, `heat_radiation`, `transparent`,
open/close/transform/roof/lockpick terrain references, and an embedded `trap`
are plain options, while `:flag(id)` appends bounded terrain flags.
Finalization inserts a native `ter_t` into the shared terrain registry;
rollback restores or erases the exact ids.  Legacy `bash`, `deconstruct`,
examine actions, phase targets, connection groups, and emissions stay
author-owned Lua behaviour and the migrator reports them as explicit TODOs.

`ccb.content.Terrain` 通过同样的事务模型暂存地图地形：`id`、`name`、
`description`、`color`、`symbol`、`move_cost`、`light_emitted`、`comfort`、
`max_volume_ml`、`heat_radiation`、`transparent`、开关/变换/屋顶/撬锁地形引用
与内嵌 `trap` 都是普通 options，`:flag(id)` 追加有界地形标志。Finalize 时把
原生 `ter_t` 插入共享地形注册表；回滚精确恢复或擦除对应 id。legacy `bash`、
`deconstruct`、examine 动作、相变目标、连接组与排放保持作者自有的 Lua 行为，
迁移器将其列为显式 TODO。

`ccb.content.Gate` stages gates through the same transactional model: `id`,
`door`, `floor`, optional pull/open/close/fail messages, `moves`, and
`bashing_damage` are plain options, while `:wall(terrain_id)` appends the wall
sections.  Finalization inserts a native `gate_data` into the shared gate
registry; rollback restores or erases the exact ids.  The gate model has no
legacy-only sub-shapes, so the migrator converts every well-formed shape
without key-shaped TODOs.

`ccb.content.Gate` 通过同样的事务模型暂存大门：`id`、`door`、`floor`、可选
拉/开/关/失败消息、`moves` 与 `bashing_damage` 都是普通 options，
`:wall(terrain_id)` 追加墙体段。Finalize 时把原生 `gate_data` 插入共享大门
注册表；回滚精确恢复或擦除对应 id。大门模型没有 legacy 专属子形状，迁移器可
转换所有良构形状而无需逐键 TODO。

`ccb.content.Fault` and `ccb.content.FaultFix` stage item faults and their
repairs through the same transactional model.  Fault options cover `id`,
`fault_type`, `name`, optional messages and name affixes, price/damage and
encumbrance modifiers, and the degradation flag, while `:flag(id)`,
`:block_fault(id)`, and `:fix(id)` append bounded relationships.  Fault-fix
options cover `id`, `name`, `success_msg`, `time_seconds`, and damage and
degradation modifiers, while `:requires_skill(skill, level)`,
`:removes_fault(id)`, and `:adds_fault(id)` append bounded requirements.
Finalization inserts native `fault` and `fault_fix` objects into the shared
fault registries; rollback restores or erases the exact ids.  Legacy inline
`requirements`, `set_variables`, melee and armor modifiers stay author-owned
Lua behaviour and the migrator reports them as explicit TODOs.

`ccb.content.Fault` 与 `ccb.content.FaultFix` 通过同样的事务模型暂存物品故障
及其维修。Fault options 覆盖 `id`、`fault_type`、`name`、可选消息与名称前后缀、
价格/伤害与累赘修正以及退化标志，`:flag(id)`、`:block_fault(id)` 与
`:fix(id)` 追加有界关系。Fault-fix options 覆盖 `id`、`name`、`success_msg`、
`time_seconds` 与伤害和退化修正，`:requires_skill(skill, level)`、
`:removes_fault(id)` 与 `:adds_fault(id)` 追加有界需求。Finalize 时把原生
`fault` 与 `fault_fix` 对象插入共享故障注册表；回滚精确恢复或擦除对应 id。
legacy 内联 `requirements`、`set_variables`、近战与护甲修正保持作者自有的
Lua 行为，迁移器将其列为显式 TODO。

`ccb.content.Dream` stages dreams through the same transactional model with
`category`, `strength`, and `:message(text)` entries.  Dreams are id-less
append-only engine data, so finalization appends native `dream` objects to the
shared dream list and rollback truncates back to the pre-commit count.

`ccb.content.Dream` 通过同样的事务模型暂存梦境：`category`、`strength` 与
`:message(text)` 条目。梦境是无 id 的纯追加引擎数据，因此 finalize 时把原生
`dream` 对象追加进共享梦境列表，回滚时截断回提交前的数量。

`ccb.content.Achievement` and `ccb.content.Conduct` stage achievements through
the same transactional model: `id`, `name`, `description`, and the
`:hidden_by(id)` relationships are plain options, while `Conduct` simply
pre-sets the native conduct flag.  Because native achievements own a
cpp-private requirement type, insertion, erasure, and finalization go through
bounded helpers in the engine translation unit.  Legacy `requirements`,
`time_constraint`, and `event_statistic` stay author-owned Lua behaviour and
the migrator reports them as explicit TODOs.

`ccb.content.Achievement` 与 `ccb.content.Conduct` 通过同样的事务模型暂存成就：
`id`、`name`、`description` 与 `:hidden_by(id)` 关系都是普通 options，`Conduct`
只是预置原生 conduct 标志。由于原生 achievement 持有 cpp 私有的 requirement
类型，插入、擦除与 finalize 都通过引擎翻译单元内的有界 helper。legacy
`requirements`、`time_constraint` 与 `event_statistic` 保持作者自有的 Lua
行为，迁移器将其列为显式 TODO。

`ccb.content.Blacklist` stages trait and monster blacklists and whitelists
through the same transactional model: `kind` selects the native target,
`whitelist` toggles whitelist semantics, and `:entry(id)` appends bounded
entries.  Finalization inserts the entries into the shared trait or monster
sets through engine-side helpers; rollback erases exactly the appended ids.
The migrator converts `TRAIT_BLACKLIST`, `MONSTER_BLACKLIST`, and
`MONSTER_WHITELIST` shapes and keeps `ITEM_BLACKLIST` and
`SCENARIO_BLACKLIST` partial until their native registrars exist.

`ccb.content.Blacklist` 通过同样的事务模型暂存特质与怪物黑/白名单：`kind`
选择原生目标，`whitelist` 切换白名单语义，`:entry(id)` 追加有界条目。
Finalize 时通过引擎侧 helper 把条目插入共享特质或怪物集合；回滚精确擦除追加的
id。迁移器转换 `TRAIT_BLACKLIST`、`MONSTER_BLACKLIST` 与 `MONSTER_WHITELIST`
形状，`ITEM_BLACKLIST` 与 `SCENARIO_BLACKLIST` 保持 partial，直到其原生注册器
存在。

`ccb.content.MapExtra` stages map extras through the same transactional model:
`id`, `name`, `description`, `generator_id`, `symbol`, and `color` are plain
options, while `:flag(id)` appends bounded flags.  Finalization inserts a
native `map_extra` into the shared registry; rollback restores or erases the
exact ids.  Native generator-function bindings and z-level ranges stay
author-owned Lua behaviour and the migrator reports them as explicit TODOs.

`ccb.content.MapExtra` 通过同样的事务模型暂存地图附加物：`id`、`name`、
`description`、`generator_id`、`symbol` 与 `color` 都是普通 options，
`:flag(id)` 追加有界标志。Finalize 时把原生 `map_extra` 插入共享注册表；
回滚精确恢复或擦除对应 id。原生 generator 函数绑定与 z 层范围保持作者自有的
Lua 行为，迁移器将其列为显式 TODO。

`ccb.content.WeatherGenerator` stages weather generators through the same
transactional model: `id`, base temperature/humidity/pressure/wind, wind
distribution peaks, and the per-season temperature and humidity modifiers are
plain options, while `:blacklisted_weather(id)` and
`:whitelisted_weather(id)` append bounded weather lists.  Finalization inserts
a native `weather_generator` into the shared registry; rollback restores or
erases the exact ids.  Legacy `weather_types` keep the author-owned Lua
behaviour and the migrator reports them as explicit TODOs.

`ccb.content.WeatherGenerator` 通过同样的事务模型暂存天气生成器：`id`、基础
温度/湿度/气压/风速、风速分布峰值与各季节温度/湿度修正都是普通 options，
`:blacklisted_weather(id)` 与 `:whitelisted_weather(id)` 追加有界天气列表。
Finalize 时把原生 `weather_generator` 插入共享注册表；回滚精确恢复或擦除对应
id。legacy `weather_types` 保持作者自有的 Lua 行为，迁移器将其列为显式 TODO。

`ccb.content.Migration` stages savegame id migrations through the same
transactional model: `kind` selects the native target (bionic, effect,
field_type, furniture, oter, overmap_special, proficiency, terrain, trap,
var, vehicle_part), `from` names the legacy id, and an empty `to` means the id
was removed.  Finalization routes each entry into the engine's per-kind
migration map; rollback erases exactly the added keys.  The migrator expands
`oter_id_migration` dictionaries and converts the per-kind legacy field names
(`from_trap`, `from_ter`, `from_field_type`, `id`/`new_id`) without TODOs.

`ccb.content.ShopkeeperBlacklist`, `ccb.content.ShopkeeperWhitelist`, and
`ccb.content.ShopkeeperConsumptionRates` stage shopkeeper rules through the
same transactional model: `id`, an optional `message`, and the consumption
`default_rate` are plain options, while `:entry(item, category, item_group,
message)` appends bounded entries.  Finalization inserts native
`shopkeeper_blacklist`, `shopkeeper_whitelist`, and `shopkeeper_cons_rates`
objects into the shared shop-rule registries; rollback erases the exact ids.
Legacy entry `condition` functions and per-entry `rate` overrides stay
author-owned Lua behaviour and the migrator reports them as explicit TODOs.

`ccb.content.ShopkeeperBlacklist`、`ccb.content.ShopkeeperWhitelist` 与
`ccb.content.ShopkeeperConsumptionRates` 通过同样的事务模型暂存商人规则：
`id`、可选 `message` 与消费 `default_rate` 都是普通 options，
`:entry(item, category, item_group, message)` 追加有界条目。Finalize 时把
原生 `shopkeeper_blacklist`、`shopkeeper_whitelist` 与
`shopkeeper_cons_rates` 对象插入共享商人规则注册表；回滚精确擦除对应 id。
legacy 条目的 `condition` 函数与逐条 `rate` 覆盖保持作者自有的 Lua 行为，
迁移器将其列为显式 TODO。

`ccb.content.Migration` 通过同样的事务模型暂存存档 id 迁移：`kind` 选择原生
目标(bionic、effect、field_type、furniture、oter、overmap_special、
proficiency、terrain、trap、var、vehicle_part),`from` 命名 legacy id,`to`
为空表示该 id 被移除。Finalize 时把每个条目路由进引擎对应 kind 的迁移 map；
回滚精确擦除添加的键。迁移器展开 `oter_id_migration` 字典并转换各 kind 的
legacy 字段名(`from_trap`、`from_ter`、`from_field_type`、`id`/`new_id`),无需
TODO。

Player-facing interaction is a separate top-level domain rather than an EOC
effect spelling.  Inside an active callback, `ccb.presentation.notice`,
`confirm`, `choose`, and `input_text` provide bounded native dialogs.  Choice
ids are stable values independent from labels, cancellation returns `nil`, and
input sizes, duplicate ids, and non-dense choice arrays are rejected before UI
opens.  A choice list must use consecutive integer keys starting at one; extra
string keys or holes are an error rather than silently ignored content.  Mods
compose these primitives with ordinary Lua functions, coroutines, handlers,
and state machines.

`ccb.presentation.canvas` is a synchronous graphical modal for a bounded
two-dimensional canvas.  Its draw callback receives elapsed/frame time and
can issue rectangles, text, registered tile sprites, and positioned buttons,
and can query/request its close state;
the call returns `false` without invoking Lua when the graphical tiles backend
is unavailable.  It reuses `script_ui_context`/`script_ui_renderer` and the
current UI frame loop, rather than exposing textures or a second windowing
stack.  An optional `music` path is limited to a regular audio file below the
active Mod root; it is registered through the existing playlist backend as a
temporary looping track for the modal, and the prior game playlist resumes
when the modal closes.  `ccb.presentation.play_sound` plays a validated
Mod-local file through the existing one-shot SFX backend without interrupting
that music.  A positioned button's optional `request_focus` argument assigns
the native keyboard/navigation focus only for that frame, so state-machine UIs
can choose an initial action without overriding later player navigation.
`allow_quit = false` is available for an intentionally
unskippable animation, which must still offer its own terminal close control.

面向玩家的交互使用独立的 `ccb.presentation` 领域，而不是照抄 EOC effect 键。活动
回调内可调用 `notice`、`confirm`、`choose` 与 `input_text`；选项的稳定 ID 与显示文本
分离，取消返回 nil，打开界面前会检查数量、大小、重复 ID，以及列表是否为从 1 开始
且没有空洞的连续整数数组；额外字符串键也会被拒绝。复杂流程由普通 Lua 函数、协程、
handler 和状态机组合。

`ccb.presentation.canvas` 是有界二维画布的同步图形模态窗口。其 draw 回调获得经过
时间和帧时间，可绘制矩形、文字、已注册 tile 精灵与定位按钮，并可查询或请求关闭状态；图形 tiles 后端不可用时，
它不调用 Lua 而返回 `false`。该接口复用 `script_ui_context`/`script_ui_renderer` 和当前
UI 帧循环，不暴露纹理或第二套窗口栈。可选的 `music` 路径只能指向当前 Mod 根目录内的
常规音频文件；它通过既有播放列表后端作为模态窗口期间循环播放的临时曲目登记，并在窗口
关闭时恢复之前的游戏播放列表。`ccb.presentation.play_sound` 通过既有一次性 SFX 后端播放
经过校验的 Mod 本地文件，不会中断这段音乐。定位按钮的可选 `request_focus` 参数仅在当前帧请求原生键盘/导航
焦点，使状态机 UI 能设定初始操作而不干扰之后玩家自行导航。需要完整播放的动画可设 `allow_quit = false`，但必须在其
最终状态提供自己的关闭控件。

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

This creature graph remains `bounded_implemented_unverified`: native code,
LuaLS declarations, rollback/retention paths, migration extraction, and tests
exist, and its written local C++ gate passed on 2026-08-11.  That local result
validates only the documented bounded slice; it is not production-complete or
full field-level JSON parity.

这张怪物内容图当前状态是 `bounded_implemented_unverified`：原生代码、LuaLS 声明、回滚/保留
路径、迁移提取器与测试已经存在，且其书面本地 C++ 门禁已于 2026-08-11 通过。该结果只验证
本文明确描述的有界切片，不能称为生产级完成，也不能声称已覆盖对应 JSON 类型的全部字段。

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

Every `game:<event>` payload contains the native event type, turn, typed data,
and data-type names.  Its `actors` table maps semantic native `character_id`
field names such as `character`, `attacker`, `killer`, or `victim` to live,
generation-checked Character handles.  The bridge neither guesses one primary
actor nor falls back to the avatar, and it never publishes EOC alpha/beta
aliases.  `character_wields_item`, `character_wears_item`,
`character_takeoff_item`, and `character_armor_destroyed` additionally expose
`actors.item` only when the native producer actually supplied its
`item_location` talker.  A plain `event_bus.send`, another event with an item in
the same positional slot, or a missing item talker never falls back to a guessed
wielded item.  Events whose native schema names no supported live entity simply
have an empty `actors` table; future vehicle or other entity references must use
equally semantic native fields instead of positional talker compatibility.
All subscribed Mod/handler payloads are built before the first callback and
each handler receives its own table graph, so mutation or failure cannot
contaminate the next handler.  Per-Mod callback depth remains isolated while a
global event-bridge depth cap bounds the native stack across all Mods.

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
每个 `game:<event>` payload 都包含原生事件类型、回合、类型化 data 与 data type 名称。
其中 `actors` 表会把 `character`、`attacker`、`killer`、`victim` 等具有语义的原生
`character_id` 字段名映射成带 generation 检查的 Character handle。桥接层不会猜测
“主角色”，不会回退到 avatar，也绝不发布 EOC 的 alpha/beta 别名。
`character_wields_item`、`character_wears_item`、`character_takeoff_item` 与
`character_armor_destroyed` 只有在原生发送方确实附带对应 `item_location` talker 时才会
额外提供 `actors.item`。普通 `event_bus.send`、其他事件碰巧把物品放在同一位置，或缺少
物品 talker 时，都不会回退去猜当前持握物。原生 schema 没有命名受支持活对象的事件只
得到空 `actors` 表；未来的载具或其他实体引用也必须使用同样有语义的原生字段，而不是
位置式 talker 兼容。
所有订阅 Mod/handler 的 payload 都会在第一个回调执行前完成构造，而且每个 handler
得到独立表图，因此修改或异常不会污染后续 handler。每 Mod 的 callback depth 仍相互
隔离，同时由事件桥全局 depth 上限约束跨 Mod 的原生调用栈。

Sidecar records belonging to a currently disabled or missing Mod are retained
unchanged in the typed engine representation when other active Platform Mods
save.  Re-enabling the Mod restores its record instead of treating another
Mod's save as permission to delete it.  Malformed records still reject that
scope as a bounded unit and fall back to empty active state with a diagnostic.

暂时禁用或缺失 Mod 的 sidecar 记录会以引擎内部类型化表示保留；其他 Platform Mod
保存时不会把它顺带删除。重新启用后会恢复原记录。格式损坏时仍以整个 scope 为有界
失败单元，清空活动状态并给出诊断。

Platform gameplay randomness is isolated per Mod in `ccb.services.random`.
`int`, `chance`, `one_in`, `probability`, `sample_integers`, and `contested`
all consume that stream only inside a runtime callback.  A runtime-only hot
reload moves the engine state into the replacement runtime, so reloading code
does not silently restart a Mod's random sequence.  `sample_integers` returns
a dense Lua array instead of writing legacy variables.  String predicates are
ordinary composition through `ccb.services.gameplay.strings.any_equal` and
`all_equal`; active Mod visibility is queried through
`ccb.services.gameplay.mods.is_loaded`.  These primitives replace behaviour,
not old EOC-shaped keys.  The current dimension is exposed as the stable id
returned by `ccb.services.gameplay.environment.dimension()` and compared with
ordinary Lua operators.  `environment.is_outside` and `line_of_sight` consume
typed absolute map-square coordinates, so callers can compose them with
creature handles and coordinate utilities without recreating EOC variables.
Native gameplay awards use `ccb.services.achievements.complete(GameId)`; it
completes any tracked pending achievement and reports whether state changed,
instead of exposing an EOC activation entry point.
Avatar and NPC gameplay changes use
`ccb.services.bionics.grant(GameHandle, GameId)` and `remove_type`; these
Platform operations call native character rules directly and are not capped
by the v5 inspection-list limit or forced through UID enumeration.  The
Platform-only `summary(GameHandle)` query returns installed count, current and
maximum typed energy, and the independent capacity fact, so Lua can express
"any installed bionic or power capacity" without an EOC-shaped predicate.
Recipe knowledge uses `ccb.services.recipes.knows(GameHandle, GameId)`,
`learn`, and `forget`.  They operate on learned knowledge rather than temporary
book or helper availability; `learn` preserves the native `never_learn`
policy.  `forget_category(GameHandle, GameId, subcategory?)` is a separate
typed batch operation.  It applies the native category/subcategory selection
rules, returns before/after counts, and does not disguise a category as a
recipe id.
Martial-art knowledge uses `ccb.services.martial_arts.learn(GameHandle, GameId)`
and `forget`.  Platform learning intentionally changes the native style
collection without displaying UI text, so Mods can compose presentation
separately; both methods report whether known state changed.
Physical weapon state uses the Platform-only
`ccb.services.inventory.wielded(GameHandle)` singular query.  It returns a live
item handle or nil in constant work and deliberately does not bake in legacy
weapon-predicate names.  A selected martial art may set
`martial_arts.current(character).force_unarmed` while an item remains physically
wielded, so Lua composes those facts explicitly.  `services.items.has_flag`
reads the item's effective flags, including type inheritance, while
`services.items.set_flag(item, flag, enabled)` changes only the instance-owned
flag set.  Its `value.changed` compares `own_before` with `own_after`; therefore
an inherited effective flag may remain true before and after a real instance
change, or remain true while an idempotent unset correctly reports false.

```lua
local wielded = service_value(services.inventory.wielded(character))
local style = service_value(services.martial_arts.current(character))
local physically_armed = wielded ~= nil
local attacks_unarmed = not physically_armed or style.force_unarmed
local can_release = physically_armed and not service_value(
    services.items.has_flag(wielded, services.types.id("json_flag", "NO_UNWIELD")))
```

Typed morale instances use
`ccb.services.morale.add(GameHandle, GameId, bonus, max_bonus, options)` and
`remove`.  `add` delegates to native morale stacking and accepts optional typed
`duration`, `decay_start`, and `capped` values; `remove` clears every
item-specific instance of the requested morale type, matching the native
character operation.  Both methods return the matching net bonus before and
after the mutation.  This is a Lua domain service rather than an EOC-shaped
wrapper: callers supply an explicit Character handle and compose timing or
presentation in Lua.
Current activity state uses `ccb.services.activities.snapshot(GameHandle)`.
The returned value is a detached snapshot with a typed activity id, native
move budget, interruption/resumption flags, and bounded progress; it works for
avatar and NPC Character handles without exposing a borrowed `player_activity`.
`assign_timed` converts a positive typed `TimeDuration` to a checked native
move budget and delegates to `Character::assign_activity`, preserving native
resume, backlog, and NPC bookkeeping.  It accepts only plain time-based
activities.  Specialized native actors or handlers, EOC policies,
multi-activity workflows, automatic-needs activities, and speed/neither move
budgets are rejected; they need explicit Lua-native domain constructors rather
than empty target/value arrays or a hidden return to EOC.  `cancel` delegates
to `Character::cancel_activity` only when an activity is active, preserving
actor cleanup, resumable-backlog handling, hauling cleanup, events, and
activity sound shutdown without mutating backlog on a no-op.  All three
operations return the standard structured service result.
Wound state uses `ccb.services.wounds.snapshot(character, body_part)` with a
typed `GameId<body_part>`.  It returns a detached array in native per-part
order; every entry contains a typed wound id, base/current pain, typed healing
time and progress, and healing fraction.  The body part must exist exactly in
the Character's current anatomy; the service never chooses a nearest or
fallback part.  After the Platform exact-part and per-part-limit policies
admit the operation, `add(character, body_part, wound)` delegates to
`Character::apply_wound`, preserving native add-or-worsen rules and immediate
perceived-pain derived-state synchronization.  `remove` removes every instance
of that wound type from that exact part and performs the same synchronization
after a change.  Explicit direct add intentionally bypasses the Wound's natural
damage-selection body-part eligibility: the caller's exact part is
authoritative.  The Platform service enforces the Wound's per-part limit, so
an add at the limit is a successful no-op with `changed = false`.  Writes are callback-only; snapshot remains a
world-ready read.  Successful mutations return `changed` plus complete
`before`/`after` snapshots, and removing an absent type reports
`changed = false`.  Wrong GameId kinds or unknown ids raise `invalid_argument`
before mutation; stale/destroyed handles, non-Character targets, and missing
parts return the standard structured service errors.  This
API models the wound domain and never exposes `u_add_wound`, alpha/beta, an
EOC runner, or a JSON object channel.
The 2026-08-11 local gate proves these service semantics directly.  Its
deterministic callback adds wounds A(4 pain), B(7), then A(4), observes native
snapshot order A/B/A, and observes pain, perceived pain, and Character morale
move through 4, 11, 15, 7, and 0 as add/remove operations run.  It also proves
that snapshot remains an available empty read outside a callback while direct
`add` and `remove` both fail with the callback-only diagnostic.  The focused
service tag and the complete Platform suite both passed after compiling the
native implementation and its test.
This Lua-native policy is intentionally not a drop-in execution backend for
the legacy wound selectors.  Legacy `f_add_wound` and `f_remove_wound` resolve
the requested body part through `Creature::get_part(bodypart_id)`, whose
default filter may choose `next_best`; the Platform service requires the exact
current-anatomy part.  The legacy add path also calls add-or-worsen without the
per-part-limit check that the Platform service enforces.  Therefore
`u_add_wound`, `npc_add_wound`, `u_remove_wound`, and `npc_remove_wound` all
remain planned migration work, even for literal ids and a proven Character
actor.  The extractor emits a TODO instead of silently changing gameplay.
Authors rewriting one of these selectors must choose the new exact-part and
limit-aware policy explicitly; Platform will not add a legacy-shaped
compatibility switch or entry point.
Creature effects reuse the typed `ccb.services.effects` domain.  The bounded
migration slice accepts a literal effect id with either a positive literal
duration of at most 365 days or `PERMANENT`, and accepts single literal removal
without a body-part selector.  It deliberately leaves dynamic ids and
durations, ranges, intensity/force/body-part extensions, arrays, `RANDOM`, and
`ALL` as partial work; those shapes require explicit value, actor, and anatomy
semantics rather than a legacy-key wrapper.  The legacy single variable-object
remove shape also remains partial because the old implementation silently
performs no removal.
Legacy `u_*` names identify the EOC alpha talker, not the avatar type.  The
extractor therefore binds a private local actor to the avatar only for the
bounded `game_start` event shape, where that identity is proven.  The extractor
checks the reviewed canonical native sender set and fails closed if it changes;
the event name alone is never treated as sufficient proof.  The separately
audited `character_wields_item`, `character_wears_item`,
`character_takeoff_item`, and `character_armor_destroyed` slice binds the
legacy `u` Character to `context.actors.character`.  In those same four events
only, literal legacy `npc_set_flag`/`npc_unset_flag` effects may target
`context.actors.item`; generated Lua guards nil because a plain native send has
no item talker.  This does not generalize `npc` into an item or Character in any
other context, and `u_set_flag` remains partial because `u` is the Character
talker there.  Other event and dialogue shapes remain partial until the
extractor maps their semantic Platform actor fields and proves each kind;
silently replacing an unproven actor with `services.characters.avatar()` would
change gameplay.  Dialogue hooks now expose `avatar`/`interlocutor`, but that
does not by itself prove which legacy talker a selector uses.  This
migration-only decision never adds alpha/beta to Platform.
Domain audits intentionally override name-based ledger guesses.  Native
Wound/WoundFix staging and the exact-body-part wound service passed their local
compiled validation gates: the content tag passed 5 cases and 321 assertions,
including add/replace/edit, rollback, requirement finalization, reverse-link
refresh, body-part cache refresh, and stale handles; the service evidence is
described above.  The static extractor now converts bounded concrete `wound`
and `wound_fix` definitions into those native builders, including finite
pain/healing/damage ranges, typed links, body-part filters, skills,
proficiencies, removed/added wounds, and referenced requirements.  Inheritance,
implicit indefinite healing, rich translation metadata, and inline requirement
objects remain explicit TODOs rather than hidden legacy loading.  The two JSON
selectors are therefore `bounded_implemented_unverified`.
The local creator/migrator run now passes all 86 cases.  Wound/WoundFix extraction fails closed at Platform UTF-8 byte
limits: overlong ids or text and contradictory body-part flags become explicit
TODOs or rejected definitions, and proficiency multipliers are rejected when
their native `float` conversion is no longer positive.

This does not change the four legacy `u_*`/`npc_*` wound mutation selectors:
they remain planned because their next-best body-part resolution and add-limit
behaviour do not match the deliberately strict, limit-aware service.  Service
availability and static-definition extraction are not effect-selector parity
and do not authorize automatic conversion.
Rain wetness, direct damage, specialized activity-actor construction,
navigation, and general teleportation remain planned native domains because
current Character/item primitives do not carry their complete side effects.
Character activity snapshot, plain time-based
assignment, and cancellation are implemented, and their written local C++
policy coverage passed; legacy selector promotion still requires exact shape
conversion.  In the proven `game_start` actor shape, a
literal `u_has_item` now composes `inventory.resources` through a local Lua
helper and preserves the native charges-or-amount test, while a literal
`u_has_move_mode` compares the typed Character snapshot.  The bounded proven
Character slice converts string `u_has_weapon`/`u_can_drop_weapon` and a literal
`u_has_wielded_with_flag`: generated helpers compose the singular physical
wielded handle, `force_unarmed`, effective item flags, and `NO_UNWIELD` exactly
instead of publishing EOC-shaped APIs.  The four-event item-talker slice also
converts bounded literal `npc_set_flag`/`npc_unset_flag` behind the semantic
item guard.  Those five selectors are therefore
`bounded_implemented_unverified`, not full parity; NPC weapon predicates,
`u_set_flag`/`u_unset_flag`, dynamic flags, other actor sources, mission
reservation, and bounded move cost remain primitive-only or planned.  The
ledger target describes domain ownership; it is never evidence that an
unlisted selector shape is interchangeable.
Typed character predicates reuse the same result-bearing services: single or
any-of mutation presence through `mutations.has`, martial-art knowledge through
`martial_arts.get`, selected-style state through the same snapshot, proficiency
knowledge through `proficiencies.get`, a specific installed bionic through
`bionics.has`, installed-count/capacity facts through `bionics.summary`, and
learned recipe knowledge through `recipes.knows`.
They remain normal Lua expressions; the migration output uses one local helper
to propagate a `CcbResult` error before reading its value.

Platform 的玩法随机流按 Mod 隔离在 `ccb.services.random` 中；`int`、`chance`、
`one_in`、`probability`、`sample_integers` 和 `contested` 只允许在运行时回调中消耗
该随机流。仅重载运行时代码时会把随机引擎状态移动到新 runtime，不会偷偷重启随机
序列。整数采样直接返回稠密 Lua 数组，不再写旧变量。字符串集合判断使用
`ccb.services.gameplay.strings.any_equal/all_equal` 普通组合，Mod 可见性使用
`ccb.services.gameplay.mods.is_loaded`；这些是适合 Lua 的行为原语，不是旧 EOC key 的
同名包装。当前维度由 `ccb.services.gameplay.environment.dimension()` 返回稳定 ID，
直接使用普通 Lua 运算符比较。`environment.is_outside` 与 `line_of_sight` 接受类型化
绝对地图格坐标，因此事件、任务和物品行为可以把生物 handle 与坐标工具直接组合，
无需重建 EOC 变量模型。
玩法成就使用 `ccb.services.achievements.complete(GameId)` 授予；它完成任意当前受跟踪且
pending 的成就并报告状态是否变化，不公开 EOC 激活入口。
玩家与 NPC 的玩法变更使用 `ccb.services.bionics.grant(GameHandle, GameId)` 和
`remove_type`；这些 Platform 操作直接调用角色原生规则，不受 v5 检查清单数量上限约束，
也不强制作者先枚举 UID。Platform 专属的 `summary(GameHandle)` 会同时返回安装数量、当前与
最大类型化能量以及独立的容量事实，使 Lua 能表达“存在任一仿生装置或电力容量”，而无需
增加 EOC 形状谓词。
角色配方知识使用 `ccb.services.recipes.knows(GameHandle, GameId)`、`learn` 与 `forget`；
它们只处理已学知识，不把书本或助手临时提供的配方算进去，`learn` 保留原生
`never_learn` 策略。`forget_category(GameHandle, GameId, subcategory?)` 是单独的类型化
批量操作：它遵循原生分类/子分类选择规则并返回变更前后数量，不会把分类伪装成配方 ID。
武术流派知识使用 `ccb.services.martial_arts.learn(GameHandle, GameId)` 与 `forget`。
Platform 学习只改变原生流派集合，不自行显示 UI 文本，使 Mod 可以独立组合呈现；两者都会
报告已知状态是否发生变化。
物理持握状态通过 Platform 专属的
`ccb.services.inventory.wielded(GameHandle)` 单项查询读取；它以常量规模返回活物品 handle
或 nil，不把旧武器谓词名称固化进新 API。选中的武术流派可能令
`martial_arts.current(character).force_unarmed` 为真，但物品仍然在物理上被持握，因此 Lua
应显式组合这两个事实。`services.items.has_flag` 读取包含类型继承在内的有效 flag；
`services.items.set_flag(item, flag, enabled)` 只改变实例自有 flag 集合，其
`value.changed` 比较 `own_before` 与 `own_after`。所以继承 flag 的有效状态可以在一次真实
实例变更前后都保持 true；幂等 unset 也会正确报告 false。
类型化士气实例使用
`ccb.services.morale.add(GameHandle, GameId, bonus, max_bonus, options)` 与
`remove`。`add` 直接复用原生士气叠加规则，并可接收类型化的 `duration`、
`decay_start` 与 `capped` 选项；`remove` 按原生角色操作移除该士气类型的全部
物品特定实例。两者都返回变更前后的匹配净加成。这是面向 Lua 组合的领域 service，
不是 EOC 字段形状包装：调用者必须显式提供 Character handle，计时与呈现也由 Lua
自行组合。
当前 activity 状态使用 `ccb.services.activities.snapshot(GameHandle)` 读取。返回值是脱离
原生对象的有界快照，包含类型化 activity ID、原生 moves 预算、打断/恢复标志与进度；
avatar 和 NPC 的 Character handle 都可使用，不会把借用的 `player_activity` 暴露给 Lua。
`assign_timed` 把正数类型化 `TimeDuration` 转换为经过边界检查的原生 moves，并直接调用
`Character::assign_activity`，从而保留恢复、backlog 和 NPC 记账。它只接受普通的 time-based
activity；专用原生 actor/handler、EOC policy、multi-activity、自动需求 activity，以及
speed/neither moves 预算都会被拒绝。这些形状需要显式 Lua-native 领域构造器，不能用空的
targets/values 强行构造，也不能暗中重新进入 EOC。`cancel` 只在确有当前 activity 时调用
`Character::cancel_activity`，因此既保留 actor 清理、可恢复 backlog、搬运清理、事件与活动
音效收尾，也不会让无操作取消悄悄改写 backlog。三个操作都返回统一的结构化 service result。
伤口状态使用
`ccb.services.wounds.snapshot(character, body_part)` 和类型化的
`GameId<body_part>` 读取。返回值按该身体部位的原生顺序给出脱离原生对象的数组，每项包含
类型化伤口 id、基础/当前疼痛、类型化愈合总时长/已进度与愈合比例。身体部位必须精确存在
于该 Character 当前解剖，service 不会选择 next-best 或其他回退部位。
通过 Platform 的精确部位与每部位上限策略后，`add(character, body_part, wound)` 会调用
`Character::apply_wound`，保留原生 add-or-worsen 规则并立即同步 Character 的
`perceived_pain` 派生状态；`remove` 则删除该精确部位上指定类型的全部实例，并在发生变化后
执行同样的同步。显式 direct add 有意绕过 Wound 在自然伤害候选选择中的身体部位
eligibility，调用者指定的精确部位具有最终决定权。Platform service 会执行 Wound 的每部位
上限策略，达到上限后的 add 是
成功的无操作并返回 `changed = false`。写操作只允许在 Platform runtime callback 内进行；snapshot
仍是 world-ready 只读查询。成功变更返回 `changed` 和完整的 `before`/`after` 快照；移除
不存在的类型时 `changed = false`。错误 GameId kind 或未知 id 会在变更前抛出
`invalid_argument`；过期/已销毁 handle、非 Character 目标与不存在的身体部位则返回统一的
结构化 service 错误。这个 API 建模的是伤口
领域，不公开 `u_add_wound`、alpha/beta、EOC runner 或 JSON 对象通道。
2026-08-11 的本地门禁直接证明了这些 service 语义。确定性 callback 依次添加伤口
A（疼痛 4）、B（疼痛 7）、A（疼痛 4），快照保持原生 A/B/A 顺序；随后 add/remove
过程中 pain、perceived pain 与 Character morale 依次同步为 4、11、15、7、0。门禁还证明
callback 外仍可读取空 snapshot，而直接 `add` 与 `remove` 都会以 callback-only 诊断拒绝。
聚焦 service 标签与完整 Platform 套件都在原生实现和测试重新编译后通过。
这套 Lua-native 策略有意不作为旧伤口 selector 的直接执行后端。旧
`f_add_wound`/`f_remove_wound` 通过默认可采用 `next_best` 的
`Creature::get_part(bodypart_id)` 解析身体部位，而 Platform service 只接受当前解剖中精确
存在的部位；旧 add 路径也直接调用 add-or-worsen，不执行 Platform service 所强制的每部位
上限检查。因此即使 id 都是字面量且 Character actor 已证明，`u_add_wound`、
`npc_add_wound`、`u_remove_wound` 与 `npc_remove_wound` 仍是 planned 迁移工作。迁移器会
生成 TODO，不会静默改变玩法。作者重写时必须显式选择新的“精确部位、上限生效”策略；
Platform 不会增加旧字段形状的兼容开关或入口。
生物效果复用类型化的 `ccb.services.effects` 领域。当前有界迁移只接受字面量效果 ID，
其 duration 必须是正整数且不超过 365 天，或为 `PERMANENT`；移除只接受不带身体部位
选择器的单个字面量 ID。动态 ID/时长、随机范围、intensity/force/身体部位扩展、数组、
`RANDOM` 与 `ALL` 都继续保持 partial，因为这些形状需要显式建模取值、角色和解剖语义，
不能伪装成旧 key 包装。旧版单个变量对象 remove 实际会静默不做任何移除，因此也不会被
迁移器擅自“修好”。
旧 `u_*` 名称表示 EOC 的 alpha talker，并不等于 avatar 类型。迁移器只在有界的
`game_start` 事件形状中把私有局部 actor 绑定为 avatar，因为该身份在这里已经证明；迁移器
还会检查经过审查的原生规范 sender 集合，一旦集合变化就安全降级，绝不会只凭事件名证明。
另一个单独审计过的切片只覆盖 `character_wields_item`、`character_wears_item`、
`character_takeoff_item` 与 `character_armor_destroyed`：其中旧 `u` Character 绑定为
`context.actors.character`；也只有在这四类事件中，字面量旧
`npc_set_flag`/`npc_unset_flag` 才能以 `context.actors.item` 为目标。普通原生 send 没有
物品 talker，所以生成代码必须先检查 nil。该规则不会把其他上下文的 `npc` 泛化成物品或
Character；这里的 `u_set_flag` 也继续保持 partial，因为 `u` 是 Character talker。
其他事件和对话形状会保持 partial，直到迁移器把对应的 Platform 语义 actor 字段映射清楚，
并证明每个 handle 的类型；擅自把未证明的角色替换成 `services.characters.avatar()` 会改变
玩法。对话 Hook 已提供 `avatar`/`interlocutor`，但这本身并不能证明某个旧 selector 使用
哪一个 talker。这个仅属于迁移器的决定绝不会给 Platform 添加 alpha/beta。
领域语义审计会有意覆盖按名称猜测的账本结果。原生 `Wound`/`WoundFix` 暂存与精确身体
部位伤口 service 已通过本地编译验证门禁：内容标签的 5 个用例、321 个断言覆盖
add/replace/edit、回滚、requirement finalize、反向链接刷新、身体部位缓存刷新与过期 handle；
service 证据见上文。静态提取器现在可把有界、具体的 `wound` 与 `wound_fix` JSON 定义转换为
原生 builder，包括有限疼痛/愈合/伤害区间、类型化链接、身体部位过滤、技能、熟练度、移除/
新增伤口及外部 Requirement 引用；继承、隐式无限愈合、复杂翻译元数据和内联 requirement
对象仍会生成明确 TODO，不会暗中调用旧 loader。因此这两个 JSON selector 已是
`bounded_implemented_unverified`。
本地 creator/migrator 现已通过全部 86 个用例。Wound/WoundFix
提取会按 Platform 的 UTF-8 字节上限安全失败：超长 id/文本及互相冲突的身体部位 flag 会
生成明确 TODO 或拒绝该定义，熟练度倍率转成原生 `float` 后不再为正时也会被拒绝。

四个旧 `u_*`/`npc_*` 伤口变更 selector 仍保持 planned，因为它们的 next-best 身体部位解析
和 add 上限行为与这套有意采用严格部位、上限生效的 service 不一致。具备领域 service 或
静态定义提取器不等于 effect selector 等价，也不能据此自动转换。淋雨湿润、直接伤害、专用 activity actor 构造、
导航和通用传送仍是 planned 原生领域，因为当前
Character/物品原语没有保留它们的完整副作用。Character activity 快照、普通 time-based
分配与取消已经实现，其书面本地 C++ 策略覆盖也已通过；旧 selector 仍需完成精确形状转换后
才能晋级。在已证明为
`game_start` actor 的形状中，
字面量 `u_has_item` 现在会通过局部 Lua helper 组合 `inventory.resources` 并保留原生的
“charges 或 amount”判断；字面量 `u_has_move_mode` 则比较类型化 Character snapshot。
已证明为 Character 的有界切片会转换字符串 `u_has_weapon`/`u_can_drop_weapon` 与字面量
`u_has_wielded_with_flag`；生成 helper 会精确组合单项物理持握 handle、`force_unarmed`、
有效物品 flag 和 `NO_UNWIELD`，不会公开 EOC 形状 API。四事件物品 talker 切片也会在
语义物品 nil guard 后转换字面量 `npc_set_flag`/`npc_unset_flag`。因此这五个 selector 是
`bounded_implemented_unverified`，绝不表示完整 parity；NPC 武器谓词、
`u_set_flag`/`u_unset_flag`、动态 flag、其他角色来源、任务预留与有界 moves 扣减仍保持
primitive-only 或 planned。账本 target 只描述领域归属，不能证明未列出的 selector 形状
已经可互换。
类型化角色谓词复用同一批带结果的 service：`mutations.has` 查询单个或任一突变，
`martial_arts.get` 查询武术知识和当前选中状态，`proficiencies.get` 查询熟练度知识，
`bionics.has` 查询指定已安装仿生装置，`bionics.summary` 查询安装数量与容量事实，
`recipes.knows` 查询已学配方知识。它们仍是普通 Lua
表达式；迁移输出只用一个局部 helper 在读取值前传播 `CcbResult` 错误。

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

- `implemented_unverified`: full selector-level replacement is represented by
  matching Platform code, declaration, tests, migration, and documentation,
  but the requested validation gate has not run;
- `bounded_implemented_unverified`: at least one explicitly bounded, real
  legacy shape has matching Platform code, declaration, tests, migration, and
  documentation, but other legal values, actors, options, or shapes keep the
  selector below full parity;
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
not proof that the service exists.  A bounded migratable shape may reach only
`bounded_implemented_unverified`; it never promotes its whole selector to
`implemented_unverified` while dynamic, actor, option, or alternate-shape
semantics remain.

The audit also records composable-but-inexact starting points instead of
leaving them as unspecified plans: follower presence, following transitions,
NPC hostility/neutrality, nearest-city and route reveal operations, aid,
equipment selection, turn cost, trap placement, and horde signalling already
have native follower, NPC, overmap, character, effect, inventory,
presentation, time, world, coordinate, or horde primitives.  Their legacy
selectors remain unconverted until target selection, variable semantics,
side effects, and result behaviour are proven end to end.

`ai/lua-first-replacement-ledger.yml` 由三份受检清单生成，每个 JSON type、EOC
condition key 和 effect key 恰好出现一次。`implemented_unverified` 表示整个 selector
已由源码、声明、测试、迁移与文档表示，但尚未通过本次验证门；
`bounded_implemented_unverified` 表示至少一个明确限定的真实旧形状已经具备源码、声明、
测试、迁移输出与文档，但 selector 的其他合法动态值、角色、选项或形状仍未等价；
`primitive_available_unverified` 表示已有不依赖旧公共接口的原生积木，
但还没有逐 selector 证明等价；`planned` 只表示已确定目标而没有声称替代完成，`private_adapter` 表示
仍有不公开的旧实现依赖，`reviewed_not_applicable` 表示 Lua 控制流或引擎配置本来就不该
产生作者 API。把一项归入某个 service 只是架构分类，不能当作 service 已存在的证据。
只完成有界可迁移形状最多晋级为 `bounded_implemented_unverified`，绝不会让整个 selector
成为 `implemented_unverified`；仍缺动态值、角色、选项或其他合法形状时必须保留该边界。

审计也会把“已有组合积木但还不等价”的入口从笼统计划中拆出来：随从存在与跟随状态、
NPC 敌对/中立、最近城市与路线揭示、治疗援助、装备选择、回合消耗、陷阱放置和尸群信号
已经有 follower、NPC、overmap、character、effect、inventory、presentation、time、
world、coordinate 或 horde 原语；在目标选择、变量语义、副作用与返回行为完成端到端证明
之前，它们仍不会被标成已完成迁移。

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
  and gameplay tests.

Removal is deliberately not gated on a release count or calendar window: it
may proceed as soon as the mapping, migration, save-migration, copied-world,
and end-to-end evidence above exists.

本文存在并不代表立即冻结旧作者接口。只有某个领域的 Platform 替代、工具、测试和
文档可用后，才冻结该领域的新 JSON/EOC 能力。最终移除必须同时满足完整映射、核心与
捆绑内容迁移、存档兼容、迁移工具与端到端纯 Lua Mod。移除不再附加发布数量或日历时限：
只要上述映射、迁移、存档迁移、复制世界与端到端证据齐全即可执行。

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
fault groups, faults and fault fixes, json flags, item categories, recipe
categories, gates, recipe groups, ammunition types, blacklists, skills,
proficiency categories, vehicle color palettes, monster groups, scenarios,
butchery requirements, item actions, overmap connections, migrations,
shopkeeper rules, sound effects and preloads, map extras, weather generators,
achievements and conducts, techniques, martial arts, traps, constructions,
furniture, terrain, dreams, explosion-light recipes, ammunition effects, addiction types, character modifiers, start locations, climbing aids, weather types, scores, the global mutation-overlay order, zone types, speech pools, end screens, nested recipe categories, attack vectors, magic types, and movement modes), and simple
event/message behaviour.  The regenerated `data/mods/Migrated_Core/` fixture
currently carries 4286 fully translated core entries across these domains with
0 partial skeletons and 0 TODOs.  Bounded literal `compare_string`,
`compare_string_match_all`, `one_in_chance`, `x_in_y_chance`,
`roll_contested`, `mod_is_loaded`, `current_dimension`, and the context-free
`is_day`, `is_season`, and `is_weather` conditions become ordinary Lua predicates over Platform services.  Literal-flag `map_furniture_with_flag` and `map_terrain_with_flag` conditions over a `context_val` location compose `services.gameplay.environment.furniture_has_flag`/`terrain_has_flag`; the same `context_val` + literal-id shape converts literal `map_terrain_id`, `map_furniture_id`, and `map_field_id` into `environment.terrain_id`, `environment.furniture_id`, and `environment.field_exists`; `context_val`-position `map_in_city` and `map_is_outside` compose `services.overmap.is_in_city` and `environment.is_indoor_tile` (including the legacy z < -1 clamp and the out-of-bounds false), and `context_val`-position `is_outside` emits the same `environment.is_outside` shape but stays primitive in the ledger until full parity; dynamic flags/ids and non-`context_val` locations remain explicit TODOs.  The proven `game_start` avatar slice also converts literal `u_is_on_terrain`/`u_is_on_furniture`/`u_is_in_field`/`u_is_on_terrain_with_flag`/`u_is_on_furniture_with_flag` through the same environment predicates at `service_value(services.characters.snapshot(actor)).creature.position`, with the matching `npc_*` mirrors under `npc_becomes_hostile`; dynamic values and other events remain explicit TODOs.  A literal `u_has_mission` mission type id composes `service_value(services.missions.avatar_has_active(services.types.id("mission", id)))` in any `required_event`, and the bare `u_has_camp` predicate composes `service_value(services.camps.player_has_camp())`; dynamic/variable `u_has_mission` ids remain explicit TODOs.  Random conditions convert only finite
literal values inside the native service ranges: dynamic denominators,
non-positive or out-of-range `x/y`, and non-positive, dynamic, or oversized
die sizes remain explicit TODOs.  Literal avatar `u_has_trait`,
literal-array `u_has_any_trait`,
`u_has_martial_art`, `u_using_martial_art`, `u_has_proficiency`, and specific-id
`u_has_bionics` conditions reuse typed mutation, martial-art, proficiency, and
bionic queries.  In the proven `game_start` avatar slice, literal
`u_has_bionics: "ANY"` composes `bionics.summary`, literal
`u_know_recipe` composes `recipes.knows`, the bare `u_is_alive`, `u_is_avatar`,
`u_is_character`, `u_exists`, `has_alpha`, and `u_friend` predicates are constant `true` while
`u_is_npc`, `u_is_monster`, `u_is_item`, `u_is_furniture`, `u_is_vehicle`, `u_hostile`,
`u_is_in_vehicle`, `u_controlling_vehicle`, `u_driving`, `u_is_riding`, `u_is_avatar_passenger`,
`u_is_driven`, `u_is_remote_controlled`, and `u_is_on_rails` are constant `false` because the freshly created
avatar is never dead, hostile, mounted, or in a vehicle during game-start setup, bare `u_male`/`u_female` predicates
compose `service_value(services.characters.snapshot(actor)).male` and its negation, a literal-integer
`u_has_cash` threshold composes the snapshot `cash` field in cents, a literal
`u_has_profession` id composes
`character_has_profession(actor, profession_id)` reproducing the guarded
legacy current-profession-or-held-hobby test, a literal
`u_has_flag` composes
`service_value(services.characters.has_flag(actor, services.types.id("json_flag", flag)))`
while keeping the legacy `MUTATION_THRESHOLD` divergence into
`crossed_threshold()`, and the bare `u_is_outside` predicate composes
`services.gameplay.environment.is_outside(service_value(services.characters.snapshot(actor)).creature.position)`
because the avatar always occupies the map's current z; literal `u_is_wearing`
under the proven `game_start` and four item-event Character slices composes
`service_value(services.inventory.is_wearing(actor, services.types.id("item", item_id)))`
and matches only an exact worn-item `itype_id` (never the wielded item, json
flags, categories, charges, or contents); dynamic/variable `u_is_wearing`
values, `npc_is_wearing`, and unproven actor contexts remain explicit TODOs.
`npc_is_alive`, non-`game_start`
`u_is_alive`/`u_is_avatar`/`u_is_character`/`u_male`/`u_female`/`u_is_outside`,
range/var/math `u_has_cash` shapes, dynamic or variable
`u_has_profession` values, `npc_has_profession`,
dynamic or variable `u_has_flag` values, `npc_has_flag`, and `u_has_flag` under
`npc_becomes_hostile`, dynamic values, and unproven actor contexts remain
explicit TODOs.  In the proven `npc_becomes_hostile` slice, literal
`npc_has_trait`, non-empty literal-array `npc_has_any_trait`,
`npc_has_martial_art`, `npc_using_martial_art`, `npc_has_proficiency`, and
specific-id or "ANY" `npc_has_bionics` mirror their bounded avatar siblings
against `context.actors.npc`; bare `npc_male`/`npc_female` compose the snapshot
`male` field and its negation, `npc_is_character`, `npc_is_npc`, `npc_exists`, and `npc_hostile` are constant `true`,
while `npc_is_avatar`, `npc_is_monster`, `npc_is_item`, `npc_is_furniture`, `npc_is_vehicle`, and `npc_friend` are constant `false`,
and `has_alpha`/`has_beta` stay primitive dialogue-projection selectors (`has_alpha` folds to `true` only in the `game_start` avatar slice; `has_beta` remains an explicit TODO because its legacy beta talker is unproven in every event),
and the proven `game_start` avatar slice also folds the vehicle-only movement states `u_is_falling`/`u_is_floating`/`u_is_flying`/`u_is_sinking`/`u_is_skidding` to `false` (a Character talker never overrides them; the matching `npc_*` mirrors fold under `npc_becomes_hostile`), folds the degenerate mission selectors `u_mission_complete`/`u_mission_failed`/`u_mission_goal`/`u_mission_incomplete`/`u_has_available_mission`/`u_has_many_available_missions` to `false` and `u_has_no_available_mission` to `true` (the avatar talker exposes no selected/available mission), and converts literal `u_need`/`npc_need` shapes (bare need, integer `amount`, or the four sleepiness `level` names) into `snapshot.needs.hunger|thirst|sleepiness > N` comparisons, and folds literal `u_aim_rule`/`u_engagement_rule`/`u_cbm_recharge_rule`/`u_cbm_reserve_rule` to `false` (only the NPC talker overrides `has_ai_rule`, so the avatar's base implementation returns false for every rule), and folds literal `u_bodytype`/`npc_bodytype` by the hardcoded Character rule `bodytype == "human"`, folds `u_can_float`/`u_can_fly`/`npc_can_float`/`npc_can_fly`/`u_following` to `false` (the base talker returns false and no Character talker overrides them), and converts literal `u_is_trait_purifiable`/`npc_is_trait_purifiable` into `services.mutations.definition(...).availability.purifiable`, folds the bare `u_available` predicate to `true` (the freshly created avatar never carries the `currently_busy` effect at game-start), and folds literal `u_rule` to `false` alongside the other AI-rule predicates, and converts literal `u_safe_mode_trigger` cardinal directions into the context-free `services.gameplay.environment.safe_mode_dangerous(direction)` predicate, and folds literal `u_has_part_flag`/`npc_has_part_flag` shapes (with the optional `enabled` boolean) to `false` because the base talker `has_part_flag` returns false and no Character/NPC talker overrides it, and folds literal `u_has_class` to `false` because the Character talker never overrides `is_myclass`; dynamic need/amount/rule/bodytype/trait/direction/flag/class values, the bare/npc mission forms, and other events remain explicit TODOs,
`npc_is_outside` composes `services.gameplay.environment.is_outside(service_value(services.characters.snapshot(actor)).creature.position)`,
literal valid `npc_aim_rule`, `npc_engagement_rule`, `npc_cbm_reserve_rule`,
and `npc_cbm_recharge_rule` compare against `services.npcs.ai_rules(actor)`,
and literal `npc_add_bionic`/`npc_lose_bionic`, `npc_learn_recipe`/`npc_forget_recipe`,
`npc_learn_martial_art`/`npc_forget_martial_art`, and `npc_add_morale`/`npc_lose_morale`
mirror their avatar effect counterparts;
the bare `npc_at_safe_space` predicate composes the same
`character_at_safe_space(actor)` safety conjunction,
literal `npc_has_profession`/`npc_has_flag`/`npc_is_wearing` mirror their
bounded avatar helpers against `context.actors.npc`, the bare
`npc_has_pickup_list` predicate composes the same whitelist query,
and literal `npc_has_class` composes
`service_value(services.npcs.get(actor)).class.value`,
while literal `u_lose_var`/`npc_lose_var` effects compose
`services.variables.remove(actor, name)` (`u_add_var` stays primitive because
the variables API has no native adjust), literal `u_message` composes the same
`services.message(text)` player message as the bare `message` effect (the
avatar target is the player), and literal `npc_message` is a deliberate no-op
under `npc_becomes_hostile` (the legacy handler returns early for NPC
targets), while literal `u_activate_trait`/`u_deactivate_trait` and their
`npc_*` mirrors compose `services.mutations.set_active(actor, id, true|false)`
(dynamic trait ids stay TODO);
`npc_has_item` and `npc_has_move_mode` emit the
same mirrored shapes but stay primitive in the ledger until full parity;
dynamic values, unknown AI rules, and other events remain explicit TODOs.
The proven `game_start` and four item-event Character slices
also convert string `u_has_weapon`/`u_can_drop_weapon` and literal
`u_has_wielded_with_flag`; literal `npc_set_flag`/`npc_unset_flag` convert only
for those item events and retain the optional semantic item guard.  `and`,
`or`, and `not` become native Lua
control flow.  Literal values, typed native-event data values, and character-state
values are emitted as normal Lua expressions instead of legacy variable
objects.  Literal `message` effects call the Platform message service;
`give_achievement` effects become typed achievement-service calls; literal
avatar `u_add_bionic` and `u_lose_bionic` effects become typed bionic-service
calls; literal one-recipe `u_learn_recipe` and `u_forget_recipe` effects become
typed recipe-service calls.  Literal category and subcategory
`u_forget_recipe` shapes become `recipes.forget_category`; dynamic identifiers,
dynamic subcategories, NPC targets, and unproven actor contexts stay partial.
Literal avatar `u_learn_martial_art` and
`u_forget_martial_art` effects become presentation-independent typed
martial-art service calls.  The exact three-field literal avatar
`u_add_morale` shape and the one-field literal avatar `u_lose_morale` shape
become typed morale-service calls; dynamic values and timing extensions remain
partial until their actor and value semantics are represented explicitly.
Bounded literal avatar `u_add_effect` and `u_lose_effect` shapes become typed
effect-service calls; effect options, dynamic values, body-part selectors, and
batch removal remain partial.
All legacy `u_add_wound`, `npc_add_wound`, `u_remove_wound`, and
`npc_remove_wound` shapes remain explicit TODOs.  This includes literal ids,
non-empty literal removal arrays, and proven Character actors: the old path
may select a next-best body part and its add bypasses the per-part limit, while
the Lua-native wound service is exact-part and limit-aware.  Emitting service
calls would therefore be a behavioural rewrite rather than extraction.
The extractor emits normal Lua composition and
writes `MIGRATION_REPORT.md` with a source location for every unresolved
field.  It accepts the comments and trailing commas used by game data;
unsupported inheritance, anonymous definitions, disassembly recipes, mixed
effects, lossy field shapes, malformed numeric shapes, and values outside the
native integer or skill ranges remain partial with explicit TODOs.  A legacy
`MOD_INFO` is fully classified only for the bounded `id`, plain `name`, string
`version`, unique `dependencies`, and Boolean `core` shape; every additional
metadata field remains an explicit TODO rather than being silently discarded.
`--check`
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
大地图视野配置、大地图位置、职业组、地图额外内容集合、载具组、故障组、故障与故障
修复、JSON flag、物品分类、配方分类、大门、配方组、弹药类型、黑名单、技能、熟练度
分类、载具调色板、怪物组、场景、屠宰需求、物品动作、大地图连接、迁移、商人规则、
环境音效与预加载、地图附加物、天气生成器、成就与操守、武术技巧、武术风格、陷阱、
建造、家具、地形、梦境、爆炸光效、弹药效果、成瘾类型、角色修正器、起始位置、攀爬
辅助、天气类型、分数、全局突变覆盖显示顺序、区域类型、语音池、结束画面、嵌套配方
分类、攻击向量、
魔法类型、移动模式、配方与简单事件/消息行为。重新生成的
`data/mods/Migrated_Core/` 夹具当前携带上述领域的 4286 个完整转换核心条目，0 个
部分骨架、0 个 TODO。受限的字面量
`compare_string`、`compare_string_match_all`、`one_in_chance`、
`x_in_y_chance`、`roll_contested`、`mod_is_loaded`、`current_dimension` 和上下文无关的
`is_day`、`is_season` 与 `is_weather` 条件会转成 Platform service
上的普通 Lua 谓词；字面量 flag 且位置为 `context_val` 的 `map_furniture_with_flag` 与 `map_terrain_with_flag` 条件会组合 `services.gameplay.environment.furniture_has_flag`/`terrain_has_flag`；同样的 `context_val` + 字面量 ID 形状会把字面量 `map_terrain_id`、`map_furniture_id` 与 `map_field_id` 转成 `environment.terrain_id`、`environment.furniture_id` 与 `environment.field_exists`；`context_val` 位置的 `map_in_city` 与 `map_is_outside` 则组合 `services.overmap.is_in_city` 与 `environment.is_indoor_tile`（保留 legacy 的 z < -1 夹取与越界 false），`context_val` 位置的 `is_outside` 会生成同样的 `environment.is_outside` 形状，但在账本中保持 primitive 直到完整 parity；动态 flag/ID 与非 `context_val` 位置仍保留显式 TODO。已证明的 `game_start` avatar 切片还会把字面量 `u_is_on_terrain`/`u_is_on_furniture`/`u_is_in_field`/`u_is_on_terrain_with_flag`/`u_is_on_furniture_with_flag` 通过同一批 environment 谓词作用在 `service_value(services.characters.snapshot(actor)).creature.position` 上，`npc_becomes_hostile` 下提供对应的 `npc_*` 镜像；动态值与其他事件仍保留显式 TODO。字面量 `u_has_mission` 任务类型 ID 会在任意 `required_event` 中组合 `service_value(services.missions.avatar_has_active(services.types.id("mission", id)))`，裸 `u_has_camp` 谓词则组合 `service_value(services.camps.player_has_camp())`；动态/变量 `u_has_mission` ID 仍保留显式 TODO。随机条件只转换处于原生 service 范围内的有限字面量，动态分母、非正或
越界的 `x/y`，以及非正、动态或过大的 die size 都会保留显式 TODO。字面量玩家
`u_has_trait`、字面量数组 `u_has_any_trait`、`u_has_martial_art`、
`u_using_martial_art`、`u_has_proficiency` 与指定 ID 的 `u_has_bionics` 会复用类型化
突变、武术、熟练度和仿生装置查询。在已证明的 `game_start` avatar 切片中，字面量
`u_has_bionics: "ANY"` 会组合 `bionics.summary`，字面量 `u_know_recipe` 会组合
`recipes.knows`，裸 `u_is_alive`、`u_is_avatar`、`u_is_character`、`u_exists`、`has_alpha` 与 `u_friend` 谓词恒为 `true`，而
`u_is_npc`、`u_is_monster`、`u_is_item`、`u_is_furniture`、`u_is_vehicle`、`u_hostile`、
`u_is_in_vehicle`、`u_controlling_vehicle`、`u_driving`、`u_is_riding`、`u_is_avatar_passenger`、
`u_is_driven`、`u_is_remote_controlled` 与 `u_is_on_rails` 谓词恒为 `false`（新创建的角色在
game-start 设置阶段绝不会死亡、敌对、骑乘或身处载具中），裸 `u_male`/`u_female` 谓词分别组合
`service_value(services.characters.snapshot(actor)).male` 及其否定，字面量整数 `u_has_cash` 阈值则组合
快照中按美分计数的 `cash` 字段，字面量 `u_has_profession` ID 则组合
`character_has_profession(actor, profession_id)`，复现受保护的旧式当前职业或已持有爱好判断，
字面量 `u_has_flag` 则组合
`service_value(services.characters.has_flag(actor, services.types.id("json_flag", flag)))`
并保留旧 `MUTATION_THRESHOLD` 分叉到 `crossed_threshold()` 的语义，裸
`u_is_outside` 谓词则组合
`services.gameplay.environment.is_outside(service_value(services.characters.snapshot(actor)).creature.position)`
（因为 avatar 始终位于地图当前 z 层）；在已证明的 `game_start` 与四类物品事件 Character
切片中，字面量 `u_is_wearing` 会组合
`service_value(services.inventory.is_wearing(actor, services.types.id("item", item_id)))`
并只匹配穿着物品的精确 `itype_id` 相等（绝不匹配手持物品、json flag、分类、充能或
内容物）；动态/变量 `u_is_wearing` 值、`npc_is_wearing` 与未证明的 actor 上下文仍生成
明确 TODO。`npc_is_alive`、非 `game_start` 的
`u_is_alive`/`u_is_avatar`/`u_is_character`/`u_male`/`u_female`/`u_is_outside`、区间/var/math 形状的
`u_has_cash`、动态或变量 `u_has_profession` 值、`npc_has_profession`、
动态或变量 `u_has_flag` 值、`npc_has_flag`、`npc_becomes_hostile` 下的
`u_has_flag`、动态值与未证明的 actor 上下文仍生成明确 TODO。在已证明的
`npc_becomes_hostile` 切片中，字面量 `npc_has_trait`、非空字面量数组
`npc_has_any_trait`、`npc_has_martial_art`、`npc_using_martial_art`、
`npc_has_proficiency`、指定 ID 或 "ANY" 的 `npc_has_bionics` 会对照
`context.actors.npc` 镜像其已有界的 avatar 兄弟分支；裸 `npc_at_safe_space` 谓词组合同样的
`character_at_safe_space(actor)` 安全合取，
字面量 `npc_has_profession`/`npc_has_flag`/`npc_is_wearing` 对照
`context.actors.npc` 镜像其已有界的 avatar helper，裸 `npc_has_pickup_list` 谓词组合同样的
白名单查询，字面量 `npc_has_class` 组合
`service_value(services.npcs.get(actor)).class.value`，
字面量 `u_lose_var`/`npc_lose_var` 效果则组合
`services.variables.remove(actor, name)`（`u_add_var` 保持 primitive，因为变量
API 没有原生 adjust），字面量 `u_message` 组合与裸 `message` 效果相同的
`services.message(text)` 玩家消息（avatar 目标即玩家），字面量 `npc_message` 在
`npc_becomes_hostile` 下是刻意的空操作（legacy handler 对 NPC 目标直接提前返回），
字面量 `u_activate_trait`/`u_deactivate_trait` 及其 `npc_*` 镜像则组合
`services.mutations.set_active(actor, id, true|false)`（动态特质 ID 保持 TODO）；裸 `npc_male`/`npc_female` 组合快照
`male` 字段及其否定，`npc_is_character`、`npc_is_npc`、`npc_exists` 与 `npc_hostile` 恒为 `true`，
而 `npc_is_avatar`、`npc_is_monster`、`npc_is_item`、`npc_is_furniture`、`npc_is_vehicle` 与 `npc_friend` 恒为 `false`，
`has_alpha`/`has_beta` 仍保持 primitive 的对话投影 selector（`has_alpha` 仅在 `game_start` avatar 切片折为 `true`；`has_beta` 保持显式 TODO，因为其 legacy beta talker 在任何事件中都未证明），
已证明的 `game_start` avatar 切片还会把仅载具覆盖的移动状态 `u_is_falling`/`u_is_floating`/`u_is_flying`/`u_is_sinking`/`u_is_skidding` 折为 `false`（Character talker 从不覆盖它们；`npc_becomes_hostile` 下提供对应的 `npc_*` 镜像），把退化的任务 selector `u_mission_complete`/`u_mission_failed`/`u_mission_goal`/`u_mission_incomplete`/`u_has_available_mission`/`u_has_many_available_missions` 折为 `false`、`u_has_no_available_mission` 折为 `true`（avatar talker 不暴露已选/可接任务），并把字面量 `u_need`/`npc_need` 形状（裸需求、整数 `amount` 或四个 sleepiness `level` 名）转成 `snapshot.needs.hunger|thirst|sleepiness > N` 比较，把字面量 `u_aim_rule`/`u_engagement_rule`/`u_cbm_recharge_rule`/`u_cbm_reserve_rule` 折为 `false`（只有 NPC talker 覆盖 `has_ai_rule`，avatar 的基础实现对任何规则都返回 false），并把字面量 `u_bodytype`/`npc_bodytype` 按硬编码的 Character 规则 `bodytype == "human"` 折叠，把 `u_can_float`/`u_can_fly`/`npc_can_float`/`npc_can_fly`/`u_following` 折为 `false`（基础 talker 返回 false 且无 Character talker 覆盖），并把字面量 `u_is_trait_purifiable`/`npc_is_trait_purifiable` 转成 `services.mutations.definition(...).availability.purifiable`，把裸 `u_available` 谓词折为 `true`（新创建的角色在 game-start 绝不携带 `currently_busy` 效果），把字面量 `u_rule` 与其他 AI 规则谓词一起折为 `false`，并把字面量 `u_safe_mode_trigger` 的方位角转成上下文无关的 `services.gameplay.environment.safe_mode_dangerous(direction)` 谓词，把字面量 `u_has_part_flag`/`npc_has_part_flag` 形状（含可选 `enabled` 布尔）折为 `false`（基础 talker 的 `has_part_flag` 返回 false 且无 Character/NPC talker 覆盖），把字面量 `u_has_class` 折为 `false`（Character talker 从不覆盖 `is_myclass`）；动态需求/数值/规则/体型/特质/方位/flag/职业值、裸名与 npc 任务形式及其他事件仍保留显式 TODO，`npc_is_outside` 组合
`services.gameplay.environment.is_outside(service_value(services.characters.snapshot(actor)).creature.position)`，字面量合法值的
`npc_aim_rule`、`npc_engagement_rule`、`npc_cbm_reserve_rule` 与 `npc_cbm_recharge_rule`
对照 `services.npcs.ai_rules(actor)` 比较，字面量 `npc_add_bionic`/`npc_lose_bionic`、`npc_learn_recipe`/`npc_forget_recipe`、
`npc_learn_martial_art`/`npc_forget_martial_art` 与 `npc_add_morale`/`npc_lose_morale`
镜像其 avatar effect 兄弟分支；`npc_has_item` 与
`npc_has_move_mode` 会生成同样的镜像形状，但在账本中仍保持 primitive，直到完整
parity；动态值、未知 AI 规则与其他事件仍生成明确 TODO。已证明的
`game_start` 与四类物品事件 Character 切片还会转换字符串
`u_has_weapon`/`u_can_drop_weapon` 和字面量 `u_has_wielded_with_flag`；字面量
`npc_set_flag`/`npc_unset_flag` 只在这四类物品事件中转换，并保留可选语义物品 guard。
`and/or/not` 会转成 Lua 自身控制流。字面量、类型化原生事件 data 值
和角色 state 值会直接生成普通 Lua 表达式，而不是旧变量对象；字面量 `message` effect
会调用 Platform 消息 service，`give_achievement` effect 会生成类型化成就 service 调用，字面量玩家
`u_add_bionic` 与 `u_lose_bionic` effect 会生成类型化仿生装置 service 调用，字面量
`u_learn_recipe` 与单配方 `u_forget_recipe` effect 会生成类型化配方 service 调用；字面量
分类和子分类 `u_forget_recipe` 会生成 `recipes.forget_category`，动态 ID、动态子分类、
NPC 目标与未证明 actor 上下文仍保持 partial；字面量玩家 `u_learn_martial_art` 与
`u_forget_martial_art` 会生成不绑定呈现的类型化武术 service 调用；仅含三个必需字段的
字面量玩家 `u_add_morale` 与单字段字面量玩家 `u_lose_morale` 会生成类型化士气 service
调用，动态值和扩展计时形状在角色与取值语义被显式建模前仍保持 partial；有界的字面量
玩家 `u_add_effect` 与 `u_lose_effect` 会生成类型化效果 service 调用，效果选项、动态值、
身体部位选择器与批量移除仍保持 partial。所有旧 `u_add_wound`、`npc_add_wound`、
`u_remove_wound` 与 `npc_remove_wound` 形状都会生成显式 TODO；即使 id 是字面量、remove
数组非空且 Character actor 已证明也不会自动转换，因为旧路径可能选择 next-best 身体部位，
且旧 add 绕过每部位上限，而 Lua-native 伤口 service 要求精确部位并执行上限。生成 service
调用会成为行为重写而不是提取；其余字段全部以
带来源位置的 TODO 写入报告；`--check` 只比较
现有输出。它支持游戏数据使用的注释与尾逗号；继承、匿名定义、拆解配方、混合 effect
以及有损字段形状、畸形数字和超出原生整数/技能范围的值都会保持 partial 并写明 TODO。
旧 `MOD_INFO` 只有 `id`、普通 `name`、字符串 `version`、唯一 `dependencies` 与布尔
`core` 的有界形状才能完整归类；任何额外元数据字段都会保留显式 TODO，不会被静默丢弃。
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
