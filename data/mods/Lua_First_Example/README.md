# Lua-first bundled example

This optional bundled Mod contains no JSON, EOC, manifest, or required `lua/`
directory.  The directory name supplies its default Mod id.  `main.lua`
composes ordinary local modules that create a native item and recipe and bind
their behaviour to named Lua functions.

The example is intentionally small.  It is an executable migration fixture
for the implemented Platform slice, not a claim that every legacy static
content domain has already been replaced.  Its item callback can use the
generation-safe character/item handles and tagged map position exposed by
`ItemUseContext`; durable data belongs in `ccb.state` or named task payloads,
not in live handles.

Its `world_ready` handler also exercises the per-Mod random stream, stable
dimension query, and reusable string predicates.  These are ordinary
Lua-composition examples rather than EOC-shaped compatibility calls.
