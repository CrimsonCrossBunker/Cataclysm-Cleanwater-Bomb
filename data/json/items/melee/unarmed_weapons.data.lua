local ccb = require("ccb")

ccb.content.define_item {
    id = "cestus",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.plural_text("cestus", "cesti"),
    description = ccb.content.text("A leather hand and arm wrap incorporating metal plates over the knuckles to improve punching power and defense."),
    materials = { "leather", "steel" },
    volume = "100 ml",
    mass = "300 g",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    flags = { "DURABLE_MELEE", "NONCONDUCTIVE" },
    faults = { { group = "knuckles" } },
    melee_damage = { bash = 5 },
    armor = {
        thickness = 1,
        portions = {
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "steel", coverage = 75, thickness = 0.5 },
                },
                encumbrance = 5,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_wrist_l",
                    "hand_wrist_r",
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_back_l",
                    "hand_back_r",
                },
            },
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "steel", coverage = 75, thickness = 0.5 },
                },
                encumbrance = 0,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
            {
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                encumbrance = 2,
                coverage = 60,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_cestus",
    name = ccb.content.plural_text("cestus", "cesti"),
    copy_from = "cestus",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_cestus",
    name = ccb.content.plural_text("cestus", "cesti"),
    copy_from = "cestus",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "knuckle_brass",
    symbol = "3",
    color = "yellow",
    name = ccb.content.plural_text("brass knuckles (pair)", "brass knuckles (pair)"),
    description = ccb.content.text("A metal weapon made of brass, designed to be gripped in the palm to cause punches to do extra damage.  A good, quick weapon - but you have to get within punching range to use it."),
    materials = { "brass" },
    mass = "320 g",
    volume = "250 ml",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    flags = { "DURABLE_MELEE" },
    faults = { { group = "knuckles" } },
    melee_damage = { bash = 6 },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_knuckle_brass",
    name = ccb.content.plural_text("brass knuckles (pair)", "brass knuckles (pair)"),
    copy_from = "knuckle_brass",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_knuckle_brass",
    name = ccb.content.plural_text("brass knuckles (pair)", "brass knuckles (pair)"),
    copy_from = "knuckle_brass",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "knuckle_nail",
    symbol = "]",
    color = "brown",
    name = ccb.content.plural_text("nail knuckles (pair)", "nail knuckles (pair)"),
    description = ccb.content.text("A pair of knuckles consisting of two small squares of wood with several nails sticking through them.  Useful in nasty street fights."),
    materials = { "wood" },
    volume = "250 ml",
    mass = "200 g",
    survival_price = "50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "line", balance = "neutral" },
    faults = { { group = "knuckles_bladed" } },
    flags = {},
    melee_damage = { bash = 4, stab = 4 },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 7,
                coverage = 40,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_knuckle_nail",
    name = ccb.content.plural_text("nail knuckles (pair)", "nail knuckles (pair)"),
    copy_from = "knuckle_nail",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_knuckle_nail",
    name = ccb.content.plural_text("nail knuckles (pair)", "nail knuckles (pair)"),
    copy_from = "knuckle_nail",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "knuckle_steel",
    symbol = "3",
    color = "dark_gray",
    name = ccb.content.plural_text("scrap knuckles (pair)", "scrap knuckles (pair)"),
    description = ccb.content.text("A mass of scrap metal crudely beat into shape, with folded rags underneath to protect the wearer's knuckles.  A good, quick weapon - but you have to get within punching range to use it."),
    materials = { "steel" },
    volume = "250 ml",
    mass = "430 g",
    survival_price = "50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    faults = { { group = "knuckles" } },
    qualities = { { id = "HAMMER", level = 1 } },
    melee_damage = { bash = 5, cut = 1 },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 7,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_knuckle_steel",
    name = ccb.content.plural_text("scrap knuckles (pair)", "scrap knuckles (pair)"),
    copy_from = "knuckle_steel",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_knuckle_steel",
    name = ccb.content.plural_text("scrap knuckles (pair)", "scrap knuckles (pair)"),
    copy_from = "knuckle_steel",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "knuckle_steel_forged",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.plural_text("steel knuckles (pair)", "steel knuckles (pair)"),
    looks_like = "knuckle_brass",
    description = ccb.content.text("A pair of knuckles forged from steel, designed to be gripped in the palm to cause punches to do more damage.  A good, quick weapon - but you have to get within punching range to use it."),
    materials = { "steel" },
    volume = "250 ml",
    mass = "240 g",
    survival_price = "1 USD 80 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    qualities = { { id = "HAMMER", level = 1 } },
    flags = { "DURABLE_MELEE" },
    faults = { { group = "knuckles" } },
    melee_damage = { bash = 7 },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_knuckle_steel_forged",
    name = ccb.content.plural_text("steel knuckles (pair)", "steel knuckles (pair)"),
    copy_from = "knuckle_steel_forged",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_knuckle_steel_forged",
    name = ccb.content.plural_text("steel knuckles (pair)", "steel knuckles (pair)"),
    copy_from = "knuckle_steel_forged",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "gloves_studded",
    name = ccb.content.plural_text("studded gloves (pair)", "studded gloves (pair)"),
    description = ccb.content.text("A pair of gloves with studded metal knuckles and a thin back plating."),
    mass = "218 g",
    volume = "250 ml",
    price = "11 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "line", balance = "neutral" },
    materials = { "steel", "leather", "cotton" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "light_gray",
    flags = { "WATER_FRIENDLY", "DURABLE_MELEE", "NONCONDUCTIVE" },
    faults = { { group = "knuckles" } },
    melee_damage = { bash = 2, stab = 4 },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "leather", coverage = 100, thickness = 0.5 },
                    { id = "steel", coverage = 80, thickness = 0.25 },
                },
                encumbrance = 3,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r" },
            },
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "leather", coverage = 100, thickness = 0.5 },
                },
                encumbrance = 0,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r", "hand_palm_l", "hand_palm_r" },
            },
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "leather", coverage = 100, thickness = 0.5 },
                    { id = "steel", coverage = 50, thickness = 0.25 },
                },
                encumbrance = 2,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_studded",
    name = ccb.content.plural_text("studded gloves (pair)", "studded gloves (pair)"),
    copy_from = "gloves_studded",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_studded",
    name = ccb.content.plural_text("studded gloves (pair)", "studded gloves (pair)"),
    copy_from = "gloves_studded",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "knuckle_impact",
    name = ccb.content.plural_text("impact knuckles (pair)", "impact knuckles (pair)"),
    description = ccb.content.text("A pair of thick steel plates covering your proximal phalange.  They are strapped to your hands with metal braces."),
    mass = "500 g",
    volume = "300 ml",
    price = "11 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    materials = { "steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATER_FRIENDLY", "DURABLE_MELEE", "OUTER" },
    faults = { { group = "knuckles" } },
    melee_damage = { bash = 9 },
    armor = {
        warmth = 0,
        thickness = 3,
        portions = {
            {
                encumbrance = 5,
                coverage = 80,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_knuckle_impact",
    name = ccb.content.plural_text("impact knuckles (pair)", "impact knuckles (pair)"),
    copy_from = "knuckle_impact",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_knuckle_impact",
    name = ccb.content.plural_text("impact knuckles (pair)", "impact knuckles (pair)"),
    copy_from = "knuckle_impact",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "knuckle_skewer",
    name = ccb.content.plural_text("skewer knuckles (pair)", "skewer knuckles (pair)"),
    description = ccb.content.text("A pair of metal braces, each with a single sturdy spike attached.  When strapped to your hands, the spikes protrude 5 centimeters past your clenched fists."),
    mass = "250 g",
    volume = "300 ml",
    price = "11 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "line", balance = "neutral" },
    materials = { "steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATER_FRIENDLY", "DURABLE_MELEE", "OUTER" },
    faults = { { group = "knuckles_bladed" } },
    melee_damage = { bash = 3, stab = 6 },
    armor = {
        warmth = 0,
        thickness = 2,
        portions = { { encumbrance = 5, coverage = 20, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "xl_knuckle_skewer",
    name = ccb.content.plural_text("skewer knuckles (pair)", "skewer knuckles (pair)"),
    copy_from = "knuckle_skewer",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_knuckle_skewer",
    name = ccb.content.plural_text("skewer knuckles (pair)", "skewer knuckles (pair)"),
    copy_from = "knuckle_skewer",
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.75, volume = 0.75 } },
}
