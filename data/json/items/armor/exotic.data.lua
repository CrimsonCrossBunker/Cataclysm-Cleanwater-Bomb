local ccb = require("ccb")

-- torso armor for the space samurai
ccb.content.define_item {
    id = "armor_star_samurai_torso",
    category = "armor",
    name = ccb.content.plural_text("ryūsei dō", "ryūsei dō"),
    description = ccb.content.text("An impossibly large slab of dark reflective material wrapped in bands of multicolored alloy.  It seems shaped to fit over a humanoid torso."),
    mass = "300 kg",
    volume = "6000 ml",
    price = "0 cent",
    survival_price = "80 USD",
    materials = { { id = "monolith_heavy", portions = 19 }, { id = "superalloy", portions = 1 } },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "STAR_PLATE" },
    armor = {
        warmth = 0,
        thickness = 25,
        portions = {
            { encumbrance = 15, coverage = 85, covers = { "torso" } },
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_nape", "head_throat" },
            },
        },
    },
}

-- shoulder armor for the space samurai
ccb.content.define_item {
    id = "armor_star_samurai_shoulder",
    category = "armor",
    name = ccb.content.plural_text("ryūsei kote", "ryūsei kote"),
    description = ccb.content.text("An impossibly large slab of dark reflective material wrapped in bands of multicolored alloy.  It seems shaped as though it would tie to the upper arms."),
    mass = "100 kg",
    volume = "4000 ml",
    price = "0 cent",
    survival_price = "80 USD",
    materials = { { id = "monolith_heavy", portions = 19 }, { id = "superalloy", portions = 1 } },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "STAR_SHOULDER" },
    armor = {
        warmth = 0,
        thickness = 25,
        portions = {
            {
                encumbrance = 8,
                coverage = 95,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_upper_l", "arm_shoulder_r", "arm_upper_r" },
            },
        },
    },
}

-- leg armor for the space samurai
ccb.content.define_item {
    id = "armor_star_samurai_legs",
    category = "armor",
    name = ccb.content.plural_text("ryūsei hai-date", "ryūsei hai-date"),
    description = ccb.content.text("An impossibly large slab of dark reflective material wrapped in bands of multicolored alloy.  It has been forced into a conical shape as though it could somehow be worn as a skirt."),
    mass = "275 kg",
    volume = "5500 ml",
    price = "0 cent",
    survival_price = "80 USD",
    materials = { { id = "monolith_heavy", portions = 19 }, { id = "superalloy", portions = 1 } },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "STAR_SKIRT" },
    armor = {
        warmth = 0,
        thickness = 25,
        portions = {
            {
                encumbrance = 15,
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_upper_l", "leg_hip_r", "leg_upper_r" },
            },
        },
    },
}
