local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_plantskin",
    category = "armor",
    name = ccb.content.text("phelloderm"),
    description = ccb.content.text("A pliable but hefty layer of living plant matter."),
    mass = "2 kg",
    volume = "2100 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood", "veggy" },
    symbol = "x",
    color = "light_green",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY", "SOFT",
        "ALLOWS_TALONS",
    },
    armor = {
        warmth = 1,
        environmental_protection = 2,
        portions = {
            {
                materials = {
                    { id = "veggy", coverage = 100, thickness = 2 },
                    { id = "wood", coverage = 100, thickness = 0.5 },
                },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "vine_limb_upper_r", "vine_limb_upper_l", "vine_limb_lower_r", "vine_limb_lower_l",
                    "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 1,
                breathability = "GOOD",
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_bark",
    category = "armor",
    name = ccb.content.plural_text("protective bark", "protective bark"),
    description = ccb.content.text("A powerful layer of bark, thicker in parts."),
    mass = "6 kg",
    volume = "7500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "NORMAL", "WATERPROOF", "IRRITANT_IMMUNE",
        "PADDED", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 1,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 4 },
                    { id = "wood", coverage = 75, thickness = 6 },
                },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "vine_limb_upper_r", "vine_limb_upper_l", "vine_limb_lower_r", "vine_limb_lower_l",
                    "torso", "head",
                },
                coverage = 100,
                encumbrance = 9,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_bark2_a",
    category = "armor",
    name = ccb.content.plural_text("distributed bark", "distributed bark"),
    description = ccb.content.text("Your bark is spread evenly across your body."),
    mass = "12 kg",
    volume = "15 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "NORMAL", "WATERPROOF", "IRRITANT_IMMUNE",
        "PADDED", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 2,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "wood", coverage = 75, thickness = 7 },
                },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "vine_limb_upper_r", "vine_limb_upper_l", "vine_limb_lower_r", "vine_limb_lower_l",
                    "torso", "head",
                },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_bark2_b",
    category = "armor",
    name = ccb.content.plural_text("consolidated bark", "consolidated bark"),
    description = ccb.content.text("Your bark is pulled together to protect your torso."),
    mass = "12 kg",
    volume = "15 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "NORMAL", "WATERPROOF", "IRRITANT_IMMUNE",
        "PADDED", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 2,
        environmental_protection = 4,
        portions = {
            {
                materials = { { id = "wood", coverage = 100, thickness = 15 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 4.5 },
                    { id = "wood", coverage = 50, thickness = 5.5 },
                },
                covers = {
                    "leg_l", "leg_r", "arm_l", "arm_r", "vine_limb_upper_r", "vine_limb_upper_l",
                    "vine_limb_lower_r", "vine_limb_lower_l", "head",
                },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 3 },
                    { id = "wood", coverage = 40, thickness = 4 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_back_l",
                    "hand_back_r",
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_wrist_l",
                    "hand_wrist_r",
                },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 3 },
                    { id = "wood", coverage = 40, thickness = 4 },
                },
                covers = {
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 100,
                encumbrance = 6,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_bark2_c",
    category = "armor",
    name = ccb.content.plural_text("latticed bark", "latticed bark"),
    description = ccb.content.text("Your bark is latticed into a larger frame."),
    mass = "12 kg",
    volume = "15 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "NORMAL",
        "OUTER",
        "PADDED",
        "ALLOWS_TALONS",
    },
    armor = {
        warmth = 2,
        environmental_protection = 2,
        portions = {
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 9.5 },
                    { id = "wood", coverage = 60, thickness = 7 },
                },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "vine_limb_upper_r", "vine_limb_upper_l", "vine_limb_lower_r", "vine_limb_lower_l",
                    "torso", "head",
                },
                coverage = 100,
                encumbrance = 16,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 9.5 },
                    { id = "wood", coverage = 60, thickness = 7 },
                },
                covers = { "mouth", "eyes" },
                coverage = 90,
                encumbrance = 8,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_feathers",
    category = "armor",
    name = ccb.content.plural_text("feathers", "feathers"),
    description = ccb.content.text("Iridescent feathers covering your entire body.  Provides some warmth and protection from the elements, but could be thicker."),
    mass = "640 g",
    volume = "800 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_feather" },
    symbol = "x",
    color = "white",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 15,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_feather", coverage = 100, thickness = 4 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "torso", "head",
                },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_lightfur",
    category = "armor",
    name = ccb.content.plural_text("light fur", "light fur"),
    description = ccb.content.text("Thin, patchy fur that clearly needs to grow more."),
    mass = "300 g",
    volume = "300 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "white",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 2 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 1 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_fur",
    category = "armor",
    name = ccb.content.plural_text("fur", "fur"),
    description = ccb.content.text("Though it's quite warm, your fur is also quite protective."),
    mass = "700 g",
    volume = "700 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "light_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = {
        warmth = 20,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 4 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r", "torso", "tail" },
                coverage = 100,
                encumbrance = 1,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 2 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "head",
                },
                coverage = 100,
                encumbrance = 1,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 1 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_ursine_fur",
    category = "armor",
    name = ccb.content.text("shaggy fur"),
    description = ccb.content.text("A heavy shag carpet of fur, somewhere between a ballistic vest and attic insulation."),
    mass = "2 kg",
    volume = "2 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "NORMAL", "WATER_FRIENDLY", "SOFT" },
    armor = {
        warmth = 45,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 14 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r", "torso", "tail" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 9 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "foot_l",
                    "foot_r", "avian_talon_l", "avian_talon_r", "animal_paw_l", "animal_paw_r", "head",
                },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 5 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_ursine_fur_summer",
    category = "armor",
    name = ccb.content.text("scruffy fur"),
    description = ccb.content.text("While still formidable, this furry hide has lost a lot of its bulk to better endure the summer months."),
    mass = "2 kg",
    volume = "2 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "NORMAL", "WATER_FRIENDLY", "SOFT" },
    armor = {
        warmth = 32,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 10 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r", "torso", "tail" },
                coverage = 100,
                encumbrance = 3,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 6 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "foot_l",
                    "foot_r", "avian_talon_l", "avian_talon_r", "animal_paw_l", "animal_paw_r", "head",
                },
                coverage = 100,
                encumbrance = 4,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 3 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_lupine_fur",
    category = "armor",
    name = ccb.content.text("gray fur"),
    description = ccb.content.text("The fur of a strong, wild creature."),
    mass = "1 kg",
    volume = "1 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "dark_gray",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "SKINTIGHT",
        "RAINPROOF",
        "IRRITANT_IMMUNE",
    },
    armor = {
        warmth = 25,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 8 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r", "torso", "tail" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 6 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "head",
                },
                coverage = 100,
                encumbrance = 1,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 3 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_lupine_fur_summer",
    category = "armor",
    name = ccb.content.text("summer coat"),
    description = ccb.content.text("A covering of fur that has thinned out for the summer."),
    mass = "1 kg",
    volume = "1 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "dark_gray",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "SKINTIGHT",
        "RAINPROOF",
        "IRRITANT_IMMUNE",
    },
    armor = {
        warmth = 18,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 6 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r", "torso", "tail" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 4 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "head",
                },
                coverage = 100,
                encumbrance = 1,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 2 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_feline_fur",
    category = "armor",
    name = ccb.content.text("sleek fur"),
    description = ccb.content.text("The fur of a proud, wise creature."),
    mass = "1 kg",
    volume = "1 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "brown",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT" },
    armor = {
        warmth = 13,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 4 } },
                covers = {
                    "hand_l", "hand_r", "paw_l", "paw_r", "paw_rat_l", "paw_rat_r", "paw_little_l",
                    "paw_little_r", "foot_l", "foot_r", "avian_talon_l", "avian_talon_r", "animal_paw_l",
                    "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r", "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 2 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_rabbitfur",
    category = "armor",
    name = ccb.content.plural_text("rabbit fur", "rabbit fur"),
    description = ccb.content.text("Soft, fluffy fur for a soft, fluffy rabbit."),
    mass = "350 g",
    volume = "350 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "white",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 12,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 3 } },
                covers = {
                    "hand_l", "hand_r", "paw_broad_l", "paw_broad_r", "paw_l", "paw_r", "paw_rat_l",
                    "paw_rat_r", "paw_little_l", "paw_little_r", "foot_l", "foot_r",
                    "animal_paw_rabbit_l", "animal_paw_rabbit_r", "animal_paw_l", "animal_paw_r",
                    "leg_l", "leg_r", "arm_l", "arm_r", "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 2 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_lynx_fur",
    category = "armor",
    name = ccb.content.text("lynx fur"),
    description = ccb.content.text("A pile of fur around the neck, protecting from foes that go for the throat."),
    mass = "200 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "*",
    color = "brown",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "NORMAL", "COLLAR" },
    armor = {
        warmth = 7,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 4 } },
                covers = { "head" },
                coverage = 100,
                vitals_coverage = 65,
                encumbrance = 1,
                subparts = { "head_throat" },
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_patchskin1",
    category = "armor",
    name = ccb.content.text("jumbled skin"),
    description = ccb.content.text("Skin like a spilled tub of paints, splattered in abstract shapes of chitin, fur, and hide."),
    mass = "1 kg",
    volume = "1 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather", "mut_fur", "leather_arthropod", "wool", "hflesh" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "SKINTIGHT",
        "WATER_FRIENDLY",
        "SOFT",
        "NO_SALVAGE",
    },
    armor = {
        warmth = 7,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "leather", coverage = 33, thickness = 3 },
                    { id = "fur", coverage = 33, thickness = 3 },
                    { id = "leather_arthropod", coverage = 33, thickness = 3 },
                    { id = "wool", coverage = 33, thickness = 3 },
                    { id = "hflesh", coverage = 100, thickness = 2 },
                },
                covers = {
                    "hand_l", "hand_r", "foot_l", "foot_r", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r", "arm_insect_l",
                    "arm_insect_r", "arm_insect_good_l", "arm_insect_good_r", "insect_hand_l",
                    "insect_hand_r", "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_patchskin2",
    category = "armor",
    name = ccb.content.text("patchwork skin"),
    description = ccb.content.text("Beauty is only skin deep, but with this skin, a knife might find itself broken in the beauty layer."),
    mass = "2 kg",
    volume = "2 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather", "bone", "mut_fur", "acidchitin", "leather_arthropod", "wool", "flesh" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "WATER_FRIENDLY",
        "IRRITANT_IMMUNE", "SOFT", "TOUGH_FEET", "NO_SALVAGE",
    },
    armor = {
        warmth = 12,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "leather", coverage = 35, thickness = 3 },
                    { id = "bone", coverage = 35, thickness = 3 },
                    { id = "fur", coverage = 35, thickness = 3 },
                    { id = "acidchitin", coverage = 35, thickness = 3 },
                    { id = "leather_arthropod", coverage = 35, thickness = 3 },
                    { id = "wool", coverage = 35, thickness = 3 },
                    { id = "flesh", coverage = 100, thickness = 2.5 },
                },
                covers = {
                    "hand_l", "hand_r", "foot_l", "foot_r", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r", "arm_insect_l",
                    "arm_insect_r", "arm_insect_good_l", "arm_insect_good_r", "insect_hand_l",
                    "insect_hand_r", "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_patchskin3",
    category = "armor",
    name = ccb.content.plural_text("patchwork armor", "patchwork armor"),
    description = ccb.content.text("Folks that can't catch bullets with their skin insist that it's what's on the inside that counts.  Those folks don't know anything."),
    mass = "3 kg",
    volume = "800 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = {
        "leather", "alien_carapace", "mut_bone", "mut_fur", "iflesh", "acidchitin", "leather_arthropod",
        "wool", "flesh",
    },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "NORMAL", "WATER_FRIENDLY", "PADDED",
        "IRRITANT_IMMUNE", "NO_SALVAGE",
    },
    armor = {
        warmth = 15,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "leather", coverage = 41, thickness = 3 },
                    { id = "alien_carapace", coverage = 41, thickness = 3 },
                    { id = "bone", coverage = 41, thickness = 3 },
                    { id = "fur", coverage = 41, thickness = 3 },
                    { id = "iflesh", coverage = 41, thickness = 3 },
                    { id = "acidchitin", coverage = 41, thickness = 3 },
                    { id = "leather_arthropod", coverage = 41, thickness = 3 },
                    { id = "wool", coverage = 41, thickness = 3 },
                    { id = "flesh", coverage = 100, thickness = 3 },
                },
                covers = {
                    "hand_l", "hand_r", "foot_l", "foot_r", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "leg_l", "leg_r", "arm_l", "arm_r", "arm_insect_l",
                    "arm_insect_r", "arm_insect_good_l", "arm_insect_good_r", "insect_hand_l",
                    "insect_hand_r", "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 9,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_mandibles",
    category = "armor",
    name = ccb.content.plural_text("mandibles", "mandibles"),
    description = ccb.content.text("These are much better than puny human mouthparts."),
    mass = "200 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = ";",
    color = "dark_gray",
    techniques = { "FANGS_SPIDER_BITE", "FANGS_BITE_NATURAL", "FANGS_BITE_CRIT" },
    flags = {
        "INTEGRATED", "PROVIDES_TECHNIQUES", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT",
        "PADDED", "NO_SALVAGE",
    },
    melee_damage = { stab = 12 },
    armor = {
        warmth = 2,
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "mouth" },
                coverage = 40,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_fangs_spider",
    category = "armor",
    name = ccb.content.plural_text("folding fangs", "folding fangs"),
    description = ccb.content.text("Your fangs have properly developed, and are prepared for the kill."),
    mass = "300 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "sclerotin" },
    symbol = ";",
    color = "brown",
    techniques = { "FANGS_SPIDER_BITE", "FANGS_BITE_NATURAL", "FANGS_BITE_CRIT" },
    flags = {
        "INTEGRATED", "PROVIDES_TECHNIQUES", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL",
        "WATER_FRIENDLY", "PADDED",
    },
    melee_damage = { stab = 15 },
    armor = {
        warmth = 2,
        portions = {
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 3 } },
                covers = { "mouth" },
                coverage = 40,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_chitin",
    category = "armor",
    name = ccb.content.text("epicuticle"),
    description = ccb.content.text("Your chitinous skin doesn't sweat so well and it's a bit stiffer than before, but it's far more durable than your old human skin."),
    mass = "1 kg",
    volume = "1500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather_arthropod" },
    symbol = "x",
    color = "green",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 2,
        environmental_protection = 2,
        portions = {
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.5 } },
                covers = {
                    "hand_l", "hand_r", "crustacean_pincer_r", "foot_l", "foot_r", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "leg_l", "leg_r",
                    "leg_crab_front_l", "leg_crab_front_r", "leg_crab_rear_l", "leg_crab_rear_r",
                    "arm_l", "arm_r", "arm_insect_l", "arm_insect_r", "arm_insect_good_l",
                    "arm_insect_good_r", "insect_hand_l", "insect_hand_r", "torso", "head", "tail",
                },
                coverage = 100,
                encumbrance = 2,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.5 } },
                covers = { "mouth", "muzzle" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_chitin2",
    category = "armor",
    name = ccb.content.text("chitin carapace"),
    description = ccb.content.text("The skin hardens, develops.  Good, it will be needed."),
    mass = "3 kg",
    volume = "5 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = "x",
    color = "dark_gray",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "BLOCK_WHILE_WORN", "UNBREAKABLE", "NORMAL",
        "WATER_FRIENDLY", "IRRITANT_IMMUNE", "NO_SALVAGE", "PADDED", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 8,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 2.8 } },
                covers = { "head", "head_dragonfly" },
                coverage = 95,
                encumbrance = 5,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 4.4 } },
                covers = { "torso", "tail" },
                coverage = 95,
                encumbrance = 6,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3.2 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r", "arm_insect_upper_l",
                    "arm_insect_lower_l", "arm_insect_upper_r", "arm_insect_lower_r",
                },
                coverage = 95,
                encumbrance = 2,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r",
                    "arm_insect_elbow_l", "arm_insect_elbow_r",
                },
                coverage = 95,
                encumbrance = 3,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3.2 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_lower_l", "leg_upper_r", "leg_lower_r" },
                coverage = 95,
                encumbrance = 3,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_knee_l", "leg_hip_r", "leg_knee_r" },
                coverage = 95,
                encumbrance = 3,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 2.2 } },
                covers = { "hand_l", "hand_r", "crustacean_pincer_r", "insect_hand_l", "insect_hand_r" },
                coverage = 85,
                encumbrance = 3,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 2.2 } },
                covers = {
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 90,
                encumbrance = 3,
            },
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "leg_crab_front_l", "leg_crab_front_r", "leg_crab_rear_l", "leg_crab_rear_r" },
                coverage = 95,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_chitin2_molted",
    category = "armor",
    name = ccb.content.text("fresh chitin carapace"),
    description = ccb.content.text("The exoskeleton is soft and vulnerable.  It would be best to hide until it hardens."),
    mass = "1500 g",
    volume = "1 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather_arthropod" },
    symbol = "x",
    color = "dark_gray",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "BLOCK_WHILE_WORN", "UNBREAKABLE", "NORMAL",
        "WATER_FRIENDLY", "PADDED", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 8,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.4 } },
                covers = { "head", "head_dragonfly" },
                coverage = 95,
                encumbrance = 3,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.2 } },
                covers = { "torso", "tail" },
                coverage = 95,
                encumbrance = 4,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.6 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r", "arm_insect_upper_l",
                    "arm_insect_lower_l", "arm_insect_upper_r", "arm_insect_lower_r",
                },
                coverage = 95,
                encumbrance = 1,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.5 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r",
                    "arm_insect_elbow_l", "arm_insect_elbow_r",
                },
                coverage = 95,
                encumbrance = 2,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.6 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_lower_l", "leg_upper_r", "leg_lower_r" },
                coverage = 95,
                encumbrance = 2,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.5 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_knee_l", "leg_hip_r", "leg_knee_r" },
                coverage = 95,
                encumbrance = 2,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.1 } },
                covers = { "hand_l", "hand_r", "crustacean_pincer_r" },
                coverage = 85,
                encumbrance = 2,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.1 } },
                covers = {
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 90,
                encumbrance = 2,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.5 } },
                covers = { "leg_crab_front_l", "leg_crab_front_r", "leg_crab_rear_l", "leg_crab_rear_r" },
                coverage = 95,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_chitin3",
    category = "armor",
    name = ccb.content.plural_text("sclerotin plate", "sclerotin plate"),
    description = ccb.content.text("When the time comes to prey, this platemail will be ready for any resistance."),
    mass = "12 kg",
    volume = "15 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "sclerotin" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "BLOCK_WHILE_WORN", "UNBREAKABLE", "OUTER", "PADDED",
        "IRRITANT_IMMUNE", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4 } },
                covers = { "head", "head_dragonfly" },
                coverage = 95,
                encumbrance = 12,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 7 } },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 15,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4.6 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r", "arm_insect_upper_l",
                    "arm_insect_lower_l", "arm_insect_upper_r", "arm_insect_lower_r",
                },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4.4 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r",
                    "arm_insect_elbow_l", "arm_insect_elbow_r",
                },
                coverage = 90,
                encumbrance = 7,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4.8 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_lower_l", "leg_upper_r", "leg_lower_r" },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4.6 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_knee_l", "leg_hip_r", "leg_knee_r" },
                coverage = 90,
                encumbrance = 7,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 3.6 } },
                covers = {
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 90,
                encumbrance = 8,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_chitin3_molted",
    category = "armor",
    name = ccb.content.plural_text("fresh sclerotin plate", "fresh sclerotin plate"),
    description = ccb.content.text("The exoskeleton is weak, it will require more time to harden."),
    mass = "3 kg",
    volume = "2 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather_arthropod" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "BLOCK_WHILE_WORN", "UNBREAKABLE", "OUTER", "PADDED",
        "ALLOWS_TALONS",
    },
    armor = {
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2 } },
                covers = { "head", "head_dragonfly" },
                coverage = 95,
                encumbrance = 9,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 3.5 } },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 12,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.3 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r", "arm_insect_upper_l",
                    "arm_insect_lower_l", "arm_insect_upper_r", "arm_insect_lower_r",
                },
                coverage = 100,
                encumbrance = 4,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.2 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r",
                    "arm_insect_elbow_l", "arm_insect_elbow_r",
                },
                coverage = 90,
                encumbrance = 5,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.4 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_lower_l", "leg_upper_r", "leg_lower_r" },
                coverage = 100,
                encumbrance = 4,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.3 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_knee_l", "leg_hip_r", "leg_knee_r" },
                coverage = 90,
                encumbrance = 5,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 1.8 } },
                covers = {
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 90,
                encumbrance = 6,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_chitin3_claws",
    category = "armor",
    name = ccb.content.plural_text("sclerotin claws", "sclerotin claws"),
    description = ccb.content.text("Useful for the hunt, suitable for maximum efficiency."),
    mass = "450 g",
    volume = "500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "sclerotin" },
    symbol = ",",
    color = "brown",
    accuracy = { grip = "weapon", length = "hand", surface = "line", balance = "neutral" },
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 }, { id = "PRY", level = 1 } },
    techniques = { "RAPID" },
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "ALLOWS_TALONS" },
    melee_damage = { bash = 4, cut = 8 },
    armor = {
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 3.2 } },
                covers = { "hand_l", "hand_r" },
                coverage = 80,
                encumbrance = 7,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_carapace",
    category = "armor",
    name = ccb.content.plural_text("sclerotin carapace", "sclerotin carapace"),
    description = ccb.content.text("When the time comes to prey, this unwavering carapace will keep you safe from everything that could harm you."),
    mass = "11 kg",
    volume = "6 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "sclerotin" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "BLOCK_WHILE_WORN", "UNBREAKABLE", "OUTER", "PADDED",
        "IRRITANT_IMMUNE", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 20,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4.5 } },
                covers = { "head", "head_dragonfly" },
                coverage = 95,
                encumbrance = 15,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 7.5 } },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 18,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 5.1 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r", "arm_insect_upper_l",
                    "arm_insect_lower_l", "arm_insect_upper_r", "arm_insect_lower_r",
                },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4.9 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r",
                    "arm_insect_elbow_l", "arm_insect_elbow_r",
                },
                coverage = 90,
                encumbrance = 9,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 6.4 } },
                covers = { "crustacean_pincer_r" },
                coverage = 80,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 5.3 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_lower_l", "leg_upper_r", "leg_lower_r" },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 5.1 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_knee_l", "leg_hip_r", "leg_knee_r" },
                coverage = 90,
                encumbrance = 8,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 4.1 } },
                covers = {
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 90,
                encumbrance = 9,
            },
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 5.3 } },
                covers = { "leg_crab_front_l", "leg_crab_front_r", "leg_crab_rear_l", "leg_crab_rear_r" },
                coverage = 100,
                encumbrance = 8,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_carapace_molted",
    category = "armor",
    name = ccb.content.plural_text("fresh sclerotin carapace", "fresh sclerotin carapace"),
    description = ccb.content.text("This recently-molted carapace is still soft, and will need time to harden before it provides proper protection."),
    mass = "4500 g",
    volume = "3 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather_arthropod" },
    symbol = "x",
    color = "brown",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "BLOCK_WHILE_WORN",
        "UNBREAKABLE",
        "OUTER",
        "ALLOWS_TALONS",
    },
    armor = {
        warmth = 7,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.2 } },
                covers = { "head", "head_dragonfly" },
                coverage = 95,
                encumbrance = 10,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 4 } },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 12,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.5 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r", "arm_insect_upper_l",
                    "arm_insect_lower_l", "arm_insect_upper_r", "arm_insect_lower_r",
                },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.4 } },
                covers = {
                    "arm_l",
                    "arm_r",
                    "arm_insect_l",
                    "arm_insect_r",
                    "arm_insect_good_l",
                    "arm_insect_good_r",
                },
                subparts = {
                    "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r",
                    "arm_insect_elbow_l", "arm_insect_elbow_r",
                },
                coverage = 90,
                encumbrance = 6,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.6 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_lower_l", "leg_upper_r", "leg_lower_r" },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2.5 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_knee_l", "leg_hip_r", "leg_knee_r" },
                coverage = 90,
                encumbrance = 6,
            },
            {
                materials = { { id = "leather_arthropod", coverage = 100, thickness = 2 } },
                covers = {
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 90,
                encumbrance = 6,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_shell",
    category = "armor",
    name = ccb.content.plural_text("shell", "shell"),
    description = ccb.content.text("You have a large, protective shell on your back, but unfortunately, it doesn't have enough space to fit inside or store anything, makes wearing anything on your torso impossible, and makes backpacks encumbering."),
    mass = "7 kg",
    volume = "10 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin_light" },
    symbol = "x",
    color = "magenta",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "OUTER",
        "BELTED",
        "WATERPROOF",
        "PADDED",
    },
    armor = {
        warmth = 5,
        environmental_protection = 10,
        portions = {
            {
                materials = { { id = "chitin_light", coverage = 100, thickness = 10 } },
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_hanging_back" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_shell2",
    category = "armor",
    name = ccb.content.plural_text("roomy shell", "roomy shell"),
    description = ccb.content.text("Your shell has grown larger and thicker.  You can hide yourself in it, as well as use it as a backpack, but torso armor is still off limits."),
    mass = "9 kg",
    volume = "15 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin_light" },
    symbol = "x",
    color = "magenta",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "7 L",
            mass_limit = "20 kg",
            max_item_length = "50 cm",
            moves = 350,
        },
    },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "OUTER",
        "BELTED",
        "WATERPROOF",
        "PADDED",
    },
    armor = {
        warmth = 7,
        environmental_protection = 13,
        portions = {
            {
                materials = { { id = "chitin_light", coverage = 100, thickness = 15 } },
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_hanging_back" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_shell3",
    category = "armor",
    name = ccb.content.plural_text("nacreous shell", "nacreous shell"),
    description = ccb.content.text("Your shell has grown larger and even thicker, and has a pearly sheen to it.  You can hide yourself in it, as well as use it as a backpack, but torso armor is still off limits."),
    mass = "9 kg",
    volume = "15 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_bone" },
    symbol = "x",
    color = "magenta",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "7 L",
            mass_limit = "20 kg",
            max_item_length = "50 cm",
            moves = 350,
        },
    },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "OUTER",
        "BELTED",
        "WATERPROOF",
        "PADDED",
    },
    armor = {
        warmth = 7,
        environmental_protection = 13,
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 20 } },
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_hanging_back" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_sparse_scales",
    category = "armor",
    name = ccb.content.plural_text("sparse scales", "sparse scales"),
    description = ccb.content.text("Your dermis has toughened and started to grow scales in places."),
    mass = "400 g",
    volume = "400 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh", "mut_scales" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "WATER_FRIENDLY",
        "ALLOWS_TALONS",
    },
    armor = {
        warmth = 1,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "mut_scales", coverage = 45, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 0,
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "mut_scales", coverage = 50, thickness = 1.0 },
                },
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r", "tail" },
                coverage = 100,
                encumbrance = 0,
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "mut_scales", coverage = 45, thickness = 0.5 },
                },
                covers = {
                    "hand_l",
                    "hand_r",
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 100,
                encumbrance = 0,
                breathability = "GOOD",
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_scales",
    category = "armor",
    name = ccb.content.plural_text("scales", "scales"),
    description = ccb.content.text("Your scales have grown thicker and cover most of your body, providing solid armor."),
    mass = "1 kg",
    volume = "900 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "flesh", "mut_scales" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "WATER_FRIENDLY",
        "TOUGH_FEET", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 2,
        environmental_protection = 2,
        portions = {
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.0 },
                    { id = "mut_scales", coverage = 85, thickness = 2.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 1,
                breathability = "POOR",
            },
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.0 },
                    { id = "mut_scales", coverage = 90, thickness = 2.0 },
                },
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r", "tail" },
                coverage = 100,
                encumbrance = 2,
                breathability = "POOR",
            },
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.0 },
                    { id = "mut_scales", coverage = 85, thickness = 1.0 },
                },
                covers = {
                    "hand_l",
                    "hand_r",
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 100,
                encumbrance = 1,
                breathability = "POOR",
            },
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.0 },
                    { id = "mut_scales", coverage = 90, thickness = 1.0 },
                },
                covers = { "mouth", "muzzle" },
                coverage = 90,
                encumbrance = 0,
                breathability = "POOR",
                layers = { "PERSONAL" },
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_fishscales",
    category = "armor",
    name = ccb.content.plural_text("sleek scales", "sleek scales"),
    description = ccb.content.text("Your skin has become a smooth and elegant mesh of interlocking scales."),
    mass = "2 kg",
    volume = "1800 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "flesh", "mut_scales" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "WATER_FRIENDLY",
        "IRRITANT_IMMUNE", "TOUGH_FEET", "ALLOWS_TALONS",
    },
    armor = {
        warmth = 3,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.5 },
                    { id = "mut_scales", coverage = 95, thickness = 2.5 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 3,
            },
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.5 },
                    { id = "mut_scales", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r", "tail" },
                coverage = 100,
                encumbrance = 3,
            },
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.5 },
                    { id = "mut_scales", coverage = 95, thickness = 2.0 },
                },
                covers = { "hand_l", "hand_r", "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 3,
            },
            {
                materials = {
                    { id = "flesh", coverage = 100, thickness = 1.5 },
                    { id = "mut_scales", coverage = 95, thickness = 2.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

-- mut_bone represents the scutes
ccb.content.define_item {
    id = "integrated_reptilescales",
    category = "armor",
    name = ccb.content.plural_text("thick scales", "thick scales"),
    description = ccb.content.text("Leathery and heavily armored, your lamellar skin has toughened for the fiercest battles ahead."),
    mass = "4 kg",
    volume = "3600 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather", "mut_scales", "mut_bone" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "WATER_FRIENDLY",
        "IRRITANT_IMMUNE", "PADDED", "TOUGH_FEET", "NO_SALVAGE",
    },
    armor = {
        warmth = 5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "mut_scales", coverage = 87, thickness = 5.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "mut_scales", coverage = 95, thickness = 6.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "mut_scales", coverage = 91, thickness = 6.0 },
                    { id = "mut_bone", coverage = 82, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r", "leg_l", "leg_r", "tail" },
                coverage = 100,
                encumbrance = 8,
                layers = { "NORMAL" },
            },
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "mut_scales", coverage = 85, thickness = 4.0 },
                },
                covers = {
                    "hand_l",
                    "hand_r",
                    "foot_l",
                    "foot_r",
                    "avian_talon_l",
                    "avian_talon_r",
                    "animal_paw_l",
                    "animal_paw_r",
                },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "mut_scales", coverage = 85, thickness = 4.0 },
                },
                covers = { "mouth", "muzzle" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

-- These do not preclude wearing glasses, but you'll get double-up penalties.  If you really needed to you could likely still situate the lenses in front of them.  You should probably just augment your eyes though.
ccb.content.define_item {
    id = "armor_bio_eyes",
    category = "armor",
    name = ccb.content.plural_text("protective lenses", "protective lenses"),
    description = ccb.content.text("Highly protective lenses which seal off your eyes from danger, routing your tear ducts to your mouth."),
    mass = "180 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "plastic", "lvl4ballisticglass" },
    symbol = "[",
    color = "dark_gray",
    flags = {
        "INTEGRATED", "UNBREAKABLE", "SKINTIGHT", "SOFT", "WATER_FRIENDLY", "SUN_GLASSES", "NO_REPAIR",
        "SWIM_GOGGLES", "NO_SALVAGE",
    },
    armor = {
        warmth = 0,
        thickness = 1.5,
        environmental_protection = 10,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 0.5 },
                    { id = "lvl4ballisticglass", coverage = 100, thickness = 1.0 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 1,
                rigid_only = true,
                vitals_coverage = 90,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_claws",
    category = "armor",
    name = ccb.content.plural_text("claws", "claws"),
    description = ccb.content.text("You have long, sharp claws at the tips of your fingers."),
    mass = "100 g",
    volume = "200 ml",
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 4 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = ";",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE" },
    melee_damage = { cut = 9 },
    armor = {
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = {
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "paw_default_fingers_l",
                    "paw_default_fingers_r",
                },
                coverage = 10,
                encumbrance = 1,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_claws_rat",
    category = "armor",
    name = ccb.content.plural_text("gnarled claws", "gnarled claws"),
    description = ccb.content.text("Your fingernails have become gnarled, twisted claws."),
    mass = "100 g",
    volume = "250 ml",
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 6 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = ";",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE" },
    melee_damage = { cut = 10 },
    armor = {
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = {
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "paw_default_fingers_l",
                    "paw_default_fingers_r",
                },
                coverage = 20,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_claws_st",
    category = "armor",
    name = ccb.content.plural_text("stainless claws", "stainless claws"),
    description = ccb.content.text("Your claws have toughened to become something akin to miniature butcher knives."),
    mass = "100 g",
    volume = "300 ml",
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 8 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = ";",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE" },
    melee_damage = { cut = 11 },
    armor = {
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = {
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "paw_default_fingers_l",
                    "paw_default_fingers_r",
                },
                coverage = 40,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_talons",
    category = "armor",
    name = ccb.content.plural_text("talons", "talons"),
    description = ccb.content.text("Your index fingers have become talons.  They make for wicked natural daggers.  Unfortunately, they get in the way of everything including gloves."),
    mass = "100 g",
    volume = "350 ml",
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 12 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = ";",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE" },
    melee_damage = { cut = 16 },
    armor = {
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 10,
                encumbrance = 7,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_fangs",
    category = "armor",
    name = ccb.content.plural_text("fangs", "fangs"),
    description = ccb.content.text("A pair of fangs sharp and sturdy enough to use in combat."),
    mass = "50 g",
    volume = "100 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = ",",
    color = "white",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 } },
    techniques = { "FANGS_BITE", "FANGS_BITE_NATURAL", "FANGS_BITE_CRIT" },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "PADDED",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { stab = 9 },
    armor = {
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3.2 } },
                covers = { "mouth", "muzzle" },
                subparts = { "mouth_lips", "muzzle_lips" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_saber_teeth",
    category = "armor",
    name = ccb.content.plural_text("saber teeth", "saber teeth"),
    description = ccb.content.text("A pair of enormous teeth, hanging over your lip, dagger-sharp and more than sturdy enough to use in combat."),
    mass = "125 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = ";",
    color = "white",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 } },
    techniques = { "FANGS_BITE", "FANGS_BITE_NATURAL", "FANGS_BITE_CRIT" },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "PADDED",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { stab = 18 },
    armor = {
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3.2 } },
                covers = { "mouth", "muzzle" },
                subparts = { "mouth_lips", "muzzle_lips" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_shark_teeth",
    category = "armor",
    name = ccb.content.plural_text("shark teeth", "shark teeth"),
    description = ccb.content.text("A set of razor-sharp shark teeth."),
    mass = "125 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = ";",
    color = "white",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 } },
    techniques = { "FANGS_BITE", "FANGS_BITE_NATURAL", "FANGS_BITE_CRIT" },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "PADDED",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { stab = 24 },
    armor = {
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3.2 } },
                covers = { "mouth", "muzzle" },
                subparts = { "mouth_lips", "muzzle_lips" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_vampire_fangs",
    category = "armor",
    name = ccb.content.plural_text("vampire fangs", "vampire fangs"),
    description = ccb.content.text("A wicked pair of fangs, pointed and surgically sharp."),
    mass = "100 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = ",",
    color = "white",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 } },
    techniques = { "VAMPIRE_BITE", "VAMPIRE_BITE_NATURAL", "VAMPIRE_BITE_CRIT" },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "PADDED",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { stab = 15 },
    armor = {
        warmth = 5,
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3.2 } },
                covers = { "mouth", "muzzle" },
                subparts = { "mouth_lips", "muzzle_lips" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

-- No butcher or fine cut because it's your feet
ccb.content.define_item {
    id = "integrated_toe_talons",
    category = "armor",
    name = ccb.content.plural_text("talons", "talons"),
    description = ccb.content.text("Your toes have become talons.  They make wicked natural daggers, allowing for damaging kick attacks.  Unfortunately, they get in the way of everything including shoes."),
    mass = "100 g",
    volume = "350 ml",
    qualities = { { id = "CUT", level = 2 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = ";",
    color = "dark_gray",
    techniques = { "TOE_TALONS_KICK", "TOE_TALONS_KICK_NATURAL", "TOE_TALONS_KICK_CRIT" },
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PADDED", "NO_SALVAGE",
        "PROVIDES_TECHNIQUES", "SKINTIGHT",
    },
    melee_damage = { cut = 8 },
    armor = {
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 2 } },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 10,
                encumbrance = 1,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_horns_small",
    category = "armor",
    name = ccb.content.plural_text("horns", "horns"),
    description = ccb.content.text("You have a set of small horns."),
    mass = "500 g",
    volume = "750 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = "V",
    color = "light_gray",
    techniques = { "SMALL_HORNS_RAM_BASH", "SMALL_HORNS_RAM_NATURAL" },
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "PADDED", "NO_SALVAGE",
        "PROVIDES_TECHNIQUES",
    },
    armor = {
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 1.5 } },
                covers = { "head" },
                subparts = { "head_crown" },
                coverage = 10,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_horns_curled",
    category = "armor",
    name = ccb.content.plural_text("curled horns", "curled horns"),
    description = ccb.content.text("You have a set of curling horns, like those of a ram."),
    mass = "2000 g",
    volume = "2500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = "V",
    color = "dark_gray",
    techniques = { "CURLED_HORNS_BASH", "CURLED_HORNS_BASH_NATURAL" },
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "PADDED", "NO_SALVAGE",
        "PROVIDES_TECHNIQUES",
    },
    armor = {
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3 } },
                covers = { "head" },
                subparts = { "head_crown" },
                coverage = 20,
                encumbrance = 2,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_horns_pointed",
    category = "armor",
    name = ccb.content.plural_text("pointed horns", "pointed horns"),
    description = ccb.content.text("You have a set of long pointed horns, like those of a antelope."),
    mass = "2000 g",
    volume = "2500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = "V",
    color = "dark_gray",
    techniques = { "POINTED_HORNS_STAB", "POINTED_HORNS_STAB_NATURAL" },
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "PADDED", "NO_SALVAGE",
        "PROVIDES_TECHNIQUES",
    },
    armor = {
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3 } },
                covers = { "head" },
                subparts = { "head_crown" },
                coverage = 20,
                encumbrance = 2,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_antlers",
    category = "armor",
    name = ccb.content.plural_text("antlers", "antlers"),
    description = ccb.content.text("You have a majestic crown of antlers, like those of a deer or moose."),
    mass = "2000 g",
    volume = "2500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = "V",
    color = "dark_gray",
    techniques = { "ANTLERS_BASH", "ANTLERS_BASH_NATURAL" },
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "AURA", "PADDED", "NO_SALVAGE",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { bash = 6 },
    armor = {
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3 } },
                covers = { "head" },
                subparts = { "head_crown" },
                coverage = 20,
                encumbrance = 2,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_interstice_aura",
    category = "armor",
    name = ccb.content.plural_text("Penumbral Interstitium", "Penumbral Interstitium"),
    description = ccb.content.text("Your cells operate under different rules.  While you still need to breathe, you are otherwise extremely resistant to the thermal and chemical insults of the so-called universe."),
    mass = "1 g",
    volume = "1 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "ALLOWS_TALONS", "RAD_PROOF",
        "WATERPROOF",
    },
    armor = {
        thickness = 0.01,
        warmth = 0,
        environmental_protection = 16,
        portions = { { covers_all = true, coverage = 100, encumbrance = 0, breathability = "GOOD" } },
    },
}

ccb.content.define_item {
    id = "internal_bio_purifier",
    category = "armor",
    name = ccb.content.plural_text("Air Filtration System", "Air Filtration System"),
    description = ccb.content.text("Surgically implanted in your trachea is an advanced filtration system.  If toxins or airborne diseases find their way into your windpipe, the filter will attempt to remove them."),
    mass = "1 g",
    volume = "1 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "nanotubes" },
    symbol = "x",
    color = "light_red",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL" },
    armor = {
        thickness = 0.01,
        warmth = 0,
        environmental_protection = 16,
        portions = { { covers = { "mouth", "muzzle", "beak" }, coverage = 100, encumbrance = 0 } },
    },
}
