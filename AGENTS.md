# CCB agent instructions

Read the nearest nested `AGENTS.md` before editing a subsystem; nested files add local rules without replacing this file.

## Required development skill

Before starting work in this repository, read and apply the installed
`ccb-dev-rules` skill at `$CODEX_HOME/skills/ccb-dev-rules/SKILL.md`
(`~/.codex/skills/ccb-dev-rules/SKILL.md` when `CODEX_HOME` is unset).
Use it on every development task in this directory and its subdirectories,
and read its task-specific references as directed by the skill. Follow the
applicable `AGENTS.md` files as well. If the skill is missing, report that
before proceeding rather than silently skipping it.

## Sources of truth

- Runtime behaviour: C++/Java/Lua source (and `tests/` where present).
- JSON/Lua/API contracts: schemas, LuaLS declarations, registrations, checked-in generated inventories, `data/lua/LUA_FIRST_PLATFORM.md`, and `data/lua/LUA_FIRST_EOC_WORKFLOW.md`.
- Build and validation: CI workflows, CMake, Makefile, Gradle, and repo scripts.
- Governance: this file, `CONTRIBUTING.md`, `GOVERNANCE.md`, and `ai/project-map.yml`.
- CCB-Docs explains contracts; if prose conflicts with source or contracts, fix the docs rather than changing the contract.

## Project map

| Path | Responsibility | Read next |
| --- | --- | --- |
| `src/` | C++ engine, gameplay, UI, native Lua bindings | `src/AGENTS.md` |
| `data/` | Core JSON, bundled mods, Lua runtime data | `data/AGENTS.md` |
| `tests/` | Catch2 regression and integration tests | `tests/AGENTS.md` |
| `tools/` | Formatters, validators, maintenance tools | `tools/AGENTS.md` |
| `android/` | Android Gradle project and Java/native integration | `android/AGENTS.md` |
| `build-scripts/` | Packaging and platform build helpers | `build-scripts/AGENTS.md` |
| `.github/` | CI, issue forms, PR automation | `.github/AGENTS.md` |
| `doc/` | Legacy developer docs awaiting migration | this file |

Lua changes use `require("ccb")` (Platform v1) only; sync public declarations and generated references when changing public APIs.

## Modification boundaries

- Keep edits scoped to what was requested; do not reorganize unrelated code.
- Inspect registrations, declarations, and generated-file rules before changing a public contract; never hand-edit files listed in `ai/generated-files.yml`.
- Do not edit vendored third-party code unless explicitly requested.
- Never scan, index, modify, stage, commit, or add an ignore rule for `obj-lua/` (local build cache).

## Discovery, builds, and tests

- Locate symbols and callers with `rg` / `rg --files` and read narrow slices.
- **Do not write tests, compile, or run tests unless explicitly requested by the user.**
- When validation is requested, run only the narrowest matching check from `ai/test-matrix.yml` and report strictly what ran and passed or failed.

## Pull requests and docs impact

- Every PR names a real human as Responsible human (the agent carries no responsibility); when preparing a PR, advise reviewing the full diff before pushing.
- Fill Documentation impact, Related CCB-Docs PR, Affected documentation IDs, and Generated reference impact fields per `ai/docs-impact.yml` (do not claim a mapping is required before its checks pass).
- Draft CCB-Docs PRs may open ahead of source merge, but must refresh to the final commit before merging.
- Keep newly added code comments necessary; avoid vibe-coding work-report notes or unneeded test-script bloat for minor or JSON-only changes.
