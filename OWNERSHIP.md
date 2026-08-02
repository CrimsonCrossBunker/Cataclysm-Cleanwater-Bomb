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

## Confirmed Responsible-human reviewer

No reviewer is recorded here merely from commit activity or repository access.
CCB uses one named Responsible human for each PR.  The maintainer has decided
that one active, review-capable human is sufficient for the current project.
The Ruleset therefore must not require a non-author or last-push approval:
those gates would prevent the sole reviewer from merging a self-authored
maintenance PR.

| GitHub login | Permission verified | Willingness confirmed | Confirmed at | Scope |
| --- | --- | --- | --- | --- |
| @LYHGLYTX | 2026-08-02 | yes | 2026-08-02 | All repository changes, including self-authored changes |

The latest read-only permission audit was performed on 2026-08-02
(Asia/Shanghai).  Issue
[#563](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/issues/563)
originally tracked a two-reviewer prerequisite.  The explicit maintainer
decision at 2026-08-02T19:24:37+08:00 replaces it with the single
Responsible-human model above.  This records accountability, not a fabricated
GitHub approval.

## Quarterly permission review

At least once per quarter, a human maintainer must:

1. verify that every listed reviewer is a human, active, and still has review
   permission;
2. reconfirm willingness and the review scope, recording the evidence and
   audit date without publishing private organization data;
3. remove or replace stale entries and check the rotation/escalation path;
4. verify that automation cannot replace the named Responsible human or claim
   a GitHub approval it did not receive; and
5. update `ai/repository-settings.target.yml` only after the GitHub setting is
   observed, never in anticipation of an administrator action.

## Changing ownership records

An ownership update must cite the maintainer or team, permission check, explicit
agreement, scope, effective date, and replacement/rotation plan. Remove stale
entries after a quarterly permissions audit. Bots and AI systems cannot be the
Responsible human or approve their own changes.
