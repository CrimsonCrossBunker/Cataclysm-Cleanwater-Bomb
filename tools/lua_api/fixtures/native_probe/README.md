# Optional native-module acceptance probe

This fixture is source only. It is not a bundled gameplay Mod, a shared-library
binary, or part of the normal Python tool test run. Integration acceptance results
and tested configurations are recorded in [PR #768](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/pull/768).

Use it to check the actual game executable's
exported Lua C ABI, rather than testing against the system `lua` executable.
The game must have been built with the trusted loader changes. Run the probe
with a disposable Mod/world and repeat through the supported Make and CMake
builds as appropriate.

Example preparation for Linux (commands are instructions, not recorded results):

```sh
mkdir -p /tmp/ccb-native-probe
cc -shared -fPIC -Isrc/lua \
  tools/lua_api/fixtures/native_probe/ccb_native_probe.c \
  -o /tmp/ccb-native-probe/ccb_native_probe.so
```

Copy this directory's `main.lua` and the compiled probe to an otherwise empty
optional Lua Mod root. The loader prepends that root's `?.so` (`?.dll` on Windows)
to the ordinary native search path. Alternatively, keep the probe externally and
set `CCB_NATIVE_PROBE_DIR=/tmp/ccb-native-probe` when launching the actual game.
Select/load that Mod. The script changes only its state's package search
path and checks native module loading/cache, integer round trips, native
argument-error handling and stable `require("ccb")` identity. It should produce
no gameplay effects and no error; absence of errors must be checked against the
actual Mod load result, not assumed from a successful compiler invocation.

On macOS, the equivalent fixture link needs `-undefined dynamic_lookup`; verify
the real game binary exports the Lua API. Android needs an ABI-matched shared
object and an OS-permitted library location. Windows public Lua functions are marked for export by the build configuration.
Import-library/runtime packaging still needs separate acceptance; the `.so` recipe above is not a Windows
recipe. Do not link a second Lua runtime into this fixture: it must exercise the
host's Lua state and C API. This does not expose or stabilize CCB's internal C++
objects.

Lua's cpath grammar cannot escape literal `;` or `?` in directory names. The
automatic local prefix is omitted for such roots; explicit `package.loadlib`
paths and the original external searchers remain available. A path-resolution
regression uses a placeholder library, which is not native loading evidence.

A dedicated hidden Catch2 case exercises this fixture through the real Platform
loader in the native test executable. Compile the shared object as above and
copy this directory's `main.lua` beside it, then run:

```sh
CCB_NATIVE_PROBE_DIR=/tmp/ccb-native-probe ./tests/cata_test \
  lua_platform_native_module_uses_host_lua_abi --rng-seed 20260908
```

This explicit test requires the prepared directory; it does not silently skip a
missing probe. The ordinary Platform suite does not require a compiled external
module. The fixture links against the host Lua ABI, never a second Lua runtime.
