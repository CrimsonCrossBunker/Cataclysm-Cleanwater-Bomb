local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario", whitelist = true }
filter:entry("fractal_facility")
content.replace(filter)
