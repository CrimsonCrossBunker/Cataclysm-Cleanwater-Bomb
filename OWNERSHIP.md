# Ownership and review

This file describes responsibility without inventing file owners or GitHub
teams. CCB does not currently publish a `CODEOWNERS` file. Add one only after
real maintainers and teams explicitly accept durable path ownership.

## Authority and responsibility

- Repository source and tests own runtime behaviour.
- Schemas, LuaLS declarations, registrations, and generated inventories own
  JSON/Lua/API contracts.
- CI, CMake, Makefile, Gradle, and validators own build behaviour.
- `AGENTS.md`, `CONTRIBUTING.md`, and `GOVERNANCE.md` own contribution policy.
- CCB-Docs owns tutorials, explanations, architecture prose, and navigation,
  but never overrides a repository contract.

Every PR names a Responsible human. That role is accountability for the
specific change, not permanent subsystem ownership.

## Review roles

| Role | Responsibility |
| --- | --- |
| Responsible human | Understands final diff, owns tests/provenance, answers review |
| Subsystem reviewer | Checks domain correctness, compatibility, and focused tests |
| Documentation reviewer | Checks source linkage, bilingual parity, metadata, and navigation |
| Release/security maintainer | Reviews privileged workflows, credentials, advisories, and releases |

## Confirmed non-author reviewers

No reviewer is recorded here merely from commit activity or repository access.
Before requiring a non-author approval, record at least two active human
maintainers who have review permission and have explicitly agreed to provide
ongoing review.

| GitHub login | Permission verified | Willingness confirmed | Confirmed at | Scope |
| --- | --- | --- | --- | --- |
| _none recorded_ | — | — | — | — |

Until this table contains two qualified humans, approval protection remains a
documented target rather than an active rule that could lock the repository.
The ongoing-review confirmation is tracked in
https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/issues/563.
Repository permission or recent activity alone is not treated as consent.

## Changing ownership records

An ownership update must cite the maintainer or team, permission check, explicit
agreement, scope, effective date, and replacement/rotation plan. Remove stale
entries after a quarterly permissions audit. Bots and AI systems cannot satisfy
the human-reviewer requirement or approve their own changes.
