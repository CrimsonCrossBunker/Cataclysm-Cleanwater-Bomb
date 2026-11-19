local ccb = require("ccb")

ccb.content.define_item {
    id = "crafting_assistant_on",
    copy_from = "crafting_assistant",
    name = ccb.content.plural_text("Crafting Assistant Robot (on)", "Crafting Assistant Robot (on)"),
    revert_to = "crafting_assistant",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "1550 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "crafting_assistant",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The assistant retracts and recycles its arms."),
        },
    },
}
