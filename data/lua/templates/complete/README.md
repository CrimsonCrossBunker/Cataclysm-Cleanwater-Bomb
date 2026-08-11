# Complete Lua-first Platform template

This template is a zero-JSON/EOC vertical slice.  Its root `main.lua` defines
one native item and recipe, registers a named item-use handler, stores typed
character/world state, and schedules one serializable named task.  Live
gameplay code can compose generation-safe native domains under
`ccb.services`; synchronous decisions use `ccb.runtime.hook`, and durable
payload changes use explicit `ccb.runtime.migrate_task_payload` chains.
Callback-driven prompts and menus use `ccb.presentation`; keep stable choice
ids separate from translated labels, pass choices as a dense one-based array,
and treat cancellation as `nil`.  Item callbacks receive generation-safe
`context.character` and `context.item` handles plus a tagged
`context.position`; keep long-lived data as stable ids or typed state instead
of trying to serialize those live handles.

Runtime-only developer reload preserves typed state, delayed tasks, task ids,
and the gameplay random stream only when the static content fingerprint is
unchanged.  A change to an item or recipe definition deliberately requires a
full data reload.

`runtime/behaviour.lua` also demonstrates Lua-native predicates: stable
dimension ids come from `ccb.services.gameplay.environment`, string relations
use the reusable `gameplay.strings` helpers, and gameplay randomness comes
from the per-Mod `ccb.services.random` stream.  Build larger conditions as
ordinary Lua functions and modules; do not recreate EOC key tables.

The `runtime/` directory is only a suggested organization.  The loader does
not require it, and the scaffold command never overwrites generated files.
Likewise, `content/token.lua` is an ordinary root-local module with a
`register(ccb)` function, not a special loader convention.  Add sibling
modules, compose them from `main.lua`, or replace this layout entirely; only
the root entry point is conventional.  During scaffolding, the target
directory name becomes the zero-configuration Mod id and is inserted as the
content-id namespace, so independently generated Mods do not share the
template's example item id.  If final installation fails, a pre-existing empty
target directory is restored instead of being left removed.

For existing JSON/EOC content, start with
`python3 tools/migrate_lua_first.py INPUT --output TARGET`.  Its output is a
reviewable skeleton: every unsupported semantic field remains an explicit
TODO in `MIGRATION_REPORT.md`, never a hidden legacy runner.
