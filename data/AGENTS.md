# `data/` agent instructions

Applies to core JSON, bundled mods, schemas, and Lua data.

- Read the nearest nested `AGENTS.md` for `data/lua/` or `data/mods/`.
- Preserve stable IDs unless an explicit migration/obsolete entry accompanies
  the change.
- Keep JSON in repository formatter style and validate data loading.
- Treat schemas and checked generated inventories as contracts, not prose.
- Keep content changes separate from unrelated engine refactors.

Typical validation:

```sh
make -j2 json-check
tools/format/json_formatter.cgi <changed-json-file>
```

本目录以稳定 ID、Schema 和实际加载结果为准；修改数据后必须运行最小相关的
JSON 格式与加载检查。
