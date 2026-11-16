local ccb = require("ccb")

local wildlife = ccb.content.Blacklist {
    kind = "monster",
    whitelist = true,
    exclusive = true,
}
wildlife:category("WILDLIFE")
ccb.content.add(wildlife)
