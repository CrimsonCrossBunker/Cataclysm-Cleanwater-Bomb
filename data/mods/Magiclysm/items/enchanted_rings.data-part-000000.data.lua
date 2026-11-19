local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_copper",
    abstract = true,
    name = ccb.content.text_without_extraction("copper magic ring"),
    description = ccb.content.text_without_extraction("A generic copper magic ring."),
    mass = "4 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "copper" },
    symbol = "[",
    color = "light_red",
    looks_like = "copper_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_silver",
    abstract = true,
    name = ccb.content.text_without_extraction("silver magic ring"),
    description = ccb.content.text_without_extraction("A generic silver magic ring."),
    mass = "5 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    looks_like = "silver_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_gold",
    abstract = true,
    name = ccb.content.text_without_extraction("gold magic ring"),
    description = ccb.content.text_without_extraction("A generic gold magic ring."),
    mass = "9 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    looks_like = "gold_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_platinum",
    abstract = true,
    name = ccb.content.text_without_extraction("platinum magic ring"),
    description = ccb.content.text_without_extraction("A generic platinum magic ring"),
    mass = "11 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "platinum" },
    symbol = "[",
    color = "light_gray",
    looks_like = "platinum_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}
