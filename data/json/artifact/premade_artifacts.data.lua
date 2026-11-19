local ccb = require("ccb")

ccb.content.define_item {
    id = "architect_cube",
    name = ccb.content.plural_text("The Architect's Cube", "The Architect's Cubes"),
    description = ccb.content.text("This is a solid cube that is much heavier than its size suggests.  When you look at it, it pulls your gaze inward until you fall through the sky, showing you a top-down view of your position with the surroundings revealed."),
    mass = "2 kg",
    volume = "100 ml",
    materials = { "iron" },
    symbol = "]",
    color = "light_gray",
    flags = { "TRADER_AVOID" },
    subtype_order = { "tool", "artifact" },
    tool = {},
    artifact = { enchantments = { "ITEM_ENCH_dda_architect_cube_0" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "DEBUG_stabbing",
    name = ccb.content.text_without_extraction("stone of stabbing", "stones of stabbing"),
    description = ccb.content.text_without_extraction("A debug item to make sure that skills can be modified by enchantments."),
    mass = "1 kg",
    volume = "100 ml",
    symbol = ".",
    artifact = { enchantments = { "ITEM_ENCH_dda_DEBUG_stabbing_0" } },
}
