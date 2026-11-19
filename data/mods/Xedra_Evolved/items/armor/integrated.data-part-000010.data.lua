local ccb = require("ccb")

-- We can use the same techniques as werewolf bites to save time
ccb.content.define_item {
    id = "integrated_vampire_rending_jaws",
    category = "armor",
    name = ccb.content.plural_text("rending jaws", "rending jaws"),
    description = ccb.content.text("A mouth full of jagged teeth, ready to tip and tear."),
    mass = "50 g",
    volume = "100 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = ",",
    color = "white",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 } },
    techniques = { "FANGS_BITE_SHAPESHIFTER", "FANGS_BITE_SHAPESHIFTER_CRIT" },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "PADDED",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { stab = 10 },
    armor = {
        warmth = 5,
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3.2 } },
                covers = { "mouth" },
                subparts = { "mouth_lips" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_brownie_fur",
    category = "armor",
    name = ccb.content.plural_text("brownie fur", "brownie fur"),
    description = ccb.content.text("Thick fur-like hair covering your entire body."),
    mass = "300 g",
    volume = "300 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "brown",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 15,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 2 } },
                covers = {
                    "hand_l",
                    "hand_r",
                    "foot_l",
                    "foot_r",
                    "leg_l",
                    "leg_r",
                    "arm_l",
                    "arm_r",
                    "torso",
                },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_antlers",
    category = "armor",
    name = ccb.content.plural_text("deer antlers", "deer antlers"),
    description = ccb.content.text("You have a majestic crown of antlers."),
    mass = "2000 g",
    volume = "2500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = "V",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "AURA", "PADDED", "NO_SALVAGE" },
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
