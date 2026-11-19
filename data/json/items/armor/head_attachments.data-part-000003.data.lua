local ccb = require("ccb")

-- GPNVG-18
ccb.content.define_item {
    id = "advanced_gpnvg_on",
    copy_from = "advanced_gpnvg",
    name = ccb.content.plural_text("panoramic night vision goggles (on)", "panoramic night vision goggles (on)"),
    description = ccb.content.text("Advanced GPNVG with four image intensifier tubes, allowing for a large field of view at night, designed to be mounted on a compatible helmet.  It is turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "advanced_gpnvg",
    inheritance = { add = { flags = { "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "180 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 15, rigid_only = true },
            { covers = { "head" }, encumbrance = 3, coverage = 80, subparts = { "head_crown" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "advanced_gpnvg",
        },
    },
}
