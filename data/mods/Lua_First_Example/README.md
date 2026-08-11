# Lua-first bundled example

This optional bundled Mod contains no JSON, EOC, manifest, or required `lua/`
directory.  Its optional native `mod.lua` supplies display metadata and the
core dependency without using `modinfo.json`.  `main.lua` composes ordinary
local modules that create a native item and recipe and bind their behaviour to
named Lua functions.

The example is intentionally small.  It is an executable migration fixture
for the implemented Platform slice, not a claim that every legacy static
content domain has already been replaced.  Its item callback can use the
generation-safe character/item handles and tagged map position exposed by
`ItemUseContext`; durable data belongs in `ccb.state` or named task payloads,
not in live handles.

Its `world_ready` handler also exercises the per-Mod random stream, stable
dimension query, reusable string predicates, typed world state, and one named
persistent task.  The task survives a save/reload cycle and emits its reminder
after ten turns.  These are ordinary Lua-composition examples rather than
EOC-shaped compatibility calls.

The repository's `[playable_mvp]` test treats this directory as an installed
Mod, selects it through the real Mod manager, loads and uses its item, performs
real game saves, destroys the Lua runtime, reloads all data, and proves that
the item behaviour, typed state, and delayed task continue correctly.
