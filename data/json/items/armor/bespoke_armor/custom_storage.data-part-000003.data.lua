local ccb = require("ccb")

ccb.content.define_item {
    id = "nomad_rig_on",
    copy_from = "nomad_rig",
    name = ccb.content.plural_text("nomad harness (on)", "nomad harnesses (on)"),
    revert_to = "nomad_rig",
    light = 500,
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "USES_BIONIC_POWER", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "15 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the shoulder mounted flashlight off."),
            target = "nomad_rig",
        },
    },
}
