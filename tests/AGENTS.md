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
