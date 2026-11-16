local ccb = require("ccb")
local content = ccb.content

local definition = content.Blacklist {
    kind = "monster",
    whitelist = true,
    exclusive = true,
}
definition:category("CLASSIC")
definition:category("WILDLIFE")
content.add(definition)
