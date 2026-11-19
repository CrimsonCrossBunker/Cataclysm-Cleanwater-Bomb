local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_bio_flesh_roots",
    category = "armor",
    mass = "500 g",
    volume = "1200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    symbol = ",",
    color = "brown",
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "PADDED", "WATER_FRIENDLY", "SOFT", "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
    },
    materials = { "flesh_roots" },
    name = ccb.content.plural_text("flesh roots", "flesh roots"),
    description = ccb.content.text("A layer of bulging rootlike structures distending the upper layers of skin.  Helps protect your body from damage."),
    armor = {
        warmth = 0,
        environmental_protection = 1,
        thickness = 1.25,
        portions = {
            {
                materials = { { id = "flesh_roots", coverage = 100, thickness = 1 } },
                covers = { "torso", "head", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 80,
                encumbrance = 0,
                vitals_coverage = 65,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_pebbled",
    category = "armor",
    name = ccb.content.plural_text("pebbled skin", "pebbled skin"),
    description = ccb.content.text("Your skin has begun to harden and pebbles have begun to surface."),
    mass = "400 g",
    volume = "400 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh", "stone" },
    symbol = "x",
    color = "light_red",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 1,
        environmental_protection = 2,
        portions = {
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "stone", coverage = 55, thickness = 1 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 0,
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "stone", coverage = 60, thickness = 1 },
                },
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 0,
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "stone", coverage = 55, thickness = 0.5 },
                },
                covers = { "hand_l", "hand_r", "foot_l", "foot_r", "mouth" },
                coverage = 100,
                encumbrance = 0,
                breathability = "GOOD",
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_granite_skin",
    category = "armor",
    name = ccb.content.plural_text("granite skin", "granite skin"),
    description = ccb.content.text("Your skin has hardened into a granite like covering."),
    mass = "400 g",
    volume = "400 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh", "stone" },
    symbol = "x",
    color = "light_red",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 1,
        environmental_protection = 5,
        portions = {
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "stone", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 4,
                breathability = "POOR",
            },
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "stone", coverage = 100, thickness = 2.5 },
                },
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 4,
                breathability = "POOR",
            },
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.5 },
                    { id = "stone", coverage = 100, thickness = 1.5 },
                },
                covers = { "hand_l", "hand_r", "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 4,
                breathability = "POOR",
            },
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 0.25 },
                    { id = "stone", coverage = 100, thickness = 1.5 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 0,
                breathability = "POOR",
            },
        },
    },
}
