# Repository settings and administrator operations

Tracked configuration describes intended settings; GitHub itself is the source
of truth for settings actually applied. `ai/repository-settings.target.yml`
must record the date and operator after each administrator change.

## Safe activation order

1. Merge and observe the relevant CI on the default branch.
2. Confirm stable required-check names and successful default-branch runs.
3. Confirm at least two active human maintainers with review permission and
   explicit willingness to review; record them in `OWNERSHIP.md`.
4. Create the ruleset with force-push/deletion protection and conversation
   resolution. Add non-author approval only after step 3.
5. Test an ordinary Draft PR and an administrator emergency path.
6. Record the applied settings, operator, time, and bypass rationale.

## Target protections

- changes arrive through pull requests;
- one non-author human approval after the reviewer prerequisite is satisfied;
- stale approvals are dismissed and conversations resolved;
- stable status checks are required;
- force pushes and branch deletion are prohibited;
- emergency bypass is limited, intentional, and records a reason;
- bots cannot approve their own pull requests and no PR is automatically merged.

The candidate check names introduced by the staged documentation work are
`Agent context and documentation impact` and `Lua public contract`.  They are
only candidates until each has a stable successful run on `master`; merging a
workflow does not add either name to a ruleset.  JSON/EOC contract validation
currently runs inside `Agent context and documentation impact`.  The Lua
workflow starts for every pull request so its named check exists; its expensive
validation job is path-scoped and is skipped successfully for unrelated work.

As observed on 2026-08-02, `master` has no branch protection and the repository
has no Ruleset.  This is deliberate while issue #563 has no two maintainers who
both have review permission and explicitly accept ongoing review.  Do not turn
the candidate checks into required checks, or enable the approval rule, merely
because this target file merges.

## Actions and automation

- Default `GITHUB_TOKEN` permissions remain read-only.
- Each workflow requests only the write scopes needed by that job.
- Enabling Actions-created PRs is for fixed-scope maintenance branches; it does
  not authorize bot approval or auto-merge.
- Pin third-party Actions to full commit SHAs.
- Scheduled jobs need `workflow_dispatch`, timeouts, concurrency, rate-limit
  handling, Issue deduplication, and a no-empty-PR guard.

## Security settings

Private vulnerability reporting is the reporting path.  On 2026-08-02 the
repository API reported secret scanning, push protection, and Dependabot
security updates enabled.  The Actions token default was read-only, Actions Bot
approval was disabled, and auto-merge was disabled.  These observations are
recorded in `ai/repository-settings.target.yml`; GitHub remains authoritative.

Organization 2FA is not enabled.  Issue #564 requires an organization member
and outside-collaborator audit, advance notice, recovery coverage, and a named
owner before enforcement.  A repository commit cannot safely perform that
organization-wide action.

## Manual verification commands

Administrators can inspect current state with authenticated GitHub tooling:

```sh
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/rulesets
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/actions/permissions/workflow
gh api repos/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb
```

Do not paste tokens or private organization data into issues or PR logs.
