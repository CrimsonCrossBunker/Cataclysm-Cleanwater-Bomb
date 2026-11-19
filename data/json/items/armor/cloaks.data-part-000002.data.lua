local ccb = require("ccb")

ccb.content.define_item {
    id = "cloak_vampire",
    name = ccb.content.plural_text("sinister cloak (black)", "sinister cloaks (black)"),
    description = ccb.content.text("A sinister-looking hooded cloak meant to be thrown over your body.  The black side is currently facing outwards.  Use it to reverse it and show the red side."),
    mass = "150 g",
    volume = "2500 ml",
    price = "108 USD",
    survival_price = "5 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "cloak",
    color = "dark_gray",
    flags = {
        "OVERSIZE", "HOOD", "BELTED", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 10,
        thickness = 0.2,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 2,
                coverage = 65,
                covers = {
                    "torso", "arm_l", "arm_r", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l",
                    "arm_wing_bird_r", "wing_l", "wing_r",
                },
            },
            {
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                coverage = 65,
                encumbrance = 2,
                subparts = {
                    "leg_draped_l",
                    "leg_draped_r",
                    "leg_gastropod_draped",
                    "tail_default_base",
                    "tail_default_center",
                },
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 65,
                encumbrance = 2,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Your cloak is now bathed in blood."),
            target = "cloak_vampire_red",
            menu_text = ccb.content.text("Reverse the colors"),
        },
    },
}

ccb.content.define_item {
    id = "cloak_vampire_red",
    copy_from = "cloak_vampire",
    name = ccb.content.plural_text("sinister cloak (red)", "sinister cloaks (red)"),
    description = ccb.content.text("A sinister-looking hooded cloak meant to be thrown over your body.  The red side is currently facing outwards.  Use it to reverse it and show the black side."),
    color = "red",
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Your cloak is now one with the night."),
            target = "cloak_vampire",
            menu_text = ccb.content.text("Reverse the colors"),
        },
    },
}
