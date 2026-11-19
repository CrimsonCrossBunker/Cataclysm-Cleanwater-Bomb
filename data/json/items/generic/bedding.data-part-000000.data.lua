local ccb = require("ccb")

-- 1.6 grams per mL
ccb.content.define_item {
    id = "sheet",
    name = ccb.content.text("sheet"),
    description = ccb.content.text("A 72 by 24 inch two-layer-thick fabric sheet.  It could be used as a curtain or bedsheet, or cut up for a bunch of smaller sheets."),
    category = "other",
    mass = "282 g",
    volume = "564 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "blanket",
    color = "white",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 15,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

-- Based on https://www.amazon.com/dp/B091DZVHX7 with the assumed material thickness of 0.8cm
-- Comes out to be about 1% ish spawn, don't increase this, although it uses a joke about being more common I think it would be annoying for it to crop up too much.
-- Note to self, look up if ever popular is hyphenated.  If you're seeing this tell me so I can remember to look.
ccb.content.define_item {
    id = "blanket",
    name = ccb.content.text("blanket"),
    description = ccb.content.text("Hiding under here will not protect you from the monsters."),
    mass = "848 g",
    volume = "15500 ml",
    price = "15 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "towel",
    color = "blue",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    variants = {
        {
            id = "blanket_makeshift",
            name = ccb.content.text("makeshift blanket"),
            description = ccb.content.text("A blanket made by you!  Embrace your inner tailor."),
            expand_snippets = true,
            weight = 0,
        },
        {
            id = "blanket_sports",
            name = ccb.content.text("sports blanket"),
            description = ccb.content.text("This blanket is official sports memorabilia, or so says the tag.  It features the name and mascot of the <sports_teams>!"),
            expand_snippets = true,
            weight = 50,
        },
        {
            id = "blanket_sports_collectable",
            name = ccb.content.text("collectable sports blanket"),
            description = ccb.content.text("This blanket is an alleged collector's piece, featuring the name and mascot of the <sports_teams>!  The tag explains that only 100,000 were made and reads: #<number><number><number><number><number>."),
            expand_snippets = true,
            weight = 10,
        },
        {
            id = "blanket_geometric",
            name = ccb.content.text("geometric blanket"),
            description = ccb.content.text("A standard blanket, except that the stitching across the surface is patterned in <geometric_patterns>s."),
            expand_snippets = true,
            weight = 250,
        },
        {
            id = "blanket_fluffy",
            name = ccb.content.text("fluffy blanket"),
            description = ccb.content.text("This blanket's tag lists it as \"the fluffiest blanket in the world\" and was made in the USA.  Only moderately fluffy."),
            expand_snippets = true,
            weight = 50,
        },
        {
            id = "blanket_floral",
            name = ccb.content.text("floral blanket"),
            description = ccb.content.text("The ever popular floral print blanket.  This one is patterned with <flowers>.  Popular with grandmothers."),
            expand_snippets = true,
            weight = 250,
        },
        {
            id = "blanket_cartoon",
            name = ccb.content.text("cartoon blanket"),
            description = ccb.content.text("A blanket adorned with a famous animated character!  It depicts <cartoon_blanket>!"),
            expand_snippets = true,
            weight = 50,
        },
    },
    armor = {
        warmth = 50,
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 35,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

-- Based vaguely on https://www.amazon.com/BETU-Weighted-Blanket-Blankets-Factory/dp/B08N66D947 the 60x80 12lb version.
ccb.content.define_item {
    id = "blanket_weighted",
    name = ccb.content.text("weighted blanket"),
    description = ccb.content.text("A thick, layered blanket with glass microbeads added to increase the weight."),
    mass = "5670 g",
    volume = "18000 ml",
    copy_from = "blanket",
    price = "30 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "blanket",
    color = "blue",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    variant_kind = "generic",
    variants = {
        {
            id = "blanket_weighted_geometric",
            name = ccb.content.text("weighted geometric blanket"),
            description = ccb.content.text("It's been stitched in a <geometric_patterns> pattern."),
            expand_snippets = true,
            append = true,
        },
    },
    armor = {
        warmth = 60,
        thickness = 2,
        portions = {
            {
                encumbrance = 50,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "down_blanket",
    name = ccb.content.text("down-filled blanket"),
    description = ccb.content.text("Hiding under here will not protect you from the monsters, but it'll keep you warm."),
    mass = "3500 g",
    volume = "15 L",
    price = "55 USD",
    survival_price = "1 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "blanket",
    color = "blue",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 70,
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 45,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "fur_blanket",
    name = ccb.content.text("fur blanket"),
    description = ccb.content.text("A heavy fur blanket that covers most of your body."),
    mass = "3500 g",
    volume = "31 L",
    price = "195 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "fur" },
    symbol = "[",
    looks_like = "blanket",
    color = "brown",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 80,
        thickness = 2,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 55,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "quilt",
    name = ccb.content.text("quilt"),
    description = ccb.content.text("A big, comfy quilt made of thick wool in a triangle pattern.  Extremely cozy!"),
    mass = "1814 g",
    volume = "5 L",
    price = "55 USD",
    survival_price = "2 USD",
    materials = { "wool" },
    symbol = "[",
    color = "white",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    looks_like = "down_blanket",
    armor = {
        warmth = 75,
        thickness = 1,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 40,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "quilt_patchwork",
    copy_from = "quilt",
    name = ccb.content.text("patchwork quilt"),
    description = ccb.content.text("A huge, patchwork wool quilt.  Very, very warm."),
    materials = { "wool" },
    armor = {
        warmth = 70,
        portions = {
            {
                encumbrance = 50,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

-- https://www.lomo.co.uk/products/emergency-foil-blanket-sliver-10-pack/
ccb.content.define_item {
    id = "emer_blanket",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.text("emergency blanket"),
    description = ccb.content.text("A blanket made of space-age material that covers your most important body parts.  It folds into a very compact form when not in use."),
    price = "4 USD 25 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    mass = "50 g",
    volume = "200 ml",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "SOFT", "ALLOWS_GASTROPOD_FOOT",
        "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 50,
        environmental_protection = 1,
        thickness = 0.01,
        portions = {
            {
                encumbrance = 50,
                coverage = 90,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}
