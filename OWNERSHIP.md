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

The latest read-only audit was performed on 2026-08-02 (Asia/Shanghai).  Issue
[#563](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/issues/563)
had no comments at that time, so the confirmed reviewer count remains 0/2.
Repository access, commit activity, or an assumed maintainer role is not
evidence of willingness to provide continuing review.

## Quarterly permission review

At least once per quarter, a human maintainer must:

1. verify that every listed reviewer is a human, active, and still has review
   permission;
2. reconfirm willingness and the review scope, recording the evidence and
   audit date without publishing private organization data;
3. remove or replace stale entries and check the rotation/escalation path;
4. verify that bots and PR authors cannot satisfy the non-author human approval
   requirement; and
5. update `ai/repository-settings.target.yml` only after the GitHub setting is
   observed, never in anticipation of an administrator action.

## Changing ownership records

An ownership update must cite the maintainer or team, permission check, explicit
agreement, scope, effective date, and replacement/rotation plan. Remove stale
entries after a quarterly permissions audit. Bots and AI systems cannot satisfy
the human-reviewer requirement or approve their own changes.
