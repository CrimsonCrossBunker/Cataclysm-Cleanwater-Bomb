local ccb = require("ccb")
local content = ccb.content

local definition = content.Blacklist {
    kind = "monster",
    whitelist = true,
    exclusive = true,
}
definition:species("EUZHVIL")
content.add(definition)

require("flags")

require("vitamins")
