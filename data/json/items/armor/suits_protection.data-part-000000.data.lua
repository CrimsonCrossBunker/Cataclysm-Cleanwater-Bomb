local ccb = require("ccb")

-- Unsure what exactly this armor is, I assume the extra thickness is because boiled leather is stronger, so in that case I just used the weight from regular leather body armor
ccb.content.define_item {
    id = "armor_blarmor",
    category = "armor",
    name = ccb.content.text("boiled leather armor"),
    description = ccb.content.text("Thick leather body armor that has been hardened via chemical treatment.  Light and strong."),
    mass = "8400 g",
    volume = "9500 ml",
    price = "260 USD",
    survival_price = "30 USD",
    materials = { "leather" },
    symbol = "[",
    length = "60 cm",
    looks_like = "armor_larmor",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "OUTER", "BLOCK_WHILE_WORN" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 95,
                encumbrance = 22,
                materials = { { id = "leather", coverage = 100, thickness = 6.5 } },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 90, encumbrance = 18 },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = 18 },
        },
        warmth = 20,
        thickness = 6,
        valid_mods = { "steel_padded" },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36%, both arms are 18%, both legs are 36% leaving us with 16740 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 7 767 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 1 289 grams.
-- Totalled up this is 9 056 grams with some rounding
ccb.content.define_item {
    id = "armor_chitin",
    category = "armor",
    name = ccb.content.text("chitinous scale mail suit"),
    description = ccb.content.text("A full body suit of chitin sections overlapping with each other, secured to a leather backing.  The odd irregular shapes make full coverage impossible, not helped by how poor of a material chitin is.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "9056 g",
    volume = "7 L",
    price = "1 kUSD 200 USD",
    survival_price = "5 USD",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "green",
    length = "60 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_chitin",
    name = ccb.content.text("chitinous scale mail suit"),
    copy_from = "armor_chitin",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_chitin_xs",
    copy_from = "armor_chitin",
    looks_like = "armor_chitin",
    name = ccb.content.text("chitinous scale mail suit"),
    flags = { "STURDY", "OUTER", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "armor_acidchitin",
    copy_from = "armor_chitin",
    looks_like = "armor_chitin",
    name = ccb.content.text("biosilicified chitin armor"),
    description = ccb.content.text("Leg and body armor crafted from the carefully cleaned and pruned biosilicified exoskeletons of acidic ants.  Acid-resistant but brittle."),
    materials = { "acidchitin" },
    survival_price = "35 USD",
    armor = { environmental_protection = 2 },
    inheritance = { offset = { melee_damage = { bash = 1 } } },
}

ccb.content.define_item {
    id = "xl_armor_acidchitin",
    name = ccb.content.text("biosilicified chitin armor"),
    copy_from = "armor_acidchitin",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_acidchitin_xs",
    copy_from = "armor_acidchitin",
    looks_like = "armor_acidchitin",
    name = ccb.content.text("biosilicified chitin armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_farmor",
    category = "armor",
    name = ccb.content.text("fur body armor"),
    description = ccb.content.text("Thick body armor made from furs."),
    mass = "3414 g",
    volume = "10 L",
    price = "1 kUSD",
    survival_price = "15 USD",
    materials = { "fur" },
    symbol = "[",
    length = "30 cm",
    looks_like = "armor_larmor",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "3 kg",
            max_item_length = "165 mm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "3 kg",
            max_item_length = "165 mm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 17, 17 } },
            { covers = { "leg_l", "leg_r" }, coverage = 85, encumbrance = { 17, 17 } },
            { covers = { "arm_l", "arm_r" }, coverage = 90, encumbrance = { 17, 17 } },
        },
        warmth = 45,
        thickness = 4,
        valid_mods = { "steel_padded" },
    },
}

ccb.content.define_item {
    id = "xl_armor_farmor",
    name = ccb.content.text("fur body armor"),
    copy_from = "armor_farmor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_farmor_xs",
    copy_from = "armor_farmor",
    looks_like = "armor_farmor",
    name = ccb.content.text("fur body armor"),
    flags = { "VARSIZE", "POCKETS", "WATERPROOF", "STURDY", "OUTER", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "armor_faux_farmor",
    category = "armor",
    name = ccb.content.text("faux fur body armor"),
    description = ccb.content.text("Thick body armor made from faux furs."),
    mass = "3414 g",
    volume = "10 L",
    price = "1 kUSD",
    survival_price = "15 USD",
    materials = { "faux_fur" },
    symbol = "[",
    length = "30 cm",
    looks_like = "armor_larmor",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "3 kg",
            max_item_length = "165 mm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "3 kg",
            max_item_length = "165 mm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 90, encumbrance = { 21, 25 } },
            { covers = { "leg_l", "leg_r" }, coverage = 90, encumbrance = { 21, 21 } },
            { covers = { "arm_l", "arm_r" }, coverage = 90, encumbrance = { 21, 21 } },
        },
        warmth = 40,
        thickness = 4,
    },
}

