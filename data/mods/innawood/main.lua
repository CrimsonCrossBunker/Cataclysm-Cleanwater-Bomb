local ccb = require("ccb")
local content = ccb.content

local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
definition:category("MAN_MADE")
content.add(definition)

require("requirements")

require("portal_storm_scenario")

require("portal_storm_strength")

require("xp_progression")
