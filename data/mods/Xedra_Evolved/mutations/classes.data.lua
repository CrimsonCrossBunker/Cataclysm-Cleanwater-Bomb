local ccb = require("ccb")

ccb.content.define_mutation {
    id = "XE_NETHER_SORCERY",
    name = ccb.content.text("Nether Sorcery"),
    points = 0,
    description = ccb.content.text("There is power in the Nether for those with the will and the strength to seize it, and you are such a one.  Hopefully you won't fly too close to the void."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "XE_NO_NETHER_SORCERY",
    name = ccb.content.text_without_extraction("Not a Nether Sorcerer"),
    points = 0,
    description = ccb.content.text_without_extraction("You can't use Nether Sorcery, which makes you pretty much the same as anyone else, to be honest.  This trait blocks using Nether Sorcery grimoires as spellbooks and is not player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    cancels = { "XE_NETHER_SORCERY" },
}
