# Performance measurement

Performance measurements have two entry points.  Do not add ad-hoc
`std::chrono`/`printf` benchmarks or use profiler-vendor macros directly.

## Microbenchmarks

Keep a microbenchmark in the test file for the subsystem it exercises, but
declare it with `BENCHMARK_TEST_CASE` and measure operations with Catch2's
`BENCHMARK` or `BENCHMARK_ADVANCED` macros.  `BENCHMARK_TEST_CASE` adds the
hidden `[.]` and `[benchmark]` tags consistently, so benchmarks do not slow the
default correctness suite and all of them can be run through one filter:

```sh
tests/cata_test '[benchmark]'
```

Add a subsystem tag to support focused runs:

```cpp
BENCHMARK_TEST_CASE( "route_benchmark", "[pathfinding]" )
{
    BENCHMARK( "route" ) {
        return here.route( from, target, settings, avoid );
    };
}
```

Run one subsystem with both tags:

```sh
tests/cata_test '[benchmark][pathfinding]'
```

Keep correctness assertions outside the measured expression whenever possible.
Use `BENCHMARK_ADVANCED` when each sample needs unmeasured setup or teardown.

## Runtime profiling

Runtime profiling is exposed only through `src/profiling.h`:

```cpp
#include "profiling.h"

void expensive_function()
{
    CATA_PROFILE_SCOPE();
    // ...
}
```

Available entry points are `CATA_PROFILE_SCOPE`,
`CATA_PROFILE_SCOPE_NAMED`, `CATA_PROFILE_TEXT`, `CATA_PROFILE_LITERAL`,
`CATA_PROFILE_FRAME`, `CATA_PROFILE_FRAME_NAMED`, and `CATA_PROFILE_PLOT`.
They currently forward to Tracy when configured with `-DTRACY=ON` and compile
to no-ops otherwise.  Game code must not use `ZoneScoped`, `FrameMark`, or other
Tracy macros directly; this keeps profiler selection and disabled-build
behavior centralized.

Build a profiled executable with an installed Tracy client library:

```sh
# Arch Linux
sudo pacman -S tracy

cmake -S . -B build-tracy -DTRACY=ON
cmake --build build-tracy -j
```

## Diagnostic timings

Thresholded timings that explain a live failure, such as multiplayer wait
phases or a slow monster/NPC, may remain near the code that owns the diagnostic
log.  They are operational telemetry rather than repeatable benchmarks.  Give
them a stable log prefix, use `std::chrono::steady_clock`, and document the
threshold beside the measurement.

The debug-menu draw benchmark and hour timer are interactive diagnostics and
follow the same exception.  New repeatable comparisons belong in the Catch2
microbenchmark suite instead.
