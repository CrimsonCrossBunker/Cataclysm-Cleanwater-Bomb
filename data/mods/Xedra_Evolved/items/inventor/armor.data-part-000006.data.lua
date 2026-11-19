local ccb = require("ccb")

ccb.content.define_item {
    id = "vision_halo_on",
    category = "armor",
    name = ccb.content.plural_text("electronic halo (on)", "electronic halos (on)"),
    copy_from = "vision_halo",
    revert_to = "vision_halo",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "500 W" },
    armor = {},
    use_actions = {
        "CAMERA",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "transform",
            target = "vision_halo",
            message = ccb.content.text("You turn off the %s."),
            menu_text = ccb.content.text("Turn off battle mode"),
            need_charges = 0,
        },
    },
}
