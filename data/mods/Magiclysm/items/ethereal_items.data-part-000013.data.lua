local ccb = require("ccb")

ccb.content.define_item {
    id = "flask_ethereal_rebreather",
    name = ccb.content.plural_text("air bubble", "air bubble"),
    description = ccb.content.text("Now you can breath under water, like a fish."),
    category = "clothing",
    mass = "0 g",
    materials = { "concentrated_mana" },
    volume = "1 ml",
    symbol = "0",
    color = "white",
    flags = {
        "WATER_FRIENDLY", "SEMITANGIBLE", "OVERSIZE", "AURA", "ZERO_WEIGHT", "NO_TAKEOFF",
        "NONCONDUCTIVE", "TRADER_AVOID", "REBREATHER", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 25,
        portions = { { encumbrance = 0, coverage = 75, covers = { "head", "mouth", "eyes" } } },
    },
}

ccb.content.define_item {
    id = "thought_shield_item",
    name = ccb.content.plural_text("thought shields", "thought shields"),
    description = ccb.content.text("These two tiny shields on your temples should protect your mind from outside influences"),
    category = "clothing",
    mass = "0 g",
    materials = { "concentrated_mana" },
    volume = "1 ml",
    symbol = "0",
    color = "white",
    flags = {
        "WATER_FRIENDLY", "SEMITANGIBLE", "OVERSIZE", "AURA", "ZERO_WEIGHT", "NO_TAKEOFF",
        "NONCONDUCTIVE", "TRADER_AVOID", "PSYSHIELD_PARTIAL", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS",
        "MAGICAL_MIND_PROTECTION",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 1,
        portions = { { encumbrance = 0, coverage = 75, covers = { "head", "mouth", "eyes" } } },
    },
}

ccb.content.define_item {
    id = "thought_shield_plus_item",
    name = ccb.content.plural_text("thought suit", "thought suit"),
    description = ccb.content.text("The tiny shields all over your body should protect your mind from outside influences and your body from being moved by outside magic"),
    category = "clothing",
    mass = "0 g",
    materials = { "concentrated_mana" },
    volume = "1 ml",
    symbol = "0",
    color = "white",
    flags = {
        "WATER_FRIENDLY", "SEMITANGIBLE", "OVERSIZE", "AURA", "ZERO_WEIGHT", "NO_TAKEOFF",
        "NONCONDUCTIVE", "TRADER_AVOID", "PSYSHIELD_PARTIAL", "PORTAL_PROOF", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS", "MAGICAL_MIND_PROTECTION",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 75,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
}
