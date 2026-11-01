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
cmake --build out/replay-protocol --parallel 2
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
seconds. Native report v2 also records calendar advancement and the absolute
player position after each completed call, excluding the final save call. This
distinguishes a real out-and-back route from waiting or hitting an obstacle even
when both end at the starting position. Recording happens outside the measured
`do_turn` interval; whole-process measurements still include that reporting cost.
An exhausted log inside a menu, missing report, failed save, or unexpected
number of completed calls fails acceptance. Failed runs retain their logs and
save copies. Success requires changed player saves and matching full save bytes;
v2 comparisons additionally require identical trajectories. The reader still
accepts v1 reports as evidence without intermediate positions, but comparisons
reject mixed versions instead of silently dropping the trace. Neither version
establishes visual parity, complete semantic equivalence or a speedup.
Startup/save wall times and replay turn timings are diagnostic measurements;
hotspot attribution still uses the engine's `CATA_PROFILE_*` instrumentation.

## Bounded compute resources

The same standalone build also tests the production executor and retained-byte
allocator, without loading game data. It covers saturated queues, synchronous
nested dispatch, range exceptions, draining at teardown, allocation overflow,
failed construction, retained capacity and concurrent reservations. Only the
game-options facade is bound to a fixed test executor. Game worker initialization
(crash handlers and legacy thread-local RNG) is in `src/thread_pool_game.cpp` and
is covered by full-engine tests, not the standalone target.

AI, vision and tile preparation share one executor, retaining their per-domain
admission and worker-count limits. With the legacy generic switch disabled the
shared executor has four workers; when enabled its existing worker setting sets
the common capacity. The queue holds at most 64 pending tasks; a full queue and
nested submissions execute synchronously without holding the queue lock.

These domains share a 64 MiB allocation budget for retained snapshots, outputs
and their dynamic buffers. Old and replacement allocations count together during
growth. Exhaustion uses the owner's existing serial fallback. This is not a cap
on authoritative world data, GPU textures or prefetch I/O. Pool shutdown and
per-domain barriers must complete before captured data is destroyed. On Unix,
`ai_reachability_fault_test` also injects failures into lazy pool creation,
snapshot/output allocation and partial task submission, then checks recovery
against the serial kernel with an executor that outlives each frame.

## Bounded map prefetch I/O

The prefetch service uses one separate blocking I/O worker, up to 128 pending or
ready entries and a shared 32 MiB allowance. Queue/result nodes, decoded buffers,
their ownership blocks and private ZSTD allocations count against that allowance.
At most two archive mappings and one private decoder are retained; a save pause
releases them and invalidates ready bytes before the owner writes map data.
Path storage, stream internals and mapped archive pages are not fully covered by
the byte allowance, so this is not a bound on total process RSS.

Workers publish immutable owned bytes. Parsing and map mutation remain on the
owner thread; parser diagnostics retain the source without an extra normal-path
copy. Cancelled request tickets cannot complete a newer request for the same
quad. Admission, reading, decoding and publication failures become cache misses
and use the existing synchronous load path.

Select `submap_prefetch_test.cpp;zzip_test.cpp;compute_resources_test.cpp` in the
focused engine build below, then run `[prefetch],[zzip],[compute_resources]`.
These tests use real temporary plain files and compressed archives, including
quota pressure, publication failure, cancel/reissue, nested save pauses and
clear/restart. They supplement full-game movement and save/reload acceptance;
they do not establish exploration speed or long-session memory behavior.

## Focused tests with the complete engine

When a regression needs game data or world state, select its test translation
units in an existing compatible CMake build instead of compiling every test:

```sh
cmake -S . -B out/game -DTESTS=ON -DBUILD_TESTING=ON \
  -DCATA_TEST_SUITE=focused \
  '-DCATA_TEST_FILES=recipe_serialization_test.cpp'
cmake --build out/game --target cata_test-tiles --parallel 2
./out/game/tests/cata_test-tiles '[recipe][save]' --rng-seed 20261101 \
  --warn NoTests --user-dir=/tmp/ccb-recipe-test
```

Keep the existing compiler, SDL, Lua, optimization and profiling settings.
This reuses the complete engine objects and includes the normal native test
runner/support sources. It is not a stubbed engine or the standalone protocol
test above. Separate multiple filenames with semicolons; absolute paths,
subdirectories and missing files are rejected. The Catch filter limits execution,
while `CATA_TEST_FILES` limits compilation. Both limits must cover the change.

The default `CATA_TEST_SUITE=all` and the existing `lua` suite are unchanged.
Switch back to `all` before claiming full-suite coverage. A focused suite does
not register the broad hosted test batches.
