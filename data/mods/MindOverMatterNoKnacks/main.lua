require("item_blacklists")

local ccb = require("ccb")
local content = ccb.content

-- Extremely powerful human psions are blacklisted.  Tier 2 are not--ferals can use their ferality to get more powerful than the player can
local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
definition:entry("mon_feral_scientist_psychic")
definition:entry("mon_feral_security_psychic")
definition:entry("mon_mutant_biokinetic_alpha")
definition:entry("mon_transcendant_alpha_psion")
definition:entry("mon_feral_human_bio3")
definition:entry("mon_feral_human_clair3")
definition:entry("mon_feral_human_electrokin3")
definition:entry("mon_feral_human_photokin3")
definition:entry("mon_feral_human_pyrokin3")
definition:entry("mon_feral_human_telekin3")
definition:entry("mon_feral_human_teep3")
definition:entry("mon_feral_human_porter")
definition:entry("mon_feral_human_porter2")
definition:entry("mon_feral_human_porter3")
definition:entry("mon_feral_human_vita3")
content.add(definition)

require("attribute_scaling")
