# `tests/` agent instructions

- Prefer a focused regression test that fails before the fix and passes after.
- Keep tests deterministic; print or record the RNG seed when randomness is
  relevant.
- Reuse test helpers and fixtures instead of introducing production-only test
  branches.
- Match the subsystem's ownership and cleanup patterns.

```sh
make -j2 tests
./tests/cata_test "<focused test filter>"
```

测试应能证明行为变化，而不只是覆盖新代码行；随机测试必须可复现。
