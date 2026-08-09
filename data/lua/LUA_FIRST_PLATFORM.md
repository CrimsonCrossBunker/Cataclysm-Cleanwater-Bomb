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

- the directory name is the Mod id and display name;
- dependencies are empty;
- the platform version is 1;
- `main.lua` is the content and runtime registration entry point.

Subdirectories such as `content/`, `runtime/`, `lib/`, and `tests/` are author
choices.  Templates may recommend them, but the loader must not require them.
Local `require` searches the Mod root for `?.lua` and `?/init.lua`; trusted
scripts may further change `package.path`.

最小 Platform v1 Mod 只约定根目录存在 `main.lua`。不强制 `lua/` 目录，也不需要
`manifest.json` 或 `modinfo.json`。目录名默认同时作为 Mod ID 与显示名，依赖默认为
空，Platform 版本默认为 1。`content/`、`runtime/`、`lib/`、`tests/` 等目录只属于
作者的组织选择，模板可以推荐，引擎不能强制。

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

Platform v1 开放捆绑 Lua 5.4 的完整标准库，包括 `io`、`os`、`debug`、协程、动态
加载和普通 package 支持，不沿用 v5 capability 沙箱。脚本与游戏进程权限相同；这种
选择换取最大扩展能力，但不再提供“不可信 Mod”安全边界。文件、进程和原生模块副作用
无法事务回滚，也不保证跨平台可用。

## Loading lifecycle / 加载生命周期

The target lifecycle is:

1. Discover a root `main.lua` or optional `mod.lua`.
2. Resolve metadata and dependency order.
3. Begin one data-load transaction.
4. Load legacy JSON for a hybrid Mod, when present.
5. Execute the Platform entry and stage native content definitions.
6. Commit staged definitions and run normal global finalization.
7. Make registered runtime handlers active after `world_ready`.

Top-level code may create content and register handlers.  Access to live map,
character, or world state is invalid until the world is ready.  A failed data
load never enters a playable partially finalized state, although trusted
external side effects cannot be undone.

Runtime hot reload executes the entry in a candidate state.  If the static
content fingerprint is unchanged, runtime registrations can be swapped.  If
content changed, the reload reports `requires_full_data_reload` rather than
mutating finalized registries in place.

目标生命周期依次为：发现入口、解析依赖、开始数据事务、按需加载旧 JSON、执行 Lua
并暂存原生定义、提交并统一 finalize、最后在 `world_ready` 后激活运行时 handler。
顶层代码可以创建内容和注册回调，但世界就绪前不能访问实时地图或角色。静态内容指纹
改变时拒绝局部热重载，并要求完整数据重载。

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

## First vertical slice and templates / 首个纵向样板与模板

The first executable slice is one zero-JSON/EOC Mod that defines an item, its
recipe, and a Lua use behaviour.  It must exercise discovery, native content,
cross-id references, a named handler, persistent state, save/load, and an
observable in-game result.

Developer tooling will provide `minimal` and `complete` templates plus a
scaffolding command.  Generated Mods contain no JSON and no required `lua/`
directory.  The complete template may recommend `content/`, `runtime/`, and
`tests/`, but generated files become author-owned and are never overwritten by
template updates.

首个可执行样板固定为“物品 + 配方 + Lua 使用行为”的零 JSON/EOC Mod。开发工具将
提供 minimal、complete 模板和脚手架命令；生成结果不包含 JSON，也不强制 `lua/`
目录。模板只推荐组织方式，生成后文件完全归作者所有，工具不得覆盖其修改。

## Maintenance rule / 维护规则

Any change to Platform discovery, lifecycle, exported native surface,
persistence, legacy dependency, or milestone status updates this document or
`ai/lua-first-roadmap.yml` and names the affected CCB-Docs ids.  Runtime source
and tests remain authoritative for implemented behaviour; planned entries must
never be presented as shipped API.

Platform 的发现、生命周期、原生导出、持久化、旧接口依赖或阶段状态变化时，必须同步
更新本文或 `ai/lua-first-roadmap.yml`，并注明受影响的 CCB-Docs 文档 ID。运行时源码
和测试始终决定已实现行为；计划项不得冒充已发布 API。
