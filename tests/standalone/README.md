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
