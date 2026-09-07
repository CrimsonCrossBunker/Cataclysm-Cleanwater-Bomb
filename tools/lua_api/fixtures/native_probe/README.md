# Optional native-module acceptance probe

This fixture is source only. It is not a bundled gameplay Mod, a shared-library
binary, or part of the normal Python tool test run. It has not been compiled or
run as part of the overnight implementation work.

After native builds are permitted, use it to check the actual game executable's
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

Copy this directory's `main.lua` to an otherwise empty optional Lua Mod root.
Set `CCB_NATIVE_PROBE_DIR=/tmp/ccb-native-probe` when launching the actual game,
then select/load that Mod. The script changes only its state's package search
path and checks native module loading/cache, integer round trips, native
argument-error handling and stable `require("ccb")` identity. It should produce
no gameplay effects and no error; absence of errors must be checked against the
actual Mod load result, not assumed from a successful compiler invocation.

On macOS, the equivalent fixture link needs `-undefined dynamic_lookup`; verify
the real game binary exports the Lua API. Android needs an ABI-matched shared
object and an OS-permitted library location. Windows import-library/runtime
packaging needs separate acceptance; the `.so` recipe above is not a Windows
recipe. Do not link a second Lua runtime into this fixture: it must exercise the
host's Lua state and C API. This does not expose or stabilize CCB's internal C++
objects.
