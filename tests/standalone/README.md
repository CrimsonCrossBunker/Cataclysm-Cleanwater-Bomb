# Draw-cache row allocation failures

This isolated executable overrides allocation only around row append. It links
actual production row and string-ID code, warms fixture initialization first,
and checks entry/index growth failures, rollback, reuse, relocation and clear.
It is outside the normal `tests/*.cpp` source globs because it owns `main` and
an allocation override. It does not test complete map/renderer recovery.

From the repository root, keep assertions enabled (do not add `-DNDEBUG`):

```sh
clang++ -std=c++17 -DTILES -DRELEASE -Isrc -isystem src/third-party -O2 -g1 \
  tests/standalone/draw_cache_row_fault_test.cpp src/string_id.cpp \
  -o /tmp/ccb-draw-row-fault
/tmp/ccb-draw-row-fault
```

For scoped ASan/UBSan/LSan, add `-fsanitize=address,undefined
-fno-omit-frame-pointer` and run with `ASAN_OPTIONS=detect_leaks=1:halt_on_error=1`
and `UBSAN_OPTIONS=halt_on_error=1:print_stacktrace=1`.

## Owned layer capture reuse

`tile_layer_reuse_test.cpp` checks the actual production view with strings
larger than SSO. It compares 1,000 fresh constructions with 1,000 warmed
assignments, checks every semantic field and verifies retained copies remain
independent. This is an allocation test, not a game-performance measurement.
It owns `main` and its allocator override, so it also stays outside test globs.

```sh
clang++ -std=c++17 -DTILES -DRELEASE -Isrc -isystem src/third-party -O2 -g1 \
  tests/standalone/tile_layer_reuse_test.cpp -o /tmp/ccb-layer-reuse
/tmp/ccb-layer-reuse
```

## Input replay protocol

The CMake target below links `src/input_replay.cpp` and cached options directly,
without game-code stubs, engine initialization or a full game build. It checks
record/replay round trips, malformed input, transactional loading and exhaustion
inside a nested input loop. Checks remain enabled in Release builds.

```sh
cmake -S tests/standalone -B out/replay-protocol -DCMAKE_BUILD_TYPE=Release
cmake --build out/replay-protocol --target input_replay_test --parallel 2
ctest --test-dir out/replay-protocol --output-on-failure
python3 tools/test_replay_ab.py
```

Reuse this build directory for incremental checks. The workflow
`.github/workflows/replay-validation.yml` runs the protocol with ASan/UBSan and
the Python comparison regressions; it does not build or play the full game.

Full-game acceptance is separate. Given an owned copy of a starting user
directory and a recording that reaches a completed turn boundary:

```sh
python3 tools/replay_ab.py --bin /build/base/cataclysm-tiles \
  --candidate-bin /build/new/cataclysm-tiles --runtime-dir /checkout \
  --userdir-template /fixtures/user --replay /fixtures/carrier.replay \
  --world Damon --expected-turns 32 --report /results/comparison.json
```

`--expected-turns` counts completed `game::do_turn()` calls, not keys or calendar
seconds. The native report also records calendar advancement and positions.
An exhausted log inside a menu, missing report, failed save, or unexpected
number of completed calls fails acceptance. Failed runs retain their logs and
save copies. Success requires changed player saves and matching full save bytes;
it does not establish visual parity, complete semantic equivalence or a speedup.
Startup/save wall times and replay turn timings are diagnostic measurements;
hotspot attribution still uses the engine's `CATA_PROFILE_*` instrumentation.
