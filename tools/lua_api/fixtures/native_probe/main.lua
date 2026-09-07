local ccb = require("ccb")
local directory = assert(os.getenv("CCB_NATIVE_PROBE_DIR"),
    "set CCB_NATIVE_PROBE_DIR to the absolute directory containing the native probe")
package.cpath = directory .. "/?.so;" .. package.cpath
local probe = require("ccb_native_probe")
assert(probe.description == "CCB native Lua acceptance probe")
assert(probe.round_trip(42) == 42)
assert(probe.round_trip(-7) == -7)
assert(not pcall(probe.round_trip, "not an integer"))
assert(require("ccb_native_probe") == probe)
assert(require("ccb") == ccb)
