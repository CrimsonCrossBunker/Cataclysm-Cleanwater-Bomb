local ccb = require("ccb")

ccb.content.define_item {
    id = "electric_blanket",
    name = ccb.content.plural_text("electric blanket", "electric blankets"),
    description = ccb.content.text("A heated blanket made of polyester.  The most comfortable thing on Earth.  Its power drain is usually negligible, but without being able to plug it into a wall, it chews through batteries insanely quickly."),
    mass = "1123 g",
    volume = "2500 ml",
    price = "55 USD",
    survival_price = "2 USD 50 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "brown",
    flags = { "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "WATER_BREAK" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 50,
        thickness = 1,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 35,
                coverage = 100,
                covers = {
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "electric_blanket_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "link_up", cable_length = 3, charge_rate = "110 W" },
    },
}

ccb.content.define_item {
    id = "electric_blanket_on",
    name = ccb.content.plural_text("electric blanket (on)", "electric blankets (on)"),
    description = ccb.content.text("A heated blanket made of polyester.  It's turned on, making it nice and toasty while it lasts."),
    copy_from = "electric_blanket",
    revert_to = "electric_blanket",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = { warmth = 90 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "electric_blanket",
        },
        { kind = "link_up", cable_length = 3, charge_rate = "110 W" },
    },
}
