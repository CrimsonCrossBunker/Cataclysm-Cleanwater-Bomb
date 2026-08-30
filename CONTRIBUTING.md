# Contributing to Cataclysm: Cleanwater Bomb

Thank you for improving Cataclysm: Cleanwater Bomb (CCB). CCB is an
independent Cataclysm fork with its own repository, policies, releases,
translation project, compatibility commitments, and public Lua API.

感谢你参与 Cataclysm: Cleanwater Bomb（CCB）。CCB 是独立维护的 Cataclysm
分支，拥有自己的仓库、政策、发布、翻译项目、兼容性承诺和 Lua API。

- Source repository: <https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb>
- Developer documentation: <https://crimsoncrossbunker.github.io/CCB-Docs/>
- Issues: <https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/issues>
- Discussions and support: <https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/discussions>
- Security reports: [SECURITY.md](SECURITY.md)

Read [ISSUES.md](ISSUES.md) before opening an issue and the repository-root
[AGENTS.md](AGENTS.md) before changing files. The closest nested `AGENTS.md`
adds subsystem-specific boundaries and validation commands.

## Sources of truth

| Subject | Authority |
| --- | --- |
| Runtime behaviour | CCB source and tests |
| JSON, Lua, and API contracts | Schemas, LuaLS declarations, registrations, and generated inventories |
| Build and validation | CI, CMake, Makefile, Gradle, and repository validators |
| Contribution and governance | `AGENTS.md`, this file, and `GOVERNANCE.md` |
| Developer explanation and tutorials | CCB-Docs |
| Player entry point | CCB website |
| Game-data lookup | CCB-GUIDE |

If CCB-Docs conflicts with a repository contract, mark the page stale and fix
the page. Explanatory prose does not override source, tests, schemas, or build
definitions.

如果 CCB-Docs 与仓库契约冲突，应把页面标为 stale 并按源码契约修复；不得用
说明性文档覆盖源码、测试、Schema 或构建定义。

## License, attribution, and provenance

CCB is distributed under CC-BY-SA 3.0 and compatible terms. Contributions are
provided under the repository license. Cite copied or adapted material and
verify that its license is compatible. Preserve original authorship and commit
history when porting from another project where practical. Otherwise record
the source repository, exact commit, contributors, license, and the reason
history could not be retained.

Do not submit copyrighted text, art, sound, code, or data without permission.
Links and AI output are not proof of license compatibility.

## Responsible human and AI-assisted work

AI-assisted contributions and bot-authored pull requests are allowed. Tool or
model disclosure is optional. Every pull request must name one **Responsible
human** who:

- understands the change and its compatibility impact;
- reviews the final diff, including generated files;
- owns every reported test result;
- verifies licenses, attribution, and external sources;
- answers review questions and follows the PR through merge or closure.

允许 AI 辅助及机器人创建 PR，不强制披露工具或模型。每个 PR 必须指定一名
真实的 Responsible human，负责理解修改、审查最终差异、确认测试、许可证和
外部来源，并回答审阅问题。

## Prepare a development environment

CCB supports several toolchains. Use the instructions matching your target:

- Linux and general C++: `doc/c++/COMPILING.md`
- CMake: `doc/c++/COMPILING-CMAKE.md`
- MSYS2: `doc/c++/COMPILING-MSYS.md`
- MSVC with vcpkg: `doc/c++/COMPILING-VS-VCPKG.md`
- Android: `android/` and `android/AGENTS.md`
- Repository routing and validation: `ai/project-map.yml` and `ai/test-matrix.yml`

Prefer the narrowest validation that proves your change. Platform dependencies
and expensive commands must be reported honestly; never claim a command passed
if it was not run.

### Fork, clone, and branch

Fork the CCB repository, not Cataclysm-DDA. Replace `YOUR_USERNAME` below:

```sh
git clone https://github.com/YOUR_USERNAME/Cataclysm-Cleanwater-Bomb.git
cd Cataclysm-Cleanwater-Bomb
git remote add upstream https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb.git
git fetch upstream --tags
git switch --create topic/short-description upstream/master
```

Keep one coherent change per branch. Do not develop directly on `master`.
Before requesting review, update from CCB `master` without rewriting commits
that preserve third-party authorship.

