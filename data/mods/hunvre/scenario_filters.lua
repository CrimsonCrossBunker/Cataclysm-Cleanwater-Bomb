local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario", whitelist = true }
filter:entry("awakened")
content.replace(filter)
