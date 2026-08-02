# Reporting issues to CCB

GitHub Issues track reproducible defects and actionable project work for
Cataclysm: Cleanwater Bomb (CCB). Use the structured form that best matches the
request. A clear report is easier to reproduce, classify, and review.

CCB 的 GitHub Issues 用于跟踪可复现缺陷和可执行工作。请选择最接近问题类型的
结构化表单，并提供维护者能够复核的证据。

## Before opening an issue

1. Search open and closed CCB issues for the same behaviour.
2. Reproduce on a current CCB experimental build or identify the exact commit.
3. Reduce the mod list and determine whether the issue requires a third-party mod.
4. Collect exact steps, expected result, actual result, platform, logs, and save data.
5. Remove secrets and personal information before attaching files.

Do not report a CCB problem only to Cataclysm-DDA. CCB has different runtime
behaviour, data, Lua APIs, releases, and compatibility policy.

## Choose a form

| Form | Use it for |
| --- | --- |
| Bug report | Reproducible crashes, incorrect behaviour, regressions, or UI defects |
| Feature proposal | A concrete user problem and implementable outcome |
| Mechanics and balance | Gameplay rules, realism, difficulty, fairness, or tuning with evidence |
| JSON content | Data IDs, recipes, items, monsters, maps, EOCs, or bundled-mod content |
| Performance | Measured speed, memory, loading, rendering, or responsiveness regressions |
| Documentation | Incorrect, missing, stale, untranslated, or inaccessible documentation |
| Upstream sync | A specific port from another repository or an upstream conflict |

Build questions, general help, and early ideas belong in
[GitHub Discussions](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/discussions).
See [SUPPORT.md](SUPPORT.md) for other support channels.

Security vulnerabilities must be reported privately according to
[SECURITY.md](SECURITY.md). Do not publish exploit details, credentials, or
private player data in a normal issue.

## Evidence expected by type

### Bugs and crashes

- exact CCB version or commit;
- OS, architecture, terminal/tiles build, and SDL backend where relevant;
- smallest reproducible mod list;
- numbered reproduction steps;
- expected and actual behaviour;
- `debug.log`, `crash.log`, screenshots, and a minimal save when useful.

Make a copy of a save before reducing or modifying it. Attachments are public;
remove usernames, access tokens, private chat, and unrelated personal data.

### Mechanics and balance

Describe the current rule, the player-visible problem, the proposed goal, and
trade-offs. Provide primary or technically credible sources when making a
realism claim. Explain compatibility and migration impact instead of proposing
an unexplained numeric change.

### JSON, EOC, and mods

Name the object type, stable ID, source file, active mod list, and validation
already run. For EOCs, identify relevant talkers, variables, conditions, and
effects. Include a minimal data example when possible.

### Performance

Provide before/after numbers on the same hardware and scenario. State the
measurement tool, build flags, save/mod set, sample duration, and whether the
result is CPU, GPU, memory, I/O, loading, or latency related.

### Documentation

Give the URL or repository path, language, incorrect statement, expected
replacement, and authoritative source path if known. A source-linked CCB-Docs
page that conflicts with code should be marked stale while corrected.

### Upstream sync

Provide the source repository, PR and exact commit range, authors, license,
CCB conflict analysis, compatibility impact, and tests against current CCB
`master`. A useful upstream change is not automatically suitable for CCB.

## Triage and resolution

Maintainers use labels to describe type, subsystem, confirmation, and status.
Labels do not establish ownership or promise a schedule. See [LABELS.md](LABELS.md).

An issue may be closed when it is fixed, duplicated, not reproducible after a
reasonable request for information, outside CCB scope, superseded, or rejected
with a recorded reason. Reopening should include new evidence. A bounty does
not guarantee acceptance and does not override review, compatibility, or
license requirements.

If you intend to implement an issue, comment with the intended scope and open a
Draft PR. Do not wait for assignment unless a maintainer says coordination is
required.
