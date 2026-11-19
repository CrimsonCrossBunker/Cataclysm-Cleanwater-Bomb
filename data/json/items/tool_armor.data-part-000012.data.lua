local ccb = require("ccb")

-- 2019 commercial models can operate at under 0.375W with the IR illuminator on
ccb.content.define_item {
    id = "goggles_nv_on",
    copy_from = "goggles_nv",
    name = ccb.content.plural_text("light amp goggles (on)", "light amp goggles (on)"),
    description = ccb.content.text("A pair of battery-powered goggles that use a infrared LED in conjunction with a IR camera, allowing you to see in the dark.  It is turned on, and continually draining batteries.  Use it to turn them off."),
    materials = { "plastic", "steel" },
    revert_to = "goggles_nv",
    inheritance = { add = { flags = { "TRADER_AVOID", "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "375 mW" },
    armor = {
        warmth = 15,
        portions = { { encumbrance = 20, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "goggles_nv",
        },
    },
}
