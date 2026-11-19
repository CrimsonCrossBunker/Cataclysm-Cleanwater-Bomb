local ccb = require("ccb")

ccb.content.define_mutation {
    id = "STR_UP_POOKA",
    name = ccb.content.text("Bestial Strength"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Even when not shapeshifted you can bring part of a wild animal's strength to bear.  +2 Strength."),
    prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_STR_UP_POOKA_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP_POOKA",
    name = ccb.content.text("Untamed Agility"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You have the quick reactions of a wild animal.  +3 Dexterity."),
    prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_DEX_UP_POOKA_0" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_GOOD",
    name = ccb.content.text("Initiate of Forms"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You are getting better at shapeshifting and are able to maintain one more simultaneous shapeshift without drawing on your mana."),
    replacements = { "POOKA_SHAPESHIFT_GOOD2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_GOOD2",
    name = ccb.content.text("Adept of Forms"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You are getting much better at shapeshifting and are able to maintain two more simultaneous shapeshifts without drawing on your mana."),
    prerequisites = { "POOKA_SHAPESHIFT_GOOD" },
    replacements = { "POOKA_SHAPESHIFT_GOOD3" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_GOOD3",
    name = ccb.content.text("Master of Forms"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("You are a master of shapeshifting and are able to maintain four more simultaneous shapeshifts without drawing on your mana."),
    prerequisites = { "POOKA_SHAPESHIFT_GOOD2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_SELECTOR",
    name = ccb.content.text_without_extraction("Pinnacle of Forms"),
    points = 6,
    purifiable = false,
    description = ccb.content.text_without_extraction("This gives you access to the full shapeshift traits.  You should never seen it."),
    prerequisites = { "POOKA_SHAPESHIFT_GOOD2", "POOKA_SHAPESHIFT_GOOD3" },
    player_display = false,
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA" },
}
