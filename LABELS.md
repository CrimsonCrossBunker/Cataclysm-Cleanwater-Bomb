# Issue and pull-request labels

GitHub repository labels are the live source of truth. This page documents how
to apply the existing vocabulary; it does not create ownership or workflow
state merely by naming a label.

## Type labels

| Label | Meaning |
| --- | --- |
| `bug` / `<Bugfix>` | Reproducible defect or its fix |
| `enhancement` / `<Enhancement / Feature>` | New or improved behaviour |
| `documentation` / `<Documentation>` | Documentation work |
| `question` | More suitable for support or clarification |
| `dependencies` | Automated or manual dependency update |
| `github_actions` | GitHub Actions dependency or workflow update |

## Technology and subsystem labels

Use the narrowest existing label, including `[C++]`, `[JSON]`, `[Lua]`,
`[Python]`, `EOC: Effects On Condition`, `Code: Tests`, `Code: Build`,
`Code: Performance`, `Code: Tooling`, `Translation`, `SDL: Tiles / Sound`,
and the existing gameplay/content labels. A label describes affected scope; it
does not replace a clear issue title or PR summary.

## Triage labels

| Label | Meaning |
| --- | --- |
| `duplicate` | Already tracked elsewhere; link the canonical item |
| `invalid` | Cannot be acted on in its current form or is outside scope |
| `wontfix` | Deliberate decision not to implement; record the reason |
| `help wanted` | Maintainers welcome a contributor |
| `good first issue` | Scoped and documented for a new contributor |
| `stale` | Needs renewed evidence or maintenance attention |
| `<DO NOT MERGE>` | Explicit merge blocker; explain removal criteria |

Do not create near-duplicate labels without first reconciling existing names.
Quarterly maintenance should detect unused, ambiguous, and duplicate labels and
propose changes for human review.
