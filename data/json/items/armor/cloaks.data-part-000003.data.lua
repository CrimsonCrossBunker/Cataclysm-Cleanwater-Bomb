local ccb = require("ccb")

ccb.content.define_item {
    id = "cloak_black",
    name = ccb.content.text("dark cloak"),
    description = ccb.content.text("A black cloak meant to be thrown over your body.  Commonly used by witches and other creatures of the night."),
    mass = "100 g",
    volume = "2000 ml",
    price = "90 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "cloak",
    color = "dark_gray",
    flags = {
        "OVERSIZE", "BELTED", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS",
        "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 8,
        thickness = 0.1,
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
}

ccb.content.define_item {
    id = "cloak_fur",
    name = ccb.content.text("fur cloak"),
    description = ccb.content.text("A heavy fur cloak meant to be thrown over your body."),
    mass = "1735 g",
    volume = "4 L",
    price = "245 USD",
    survival_price = "7 USD 50 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "cloak_leather",
    color = "brown",
    flags = {
        "OVERSIZE", "HOOD", "BELTED", "RAINPROOF", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 60,
        thickness = 0.6,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 6,
                coverage = 65,
                covers = {
                    "torso", "arm_l", "arm_r", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l",
                    "arm_wing_bird_r", "wing_l", "wing_r",
                },
            },
            {
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                coverage = 65,
                encumbrance = 6,
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
                encumbrance = 6,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "cloak_leather",
    name = ccb.content.text("leather cloak"),
    description = ccb.content.text("A heavy leather cloak meant to be thrown over your body."),
    mass = "2060 g",
    volume = "3500 ml",
    price = "245 USD",
    survival_price = "10 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "cloak",
    color = "dark_gray",
    flags = {
        "OVERSIZE", "HOOD", "BELTED", "RAINPROOF", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 40,
        thickness = 1.5,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 6,
                coverage = 65,
                covers = {
                    "torso", "arm_l", "arm_r", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l",
                    "arm_wing_bird_r", "wing_l", "wing_r",
                },
            },
            {
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                coverage = 65,
                encumbrance = 6,
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
                encumbrance = 6,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "cloak_wool",
    name = ccb.content.text("wool cloak"),
    description = ccb.content.text("A heavy woolen cloak meant to be thrown over your body."),
    mass = "900 g",
    volume = "3750 ml",
    price = "245 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "cloak",
    color = "blue",
    flags = {
        "OVERSIZE", "HOOD", "BELTED", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 50,
        thickness = 0.5,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "torso", "arm_l", "arm_r", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l",
                    "arm_wing_bird_r", "wing_l", "wing_r",
                },
            },
            {
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                coverage = 65,
                encumbrance = 5,
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
                encumbrance = 5,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "jedi_cloak",
    name = ccb.content.text("Jedi cloak"),
    description = ccb.content.text("A long, flowing robe.  Be sure to tear it off dramatically before fighting any foes!"),
    mass = "1250 g",
    volume = "2500 ml",
    price = "225 USD",
    survival_price = "5 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "robe",
    color = "brown",
    flags = {
        "OVERSIZE", "BELTED", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS",
        "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 5,
        thickness = 0.3,
        environmental_protection = 5,
        portions = {
            {
                encumbrance = 3,
                coverage = 65,
                covers = {
                    "torso", "arm_l", "arm_r", "head", "hand_l", "hand_r", "arm_wing_bat_l",
                    "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r", "wing_l", "wing_r",
                },
            },
            {
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                coverage = 65,
                encumbrance = 3,
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
                encumbrance = 3,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
        },
    },
}
