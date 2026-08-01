# `tools/` agent instructions

- Maintenance tools are part of the developer interface.  Preserve stable CLI
  behaviour or document intentional changes.
- Prefer standard-library Python where practical; pin any added dependency.
- Add unit tests for parsers, generators, and policy checks.
- Generators must offer a non-mutating `--check` mode for CI.
- Never traverse ignored build caches; use tracked-file lists for inventory
  jobs.

```sh
python3 -m unittest discover -s tools/agent -p 'test_*.py'
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

工具是开发者接口；生成器必须可复现，并提供不会改文件的 CI 检查模式。
