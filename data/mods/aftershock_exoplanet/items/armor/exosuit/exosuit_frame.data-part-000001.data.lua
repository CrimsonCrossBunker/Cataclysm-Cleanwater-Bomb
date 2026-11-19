local ccb = require("ccb")

ccb.content.define_item {
    id = "modular_exosuit_on",
    copy_from = "modular_exosuit",
    repair_like = "modular_exosuit",
    looks_like = "power_armor_light",
    name = ccb.content.plural_text("exosuit frame (on)", "exosuit frames (on)"),
    description = ccb.content.text("This is a standard exosuit frame.  Designed to be modular, it can accept a variety of power supplies, defensive and offensive systems, and utility tools.  Slots exist for the torso, back, arms, and legs.  It is turned on and continually drawing power.  Use it to turn it off."),
    flags = {
        "USE_UPS", "STURDY", "WATERPROOF", "ELECTRIC_IMMUNE", "COMBAT_TOGGLEABLE", "OUTER",
        "PARTIAL_DEAF", "SUN_GLASSES", "FLASH_PROTECTION", "TARDIS", "MODULE_HOLDER", "SPAWN_ACTIVE",
    },
    revert_to = "modular_exosuit",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "6460 mW" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 80, thickness = 2 },
                    { id = "rubber", coverage = 20, thickness = 2 },
                    { id = "lvl4ballisticglass", coverage = 100, thickness = 2 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = { 5, 5 },
                layers = { "OUTER" },
            },
            {
                materials = { { id = "titanium", coverage = 100, thickness = 1 } },
                covers = { "head", "mouth", "torso", "arm_l", "arm_r", "leg_l", "leg_r", "foot_l", "foot_r" },
                coverage = 20,
                encumbrance = { 5, 10 },
                layers = { "OUTER" },
            },
            {
                materials = { { id = "titanium", coverage = 100, thickness = 1 } },
                covers = { "hand_l", "hand_r" },
                coverage = 20,
                encumbrance = { 5, 5 },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The %s disengages."),
            target = "modular_exosuit",
        },
    },
}
