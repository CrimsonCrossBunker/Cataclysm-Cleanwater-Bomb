<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `lua.v5.example-mod`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/api/lua/v5/example-mod/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/api/lua/v5/example-mod/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
# Lua API v5 example Mod

This directory is a complete, intentionally small loadable Mod. Copy the whole
`api_v5_mod/` directory into `data/mods/` (or a user Mod directory) and enable
"CCB Lua API v5 Example". If you change the Mod id, change the Lua manifest id
and any provider ids in `main.lua` to match it.

The example demonstrates:

- a source-local module loaded with `require`;
- a versioned service with copied scalar arguments and results;
- custom and lifecycle events;
- a deterministic turn scheduler;
- read-only definition-registry search;
- character/page state;
- one page shared by Android touch, desktop ImGui, and terminal ImTui;
- named actions from the current input context;
- typed game values and detached definition lookup;
- native calendar/weather snapshots and native event schema subscriptions;
- a source-owned native action-menu entry and PC sidebar widget; and
- a typed native lifecycle hook.

The Android schema-6 HUD is deliberately not involved. Lua pages and the
native Android HUD are separate extension surfaces.

Repository validation checks `modinfo.json`, Manifest Schema conformance,
tracked Lua syntax, example references, and the equality of the Mod and Lua
source ids.
