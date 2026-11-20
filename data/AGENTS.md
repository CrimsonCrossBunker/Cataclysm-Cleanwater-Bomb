# `data/` agent instructions

Applies to core JSON, bundled mods, schemas, and Lua data.

- Read `data/lua/AGENTS.md` or `data/mods/AGENTS.md` when editing those subtrees.
- Preserve stable IDs unless accompanied by an explicit migration/obsolete entry.
- Follow repository JSON formatting and treat schemas and generated inventories as contracts.
- Keep content edits separate from unrelated engine refactors; run `json-check`/formatters only when requested.
