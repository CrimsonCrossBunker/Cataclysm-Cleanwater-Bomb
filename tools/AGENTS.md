# `tools/` agent instructions

- Preserve stable CLI behavior for developer tools or document intentional changes.
- Prefer standard-library Python where practical and pin any added dependency.
- Generators must support a non-mutating `--check` mode for CI.
- Never traverse ignored build caches; use tracked-file lists for inventory jobs.
