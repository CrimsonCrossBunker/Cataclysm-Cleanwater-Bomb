local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_carry_on",
    copy_from = "exo_carry",
    name = ccb.content.plural_text("exosuit load support module (on)", "exosuit load support modules (on)"),
    description = ccb.content.text("This module significantly increases the exosuit's weight bearing at the cost of increased power consumption.  It is turned on and continually drawing power.  Use it to turn it off."),
    flags = { "FRAGILE", "CANT_WEAR", "WATERPROOF", "USE_UPS", "EXO_MEDIUM_GADGET", "SPAWN_ACTIVE" },
    max_worn = 1,
    revert_to = "exo_carry",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "1 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "exo_carry",
            message = ccb.content.text("You deactivate the module."),
            menu_text = ccb.content.text("Turn off module"),
        },
    },
}
