local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_vegital_cuticle",
    category = "armor",
    name = ccb.content.text("vegetal cuticle"),
    description = ccb.content.text("A pliable but hefty layer of living plant matter impregnated with various waxy polymers."),
    mass = "2 kg",
    volume = "3 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood", "veggy" },
    symbol = "x",
    color = "light_green",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY", "SOFT" },
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
                    "hand_l", "hand_r", "foot_l", "foot_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "vine_limb_upper_r", "vine_limb_upper_l", "vine_limb_lower_r", "vine_limb_lower_l",
                    "torso", "head",
                },
                coverage = 100,
                encumbrance = 1,
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "veggy", coverage = 100, thickness = 2 },
                    { id = "wood", coverage = 100, thickness = 0.5 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 0,
                breathability = "GOOD",
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_bark_skin",
    category = "armor",
    name = ccb.content.plural_text("barkskin", "barkskin"),
    description = ccb.content.text("A thin layer of bark covers your body."),
    mass = "4 kg",
    volume = "5 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood" },
    symbol = "x",
    color = "brown",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATERPROOF", "PADDED" },
    armor = {
        warmth = 2,
        environmental_protection = 4,
        portions = {
            {
                materials = { { id = "wood", coverage = 100, thickness = 2 } },
                covers = {
                    "hand_l", "hand_r", "foot_l", "foot_r", "leg_l", "leg_r", "arm_l", "arm_r",
                    "vine_limb_upper_r", "vine_limb_upper_l", "vine_limb_lower_r", "vine_limb_lower_l",
                    "torso", "head",
                },
                coverage = 100,
                encumbrance = 4,
                breathability = "AVERAGE",
            },
            {
                materials = { { id = "wood", coverage = 100, thickness = 2 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 0,
                breathability = "AVERAGE",
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_arvore_thorns",
    category = "armor",
    name = ccb.content.plural_text("woody thorns", "woody thorns"),
    description = ccb.content.text("Your skin is covered in thick, woody thorns."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_wood" },
    symbol = ",",
    color = "green",
    flags = {
        "INTEGRATED",
        "SEMITANGIBLE",
        "ZERO_WEIGHT",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "OUTER",
        "PADDED",
    },
    melee_damage = { stab = 4 },
    armor = {
        portions = {
            {
                materials = { { id = "mut_wood", coverage = 100, thickness = 3.2 } },
                covers = { "hand_l", "hand_r" },
                coverage = 0,
                encumbrance = 0,
            },
        },
    },
}
