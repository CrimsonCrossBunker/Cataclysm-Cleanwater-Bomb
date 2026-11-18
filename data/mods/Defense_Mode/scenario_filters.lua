local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario", whitelist = true }
filter:entry("defense_mode_fortified")
content.replace(filter)
