local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario", whitelist = true }
filter:entry("evacuee")
filter:entry("scavenger")
filter:entry("survivor")
content.replace(filter)
