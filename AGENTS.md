# CCB agent instructions / CCB Agent 指南

These instructions are intentionally useful offline.  Read the nearest nested
`AGENTS.md` before changing files in a subsystem.  The nested file adds local
rules and does not replace this file.

本文件刻意保留离线可用的最小上下文。修改某个子系统前，先读取路径上最近的
`AGENTS.md`；子目录规则只补充本文件，不覆盖全局规则。

## Sources of truth / 权威来源

- Runtime behaviour: C++/Java/Lua source and tests in this repository.
- JSON/Lua/API contracts: schemas, LuaLS declarations, registrations,
  checked-in generated inventories, and the accepted Lua-first architecture
  contract plus its checked roadmap.
- Build and validation: GitHub Actions, CMake, Makefile, Gradle, and repository
  validation scripts.
- Contribution and governance: this file, `CONTRIBUTING.md`, and
  `GOVERNANCE.md`.
- CCB-Docs explains and navigates these contracts.  If a page conflicts with a
  repository contract, mark the page stale and fix it; do not change the
  contract merely to match prose.

- 运行时行为以本仓库源码和测试为准。
- JSON、Lua 与 API 契约以 Schema、LuaLS 声明、注册信息、生成清单，以及已接受的
  Lua-first 架构合同与受检路线图为准。
- 构建和验证以 CI、CMake、Makefile、Gradle 与仓库验证脚本为准。
- 贡献和治理以本文件、`CONTRIBUTING.md`、`GOVERNANCE.md` 为准。
- CCB-Docs 负责解释和导航；与源码契约冲突时应标记文档过期并修正文档。

## Minimal project map / 最小项目地图

| Path | Responsibility | Read next |
| --- | --- | --- |
| `src/` | C++ engine, gameplay, UI, native Lua bindings | `src/AGENTS.md` |
| `data/` | Core JSON, bundled mods, Lua runtime data | `data/AGENTS.md` |
| `tests/` | Catch2 regression and integration tests | `tests/AGENTS.md` |
| `tools/` | Formatters, validators, maintenance tools | `tools/AGENTS.md` |
| `android/` | Android Gradle project and Java/native integration | `android/AGENTS.md` |
| `build-scripts/` | Packaging and platform build helpers | `build-scripts/AGENTS.md` |
| `.github/` | CI, issue forms, PR automation | `.github/AGENTS.md` |
| `doc/` | Legacy developer documentation awaiting classified migration | this file |

The machine-readable map is `ai/project-map.yml`; validation routing is in
`ai/test-matrix.yml`.  The long-term pure-Lua authoring direction is defined
by `data/lua/LUA_FIRST_PLATFORM.md`, with implementation status in
`ai/lua-first-roadmap.yml`; it is independent of the currently shipped Lua
API v5 contract.

## Modification boundaries / 修改边界

- Keep changes scoped to the requested behaviour.  Do not reorganize unrelated
  game code for agent readability.
- Inspect registrations, declarations, generated-file rules, and relevant
  tests before changing a public contract.
- Never hand-edit a file listed as generated in `ai/generated-files.yml`.
- Do not treat CCB-Docs prose as a substitute for checking source and tests.
- Do not edit vendored third-party code unless the task explicitly targets it.
- Do not scan, index, modify, stage, commit, or add an ignore rule for
  `obj-lua/`.  It is a local 622 MB build cache, not an established project
  output contract.

## Basic discovery and validation / 基础定位与验证

Use `rg` and `rg --files` for discovery.  Choose the narrowest applicable
validation from `ai/test-matrix.yml`; common entry points are:

```sh
# Agent metadata and migration inventory
python3 -m unittest discover -s tools/agent -p 'test_*.py'
python3 tools/agent/check_project_metadata.py
python3 tools/agent/generate_markdown_inventory.py --check
python3 tools/agent/generate_documentation_registry.py --check
python3 tools/agent/generate_migration_reports.py --check

# Bounded task context and deterministic benchmark
python3 tools/agent/build_context_pack.py --task-id repository-navigation --file AGENTS.md
python3 tools/agent/benchmark_context_pack.py --check

# C++ formatting and unit tests
make astyle-check
make -j2 tests
./tests/cata_test

# JSON loading and formatting
make -j2 json-check

# Lua public-contract checks
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_coverage.py
python3 tools/lua_api/check_cmake_contract.py

# CMake configuration (out-of-tree)
cmake --preset linux-x64
```

Some commands require platform dependencies and can be expensive.  Report
exactly what ran, what was skipped, and why.  Never claim a check passed when
it was not executed.

## Pull requests and documentation impact / PR 与文档影响

- Every PR names a Responsible human.  AI-tool disclosure is not required.
- Complete the Documentation impact, Related CCB-Docs PR, Affected
  documentation IDs, and Generated reference impact fields.
- Documentation-impact enforcement is staged in `ai/docs-impact.yml`; do not
  claim a mapping is required until its referenced docs and default-branch
  checks are complete.
- A CCB-Docs PR may be prepared before its source PR merges, but it stays draft.
  After source merge, refresh it to the final commit before merging the docs.
