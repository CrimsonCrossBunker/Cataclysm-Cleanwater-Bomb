local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario" }
filter:entry("dimension_lost_fifth_sun")
content.replace(filter)
