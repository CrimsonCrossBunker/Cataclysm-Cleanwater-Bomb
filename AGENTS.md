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
`ai/lua-first-roadmap.yml`.  Platform v1 is the repository's only supported
Lua runtime and public authoring contract; the former API v5 runtime,
capability sandbox, manifest, and `game.*` compatibility surface are removed
rather than maintained as a second system.

Lua-first EOC capability work follows `data/lua/LUA_FIRST_EOC_WORKFLOW.md`.
Finish one domain batch with its implementation, declarations, and test source.
Run the affected acceptance gate once; reuse passing evidence while its inputs
and build configuration are unchanged. Focused tool tests are allowed during
implementation. Defer C++ builds, broad suites and generated refreshes to batch
acceptance; full corpus audits are for migration, parity claims, or EOC removal.
`ai/test-matrix.yml` lists available checks, not a mandate to run them all.

Lua-first 的 EOC 能力开发遵循 `data/lua/LUA_FIRST_EOC_WORKFLOW.md`：按完整领域批次同步
实现、声明与测试，集中验收受影响的范围；输入和构建配置不变时复用已通过证据。开发中可执行
聚焦工具测试，C++ 构建、宽测试与生成刷新留到批次验收；全量语料审计用于迁移、完整替代声明
或删除 EOC。`ai/test-matrix.yml` 是可选检查的路由表，不是每轮全跑的清单。

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
python3 tools/lua_api/check_platform_native_inventory.py
python3 tools/lua_api/check_platform_contract.py
python3 tools/lua_api/check_platform_coverage.py
python3 tools/lua_api/check_cmake_contract.py

# CMake configuration (out-of-tree)
cmake --preset linux-x64
```

Some commands require platform dependencies and can be expensive.  Report
exactly what ran, what was skipped, and why.  Never claim a check passed when
it was not executed.

## Long-task execution efficiency / 长任务执行效率

Treat context, command output, and repeated validation as limited resources on
large or multi-turn work.  These rules apply across C++, Java, Lua, JSON,
Android, tools, and documentation:

- **Bounded context / 有界上下文:** Start from the nearest `AGENTS.md`, the
  project/test maps, changed-file names, and exact symbols or tests.  On
  continuation, do not reread whole threads, full diffs, generated inventories,
  logs, or unchanged completed files. / 从最近的 `AGENTS.md`、项目/测试映射、
  变更文件名和精确符号或测试开始；续接时不得重读完整聊天、完整 diff、生成清单、
  日志或未变化的已完成文件。
- **Indexed large-file access / 大文件索引式读取:** Locate definitions,
  callers, registrations, and tests with `rg`, then read and patch narrow
  windows.  Split a large file only at a real responsibility boundary, not
  merely to make it easier for an agent to read. / 先用 `rg` 定位定义、调用、
  注册和测试，再读取及修改小窗口；只有存在真实职责边界时才拆分大文件。
- **One coherent batch / 单一完整批次:** Finish one subsystem or domain batch
  at a time, including its implementation, declarations/contracts, and test
  source.  Inspect one authoritative lifecycle or registration point and one
  representative caller/data shape before broad edits. / 每次完成一个完整子系统或
  领域批次，并同步实现、声明/契约和测试源码；批量修改前只检查一个权威生命周期或
  注册点及一个代表性调用或数据形状。
- **Checkpoint, do not reconstruct / 记录断点，不重建历史:** For unfinished
  multi-turn work, keep a compact local checkpoint containing the current
  batch, closed work, changed files, last checks, unresolved risk, and next
  exact search.  Resume from it after context compression; do not reconstruct
  the task from chat history. / 未完成的多轮任务只保存当前批次、已完成工作、修改文件、
  最近检查、未解决风险和下一条精确搜索；上下文压缩后从断点继续，不从聊天历史重建。
- **Cache evidence / 缓存验证证据:** Reuse a passing check while its relevant
  inputs are unchanged.  Run cheap syntax, formatting, and focused tests in the
  edit loop; reserve builds, full data loads, broad suites, and generated-file
  refreshes for the applicable acceptance gate. / 相关输入未变化时复用已通过的检查；
  编辑循环只运行廉价语法、格式和聚焦测试，把编译、完整数据加载、宽测试和生成文件
  刷新留到相应验收门。
- **Bounded output / 有界输出:** Limit search and command output.  Report
  counts, exit status, elapsed time, and the relevant error excerpt instead of
  pasting full reports, generated files, or build logs into task context. /
  限制搜索和命令输出，只记录计数、退出状态、耗时及相关错误片段，不把完整报告、
  生成文件或构建日志放入任务上下文。
- **One failure loop / 单次失败闭环:** On failure, collect one focused
  diagnostic, fix the root cause, and return to the same gate.  Do not restart
  earlier broad scans or use a full suite as a probe. / 失败时只收集一次聚焦诊断，
  修复根因后返回同一验收门；不得重启之前的宽扫描或用完整套件探测问题。
- **Defer non-evidence churn / 推迟无验证价值的工作:** Keep unrelated history
  rewriting, PR description changes, generated progress prose, and repeated
  unchanged statistics outside the implementation loop. / 实现循环中不做无关历史
  重写、PR 描述修改、进度文案生成或重复统计未变化的数据。

## Pull requests and documentation impact / PR 与文档影响

- Every PR names a Responsible human.  AI-tool disclosure is not required.
- Complete the Documentation impact, Related CCB-Docs PR, Affected
  documentation IDs, and Generated reference impact fields.
- Documentation-impact enforcement is staged in `ai/docs-impact.yml`; do not
  claim a mapping is required until its referenced docs and default-branch
  checks are complete.
- A CCB-Docs PR may be prepared before its source PR merges, but it stays draft.
  After source merge, refresh it to the final commit before merging the docs.