ccb.content.define_item {
    id = "xl_armor_faux_farmor",
    name = ccb.content.text("faux fur body armor"),
    copy_from = "armor_faux_farmor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_faux_farmor_xs",
    copy_from = "armor_faux_farmor",
    name = ccb.content.text("faux fur body armor"),
    flags = { "VARSIZE", "POCKETS", "WATERPROOF", "STURDY", "OUTER", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "armor_larmor",
    category = "armor",
    name = ccb.content.text("leather body armor"),
    description = ccb.content.text("A full suit of thick leather body armor.  Light and comfortable."),
    mass = "8400 g",
    volume = "10 L",
    price = "120 USD",
    survival_price = "25 USD",
    materials = { "leather" },
    symbol = "[",
    length = "60 cm",
    looks_like = "touring_suit",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "OUTER", "BLOCK_WHILE_WORN" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 95,
                encumbrance = 16,
                materials = { { id = "leather", coverage = 100, thickness = 4.5 } },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 90, encumbrance = 14 },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = 14 },
        },
        warmth = 25,
        thickness = 4,
        valid_mods = { "steel_padded" },
    },
}

ccb.content.define_item {
    id = "xl_armor_larmor",
    name = ccb.content.text("leather body armor"),
    copy_from = "armor_larmor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_larmor_xs",
    copy_from = "armor_larmor",
    looks_like = "armor_larmor",
    name = ccb.content.text("leather body armor"),
    flags = { "VARSIZE", "STURDY", "OUTER", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "armor_junk_lightplate",
    category = "armor",
    name = ccb.content.text("junk plate armor"),
    description = ccb.content.text("A suit of Gothic plate armor.  The metal shows signs of rust and corrosion, and the leather straps are tattered."),
    mass = "11 kg",
    volume = "17500 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "budget_steel", "leather" },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 25,
        thickness = 4,
        portions = {
            {
                encumbrance = 35,
                coverage = 95,
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_metal_sheets",
    category = "armor",
    name = ccb.content.text("sheet metal armor"),
    description = ccb.content.text("A full set of armor hammered out from sheet metal and tied in place with leather straps and belts.  It's crude, heavy, and uncomfortable, but damn protective.  Now, you're a true Post-Apocalyptic Warrior."),
    mass = "22300 g",
    volume = "17500 ml",
    price = "60 USD",
    survival_price = "12 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armor_junk_lightplate",
    color = "light_gray",
    length = "120 cm",
    flags = { "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = 18 },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = 21 },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = 19 },
        },
    },
}

ccb.content.define_item {
    id = "armor_ch_metal_sheets",
    copy_from = "armor_metal_sheets",
    name = ccb.content.text("hardened sheet metal armor"),
    description = ccb.content.text("A full set of armor hammered out from sheet metal and hardened for added protection.  Perfect for keeping all your fleshy bits safe from zombie teeth."),
    materials = { "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "armor_metal_sheets_heavy",
    category = "armor",
    name = ccb.content.text("heavy sheet metal armor"),
    description = ccb.content.text("A full set of armor hammered out from sheet metal and tied in place with leather straps and belts, with a doubly-thick chest guard to keep all your important organs safe.  You might be as mobile as a refrigerator wearing all this, but that's the price to pay to keep your flesh attached."),
    mass = "31100 g",
    volume = "17500 ml",
    price = "60 USD",
    survival_price = "13 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armor_junk_lightplate",
    color = "light_gray",
    length = "120 cm",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "STURDY" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 3 } },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 30,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = 19,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 21,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_ch_metal_sheets_heavy",
    copy_from = "armor_metal_sheets_heavy",
    name = ccb.content.text("heavy hardened sheet metal armor"),
    description = ccb.content.text("A full set of armor hammered out from sheet metal and hardened for extra protection, with a doubly-thick chest guard.  The Ned Kelly gang would be proud."),
    materials = { "ch_steel" },
    armor = {
        portions = {
            {
                materials = { { id = "ch_steel", coverage = 100, thickness = 3 } },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 30,
            },
            {
                materials = { { id = "ch_steel", coverage = 100, thickness = 1.5 } },
                covers = { "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = 19,
            },
            {
                materials = { { id = "ch_steel", coverage = 100, thickness = 1.5 } },
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 21,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_metal_sheets_chain",
    category = "armor",
    name = ccb.content.text("junkyard plate armor"),
    description = ccb.content.text("A full set of steel armor made from sheet metal hammered into shape and attached with chainmail covering the gaps.  For the modern knight on a budget."),
    mass = "24300 g",
    volume = "17500 ml",
    price = "60 USD",
    survival_price = "13 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "armor_junk_lightplate",
    color = "light_gray",
    length = "120 cm",
    flags = { "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 23,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_metal_sheets_chain_heavy",
    category = "armor",
    name = ccb.content.text("heavy junkyard plate armor"),
    description = ccb.content.text("A full set of steel armor made from sheet metal hammered into shape and attached with chainmail covering the gaps, with an extra-thick chestpiece.  About as heavy as a car but nowhere near as mobile, this suit is nonetheless quite protective."),
    mass = "33100 g",
    volume = "17500 ml",
    price = "60 USD",
    survival_price = "13 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "armor_junk_lightplate",
    color = "light_gray",
    length = "120 cm",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "STURDY" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 1.8 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 32,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 23,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_ch_metal_sheets_chain",
    copy_from = "armor_metal_sheets_chain",
    name = ccb.content.text("hardened junkyard plate armor"),
    description = ccb.content.text("A full set of steel armor made from sheet metal hammered into shape, attached with chainmail, and case-hardened for extra strength.  It might be crude and uncomfortably heavy, but it was clearly made by a skilled metalworker and offers excellent protection."),
    materials = { "ch_steel", "ch_steel_chain" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "ch_steel", coverage = 95, thickness = 0.3 },
                    { id = "ch_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "ch_steel", coverage = 95, thickness = 0.3 },
                    { id = "ch_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 23,
            },
            {
                materials = {
                    { id = "ch_steel", coverage = 95, thickness = 0.3 },
                    { id = "ch_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "armor_ch_metal_sheets_chain_heavy",
    copy_from = "armor_metal_sheets_chain_heavy",
    name = ccb.content.text("heavy hardened junkyard plate armor"),
    description = ccb.content.text("A full set of steel armor made from sheet metal hammered into shape, attached with chainmail, with a double-thick chestpiece, and case-hardened for extra strength.  Top-of-the-line in armor that looks like it was made from banged-up lockers, for the skilled metalworker that values protection over being able to move."),
    materials = { "ch_steel", "ch_steel_chain" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "ch_steel", coverage = 95, thickness = 1.8 },
                    { id = "ch_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 32,
            },
            {
                materials = {
                    { id = "ch_steel", coverage = 95, thickness = 0.3 },
                    { id = "ch_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 23,
            },
            {
                materials = {
                    { id = "ch_steel", coverage = 95, thickness = 0.3 },
                    { id = "ch_steel_chain", coverage = 100, thickness = 1.2 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_lc_lightplate",
    category = "armor",
    name = ccb.content.text("mild steel light plate armor"),
    description = ccb.content.text("A light suit of plate armor with a 2 mm thick chestpiece.  This one has been made with mild steel."),
    mass = "15 kg",
    volume = "17500 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "BLOCK_WHILE_WORN" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 92, thickness = 1.5 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 100,
                encumbrance = 12,
                vitals_coverage = 92,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 1.45 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                vitals_coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.75 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 100,
                encumbrance = 8,
                vitals_coverage = 95,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 0.7 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
                coverage = 100,
                vitals_coverage = 80,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 88, thickness = 1.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                vitals_coverage = 85,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 0.75 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r" },
                coverage = 100,
                vitals_coverage = 85,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 1.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 9,
                vitals_coverage = 85,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 85, thickness = 0.7 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                vitals_coverage = 85,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.75 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_lightplate",
    name = ccb.content.text("mild steel light plate armor"),
    copy_from = "armor_lc_lightplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_lightplate",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.text("medium steel light plate armor"),
    description = ccb.content.text("A light suit of plate armor with a 2 mm thick chestpiece.  Made with tougher medium steel, this suit offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_lightplate",
    name = ccb.content.text("medium steel light plate armor"),
    copy_from = "armor_mc_lightplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_lightplate",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.text("high steel light plate armor"),
    description = ccb.content.text("A light suit of plate armor with a 2 mm thick chestpiece.  Made with high steel, offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_lightplate",
    name = ccb.content.text("high steel light plate armor"),
    copy_from = "armor_hc_lightplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_lightplate",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.text("hardened steel light plate armor"),
    description = ccb.content.text("A light suit of plate armor with a 2 mm thick chestpiece.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_lightplate",
    name = ccb.content.text("hardened steel light plate armor"),
    copy_from = "armor_ch_lightplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_lightplate",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.text("tempered steel light plate armor"),
    description = ccb.content.text("A light suit of plate armor with a 2 mm thick chestpiece.  The medium steel has been quenched and tempered, offering top-of-the-line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_lightplate",
    name = ccb.content.text("tempered steel light plate armor"),
    copy_from = "armor_qt_lightplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_plate",
    category = "armor",
    name = ccb.content.text("mild steel plate armor"),
    description = ccb.content.text("A suit of plate armor with a 4 mm thick chestpiece.  This one has been made with mild steel."),
    mass = "20 kg",
    volume = "17500 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "BLOCK_WHILE_WORN" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        thickness = 4,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 3.1 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 100,
                vitals_coverage = 98,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 98, thickness = 2.5 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_lower" },
                vitals_coverage = 100,
                coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 97, thickness = 1.15 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 100,
                vitals_coverage = 100,
                encumbrance = 12,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 94, thickness = 1.15 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r", "arm_elbow_l", "arm_elbow_r" },
                coverage = 100,
                vitals_coverage = 90,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 92, thickness = 2.5 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                vitals_coverage = 90,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 2.5 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 15,
                vitals_coverage = 90,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 92, thickness = 1.15 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                vitals_coverage = 90,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 97, thickness = 1.15 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_plate",
    name = ccb.content.text("mild steel plate armor"),
    copy_from = "armor_lc_plate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_plate",
    copy_from = "armor_lc_plate",
    name = ccb.content.text("medium steel plate armor"),
    description = ccb.content.text("A suit of plate armor with a 4 mm thick chestpiece.  Made with tougher medium steel, this suit offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_plate",
    name = ccb.content.text("medium steel plate armor"),
    copy_from = "armor_mc_plate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_plate",
    copy_from = "armor_lc_plate",
    materials = { "hc_steel", "hc_steel_chain" },
    name = ccb.content.text("high steel plate armor"),
    description = ccb.content.text("A suit of plate armor with a 4 mm thick chestpiece.  Made with high steel, offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_plate",
    name = ccb.content.text("high steel plate armor"),
    copy_from = "armor_hc_plate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_plate",
    copy_from = "armor_lc_plate",
    materials = { "ch_steel", "ch_steel_chain" },
    name = ccb.content.text("hardened steel plate armor"),
    description = ccb.content.text("A suit of plate armor with a 4 mm thick chestpiece.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_plate",
    name = ccb.content.text("hardened steel plate armor"),
    copy_from = "armor_ch_plate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_plate",
    copy_from = "armor_lc_plate",
    materials = { "qt_steel", "qt_steel_chain" },
    name = ccb.content.text("tempered steel plate armor"),
    description = ccb.content.text("A suit of plate armor with a 4 mm thick chestpiece.  The medium steel has been quenched and tempered, offering top-of-the-line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_plate",
    name = ccb.content.text("tempered steel plate armor"),
    copy_from = "armor_qt_plate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- This version would have a comprehensive fauld over the groin and butt, which is why coverage is at 100
ccb.content.define_item {
    id = "armor_lc_heavyplate",
    category = "armor",
    name = ccb.content.text("mild steel heavy plate armor"),
    description = ccb.content.text("A heavy suit of plate armor with a 5 mm thick chestpiece.  This one has been made with mild steel."),
    mass = "25 kg",
    volume = "17500 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "BLOCK_WHILE_WORN" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        thickness = 6,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 97, thickness = 4.1 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                vitals_coverage = 100,
                subparts = { "torso_upper" },
                coverage = 100,
                encumbrance = 23,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 3.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_lower" },
                vitals_coverage = 100,
                coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.65 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                vitals_coverage = 100,
                coverage = 100,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 96, thickness = 1.65 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r", "arm_elbow_l", "arm_elbow_r" },
                coverage = 100,
                vitals_coverage = 95,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 96, thickness = 3.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                vitals_coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 3.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                vitals_coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 96, thickness = 1.65 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r", "leg_upper_l", "leg_upper_r" },
                vitals_coverage = 95,
                coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.65 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_heavyplate",
    name = ccb.content.text("mild steel heavy plate armor"),
    copy_from = "armor_lc_heavyplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_heavyplate",
    copy_from = "armor_lc_heavyplate",
    name = ccb.content.text("medium steel heavy plate armor"),
    description = ccb.content.text("A heavy suit of plate armor with a 6 mm thick chestpiece.  Made with tougher medium steel, this suit offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_heavyplate",
    name = ccb.content.text("medium steel heavy plate armor"),
    copy_from = "armor_mc_heavyplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_heavyplate",
    copy_from = "armor_lc_heavyplate",
    name = ccb.content.text("high steel heavy plate armor"),
    description = ccb.content.text("A heavy suit of plate armor with a 6 mm thick chestpiece.  Made with high steel, offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_heavyplate",
    name = ccb.content.text("high steel heavy plate armor"),
    copy_from = "armor_hc_heavyplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_heavyplate",
    copy_from = "armor_lc_heavyplate",
    name = ccb.content.text("hardened steel heavy plate armor"),
    description = ccb.content.text("A heavy suit of plate armor with a 6 mm thick chestpiece.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_heavyplate",
    name = ccb.content.text("hardened steel heavy plate armor"),
    copy_from = "armor_ch_heavyplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_heavyplate",
    copy_from = "armor_lc_heavyplate",
    name = ccb.content.text("tempered steel heavy plate armor"),
    description = ccb.content.text("A heavy suit of plate armor with a 6 mm thick chestpiece.  The medium steel has been quenched and tempered, offering top-of-the-line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_heavyplate",
    name = ccb.content.text("tempered steel heavy plate armor"),
    copy_from = "armor_qt_heavyplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36% leaving us with 6696 cm^2, arms are 18% leaving us with 3348 cm^2, and the legs are the 36% leaving us with 6696 cm^2.
-- Leather has a density of 1.1g/cm^3, thickness of 0.45 cm, coverage of 95% leaves us with 3 149 grams.
-- Budget steel has a density of 8g/cm^3, thickness of 0.175 cm, coverage of 80.75% leaves us with 7 570 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 90% leaves us with 1205 grams.
-- Budget steel has a density of 8g/cm^3, thickness of 0.125 cm, coverage of 56.25% leaves us with 1 883 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 95% leaves us with 3 149 grams.
-- Budget steel has a density of 8g/cm^3, thickness of 0.125 cm, coverage of 52.5% leaves us with 3 515 grams.
ccb.content.define_item {
    id = "armor_plarmor",
    category = "armor",
    name = ccb.content.text("plated leather armor"),
    description = ccb.content.text("Thick leather body armor that has been reinforced with strategically-placed metal plates."),
    mass = "21 kg",
    volume = "9 L",
    price = "1 kUSD 100 USD",
    survival_price = "30 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "leather", "budget_steel" },
    symbol = "[",
    color = "brown",
    length = "60 cm",
    looks_like = "armor_larmor",
    flags = { "VARSIZE", "STURDY", "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 95,
                encumbrance = 22,
                materials = {
                    { id = "leather", coverage = 100, thickness = 4.5 },
                    { id = "budget_steel", coverage = 85, thickness = 1.75 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 90,
                encumbrance = 22,
                materials = {
                    { id = "leather", coverage = 100, thickness = 4 },
                    { id = "budget_steel", coverage = 75, thickness = 1.25 },
                },
                subparts = { "arm_lower_l", "arm_lower_r", "arm_upper_r", "arm_upper_l" },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 90,
                encumbrance = 0,
                materials = { { id = "leather", coverage = 100, thickness = 4 } },
                subparts = { "arm_elbow_l", "arm_elbow_r", "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 22,
                materials = {
                    { id = "leather", coverage = 100, thickness = 4 },
                    { id = "budget_steel", coverage = 70, thickness = 1.25 },
                },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_upper_l", "leg_upper_r" },
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 0,
                materials = { { id = "leather", coverage = 100, thickness = 4 } },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_knee_l", "leg_knee_r" },
            },
        },
        warmth = 25,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_armor_plarmor",
    name = ccb.content.text("plated leather armor"),
    copy_from = "armor_plarmor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_plarmor_xs",
    copy_from = "armor_plarmor",
    looks_like = "armor_plarmor",
    name = ccb.content.text("plated leather armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_junk_plate",
    category = "armor",
    name = ccb.content.text("junk ornamental plate armor"),
    description = ccb.content.text("An extremely heavy suit of ornamental armor.  The metal shows signs of rust and corrosion, and the leather straps are tattered."),
    mass = "18 kg",
    volume = "30 L",
    price = "7 kUSD 800 USD",
    survival_price = "60 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "budget_steel", "leather" },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 25,
        thickness = 5,
        portions = {
            {
                encumbrance = 50,
                coverage = 90,
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
            },
        },
    },
}
