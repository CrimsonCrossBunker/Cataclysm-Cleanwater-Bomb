local ccb = require("ccb")

ccb.content.define_item {
    id = "wetsuit_spring",
    name = ccb.content.text("spring suit"),
    description = ccb.content.text("A long-sleeved spring wetsuit with pink color details and cleavage-enhancing, hip-accentuating construction.  Not as protective as a full-body suit, but also less restrictive."),
    mass = "550 g",
    volume = "4 L",
    price = "100 USD",
    survival_price = "5 USD",
    materials = { "neoprene" },
    symbol = "[",
    looks_like = "wetsuit",
    color = "pink",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 5,
                volume_encumbrance = 0.25,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 5, 5 },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 75,
                subparts = { "leg_hip_l", "leg_hip_r" },
                encumbrance = { 0, 0 },
            },
        },
        warmth = 10,
        environmental_protection = 6,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_spring",
    copy_from = "wetsuit_spring",
    name = ccb.content.text("spring suit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_spring",
    copy_from = "wetsuit_spring",
    name = ccb.content.text("spring suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_spring_sleeveless",
    name = ccb.content.text("sleeveless spring suit"),
    description = ccb.content.text("A sleeveless spring wetsuit with an ocean blue color and cleavage-enhancing, hip-accentuating construction.  Not as protective as a full-body suit, but also less restrictive."),
    mass = "300 g",
    volume = "3 L",
    price = "80 USD",
    survival_price = "4 USD 50 cent",
    materials = { "neoprene" },
    symbol = "[",
    looks_like = "wetsuit_spring",
    color = "blue",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "torso" },
                coverage = 90,
                encumbrance = 5,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 75,
                subparts = { "leg_hip_l", "leg_hip_r" },
                encumbrance = 0,
            },
        },
        warmth = 8,
        environmental_protection = 6,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_spring_sleeveless",
    copy_from = "wetsuit_spring_sleeveless",
    name = ccb.content.text("sleeveless spring suit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_spring_sleeveless",
    copy_from = "wetsuit_spring_sleeveless",
    name = ccb.content.text("sleeveless spring suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- Will be based on this: https://www.hammacher.com/product/chainmail-sharkproof-suit
ccb.content.define_item {
    id = "shark_suit_faraday",
    name = ccb.content.text("faraday sharksuit"),
    description = ccb.content.text("A one-piece chainmail suit used by SCUBA divers for protection against shark bites.  It has been conductively interconnected, protecting against electricity."),
    mass = "8164 g",
    volume = "3500 ml",
    price = "350 USD",
    survival_price = "60 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    looks_like = "chainmail_hauberk",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "ELECTRIC_IMMUNE" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                encumbrance = 30,
                coverage = 100,
                covers = { "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r" },
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
            },
            {
                coverage = 100,
                covers = { "foot_l", "foot_r", "head" },
                encumbrance = 25,
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_shark_suit_faraday",
    copy_from = "shark_suit_faraday",
    name = ccb.content.text("faraday sharksuit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_shark_suit_faraday",
    copy_from = "shark_suit_faraday",
    name = ccb.content.text("faraday sharksuit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- Will be based on this: https://www.hammacher.com/product/chainmail-sharkproof-suit, helmet will be a separate piece
ccb.content.define_item {
    id = "shark_suit",
    name = ccb.content.text("sharksuit"),
    description = ccb.content.text("A-one piece chainmail suit used by SCUBA divers for protection against shark bites."),
    mass = "8164 g",
    volume = "3500 ml",
    price = "350 USD",
    survival_price = "50 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    looks_like = "chainmail_suit",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                encumbrance = 30,
                coverage = 100,
                covers = { "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r" },
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
            },
            {
                coverage = 100,
                covers = { "foot_l", "foot_r", "head" },
                encumbrance = 25,
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_shark_suit",
    copy_from = "shark_suit_faraday",
    name = ccb.content.text("sharksuit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_shark_suit",
    copy_from = "shark_suit",
    name = ccb.content.text("sharksuit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "goggles_swim",
    name = ccb.content.plural_text("swim goggles", "swim goggles"),
    description = ccb.content.text("A small pair of goggles made for swimming."),
    mass = "81 g",
    volume = "250 ml",
    price = "11 USD",
    survival_price = "50 cent",
    materials = { "plastic", "rubber" },
    symbol = "[",
    looks_like = "goggles_welding",
    color = "light_blue",
    flags = { "WATER_FRIENDLY", "WATERPROOF", "SWIM_GOGGLES", "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 10,
        environmental_protection = 16,
        portions = {
            {
                materials = {
                    { id = "rubber", coverage = 20, thickness = 1.0 },
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 10,
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "wetsuit_gloves",
    name = ccb.content.plural_text("diving gloves (pair)", "diving gloves (pair)"),
    description = ccb.content.text("A pair of flexible neoprene-silicone rubber gloves, suitable for underwater use."),
    mass = "80 g",
    volume = "500 ml",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    looks_like = "gloves_tactical",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        warmth = 30,
        environmental_protection = 10,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 3.0 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_gloves",
    copy_from = "wetsuit_gloves",
    name = ccb.content.plural_text("diving gloves (pair)", "diving gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_gloves",
    copy_from = "wetsuit_gloves",
    name = ccb.content.plural_text("diving gloves (pair)", "diving gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_gloves_thick",
    copy_from = "wetsuit_gloves",
    name = ccb.content.plural_text("thick diving gloves (pair)", "thick diving gloves (pair)"),
    description = ccb.content.text("A pair of thick neoprene-silicone rubber gloves, suitable for underwater use."),
    mass = "90 g",
    armor = {
        warmth = 50,
        environmental_protection = 12,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "neoprene", coverage = 100, thickness = 5.0 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 16,
            },
        },
    },
    inheritance = { add = { flags = { "NORMAL" } } },
}

ccb.content.define_item {
    id = "xl_wetsuit_gloves_thick",
    copy_from = "wetsuit_gloves_thick",
    name = ccb.content.plural_text("thick diving gloves (pair)", "thick diving gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_gloves_thick",
    copy_from = "wetsuit_gloves_thick",
    name = ccb.content.plural_text("thick diving gloves (pair)", "thick diving gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- Based on OTS Spectrum mask
ccb.content.define_item {
    id = "divemask_full_scuba_notready",
    name = ccb.content.text("full-face diving mask"),
    description = ccb.content.text("A full-face diving mask that covers the face and eyes.  It requires a separate rebreather mask or SCUBA regulator for full protection."),
    mass = "1040 g",
    volume = "1500 ml",
    price = "400 USD",
    survival_price = "20 USD",
    materials = { "plastic", "rubber", "thermo_resin" },
    symbol = "[",
    looks_like = "mask_h20survivor",
    color = "blue",
    flags = { "WATER_FRIENDLY", "RAINPROOF", "SWIM_GOGGLES" },
    armor = {
        warmth = 10,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "rubber", coverage = 20, thickness = 1.0 },
                    { id = "plastic", coverage = 100, thickness = 3.0 },
                    { id = "thermo_resin", coverage = 20, thickness = 2.0 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 10,
                rigid_only = true,
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 3.0 },
                    { id = "plastic", coverage = 20, thickness = 2.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                subparts = { "mouth_cheeks", "mouth_chin", "mouth_nose" },
                rigid_only = true,
            },
        },
    },
}

-- Based on Kirby Morgan M-48 MOD-1 mask
ccb.content.define_item {
    id = "divemask_full_modular",
    name = ccb.content.text("modular full-face diving mask"),
    description = ccb.content.text("A high-end modular full-face diving mask that covers the face and eyes.  It requires a separate rebreather mask or SCUBA regulator for full protection."),
    mass = "830 g",
    volume = "1500 ml",
    price = "400 USD",
    survival_price = "20 USD",
    materials = { "plastic", "rubber", "thermo_resin" },
    symbol = "[",
    looks_like = "mask_h20survivor",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "WATERPROOF", "SWIM_GOGGLES" },
    armor = {
        warmth = 10,
        environmental_protection = 16,
        portions = {
            {
                materials = {
                    { id = "rubber", coverage = 20, thickness = 1.0 },
                    { id = "plastic", coverage = 100, thickness = 3.0 },
                    { id = "thermo_resin", coverage = 25, thickness = 3.0 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 10,
                rigid_only = true,
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 3.0 },
                    { id = "thermo_resin", coverage = 40, thickness = 3.0 },
                },
                covers = { "mouth" },
                subparts = { "mouth_nose" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                    { id = "thermo_resin", coverage = 50, thickness = 3.0 },
                },
                covers = { "mouth" },
                subparts = { "mouth_cheeks", "mouth_chin" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}
