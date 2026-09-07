local ccb = require("ccb")
-- Without an override, require uses the native library beside this main.lua.
local directory = os.getenv("CCB_NATIVE_PROBE_DIR")
if directory then
    local extension = package.config:sub(1, 1) == "\\" and ".dll" or ".so"
    package.cpath = directory .. "/?" .. extension .. ";" .. package.cpath
end
local probe = require("ccb_native_probe")
assert(probe.description == "CCB native Lua acceptance probe")
assert(probe.round_trip(42) == 42)
assert(probe.round_trip(-7) == -7)
assert(not pcall(probe.round_trip, "not an integer"))
assert(require("ccb_native_probe") == probe)
assert(require("ccb") == ccb)
