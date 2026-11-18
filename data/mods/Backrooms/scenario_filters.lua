local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario", whitelist = true }
filter:entry("backroom_dweller")
filter:entry("backroom_dweller_starternpc")
content.replace(filter)
