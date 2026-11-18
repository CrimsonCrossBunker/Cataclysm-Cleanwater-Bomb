local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario", whitelist = true }
filter:entry("escape_pod")
filter:entry("crashing_ship")
filter:entry("augustmoon")
filter:entry("ship")
filter:entry("last_dance")
filter:entry("afs_esper_start")
content.replace(filter)
