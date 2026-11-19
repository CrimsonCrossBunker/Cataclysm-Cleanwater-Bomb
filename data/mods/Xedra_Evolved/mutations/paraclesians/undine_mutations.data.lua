local ccb = require("ccb")

ccb.content.define_mutation {
    id = "UNDINE_WATER_FORM_TRAITS",
    name = ccb.content.text("Water Form"),
    description = ccb.content.text("You are a mass of pure water.  It is much harder to damage you, and you can move over any terrain without penalty, but you cannot attack."),
    points = 10,
    valid = false,
    appearance = { id = "mon_water_sprite", tile_category = "monster" },
    enchantments = {
        "ench_undine_water_form_no_attack", "ench_undine_water_form_armor",
        "INLINE_ENCH_UNDINE_WATER_FORM_TRAITS_2",
    },
    flags = {
        "STEADY", "WALK_UNDERWATER", "BULLET_IMMUNE", "DISTRIBUTED_DAMAGE", "SUFFOCATION_IMMUNE",
        "MYCUS_IMMUNE", "CANNOT_CONSUME_DRUGS",
    },
}

ccb.content.define_mutation {
    id = "UNDINE_WATER_FORM_CAMOUFLAGE",
    name = ccb.content.text("Watery Camouflage"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Being made entirely of water, it is easy for you to disguise yourself when underwater."),
    categories = { "UNDINE" },
    purifiable = false,
    valid = false,
    enchantments = { "undine_water_form_hiding" },
}

ccb.content.define_mutation {
    id = "UNDINE_LIQUID_WATER_POCKET",
    name = ccb.content.text("The Sea Is Always With Me"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Undine can draw a bit of extra water into their watery skin, fortifying them for journeys away from a water source."),
    prerequisites = { "UNDINE_SKIN_3" },
    secondary_prerequisites = { "WATER_SEALED" },
    categories = { "UNDINE" },
    purifiable = false,
    threshold_requirements = { "THRESH_UNDINE" },
    integrated_armor = { "item_undine_liquid_water_pocket" },
}
