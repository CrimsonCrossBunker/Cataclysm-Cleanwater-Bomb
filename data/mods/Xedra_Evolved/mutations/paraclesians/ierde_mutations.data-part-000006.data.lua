local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_STONE_SLEEP",
    name = ccb.content.text_without_extraction("Sleeping in the Earth"),
    description = ccb.content.text_without_extraction("You are resting in the depths of the earth.  You should never actually see this."),
    player_display = false,
    points = 0,
    enchantments = { "INLINE_ENCH_IERDE_STONE_SLEEP_0" },
}

-- Ideally there'd be a flag to let them bleed oil, but there doesn't currently seem to be
ccb.content.define_mutation {
    id = "IERDE_SLOW_BLEEDING",
    name = ccb.content.text("Blood of the Earth"),
    points = 2,
    description = ccb.content.text("The Ierde's blood has turned black and grown thick and tar-like.  They will bleed much more slowly."),
    categories = { "IERDE" },
    purifiable = false,
    replacements = { "IERDE_STOP_BLEEDING" },
    prerequisites = { "IERDE_HEAL_FASTER_UNDERGROUND" },
    enchantments = { "INLINE_ENCH_IERDE_SLOW_BLEEDING_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STOP_BLEEDING",
    name = ccb.content.text("Black Blood of the Earth"),
    points = 8,
    description = ccb.content.text("The Ierde's blood has turned into a black sludge that barely flows.  They no longer bleed at all."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_SLOW_BLEEDING" },
    flags = { "BLEED_IMMUNE" },
}

ccb.content.define_mutation {
    id = "IERDE_NO_KNOCKBACK",
    name = ccb.content.text("The Mountain Does Not Move"),
    points = 4,
    description = ccb.content.text("Though the earth shivers and shakes, the mountain stands tall.  The Ierde is immune to knockback and can block attacks from a target of any size."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_STR_BONUS_1", "IERDE_STR_BONUS_2", "IERDE_STR_BONUS_3", "IERDE_STR_BONUS_4" },
    enchantments = { "INLINE_ENCH_IERDE_NO_KNOCKBACK_0" },
    flags = { "BLOCK_HUGE_ATTACKS" },
}
