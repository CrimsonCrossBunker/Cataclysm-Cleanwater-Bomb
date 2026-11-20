# `src/` agent instructions

Applies to native C++ engine, gameplay, UI, platform integration, and Lua bindings.

- Follow `doc/c++/CODE_STYLE.md` and existing ownership/lifetime patterns.
- Trace JSON loaders, event registrations, and Lua registrations before changing public names or semantics.
- Do not expose borrowed native pointers to Lua; preserve the bounded snapshot, typed-handle, and capability-checked API model.
- Check `ai/generated-files.yml` before editing generated headers or sources.
- Only add or run tests in `tests/` when explicitly requested.
