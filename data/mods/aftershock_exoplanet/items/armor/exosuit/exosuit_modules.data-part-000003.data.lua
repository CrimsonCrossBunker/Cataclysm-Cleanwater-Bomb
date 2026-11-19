local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_small_carry_on",
    copy_from = "exo_small_carry",
    name = ccb.content.plural_text("exosuit small load support module (on)", "exosuit small load support modules (on)"),
    description = ccb.content.text("This module increases the exosuit's weight bearing at the cost of increased power consumption.  It is turned on and continually drawing power.  Use it to turn it off."),
    flags = { "FRAGILE", "CANT_WEAR", "WATERPROOF", "USE_UPS", "EXO_SMALL_GADGET", "SPAWN_ACTIVE" },
    revert_to = "exo_small_carry",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "500 mW" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "exo_small_carry",
            message = ccb.content.text("You deactivate the module."),
            menu_text = ccb.content.text("Turn off module"),
        },
    },
}

ccb.content.define_item {
    id = "exo_flashlight",
    category = "exosuit",
    name = ccb.content.plural_text("mounted lamp (off)", "mounted lamps (off)"),
    description = ccb.content.text("This is a light that can be secured to an exosuit hardpoint.  It has two levels of brightness."),
    mass = "500 g",
    volume = "500 ml",
    materials = { "qt_steel", "plastic" },
    symbol = "o",
    color = "white",
    flags = { "USE_UPS", "CANT_WEAR", "EXO_SMALL_GADGET" },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the lamp on low."),
            target = "exo_flashlight_low",
            need_charges = 1,
            need_charges_message = ccb.content.text("There is not enough charge to activate the module."),
        },
    },
}
