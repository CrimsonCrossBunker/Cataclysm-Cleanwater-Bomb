local ccb = require("ccb")
local content = ccb.content

local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
definition:entry("mon_beaver_mutant_huge")
definition:entry("mon_beaver_mutant_avian")
definition:entry("mon_mutant_experimental")
definition:entry("mon_crow_mutant_small")
definition:entry("mon_zhark")
definition:entry("mon_ocean_zhark")
content.add(definition)
