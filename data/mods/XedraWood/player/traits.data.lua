local ccb = require("ccb")

ccb.content.define_mutation {
    id = "XEDRA_WOOD_COMPUTER_ILLITERATE",
    name = ccb.content.text_without_extraction("Traditional Mindset"),
    description = ccb.content.text_without_extraction("What survives from the past has proved its worth.  A new thing is risky--who knows if it will stand the test of time?  You cannot use modern technology."),
    points = -5,
    starting_trait = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_XEDRA_WOOD_COMPUTER_ILLITERATE_0" },
    flags = { "CANNOT_USE_COMPUTERS" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CAN_USE_ELECTRONICS",
    name = ccb.content.text("Veins Like Circuits"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("For almost all of recorded history, even tool-using history, humanity had not harnessed lightning, and most of the Fair Folk still have little understanding of electrical devices.  This ability gives you an almost-instinctive understanding of circuits, however, allowing you to develop the electronics skill normally and providing a bonus to its use."),
    valid = false,
    purifiable = false,
    craft_skill_bonuses = { electronics = 2 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CAN_USE_COMPUTERS",
    name = ccb.content.text("Man-Machine Mind"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You have developed an intuitive understanding of computers.  You can develop the computer skill normally and gain a bonus to its use."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "ILLITERATE",
    name = ccb.content.text("Pre-Literate"),
    description = ccb.content.text("While some warrior societies or groups of the Wise may have secret runic codes, wide-scale writing has not yet been invented.  You cannot read."),
    cancels = { "FASTREADER", "SLOWREADER", "PROF_DICEMASTER", "LOVES_BOOKS", "HATES_BOOKS" },
    points = 0,
    valid = false,
}

ccb.content.define_mutation {
    id = "WISE_LITERATE",
    name = ccb.content.text("Rune-Lore"),
    description = ccb.content.text("You know the secret signs and runes used by the Wise to pass messages and record information."),
    cancels = { "ILLITERATE" },
    points = 0,
    valid = false,
}

ccb.content.define_mutation {
    id = "TATTOOS_BASIC_TRAIT",
    name = ccb.content.text_without_extraction("Anima Attunement"),
    description = ccb.content.text_without_extraction("You have been attuned to anima and can make use of tattoo patterns.  You regain anima quickly while meditating, moderately while asleep, and very slowly while awake."),
    points = 0,
    player_display = false,
    valid = false,
    flags = { "MAGICAL_CBMS", "ATTUNEMENT" },
    enchantments = {
        "INLINE_ENCH_TATTOOS_BASIC_TRAIT_0", "INLINE_ENCH_TATTOOS_BASIC_TRAIT_1",
        "INLINE_ENCH_TATTOOS_BASIC_TRAIT_2", "INLINE_ENCH_TATTOOS_BASIC_TRAIT_3",
    },
    cancels = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "XEDRAWOOD_THE_WISE",
    name = ccb.content.text("The Wise"),
    points = 0,
    description = ccb.content.text("You are one of the Wise, capable of performing the deeper mysteries having undergone the ordeal to bond your soul to one of the great natural forces of the Earth, the Forest, the Moon, the Sea, or the Sky."),
    valid = false,
    purifiable = false,
    profession = true,
    enchantments = { "INLINE_ENCH_XEDRAWOOD_THE_WISE_0" },
}

ccb.content.define_mutation {
    id = "WITCHSIGHT",
    name = ccb.content.text("Witch-Sight"),
    points = 2,
    description = ccb.content.text("Your senses are attuned to the unseen world."),
    player_display = true,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_WITCHSIGHT_0" },
}

ccb.content.define_mutation {
    id = "FOREST_MAGIC",
    name = ccb.content.text("Forest-Wise"),
    points = 0,
    description = ccb.content.text("You underwent the Ordeal of the Weald and bonded your soul to the Forest, and the forest spirits allow to draw on a portion of their power."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "ATTUNEMENT", "TREE_COMMUNION_PLUS" },
}
