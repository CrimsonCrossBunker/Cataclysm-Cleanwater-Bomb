local ccb = require("ccb")
local content = ccb.content

-- edited from no_wildlife
local definition = content.Blacklist {
    kind = "monster",
    whitelist = true,
    exclusive = true,
}
definition:category("WILDLIFE")
definition:category("MUTANT")
definition:species("MOXIE")
definition:species("ROBOT")
content.add(definition)
