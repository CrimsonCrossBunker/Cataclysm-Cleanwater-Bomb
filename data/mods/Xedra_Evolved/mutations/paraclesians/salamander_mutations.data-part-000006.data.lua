local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_NO_WATER",
    name = ccb.content.text("The Inner Fire Cannot Be Quenched"),
    points = 6,
    description = ccb.content.text("Accursed water.  Its touch dampens your flames, and you will no longer have anything to do with it.  You do not need to drink."),
    types = { "THIRST" },
    prerequisites = { "SALAMANDER_SKIN_2", "SALAMANDER_SKIN_3" },
    categories = { "SALAMANDER" },
    flags = { "NO_THIRST" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "SALAMANDER_NO_SMOKE_DAMAGE",
    name = ccb.content.text("Breathing in Cinders"),
    points = 6,
    description = ccb.content.text("Smoke is the breath of fire and a Salamander is born of flames.  You suffer no negative effects from smoke inhalation."),
    prerequisites = { "SALAMANDER_NO_WATER" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_NO_SMOKE_DAMAGE_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_STR_BONUS_1",
    name = ccb.content.text("Strength of the Crackling Fire"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    replacements = { "SALAMANDER_STR_BONUS_2" },
    description = ccb.content.text("Like a fire fueled with fresh wood, you have increased strength.  +1 Strength."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_STR_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_STR_BONUS_2",
    name = ccb.content.text("Strength of the Blazing Bonfire"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_STR_BONUS_1" },
    secondary_prerequisites = { "SALAMANDER_EMIT_HEAT" },
    description = ccb.content.text("Like the bonfire that will burn through the night, you have greatly increased strength.  +3 Strength."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_STR_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_DEX_BONUS_1",
    name = ccb.content.text("Fiery Speed"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    replacements = { "SALAMANDER_DEX_BONUS_2" },
    description = ccb.content.text("Like a fire sparks kindling in flame, you have increased speed.  +2 Dexterity."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_DEX_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_DEX_BONUS_2",
    name = ccb.content.text("Blazing Speed"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_DEX_BONUS_1" },
    secondary_prerequisites = { "SALAMANDER_ECTOTHERM" },
    description = ccb.content.text("Like a forest fire moving faster than a running horse, you have greatly increased speed.  +5 Dexterity."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_DEX_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_REDUCED_MOVE_COST",
    name = ccb.content.text("Outracing the Prairie Fire"),
    points = 7,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_DEX_BONUS_2" },
    description = ccb.content.text("The Salamander can move even faster than a racing prairie fire.  -10% move and attack speed."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "ench_salamander_reduced_move" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_INT_BONUS",
    name = ccb.content.text("Sparking Thoughts"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_MAKE_FIRE" },
    description = ccb.content.text("Your thoughts are as fast as a forest fire.  +2 Intelligence."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_INT_BONUS_0" },
}
