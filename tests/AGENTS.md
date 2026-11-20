# `tests/` agent instructions

Applies only when editing `tests/` or when tests are explicitly requested.

- Tests should prove behavior change (not just line coverage); keep RNG tests reproducible.
- Skip unnecessary tests for doc/JSON-only edits; prefer `TEST_DATA` over unstable core/mod data when testing new features.
- Keep tests deterministic, reuse existing helpers/fixtures, match subsystem ownership/cleanup patterns, and keep test-only branches out of production code.
