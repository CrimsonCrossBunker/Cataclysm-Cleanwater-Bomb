local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_inventor_on",
    copy_from = "helmet_inventor",
    name = ccb.content.plural_text("helmet of creative juices (on)", "helmets of creative juices (on)"),
    revert_to = "helmet_inventor",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "7 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "helmet_inventor",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}
