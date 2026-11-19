local ccb = require("ccb")

ccb.content.define_item {
    id = "poncho",
    name = ccb.content.text("wool poncho"),
    description = ccb.content.text("A simple wool garment worn over the torso and upper arms."),
    mass = "907 g",
    volume = "1250 ml",
    price = "120 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "cloak",
    color = "light_gray",
    flags = { "BELTED", "OVERSIZE", "ALLOWS_WING_ARMS", "NO_WING_GLIDING" },
    armor = {
        warmth = 35,
        thickness = 1,
        environmental_protection = 1,
        portions = {
            { encumbrance = 5, coverage = 85, covers = { "torso" } },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                coverage = 100,
                encumbrance = 5,
                subparts = {
                    "arm_shoulder_l", "arm_shoulder_r", "arm_wing_bird_shoulder_l",
                    "arm_wing_bird_shoulder_r", "arm_wing_bat_shoulder_l", "arm_wing_bat_shoulder_r",
                },
                layers = { "BELTED" },
            },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                coverage = 85,
                encumbrance = 5,
                subparts = {
                    "arm_upper_r", "arm_upper_l", "arm_wing_bird_upper_l", "arm_wing_bird_upper_r",
                    "arm_wing_bat_upper_l", "arm_wing_bat_upper_r",
                },
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "poncho_makeshift",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.text("makeshift poncho"),
    description = ccb.content.text("A large plastic trash bag with holes cut out for the head and arms."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "vinyl" },
    mass = "30 g",
    volume = "50 ml",
    flags = { "RAINPROOF", "OVERSIZE", "HOOD", "BELTED", "ALLOWS_WING_ARMS" },
    armor = {
        environmental_protection = 1,
        thickness = 0.1,
        portions = { { coverage = 90, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "folding_poncho",
    category = "clothing",
    symbol = "[",
    color = "yellow",
    name = ccb.content.text("rain poncho"),
    description = ccb.content.text("A lightweight plastic rain poncho with a hood.  It folds into a very compact form when not in use."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "vinyl" },
    mass = "280 g",
    volume = "250 ml",
    flags = { "RAINPROOF", "HOOD", "OVERSIZE", "BELTED", "ALLOWS_WING_ARMS", "NO_WING_GLIDING" },
    armor = {
        environmental_protection = 1,
        thickness = 0.4,
        portions = {
            { covers = { "torso" }, subparts = { "torso_upper", "torso_lower" }, coverage = 100 },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_shoulder_l", "arm_shoulder_r", "arm_upper_r", "arm_upper_l", "arm_elbow_r",
                    "arm_elbow_l", "arm_wing_bird_shoulder_l", "arm_wing_bird_shoulder_r",
                    "arm_wing_bird_upper_l", "arm_wing_bird_upper_r", "arm_wing_bat_shoulder_l",
                    "arm_wing_bat_shoulder_r", "arm_wing_bat_upper_l", "arm_wing_bat_upper_r",
                    "arm_wing_bird_elbow_r", "arm_wing_bird_elbow_l", "arm_wing_bat_elbow_r",
                    "arm_wing_bat_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_lower_l", "arm_lower_r", "arm_wing_bird_lower_r", "arm_wing_bird_lower_l",
                    "arm_wing_bat_lower_r", "arm_wing_bat_lower_l",
                },
                coverage = 90,
            },
        },
    },
}

ccb.content.define_item {
    id = "military_poncho",
    category = "clothing",
    looks_like = "cloak",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.text("military poncho"),
    description = ccb.content.text("A standard issue, lightweight nylon poncho with a hood.  It has a cinch cord around the hood and grommets to attach a liner, or to use it as a standard tarp."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "nylon" },
    mass = "450 g",
    volume = "2300 ml",
    flags = {
        "RAINPROOF", "HOOD", "OVERSIZE", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "NO_WING_GLIDING",
    },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "4000 ml",
            mass_limit = "900 g",
            moves = 200,
            description = ccb.content.text("Grommets for a poncho liner."),
            allowed_items = { "military_poncho_liner", "robofac_poncho_liner" },
        },
    },
    armor = {
        environmental_protection = 2,
        thickness = 0.2,
        portions = {
            {
                encumbrance = 2,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
            },
            {
                encumbrance = 2,
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_shoulder_l", "arm_shoulder_r", "arm_upper_r", "arm_upper_l", "arm_elbow_r",
                    "arm_elbow_l", "arm_wing_bird_shoulder_l", "arm_wing_bird_shoulder_r",
                    "arm_wing_bird_upper_l", "arm_wing_bird_upper_r", "arm_wing_bat_shoulder_l",
                    "arm_wing_bat_shoulder_r", "arm_wing_bat_upper_l", "arm_wing_bat_upper_r",
                    "arm_wing_bird_elbow_r", "arm_wing_bird_elbow_l", "arm_wing_bat_elbow_r",
                    "arm_wing_bat_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_lower_l", "arm_lower_r", "arm_wing_bird_lower_r", "arm_wing_bird_lower_l",
                    "arm_wing_bat_lower_r", "arm_wing_bat_lower_l",
                },
                coverage = 90,
            },
            {
                coverage = 100,
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                subparts = {
                    "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l", "leg_hip_gastropod_l",
                    "leg_hip_gastropod_r", "leg_upper_gastropod", "tail_default_base",
                    "tail_default_center",
                },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 100,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_front_middle_l",
                    "tentacle_lower_middle_base_l", "tentacle_lower_middle_middle_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_rear_middle_l",
                    "tentacle_lower_front_base_r", "tentacle_lower_front_middle_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_middle_middle_r",
                    "tentacle_lower_rear_base_r", "tentacle_lower_rear_middle_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "military_poncho_heavy",
    category = "clothing",
    looks_like = "cloak",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.text("heavy military poncho"),
    description = ccb.content.text("A standard issue, heavy nylon poncho with a hood.  It has a cinch cord around the hood and grommets to attach a liner, or to use it as a standard tarp."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "nylon" },
    mass = "1100 g",
    volume = "3800 ml",
    flags = {
        "RAINPROOF", "HOOD", "OVERSIZE", "OUTER", "STURDY", "ALLOWS_GASTROPOD_FOOT",
        "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS", "NO_WING_GLIDING",
    },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "4000 ml",
            mass_limit = "900 g",
            moves = 200,
            description = ccb.content.text("Grommets for a poncho liner."),
            allowed_items = { "military_poncho_liner", "robofac_poncho_liner" },
        },
    },
    armor = {
        environmental_protection = 4,
        warmth = 5,
        thickness = 0.4,
        portions = {
            {
                encumbrance = 4,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
            },
            {
                encumbrance = 4,
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_shoulder_l", "arm_shoulder_r", "arm_upper_r", "arm_upper_l", "arm_elbow_r",
                    "arm_elbow_l", "arm_wing_bird_shoulder_l", "arm_wing_bird_shoulder_r",
                    "arm_wing_bird_upper_l", "arm_wing_bird_upper_r", "arm_wing_bat_shoulder_l",
                    "arm_wing_bat_shoulder_r", "arm_wing_bat_upper_l", "arm_wing_bat_upper_r",
                    "arm_wing_bird_elbow_r", "arm_wing_bird_elbow_l", "arm_wing_bat_elbow_r",
                    "arm_wing_bat_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_lower_l", "arm_lower_r", "arm_wing_bird_lower_r", "arm_wing_bird_lower_l",
                    "arm_wing_bat_lower_r", "arm_wing_bat_lower_l",
                },
                coverage = 90,
            },
            {
                coverage = 100,
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                subparts = {
                    "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l", "leg_hip_gastropod_l",
                    "leg_hip_gastropod_r", "leg_upper_gastropod", "tail_default_base",
                    "tail_default_center",
                },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 100,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_front_middle_l",
                    "tentacle_lower_middle_base_l", "tentacle_lower_middle_middle_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_rear_middle_l",
                    "tentacle_lower_front_base_r", "tentacle_lower_front_middle_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_middle_middle_r",
                    "tentacle_lower_rear_base_r", "tentacle_lower_rear_middle_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "military_poncho_liner",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.text("military poncho liner"),
    description = ccb.content.text("Often called a \"woobie\" by soldiers, this sleeping bag-like poncho liner can be attached under a poncho or used as a blanket.  The synthetic stuffing makes it quite warm."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "nylon" },
    mass = "900 g",
    volume = "4000 ml",
    flags = {
        "OVERSIZE", "OUTER", "SOFT", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS",
        "NO_WING_GLIDING",
    },
    armor = {
        warmth = 50,
        environmental_protection = 4,
        thickness = 0.4,
        portions = {
            {
                encumbrance = 15,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
            },
            {
                encumbrance = 15,
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_shoulder_l", "arm_shoulder_r", "arm_upper_r", "arm_upper_l", "arm_elbow_r",
                    "arm_elbow_l", "arm_wing_bird_shoulder_l", "arm_wing_bird_shoulder_r",
                    "arm_wing_bird_upper_l", "arm_wing_bird_upper_r", "arm_wing_bat_shoulder_l",
                    "arm_wing_bat_shoulder_r", "arm_wing_bat_upper_l", "arm_wing_bat_upper_r",
                    "arm_wing_bird_elbow_r", "arm_wing_bird_elbow_l", "arm_wing_bat_elbow_r",
                    "arm_wing_bat_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                subparts = {
                    "arm_lower_l", "arm_lower_r", "arm_wing_bird_lower_r", "arm_wing_bird_lower_l",
                    "arm_wing_bat_lower_r", "arm_wing_bat_lower_l",
                },
                coverage = 90,
            },
            {
                coverage = 100,
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                subparts = {
                    "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l", "leg_hip_gastropod_l",
                    "leg_hip_gastropod_r", "leg_upper_gastropod", "tail_default_base",
                    "tail_default_center",
                },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 100,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_front_middle_l",
                    "tentacle_lower_middle_base_l", "tentacle_lower_middle_middle_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_rear_middle_l",
                    "tentacle_lower_front_base_r", "tentacle_lower_front_middle_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_middle_middle_r",
                    "tentacle_lower_rear_base_r", "tentacle_lower_rear_middle_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "coat_straw",
    name = ccb.content.text("straw cape"),
    description = ccb.content.text("A bulky traditional Japanese raincoat made from straw, which covers the entire body.  Also known as mino."),
    mass = "907 g",
    volume = "4 L",
    price = "90 USD",
    survival_price = "25 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "yellow",
    flags = { "OVERSIZE", "RAINPROOF", "BELTED", "ALLOWS_WING_ARMS", "NO_WING_GLIDING" },
    armor = {
        portions = {
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 80, encumbrance = 12 },
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
            {
                covers = { "leg_l", "leg_r", "gastropod_foot", "tail" },
                subparts = {
                    "leg_upper_l", "leg_upper_r", "leg_knee_r", "leg_knee_l", "leg_hip_r", "leg_hip_l",
                    "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod",
                    "tail_default_base", "tail_default_center",
                },
                coverage = 100,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 10,
            },
            {
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_wing_bat_l",
                    "arm_wing_bat_r",
                    "arm_wing_bird_l",
                    "arm_wing_bird_r",
                },
                coverage = 40,
                encumbrance = 2,
            },
        },
        warmth = 15,
        thickness = 2,
    },
}

ccb.content.define_item {
    id = "snuggie",
    name = ccb.content.text("snuggie"),
    description = ccb.content.text("Perfect for reading all those books you scavenged."),
    mass = "625 g",
    volume = "3 L",
    price = "36 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "blanket",
    color = "light_red",
    flags = { "UNRESTRICTED", "OUTER" },
    armor = {
        warmth = 50,
        thickness = 2,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 20,
                coverage = 85,
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
}