### Commits

- Make each commit buildable or otherwise independently understandable.
- Use an imperative subject that describes the change.
- Keep generated output in the same commit as the contract change that creates it.
- Preserve author information for upstream ports.
- Do not mix formatting, generated churn, or unrelated cleanup into a feature.
- Never commit build caches, credentials, SDK paths, APKs, or `obj-lua/`.

## Choose the correct contribution path

### C++

Read `src/AGENTS.md`, `doc/c++/CODE_STYLE.md`, and the relevant tests. Trace
ownership, serialization, registrations, and public names before editing.

Typical checks:

```sh
make astyle-check
make -j2 tests
./tests/cata_test "<focused test filter>"
```

Add a focused deterministic regression test. A successful compilation alone
does not prove behaviour.

### JSON content

Read `data/AGENTS.md` and the nearest mod instructions. Preserve stable IDs or
provide an explicit migration/obsolete entry. Build the formatter before using
it and validate actual loading:

```sh
make -j2 tools/format/json_formatter.cgi
tools/format/json_formatter.cgi path/to/changed.json
make -j2 json-check
```

Format only files you changed. Do not infer a field from prose when the loader,
factory, schema, validator, or tests say otherwise.

### EOC

Effects on Condition are JSON contracts. Identify every condition/effect,
talker, variable, context, nesting rule, and value type used by the change.
Validate formatting and the full JSON load. Add a focused test when a parser or
runtime edge case is involved.

```sh
make -j2 tools/format/json_formatter.cgi
make -j2 json-check
```

### Lua

All Lua code targets Platform v1, the repository's sole Lua runtime and public
authoring contract.  Read `data/lua/AGENTS.md`; treat the Platform LuaLS
declarations, native registrations, generated inventories, and tests as one
contract. Do not add legacy compatibility surfaces or authored manifests.

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_platform_native_inventory.py
python3 tools/lua_api/check_platform_contract.py
python3 tools/lua_api/check_platform_coverage.py
python3 tools/lua_api/check_cmake_contract.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

Never hand-edit generated API inventories. Regenerate them with the command in
`ai/generated-files.yml` and include the generated diff.

During the active Lua-first implementation sprint, do not run the C++ build,
Catch2, Python checkers, generators, public-contract refresh, ledger/registry
refresh, or full JSON/EOC audit. Write source and test changes first; run the
single routed acceptance gate only after the planned source batches are closed.

### Mods

Each bundled mod is a compatibility boundary. Read its `README`, `modinfo.json`,
dependencies, tests, and `data/mods/AGENTS.md`. Avoid undeclared cross-mod IDs
or load-order dependencies. Test the affected mod with the core JSON loader and
state which mod set was loaded.

### Android

Read `android/AGENTS.md`. Keep SDK locations, signing keys, local Gradle state,
and generated APKs out of Git. Start with unit tests:

```sh
cd android
./gradlew test
```

APK assembly additionally requires a configured Android SDK/NDK. Report the
variant and ABI used. Android uses SDL3; desktop Linux and Windows use SDL2
unless an authoritative build configuration says otherwise.

### Translation

CCB uses its own Transifex project configured in `.tx/config`. The commented
Cataclysm-DDA resources are not the CCB contribution target. Do not overwrite
translator attribution or edit generated MO files as source.

Useful local validation:

```sh
lang/update_pot.sh
msgfmt -c --statistics -o /dev/null lang/po/zh_CN.po
make -C lang LANGUAGES=zh_CN -B
```

Changes to extraction, templates, or workflow credentials require maintainer
review. Never commit a Transifex token.

### Tiles, fonts, and sound

Respect asset licenses and attribution. Keep source assets separate from
generated packages and do not re-encode unrelated assets. For a Linux SDL2
tiles and sound build, the repository-supported shape is:

```sh
make -j2 RELEASE=1 TILES=1 SOUND=1 SDL3=0
```

Tileset composition, shaders, fonts, and release packages have their own CI
contracts under `.github/workflows/` and `build-scripts/`. Use the relevant
workflow or narrow local check and record assets that were not exercised.

### Upstream ports

