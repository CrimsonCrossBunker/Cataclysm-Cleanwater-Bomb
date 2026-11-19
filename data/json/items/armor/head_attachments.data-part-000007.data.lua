local ccb = require("ccb")

-- AN/PSQ-42
ccb.content.define_item {
    id = "enhanced_nvg_on",
    copy_from = "enhanced_nvg",
    name = ccb.content.plural_text("enhanced night vision goggles (on)", "enhanced night vision goggles (on)"),
    description = ccb.content.text("New and rare high-resolution thermal NVG device, designed to be mounted on a compatible helmet.  Lets you see in the dark, and detects heat signatures emitted by (un)living organisms.  It is turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "enhanced_nvg",
    inheritance = { add = { flags = { "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "320 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 10, rigid_only = true },
            { covers = { "head" }, encumbrance = 3, coverage = 80, subparts = { "head_crown" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "enhanced_nvg",
        },
    },
}
