local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
    name = ccb.content.text("Heartvines"),
    points = 0,
    description = ccb.content.text("After being infused with the power of nature, part of the ritual of the Bloodthorne Druids was the implantation of a symbiotic plant.  You aren't sure where it came from or what its natural habitat is, but now it's a part of you.  You require slightly more food and water than normal to feed it, but have the power to fight back against the blood-drinkers.\n\nVampire blood taken from their dying hearts and stolen power from the wood-elemental fey will both fuel your Heartvines.  Enough of both will allow you to unlock new gifts."),
    purifiable = false,
    valid = false,
    visibility = 2,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_0" },
    species_anger = { THORNBEAST = -100 },
    flags = { "ATTUNEMENT", "TREE_COMMUNION_PLUS", "NO_CBM_INSTALLATION" },
    chargen_allow_npc = false,
}

-- true
ccb.content.define_mutation {
    id = "BLOODTHORNE_SORCERY",
    name = ccb.content.text("Thornwitchery"),
    points = 0,
    description = ccb.content.text("This is the school trait for Bloodthorne Druids.  You shouldn't see it directly."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
}
