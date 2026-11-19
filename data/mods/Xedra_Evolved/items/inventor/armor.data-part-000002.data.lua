local ccb = require("ccb")

ccb.content.define_item {
    id = "aura_force_on",
    copy_from = "aura_force",
    name = ccb.content.plural_text("force shield (on)", "force shields (on)"),
    revert_to = "aura_force",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "250 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "aura_force",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Torus stops working."),
        },
    },
}
