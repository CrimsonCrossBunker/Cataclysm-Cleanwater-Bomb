local ccb = require("ccb")

ccb.content.define_item {
    id = "optical_cloak",
    name = ccb.content.plural_text("FB51 optical cloak", "FB51 optical cloaks"),
    description = ccb.content.text("A plastic cloak embedded with cameras and LEDs that will render you fully invisible to normal vision when powered and worn.  You must be carrying a unified power supply, or UPS, to use it.  Activate to toggle visibility."),
    mass = "1552 g",
    volume = "3500 ml",
    price = "55 kUSD",
    survival_price = "250 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "cloak",
    color = "light_gray",
    flags = {
        "USE_UPS", "OVERSIZE", "HOOD", "BELTED", "SOFT", "NO_REPAIR", "RAINPROOF", "ALLOWS_WING_ARMS",
        "NO_WING_GLIDING",
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 0.5,
        environmental_protection = 4,
        portions = {
            {
                encumbrance = 50,
                coverage = 65,
                covers = {
                    "torso",
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 65,
                encumbrance = 50,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Your optical cloak flickers as it becomes transparent."),
            target = "optical_cloak_on",
            need_charges = 20,
            need_charges_message = ccb.content.text("You don't have enough UPS charges."),
        },
    },
}

ccb.content.define_item {
    id = "optical_cloak_on",
    copy_from = "optical_cloak",
    looks_like = "optical_cloak",
    name = ccb.content.plural_text("FB51 optical cloak (on)", "FB51 optical cloaks (on)"),
    description = ccb.content.text("A plastic cloak embedded with cameras and LEDs that will render you fully invisible to normal vision when powered and worn.  It is turned on, and continually draining power from a UPS.  Use it to turn it off."),
    flags = {
        "USE_UPS", "OVERSIZE", "HOOD", "BELTED", "ACTIVE_CLOAKING", "TRADER_AVOID", "SOFT", "NO_REPAIR",
        "RAINPROOF", "SPAWN_ACTIVE",
    },
    revert_to = "optical_cloak",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "20 kW" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your optical cloak flickers for a moment as it becomes opaque."),
            target = "optical_cloak",
        },
    },
}
