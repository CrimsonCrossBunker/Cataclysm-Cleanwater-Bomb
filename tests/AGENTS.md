# `tests/` agent instructions

- Prefer a focused regression test that fails before the fix and passes after.
- Keep tests deterministic; print or record the RNG seed when randomness is
  relevant.
- Reuse test helpers and fixtures.  Keep branches that exist only for tests
  out of production code.
- Match the subsystem's ownership and cleanup patterns.

```sh
make -j2 tests
./tests/cata_test "<focused test filter>"
```

测试应能证明行为变化；仅覆盖新代码行不算证明。随机测试必须可复现。


# other notes

- Not all changes require testing, please do not add unnecessary testing for behaviors such as document updates or JSON data changes that have no intersection with the testing system before.
- It is generally recommended to use or incorporate dedicated test data from `TEST_DATA` when testing new features and systems, rather than directly using core or first party loadable mod data that may still be continuously adjusted. (Not an absolute requirement.)
- Scripts in `tests/` can't block releases or the final game; issues found there during code review should not be flagged as critical errors.
