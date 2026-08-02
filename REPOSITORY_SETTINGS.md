# Repository settings and administrator operations

Tracked files describe auditable targets; GitHub is the source of truth for
settings actually applied.  Merging this file, a workflow, or
`ai/repository-settings.target.yml` does not change a repository or
organization setting.

## Read-only audit snapshot

Observed by `LYHGLYTX` at 2026-08-02 02:52:24+08:00 for
`CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb`:

| Setting | Observed state |
| --- | --- |
| Default branch | `master` |
| Repository rulesets | none (`[]`) |
| Branch protection | not present |
| Default `GITHUB_TOKEN` permission | read |
| Actions may approve PR reviews | false |
| Auto-merge | false |
| Secret scanning | enabled |
| Secret-scanning push protection | enabled |
| Dependabot security updates | enabled |
| Vulnerability alerts API | HTTP 204 (enabled) |
| Automated security fixes | enabled |
| Organization 2FA requirement | false |
| Confirmed Responsible-human reviewers | 1/1 (`LYHGLYTX`) |

Issue
[#563](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/issues/563)
was resolved by the maintainer's 2026-08-02 decision that one Responsible human
is sufficient.  The target deliberately requires zero GitHub approving reviews
so self-authored maintenance is not locked.
Issue
[#564](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/issues/564)
tracks the member audit and notice required before an organization 2FA rollout.
Candidate check names have only PR-branch evidence in
[#568](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/pull/568)
and
[#569](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/pull/569);
they have not yet demonstrated stable success on the default branch.

The exact evidence and disabled target payload live in
`ai/repository-settings.target.yml`.  Its schema and offline consistency checks
prevent an unresolved target from being represented as active.

## Current activation blockers

The `master` ruleset must remain disabled until all of these are resolved:

- `Agent context and documentation impact` and `Lua public contract` have
  stable successful runs on `master`; and
- a real emergency bypass actor and escalation owner are selected and tested.

Organization 2FA is a separate rollout.  Issue #564 requires an organization
member and outside-collaborator audit, advance notice, recovery coverage, and a
named owner before enforcement.  It is not a substitute for any Ruleset
prerequisite, and a repository commit cannot safely perform that
organization-wide action.

## Intended `master` protections

Once the blockers are resolved, the target requires:

- pull requests for changes;
- one named Responsible human for review accountability, without a GitHub
  approval-count or last-push-approval gate;
- review conversations resolved;
- stable named status checks, using strict up-to-date branch validation;
- force pushes and branch deletion prohibited; and
- an emergency-only bypass whose real actor and reason are recorded.

No `CODEOWNERS` file is created until real maintainers or GitHub teams accept
durable path ownership.  Bots must not approve their own changes, and auto-merge
remains disabled.

## Safe activation order (administrator only)

1. Merge the workflows and observe the intended check names succeeding on
   `master` repeatedly.
2. Verify that `LYHGLYTX` remains an active, review-capable Responsible human
   and that the pull-request rule still requires zero approving reviews.
3. Select a real emergency bypass actor and escalation owner; do not invent an
   actor ID in tracked configuration.
4. Generate the disabled Ruleset payload locally and compare it with the target.
5. Create the Ruleset as disabled, inspect it in GitHub, then activate it only
   after every prerequisite is recorded.
6. Test an ordinary Draft PR and the emergency path without fabricating an
   approval or using automatic merge.
7. Record the Ruleset ID, exact check names, reviewers, bypass actors, operator,
   timestamp, and bypass-test time in `ai/repository-settings.target.yml`.
8. For organization 2FA, separately complete the member audit and notice from
   issue #564 before an organization owner enables it.

These are administrator operations.  A normal code PR cannot truthfully mark
them complete.

## Actions and automation policy

- Repository default `GITHUB_TOKEN` permissions stay read-only.
- A job requests only the write scope required for that job.
- Actions-created maintenance PRs, if enabled later, use fixed-scope branches,
  a no-empty-PR guard, and human review; this never permits bot self-approval.
- Third-party Actions are pinned to full commit SHAs.
- Scheduled jobs provide `workflow_dispatch`, timeout, concurrency,
  rate-limit handling, Issue deduplication, and no-empty-PR behavior.
- Dependabot checks GitHub Actions weekly using `.github/dependabot.yml`.

## Offline validation

Run the checks without changing GitHub:

```sh
python3 tools/agent/audit_repository_governance.py --check
python3 tools/agent/audit_repository_governance.py --ruleset-json
python3 tools/agent/audit_repository_governance.py \
  --as-of 2026-08-02 --max-age-days 92
python3 tools/agent/check_project_metadata.py
```

The freshness limit is opt-in so an old audit cannot fail every unrelated PR.
A quarterly audit should use `--max-age-days 92`, update only facts actually
observed, and leave the Ruleset disabled whenever a gate remains open.

## Live read-only verification

An authenticated administrator can refresh the evidence with:

```sh
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/rulesets
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/actions/permissions/workflow
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/vulnerability-alerts --include
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/automated-security-fixes
gh api orgs/CrimsonCrossBunker
```

Do not paste tokens, private membership, or other private organization data
into tracked files, issues, PRs, or workflow logs.
