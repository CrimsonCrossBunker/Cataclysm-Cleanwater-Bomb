local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_nomad_chainmail_on",
    copy_from = "armor_nomad_chainmail",
    name = ccb.content.plural_text("nomad chainmail (on)", "suits of nomad chainmail (on)"),
    revert_to = "armor_nomad_chainmail",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The hum of the suit's climate control fades."),
            target = "armor_nomad_chainmail",
        },
    },
}
