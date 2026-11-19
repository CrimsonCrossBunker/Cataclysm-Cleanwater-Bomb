local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_dexterous_speed",
    name = ccb.content.text("Dexterous Speed"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've found that you can move just a little bit quicker the more dexterous you are.  Unfortunately, this applies comes at a loss to your max carry weight.  Gain 2 speed for every point of DEX away from 8.  You lose 4% of your max carry weight for each point between 8 and 20 DEX, and 2% for each point beyond 20."),
    enchantments = {
        "INLINE_ENCH_perk_dexterous_speed_0", "INLINE_ENCH_perk_dexterous_speed_1",
        "INLINE_ENCH_perk_dexterous_speed_2",
    },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_bird",
    name = ccb.content.text("Stormwrought: Bird"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_feline",
    name = ccb.content.text("Stormwrought: Feline"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_insect",
    name = ccb.content.text("Stormwrought: Insect"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_lupine",
    name = ccb.content.text("Stormwrought: Lupine"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_plant",
    name = ccb.content.text("Stormwrought: Plant"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_spider",
    name = ccb.content.text("Stormwrought: Spider"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "revolvers_are_cool",
    name = ccb.content.text("Double Action Action"),
    description = ccb.content.text("You always knew nothing can beat the good old six shooters.  You have a minor bonus using revolvers."),
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_revolvers_are_cool_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "22_is_cool",
    name = ccb.content.text("Rimfire Rebel"),
    description = ccb.content.text("You always appreciated the size of this little fella named \"Dot Two Two Long Rifle\", but they laughed at you.  Not anymore!  You found that the size of a bullet that small is perfect to hit into little spots between armor or narrow places.  .22 weapons have additional armor penetration and quadrupled chance to hit a weakpoint."),
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_22_is_cool_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_yeoman",
    name = ccb.content.text("Yeoman"),
    description = ccb.content.text("In a world of guns, you were born to string a bow.  With such weapons you draw back further, increasing damage and range, and your arrows strike true with unerring accuracy."),
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_perk_yeoman_0" },
    flags = { "PERK" },
}
