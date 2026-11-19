local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_electric_fist_act",
    copy_from = "inventor_electric_fist",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.plural_text("\"Overture\" (on)", "\"Overtures\" (on)"),
    revert_to = "inventor_electric_fist",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "50 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "inventor_electric_fist",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}
