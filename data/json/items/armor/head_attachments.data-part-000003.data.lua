local ccb = require("ccb")

-- AN/PVS-7
ccb.content.define_item {
    id = "military_nvg_on",
    copy_from = "military_nvg",
    name = ccb.content.plural_text("night vision goggles (on)", "night vision goggles (on)"),
    description = ccb.content.text("Last generation single-tube night vision device, designed to be mounted on a compatible helmet.  Limited field of view while activated.  It is turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "military_nvg",
    inheritance = { add = { flags = { "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "140 mW" },
    armor = { portions = { { covers = { "eyes" }, coverage = 100, encumbrance = 20, rigid_only = true } } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "military_nvg",
        },
    },
}
