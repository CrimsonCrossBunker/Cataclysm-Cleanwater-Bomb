<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `cpp-performance`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/cpp/performance/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/cpp/performance/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
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

Configuration checks that enabled scopes, frame markers, and plots compile and
link against the selected client. A library built with `TRACY_ENABLE=OFF` is
rejected before the game build starts. Use matching headers and an enabled
client; for a separate Linux static client build from a Tracy checkout:

```sh
cmake -S /path/to/tracy -B /path/to/tracy-client \
    -DCMAKE_BUILD_TYPE=Release -DTRACY_ENABLE=ON -DTRACY_STATIC=ON
cmake --build /path/to/tracy-client --target TracyClient --parallel 2
cmake -S . -B build-tracy -DTRACY=ON \
    -DTRACY_INCLUDE_DIR=/path/to/tracy/public \
    -DTRACY_LIBRARY=/path/to/tracy-client/libTracyClient.a
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
