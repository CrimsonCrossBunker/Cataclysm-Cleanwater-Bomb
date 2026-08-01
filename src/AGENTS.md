# `src/` agent instructions

Applies to the native C++ engine, gameplay, UI, platform integration, and Lua
bindings.  Runtime behaviour is authoritative here together with tests.

- Follow `doc/c++/CODE_STYLE.md` and existing ownership/lifetime patterns.
- Trace JSON loaders, event registrations, and Lua registrations before
  changing public names or semantics.
- Add or update focused tests in `tests/`; do not rely only on compilation.
- Do not expose borrowed native pointers to Lua.  Preserve the bounded
  snapshot, typed-handle, and capability-checked API model.
- Check `ai/generated-files.yml` before editing generated headers or sources.

Typical validation:

```sh
make astyle-check
make -j2 tests
./tests/cata_test "<focused test filter>"
```

本目录的源码与测试决定运行时行为。修改公开名称、JSON 加载或 Lua 注册前必须
追踪对应注册点并补充聚焦测试。