CCB selectively ports from Cataclysm-DDA, Cataclysm: Bright Nights, and other
compatible sources; it does not automatically adopt their policy or runtime
semantics. A port must record:

- source repository, PR, and exact commit range;
- original authors and license;
- CCB conflicts and intentional divergence;
- save, data-ID, mod, and platform compatibility impact;
- tests run against current CCB `master`.

Preserve source commits when practical. Do not silently replace a CCB-specific
behaviour with upstream behaviour.

## Testing and validation

Use `ai/test-matrix.yml` to select checks. Common entry points include:

```sh
# Agent metadata and documentation impact
python3 tools/agent/check_project_metadata.py
python3 -m unittest discover -s tools/agent -p 'test_*.py'

# Python maintenance tools
make python-check

# C++ and JSON
make astyle-check
make -j2 tests
make -j2 json-check

# Lua public contract
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_platform_native_inventory.py
python3 tools/lua_api/check_platform_contract.py
python3 tools/lua_api/check_platform_coverage.py
python3 tools/lua_api/check_cmake_contract.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

In the PR, list exact commands, platform/toolchain, result, skipped checks, and
why they were skipped. For gameplay or UI changes, include reproducible manual
steps. For performance changes, include before/after measurements and the
scenario used.

## Compatibility requirements

CCB avoids unnecessary breakage. Explicitly review:

- save serialization and migration;
- stable JSON IDs and obsolete/migration entries;
- bundled and third-party mod compatibility;
- Lua API version, capabilities, and deprecations;
- the single Platform v1 Lua runtime and its native service contract;
- desktop and Android differences;
- localization and translated strings;
- CCB divergence from upstream.

Breaking a public contract requires a migration or deprecation plan, tests,
release-note impact, and generated-reference updates. Do not hide a breaking
change in a cleanup PR.

## Pull requests

Open a Draft PR early for multi-commit work. Keep the template headings and
update the body when the diff changes. Resolve review conversations and keep
the branch scoped.

### Required Summary

The `Summary` is a one-line changelog entry:

```markdown
#### Summary
Category "short description"
```

Allowed categories are `Features`, `Content`, `Interface`, `Mods`, `Balance`,
`Bugfixes`, `Performance`, `Infrastructure`, `Build`, and `I18N`. Use `None`
for changes that should not enter the player changelog. See
`doc/CHANGELOG_GUIDELINES.md`.

### Documentation impact

Every PR must describe:

- documentation impact;
- related CCB-Docs PR, if any;
- affected stable documentation IDs;
- generated-reference impact.

Enforcement is path-scoped by `ai/docs-impact.yml`. Governance, build, and
ordinary JSON content mappings remain advisory. Changes to the public Lua
contract or the JSON/EOC registration and parsing contracts are required: the
four fields must contain a concrete impact statement, a CCB-Docs pull-request
link, at least one mapped stable document ID, and the generated-reference
result. Template placeholders such as `None`, `N/A`, and `TBD` do not satisfy a
required mapping. Unrelated paths are never made to fail merely because an API
subsystem has documentation work elsewhere.

A CCB-Docs PR may be prepared before the source PR merges, but must remain
Draft. After source merge, refresh its metadata to the final source commit,
regenerate derived files, rerun checks, and then request human review.

## Definition of Ready

A change is ready for implementation when:

- the problem and intended outcome are clear;
- authoritative source paths and existing tests are identified;
- scope excludes unrelated behaviour and cleanup;
- compatibility, license, provenance, and documentation risks are known;
- the narrowest validation commands are identified;
- a Responsible human is prepared to own the final result.

## Definition of Done

A contribution is done only when:

- the final diff is coherent and reviewed by the Responsible human;
- source, tests, schema, declarations, registrations, and generated files agree;
- applicable automated and manual checks pass and skipped checks are disclosed;
- compatibility and upstream-divergence impacts are addressed;
- licenses and attribution are verified;
- documentation-impact fields and dependent CCB-Docs work are current;
- no credentials, local paths, caches, or unrelated changes are included;
- review questions and conversations are resolved.

Questions that are not actionable issues belong in GitHub Discussions. Security
vulnerabilities must follow [SECURITY.md](SECURITY.md), not a public issue.
