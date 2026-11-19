local ccb = require("ccb")

ccb.content.define_mutation {
    id = "UNDINE_FAST_SWIM_SPEED",
    name = ccb.content.text("Like a Fish in the River"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Undines are born of the waters and water is their home.  This trait allows them to move much faster when in water."),
    prerequisites = { "BREATH_UNDERWATER" },
    categories = { "UNDINE" },
    purifiable = false,
    flags = { "WEBBED_FEET", "WEBBED_HANDS" },
    enchantments = { "INLINE_ENCH_UNDINE_FAST_SWIM_SPEED_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_WATER_PUSH_AWAY",
    name = ccb.content.text("Crashing Waves"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The waters come to the Undine's defense.  When attacked, there is a chance that a burst of water will surge out and push their attackers back."),
    prerequisites = { "UNDINE_ESCAPE_GRABS" },
    categories = { "UNDINE" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "UNDINE_DO_MORE_MELEE_DAMAGE",
    name = ccb.content.text("Pounding Surf Strikes"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like the relentless pounding of the waves against the shore, the Undine's strikes hammer into their enemies.  While this trait is active, the Undine does 25% more melee damage."),
    prerequisites = { "UNDINE_WATER_PUSH_AWAY" },
    categories = { "UNDINE" },
    purifiable = false,
    active = true,
    consumes_water = true,
    cost = 1,
    cooldown = 30,
    activation_setup_only = false,
    enchantments = { "INLINE_ENCH_UNDINE_DO_MORE_MELEE_DAMAGE_0" },
}
