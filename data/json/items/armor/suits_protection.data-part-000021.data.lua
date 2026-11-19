local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_nomad_lightplate_on",
    copy_from = "armor_nomad_lightplate",
    name = ccb.content.plural_text("nomad light plate armor (on)", "nomad light plate armors (on)"),
    revert_to = "armor_nomad_lightplate",
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
            target = "armor_nomad_lightplate",
        },
    },
}
