local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_ALCHEMY1",
    name = ccb.content.text("Basic Alchemical Knowledge"),
    points = 0,
    description = ccb.content.text("You spent years before the Cataclysm researching esoteric sciences and occult mysteries but only now in the heat of survival, have you experienced the epiphany that will allow you to create alchemical substances."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "perk_ALCHEMY2",
    name = ccb.content.text("Initiate Alchemy"),
    points = 0,
    description = ccb.content.text("The days and weeks since the Cataclysm have been a blur of ideas and thoughts that you can only wish you had been able to think of before everything ended."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "perk_ALCHEMY3",
    name = ccb.content.text("Adept Alchemical Knowledge"),
    points = 0,
    description = ccb.content.text("The things you've learned would have changed your life in the old days, you could have dropped out of the rat race and become a hidden master of the occult."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "perk_ALCHEMY3_COLD_IRON",
    name = ccb.content.text("Cold Iron Knowledge"),
    points = 0,
    description = ccb.content.text("You've mastered the technique of cold forging iron from ingots into various items and weapons that are particularly effective against creatures from faerie myths."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "perk_ALCHEMY4",
    name = ccb.content.text("Magister Alchemical Knowledge"),
    points = 0,
    description = ccb.content.text("At this stage in your occult education, normally you would start a small cabal of your own with apprentices that would engage in research and material gathering.  You would likely have several rich patrons financing you in return for alchemical medicines and goods to give them health and longevity."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "perk_ALCHEMY5",
    name = ccb.content.text("Illuminated Alchemy"),
    points = 0,
    description = ccb.content.text("Truly you have become one of the hidden occult masters of the world.  It's a pity that so few people are around for you to enjoy the benefits of your knowledge.  At least it's helping you to survive and maybe even thrive in this post-Cataclysm world."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "perk_LOW_INT_MANA",
    name = ccb.content.text("Mana for Morons"),
    points = 0,
    description = ccb.content.text("Maybe you aren't a genius, but something inside of you grants previously hidden reserves of mana."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_perk_LOW_INT_MANA_0" },
}

ccb.content.define_mutation {
    id = "perk_xe_vampire_killer",
    name = ccb.content.text("Vampire Killer"),
    points = 0,
    description = ccb.content.text("One of your ancestors spent their life fighting the monsters that stalk the night, and you have finally taken up their legacy, though you've also adopted their unusual weapon choice.  When wielding a whip, you do greatly-increased damage to vampires and renfields, and have a much easier time hitting their weakpoints."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_perk_xe_vampire_killer_0" },
}

ccb.content.define_mutation {
    id = "perk_GRACKEN_FRIENDSHIP",
    name = ccb.content.text("Grack Pack"),
    points = 0,
    description = ccb.content.text("You've found a kinship with those strange shadowy creatures as long as you move your hands fast enough when you see them.  You can befriend gracken, causing them to come to your defense."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
    active = true,
    on_activate = "perk_grack_pack",
}
