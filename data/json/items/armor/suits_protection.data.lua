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

ccb.content.define_item {
    id = "armor_riot",
    category = "armor",
    name = ccb.content.plural_text("riot armor suit", "riot armor suits"),
    description = ccb.content.text("A full suit of black plastic body armor plates used by riot police.  Cleverly placed velcro straps secure each piece, resulting in slightly less encumbrance than its constituent parts.  MOLLE webbing is attached to the torso and the word POLICE is emblazoned across the front."),
    mass = "3 kg",
    volume = "12500 ml",
    price = "600 USD",
    survival_price = "40 USD",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "kevlar",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "PADDED", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 20,
        portions = {
            {
                encumbrance = 6,
                coverage = 75,
                covers = { "torso" },
                volume_encumbrance = 0.3,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 7 },
                    { id = "thermo_resin", coverage = 90, thickness = 2 },
                },
            },
            {
                covers = { "arm_l", "arm_r", "leg_l", "leg_r" },
                volume_encumbrance = 0,
                encumbrance = 4,
                coverage = 90,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 5 },
                    { id = "thermo_resin", coverage = 90, thickness = 1.75 },
                },
                subparts = {
                    "arm_lower_l", "arm_lower_r", "arm_elbow_l", "arm_elbow_r", "leg_knee_l",
                    "leg_knee_r", "leg_lower_l", "leg_lower_r",
                },
            },
            {
                covers = { "arm_l", "arm_r", "leg_l", "leg_r", "foot_l", "foot_r" },
                volume_encumbrance = 0,
                coverage = 65,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 5 },
                    { id = "thermo_resin", coverage = 90, thickness = 1.5 },
                },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_l",
                    "arm_upper_r",
                    "leg_upper_l",
                    "leg_upper_r",
                },
            },
            {
                covers = { "foot_l", "foot_r" },
                volume_encumbrance = 0,
                encumbrance = 2,
                coverage = 75,
                materials = { { id = "thermo_resin", coverage = 100, thickness = 1.5 } },
                subparts = { "foot_arch_l", "foot_arch_r", "foot_ankle_r", "foot_ankle_l" },
            },
            {
                covers = { "leg_l", "leg_r" },
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "armor_samurai",
    category = "armor",
    name = ccb.content.plural_text("ō-yoroi", "ō-yoroi"),
    description = ccb.content.text("An ornamental suit of Japanese samurai armor."),
    mass = "9220 g",
    volume = "11500 ml",
    price = "900 USD",
    survival_price = "80 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "VARSIZE", "STURDY", "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 25,
        thickness = 4,
        portions = {
            {
                encumbrance = 15,
                coverage = 85,
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_scrapsuit",
    category = "armor",
    name = ccb.content.text("scrap suit"),
    description = ccb.content.text("A suit of armor made from scraps of metal secured by simple strings to cloth wraps; the loose collection of plates provides decent but uncomfortable protection."),
    mass = "9534 g",
    volume = "15500 ml",
    price = "600 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "uneven" },
    materials = { "budget_steel", "cotton" },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "light_gray",
    length = "40 cm",
    flags = { "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 6, cut = 3 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 75, thickness = 2 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "budget_steel", coverage = 75, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = 15,
            },
            {
                materials = {
                    { id = "budget_steel", coverage = 75, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 15,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_xl_scrapsuit",
    copy_from = "armor_scrapsuit",
    name = ccb.content.text("scrap suit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_xs_scrapsuit",
    copy_from = "armor_scrapsuit",
    name = ccb.content.text("scrap suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_tiresuit",
    category = "armor",
    name = ccb.content.text("tire suit"),
    description = ccb.content.text("A suit of armor made from thick chunks of rubber tire secured by simple strings; the loose collection of rubber plates provides decent but not the most convenient protection."),
    mass = "14400 g",
    volume = "15500 ml",
    price = "500 USD",
    survival_price = "2 USD",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "armor_scrapsuit",
    color = "light_gray",
    length = "40 cm",
    flags = { "OUTER", "NONCONDUCTIVE", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                encumbrance = 18,
                coverage = 80,
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "beekeeping_suit",
    name = ccb.content.text("beekeeping suit"),
    description = ccb.content.text("A white suit commonly worn by professional beekeepers with straps on your ankles and wrists to prevent bees from flying in.  It's not a very tough fabric, but it's lightweight and has plenty of storage thanks to a chest pocket."),
    mass = "1587 g",
    volume = "3500 ml",
    price = "120 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "hazmat_suit",
    color = "white",
    length = "12 cm",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1600 ml",
            mass_limit = "3 kg",
            max_item_length = "18 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 10, 15 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 10, 12 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 10, 10 } },
        },
        warmth = 25,
        thickness = 2,
        environmental_protection = 1,
    },
}

-- NO_I18N
-- Should be lighter when irl hauberk as it does not cover legs
ccb.content.define_item {
    id = "base_chainmail_hauberk",
    abstract = true,
    copy_from = "base_chainmail_vest",
    name = ccb.content.text_without_extraction("chainmail hauberk"),
    description = ccb.content.text("A fully customized chainmail outfit, covering torso and arms.  Combine with a aketon or other padded layer for optimal protection."),
    mass = "9356 g",
    volume = "2750 ml",
    length = "14 cm",
    price = "359 USD 88 cent",
    survival_price = "30 USD",
    looks_like = "armor_blarmor",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "9350 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2200 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 50,
                encumbrance = 0,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "gastropod_foot" },
                coverage = 50,
                encumbrance = 0,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_hauberk",
    abstract = true,
    name = ccb.content.text_without_extraction("chainmail hauberk"),
    copy_from = "base_chainmail_hauberk",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_hauberk",
    abstract = true,
    copy_from = "base_chainmail_hauberk",
    name = ccb.content.text_without_extraction("chainmail hauberk"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "550 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}

ccb.content.define_item {
    id = "chainmail_junk_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "budget_steel_chain" },
    name = ccb.content.text("chainmail hauberk"),
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "arm_l", "arm_r" },
                coverage = 97,
                encumbrance = 14,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 50,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail hauberk"),
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_sjumpsuit",
    abstract = true,
    copy_from = "base_chainmail_hauberk",
    name = ccb.content.text_without_extraction("chainmail sleeveless jumpsuit"),
    description = ccb.content.text("A fully customized chainmail outfit, covering torso and arms.  Combine with a aketon or other padded layer for optimal protection."),
    mass = "10669 g",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "9350 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3300 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "900 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 14,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 50,
                encumbrance = 0,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_sjumpsuit",
    abstract = true,
    name = ccb.content.text_without_extraction("chainmail sleeveless jumpsuit"),
    copy_from = "base_chainmail_sjumpsuit",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1050 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_sjumpsuit",
    abstract = true,
    copy_from = "base_chainmail_sjumpsuit",
    name = ccb.content.text_without_extraction("chainmail sleeveless jumpsuit"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_sjumpsuit",
    copy_from = "base_chainmail_sjumpsuit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_sjumpsuit",
    copy_from = "xl_chainmail_sjumpsuit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_sjumpsuit_xs",
    copy_from = "xs_chainmail_sjumpsuit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_sjumpsuit",
    copy_from = "base_chainmail_sjumpsuit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_sjumpsuit",
    copy_from = "xl_chainmail_sjumpsuit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_sjumpsuit_xs",
    copy_from = "xs_chainmail_sjumpsuit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_sjumpsuit",
    copy_from = "base_chainmail_sjumpsuit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_sjumpsuit",
    copy_from = "xl_chainmail_sjumpsuit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_sjumpsuit_xs",
    copy_from = "xs_chainmail_sjumpsuit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_sjumpsuit",
    copy_from = "base_chainmail_sjumpsuit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("hardened steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_sjumpsuit",
    copy_from = "xl_chainmail_sjumpsuit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_sjumpsuit_xs",
    copy_from = "xs_chainmail_sjumpsuit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_sjumpsuit",
    copy_from = "base_chainmail_sjumpsuit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_sjumpsuit",
    copy_from = "xl_chainmail_sjumpsuit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail sleeveless jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_sjumpsuit_xs",
    copy_from = "xs_chainmail_sjumpsuit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail sleeveless jumpsuit"),
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_jumpsuit",
    abstract = true,
    copy_from = "base_chainmail_vest",
    name = ccb.content.text_without_extraction("chainmail jumpsuit"),
    description = ccb.content.text("A fully customized chainmail outfit, leaving the head uncovered.  Combine with a gambeson or other padded layer for optimal protection."),
    mass = "13131 g",
    volume = "3250 ml",
    length = "15 cm",
    price = "450 USD",
    survival_price = "80 USD",
    looks_like = "touring_suit",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "9350 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2200 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3300 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "900 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_jumpsuit",
    abstract = true,
    name = ccb.content.text_without_extraction("chainmail jumpsuit"),
    copy_from = "base_chainmail_jumpsuit",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1050 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_jumpsuit",
    abstract = true,
    copy_from = "base_chainmail_jumpsuit",
    name = ccb.content.text_without_extraction("chainmail jumpsuit"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "550 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_jumpsuit",
    copy_from = "base_chainmail_jumpsuit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_jumpsuit",
    copy_from = "xl_chainmail_jumpsuit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_jumpsuit_xs",
    copy_from = "xs_chainmail_jumpsuit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_jumpsuit",
    copy_from = "base_chainmail_jumpsuit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_jumpsuit",
    copy_from = "xl_chainmail_jumpsuit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_jumpsuit_xs",
    copy_from = "xs_chainmail_jumpsuit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_jumpsuit",
    copy_from = "base_chainmail_jumpsuit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_jumpsuit",
    copy_from = "xl_chainmail_jumpsuit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_jumpsuit_xs",
    copy_from = "xs_chainmail_jumpsuit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_jumpsuit",
    copy_from = "base_chainmail_jumpsuit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_jumpsuit",
    copy_from = "xl_chainmail_jumpsuit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_jumpsuit_xs",
    copy_from = "xs_chainmail_jumpsuit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_jumpsuit",
    copy_from = "base_chainmail_jumpsuit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_jumpsuit",
    copy_from = "xl_chainmail_jumpsuit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail jumpsuit"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_jumpsuit_xs",
    copy_from = "xs_chainmail_jumpsuit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail jumpsuit"),
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_suit",
    abstract = true,
    copy_from = "base_chainmail_jumpsuit",
    name = ccb.content.text_without_extraction("chainmail armor"),
    description = ccb.content.text("A fully customized chainmail suit.  Combine with a gambeson or other padded layer for optimal protection."),
    mass = "14446 g",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "9350 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2200 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3300 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "900 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_suit",
    abstract = true,
    name = ccb.content.text_without_extraction("chainmail armor"),
    copy_from = "base_chainmail_suit",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1050 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_suit",
    abstract = true,
    copy_from = "base_chainmail_suit",
    name = ccb.content.text_without_extraction("chainmail armor"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "550 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}

ccb.content.define_item {
    id = "chainmail_junk_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "budget_steel_chain" },
    name = ccb.content.text("chainmail armor"),
    description = ccb.content.text("A fully customized chainmail suit.  The metal shows signs of rust and corrosion.  Combine with a gambeson or other padded layer for optimal protection."),
    armor = {
        portions = {
            {
                materials = { { id = "budget_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 97,
                encumbrance = 14,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "chainmail_suit_faraday",
    copy_from = "qt_chainmail_suit",
    name = ccb.content.text("faraday chainmail suit"),
    description = ccb.content.text("A fully customized chainmail suit that can be worn over your normal clothing.  The suit is conductively interconnected with a cage covering the face, protecting against electricity."),
    armor = {
        portions = {
            {
                materials = { { id = "qt_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = { { id = "qt_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head" },
                coverage = 100,
                encumbrance = 30,
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "cotton", coverage = 100, thickness = 0.001 },
                },
                covers = { "eyes" },
                coverage = 95,
                ranged_coverage = 10,
                encumbrance = 2,
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "cotton", coverage = 100, thickness = 0.001 },
                },
                covers = { "mouth", "muzzle", "beak" },
                coverage = 95,
                ranged_coverage = 10,
                encumbrance = 0,
                breathability = "GOOD",
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "qt_steel_chain", coverage = 100, thickness = 1.2 } },
                encumbrance = 10,
                coverage = 100,
            },
        },
    },
    inheritance = { add = { flags = { "ELECTRIC_IMMUNE" } } },
}

ccb.content.define_item {
    id = "xl_chainmail_suit_faraday",
    copy_from = "chainmail_suit_faraday",
    name = ccb.content.text("faraday chainmail suit"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1050 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "chainmail_suit_faraday_xs",
    copy_from = "chainmail_suit_faraday",
    looks_like = "chainmail_suit_faraday",
    name = ccb.content.text("faraday chainmail suit"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "550 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Should be somewhat more difficult to repair than ordinary plastic
ccb.content.define_item {
    id = "cleansuit",
    repair_like = "bunker_coat",
    name = ccb.content.text("cleansuit"),
    description = ccb.content.text("A simple hazardous materials handling suit.  Though somewhat restrictive and fragile, wearing it will provide excellent protection against ambient radiation."),
    mass = "2100 g",
    volume = "2500 ml",
    price = "77 USD",
    survival_price = "12 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "white",
    length = "12 cm",
    flags = { "VARSIZE", "WATERPROOF", "HOOD", "RAINPROOF", "RAD_RESIST", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 1,
        environmental_protection = 10,
        portions = {
            {
                encumbrance = 25,
                coverage = 100,
                covers = { "leg_l", "leg_r", "foot_l", "foot_r", "head", "torso", "arm_l", "arm_r" },
            },
        },
    },
}

-- Predecessor of, and lab equivalent to, the phase immersion suit
-- not in direct contact with eye or mouth
-- feet have boot-covers with a tough footpad
-- standard hazmat suit on most of body
ccb.content.define_item {
    id = "xedra_artifact_cleansuit",
    name = ccb.content.plural_text("S02a hazmat suit", "S02a hazmat suits"),
    description = ccb.content.text("A bulky hazardous materials handling suit.  This one appears outfitted for the highest levels of protection, featuring built in oversized rubber gloves, sealed boot covers with a rubber sole, and an active temperature control system.  It's clearly designed to accommodate additional equipment, including self-contained breathing apparatuses or powered air purifying respirator systems.  Strange wiring snakes the entire garment, connecting to small electronic pads on all of the joints and the head.  A battery compartment marked with \"X.E.D.R.A PROTOTYPE S02a\" is attached to the back."),
    mass = "2500 g",
    volume = "2500 ml",
    price = "1 kUSD 500 USD",
    survival_price = "80 USD",
    materials = { "plastic", "hard_plastic_transp", "butyl_rubber" },
    symbol = "[",
    looks_like = "hazmat_suit",
    color = "white",
    length = "12 cm",
    flags = { "OVERSIZE", "WATERPROOF", "HOOD", "RAINPROOF", "RAD_PROOF", "ELECTRONIC", "SOFT", "OUTER" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 10,
        environmental_protection = 10,
        portions = {
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 1.0 } },
                encumbrance = 5,
                coverage = 100,
                covers = { "mouth", "eyes" },
                volume_encumbrance = 0,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "butyl_rubber", coverage = 100, thickness = 2.0 } },
                encumbrance = 5,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                layers = { "OUTER" },
                volume_encumbrance = 0,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "plastic", coverage = 100, thickness = 2 } },
                encumbrance = 5,
                coverage = 100,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "butyl_rubber", coverage = 100, thickness = 2 } },
                encumbrance = 5,
                coverage = 100,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2 } },
                encumbrance = 27,
                coverage = 100,
                covers = { "arm_l", "arm_r", "leg_l", "leg_r", "head", "torso" },
                layers = { "OUTER" },
                volume_encumbrance = 0,
            },
        },
    },
    artifact = { enchantments = { "resonance_suit_active", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The %s starts to faintly vibrate."),
            target = "xedra_artifact_cleansuit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}

ccb.content.define_item {
    id = "xedra_artifact_cleansuit_on",
    copy_from = "xedra_artifact_cleansuit",
    name = ccb.content.plural_text("S02a hazmat suit (on)", "S02a hazmat suits (on)"),
    looks_like = "xedra_artifact_cleansuit",
    description = ccb.content.text("A bulky hazardous materials handling suit.  This one appears outfitted for the highest levels of protection, featuring built in oversized rubber gloves, sealed boot covers with a rubber sole, and an active temperature control system.  It's clearly designed to accommodate additional equipment, including self-contained breathing apparatuses or powered air purifying respirator systems.  Strange wiring snakes the entire garment, connecting to small electronic pads on all of the joints and the head.  A battery compartment marked with \"X.E.D.R.A PROTOTYPE S02a\" is attached to the back.  The device is currently switched on."),
    revert_to = "xedra_artifact_cleansuit",
    flags = {
        "OVERSIZE", "WATERPROOF", "HOOD", "RAINPROOF", "RAD_PROOF", "ELECTRONIC", "TRADER_AVOID",
        "SPAWN_ACTIVE", "PORTAL_PROOF", "ELECTRIC_IMMUNE", "PSYSHIELD_PARTIAL", "SOFT", "OUTER",
    },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 100 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The %s stops vibrating."),
            target = "xedra_artifact_cleansuit",
        },
    },
}

ccb.content.define_item {
    id = "entry_suit",
    category = "armor",
    name = ccb.content.text("entry suit"),
    description = ccb.content.text("A flame-resistant whole-body garment worn by firefighters as protection against extreme heat.  It requires a separate gas mask for full protection against smoke."),
    mass = "2900 g",
    volume = "6 L",
    price = "2 kUSD 405 USD",
    survival_price = "25 USD",
    materials = { "nomex", "kevlar" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "light_gray",
    length = "30 cm",
    flags = { "VARSIZE", "WATERPROOF", "RAINPROOF", "GAS_PROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 30,
        thickness = 5,
        environmental_protection = 20,
        portions = {
            {
                encumbrance = 50,
                coverage = 100,
                covers = {
                    "head",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_entry_suit",
    name = ccb.content.text("entry suit"),
    copy_from = "entry_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "entry_suit_xs",
    copy_from = "entry_suit",
    looks_like = "entry_suit",
    name = ccb.content.text("entry suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- real bite suits are made with linen, but we don't have linen, so denim is the closest approx. (canvas is always waterproofed and these suits are not)
-- skip second entry for arm encumbrance
ccb.content.define_item {
    id = "bite_suit",
    category = "armor",
    name = ccb.content.text("canine bite suit"),
    description = ccb.content.text("Designed to stop the injuries of dog bites, this thick, one piece suit is often used in the rehabilitation of abused animals and in training dogs by the police and military.  A base layer of aramid fabric has had strips of soft body armor sewn into it to mimic quilting, and to soften the blunt of animals jumping, slashing, or pouncing on the wearer."),
    mass = "11556 g",
    volume = "8255 ml",
    price = "200 USD",
    survival_price = "100 USD",
    materials = { "kevlar", "denim" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NONCONDUCTIVE" },
    armor = {
        warmth = 50,
        thickness = 4,
        valid_mods = { "steel_padded" },
        portions = {
            {
                materials = {
                    { id = "kevlar", coverage = 95, thickness = 4 },
                    { id = "denim", coverage = 100, thickness = 3 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 30,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 4 },
                    { id = "denim", coverage = 100, thickness = 3 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r" },
                coverage = 100,
                encumbrance = 30,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 70, thickness = 4 },
                    { id = "denim", coverage = 100, thickness = 3 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 95, thickness = 4 },
                    { id = "kevlar", coverage = 100, thickness = 3 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 30,
            },
        },
    },
}

-- Should be substantially more difficult to repair than ordinary plastic - ch_steel is difficulty 7
ccb.content.define_item {
    id = "hazmat_suit",
    repair_like = "ch_steel_lump",
    category = "armor",
    name = ccb.content.text("hazmat suit"),
    description = ccb.content.text("An impermeable whole-body garment worn as protection against hazardous materials.  Restrictive and fragile, wearing it will provide complete protection against ambient radiation.  It requires a separate gas mask for full protection."),
    mass = "5000 g",
    volume = "17 L",
    price = "1 kUSD 175 USD",
    survival_price = "15 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "beekeeping_suit",
    color = "yellow",
    flags = {
        "VARSIZE",
        "WATERPROOF",
        "RAINPROOF",
        "GAS_PROOF",
        "RAD_PROOF",
        "ELECTRIC_IMMUNE",
        "OUTER",
        "SOFT",
    },
    armor = {
        warmth = 40,
        thickness = 2,
        environmental_protection = 20,
        portions = {
            {
                encumbrance = 37,
                coverage = 100,
                covers = {
                    "head",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "nomex_suit",
    name = ccb.content.text("flame-resistant suit"),
    description = ccb.content.text("A snug body suit made from thin and lightweight Nomex fire-resistant fabric.  Tough yet breathable, it is light and comfortable to wear under clothing."),
    mass = "688 g",
    volume = "1500 ml",
    price = "130 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nomex" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 2,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 6,
                coverage = 100,
                covers = { "leg_l", "leg_r", "torso", "arm_l", "arm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_nomex_suit",
    name = ccb.content.text("flame-resistant suit"),
    copy_from = "nomex_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "nomex_suit_xs",
    copy_from = "nomex_suit",
    looks_like = "nomex_suit",
    name = ccb.content.text("flame-resistant suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- 2mm Nomex across the entire suit with a waterproof silicone outer to provide hazmat properties. Hands and feet reinforced/shaped with other materials to provide full-body hazmat protection with minimal encumbrance.
-- Back of hand from the wrist to the knuckles can be stiffer but still needs a little flexibility. This area can afford the most thickness on gloves.
-- Molded knuckle plates, spacious enough inside the gloves to flex your knuckles fine while providing extra knuckle protection because busting your knuckles sucks.
-- encumbrance accounted for above
-- A bit of Kevlar between the third and second knuckles, the part of the fingers where flexibility is least important.
-- Fingers need to be the most flexible and tactile part of the hand. Lycra/nylon blend (as the lycra material is defined) will give both those qualities while sacrificing the least protection.
-- encumbrance accounted for above
-- The boots are reinforced with plastic plates throughout to protect against penetration.
-- The Kevlar is 2mm thick over most of the boots, and 1mm thick for flexible joints.
-- Steel shank for excellent arch support and to maintain boot shape for longevity.
-- encumbrance accounted for above
-- Steel toes
-- encumbrance accounted for above
-- encumbrance accounted for above
ccb.content.define_item {
    id = "robofac_enviro_suit",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 environmental suit", "Hub 01 environmental suits"),
    description = ccb.content.text("A lightweight environmental suit incorporating Kevlar-lined boots and gloves, worn by Hub personnel in their rare forays aboveground.  Colored brown and blue, the white seal of Hub 01 is embroidered on both of its upper arms.  It requires a separate gas mask for full protection."),
    mass = "4000 g",
    volume = "14 L",
    price = "1 kUSD 175 USD",
    survival_price = "20 USD",
    materials = { "nomex", "kevlar", "hc_steel", "thermo_resin", "lycra", "vinyl" },
    symbol = "[",
    looks_like = "hazmat_suit",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 80 },
    },
    flags = { "VARSIZE", "WATERPROOF", "RAINPROOF", "GAS_PROOF", "RAD_PROOF", "ELECTRIC_IMMUNE", "STURDY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "thermo_resin", coverage = 30, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_r", "hand_back_l" },
                coverage = 100,
                encumbrance = { 16, 16 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 100, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_r", "hand_wrist_r", "hand_palm_l", "hand_wrist_l" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 25, thickness = 1 },
                    { id = "lycra", coverage = 100, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_r", "hand_fingers_l" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "thermo_resin", coverage = 85, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 90, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_heel_l", "foot_ankle_r", "foot_heel_r" },
                coverage = 100,
                encumbrance = { 25, 25 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 25, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_l", "foot_arch_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 6 },
                    { id = "nomex", coverage = 100, thickness = 2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_l", "foot_sole_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 7, 7 },
            },
        },
        warmth = 40,
        environmental_protection = 20,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear casually"),
            message = ccb.content.text("You slip out of the top of the suit and tie the sleeves around your waist."),
            target = "robofac_enviro_suit_casual",
        },
    },
}

-- The boots are reinforced with plastic plates throughout to protect against penetration.
-- The Kevlar is 2mm thick over most of the boots, and 1mm thick for flexible joints.
-- Steel shank for excellent arch support and to maintain boot shape for longevity.
-- encumbrance accounted for above
-- Steel toes
-- encumbrance accounted for above
-- encumbrance accounted for above
ccb.content.define_item {
    id = "robofac_enviro_suit_casual",
    copy_from = "robofac_enviro_suit",
    name = ccb.content.plural_text("Hub 01 environmental suit (casual)", "Hub 01 environmental suits (casual)"),
    description = ccb.content.text("A lightweight environmental suit incorporating Kevlar-lined boots, worn by Hub personnel in their rare forays aboveground.  Colored brown and blue, the upper portion has been tied around the waist casually."),
    inheritance = { remove = { flags = { "RAINPROOF", "GAS_PROOF", "RAD_PROOF", "ELECTRIC_IMMUNE" } } },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "thermo_resin", coverage = 85, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 90, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_heel_l", "foot_ankle_r", "foot_heel_r" },
                coverage = 100,
                encumbrance = { 25, 25 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 25, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_l", "foot_arch_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 6 },
                    { id = "nomex", coverage = 100, thickness = 2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_l", "foot_sole_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 7, 7 },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear normally"),
            message = ccb.content.text("You untie the sleeves and put back on the top of the suit."),
            target = "robofac_enviro_suit",
        },
    },
}

-- 2mm Nomex across the entire suit with a waterproof silicone outer to provide hazmat properties. Hands and feet reinforced/shaped with other materials to provide full-body hazmat protection with minimal encumbrance.
-- Back of hand from the wrist to the knuckles can be stiffer but still needs a little flexibility. This area can afford the most thickness on gloves.
-- Molded knuckle plates, spacious enough inside the gloves to flex your knuckles fine while providing extra knuckle protection because busting your knuckles sucks.
-- encumbrance accounted for above
-- A bit of Kevlar between the third and second knuckles, the part of the fingers where flexibility is least important.
-- Fingers need to be the most flexible and tactile part of the hand. Lycra/nylon blend (as the lycra material is defined) will give both those qualities while sacrificing the least protection.
-- encumbrance accounted for above
-- The boots are reinforced with plastic plates throughout to protect against penetration.
-- The Kevlar is 2mm thick over most of the boots, and 1mm thick for flexible joints.
-- Steel shank for excellent arch support and to maintain boot shape for longevity.
-- encumbrance accounted for above
-- Steel toes
-- encumbrance accounted for above
-- encumbrance accounted for above
ccb.content.define_item {
    id = "robofac_resonance_suit",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 hazardous materials suit", "Hub 01 hazardous materials suits"),
    description = ccb.content.text("A hefty environmental suit incorporating Kevlar-lined boots and gloves, worn by Hub personnel in their rare forays aboveground.  This one has a large battery pack and otherworldly electronics which snake the entire exterior, making it substantially more cumbersome to wear than its base model.  Colored brown and blue, the white seal of Hub 01 is embroidered on both of its upper arms.  It requires a separate gas mask for full protection.  Activate it to turn on."),
    mass = "5000 g",
    volume = "18 L",
    price = "1 kUSD 175 USD",
    survival_price = "40 USD",
    materials = { "nomex", "kevlar", "hc_steel", "thermo_resin", "lycra", "vinyl" },
    symbol = "[",
    looks_like = "hazmat_suit",
    color = "brown",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_battery_cell",
        },
    },
    flags = {
        "WATERPROOF", "RAINPROOF", "GAS_PROOF", "RAD_PROOF", "ELECTRIC_IMMUNE", "STURDY", "NO_REPAIR",
        "NANOFAB_REPAIR",
    },
    subtype_order = { "armor", "tool", "artifact" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "thermo_resin", coverage = 30, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_r", "hand_back_l" },
                coverage = 100,
                encumbrance = { 16, 16 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 100, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_r", "hand_wrist_r", "hand_palm_l", "hand_wrist_l" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 25, thickness = 1 },
                    { id = "lycra", coverage = 100, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_r", "hand_fingers_l" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "thermo_resin", coverage = 85, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 90, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_heel_l", "foot_ankle_r", "foot_heel_r" },
                coverage = 100,
                encumbrance = { 25, 25 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 25, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_l", "foot_arch_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 6 },
                    { id = "nomex", coverage = 100, thickness = 2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_l", "foot_sole_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 14, 14 },
            },
        },
        warmth = 40,
        environmental_protection = 20,
    },
    tool = { ammo_types = "battery" },
    artifact = { enchantments = { "resonance_suit_active" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("A tiny green LED on the chest of the %s lights up."),
            target = "robofac_resonance_suit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}

ccb.content.define_item {
    id = "robofac_resonance_suit_on",
    copy_from = "robofac_resonance_suit",
    name = ccb.content.plural_text("Hub 01 hazardous materials suit (on)", "Hub 01 hazardous materials suits (on)"),
    description = ccb.content.text("A hefty environmental suit incorporating Kevlar-lined boots and gloves, worn by Hub personnel in their rare forays aboveground.  This one has a large battery pack and otherworldly electronics snaking the entire exterior, making it substantially more cumbersome to wear than its base model.  Colored brown and blue, the white seal of Hub 01 is embroidered on both of its upper arms.  It requires a separate gas mask for full protection.  A tiny green LED on the chest is illuminated."),
    revert_to = "robofac_resonance_suit",
    flags = {
        "WATERPROOF", "RAINPROOF", "GAS_PROOF", "RAD_PROOF", "PSYSHIELD_PARTIAL", "PORTAL_PROOF",
        "ELECTRIC_IMMUNE", "STURDY", "NO_REPAIR", "NANOFAB_REPAIR", "TRADER_AVOID", "SPAWN_ACTIVE",
    },
    subtype_order = { "armor", "tool" },
    armor = {},
    tool = { turns_per_charge = 100 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The LED on the %s flicks off."),
            target = "robofac_resonance_suit",
        },
    },
}

ccb.content.define_item {
    id = "xedra_enviro_suit",
    copy_from = "robofac_enviro_suit",
    name = ccb.content.plural_text("activity suit", "activity suits"),
    description = ccb.content.text("A single-piece brown and orange environmental suit, tailored in a way that slightly recalls a military flight suit.  The letters \"X.E.D.R.A\" are inscribed on its back, and a white shoulder patch on the right arm shows an arrow reaching within rings of concentric circles.  It requires a separate gas mask for full protection."),
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear casually"),
            message = ccb.content.text("You slip out of the top of the suit and tie the sleeves around your waist."),
            target = "xedra_enviro_suit_casual",
        },
    },
}

ccb.content.define_item {
    id = "xedra_enviro_suit_casual",
    copy_from = "robofac_enviro_suit_casual",
    name = ccb.content.plural_text("activity suit (casual)", "activity suits (casual)"),
    description = ccb.content.text("A single-piece brown and orange environmental suit, tailored in a way that slightly recalls a military flight suit.  The upper portion has been tied around the waist casually."),
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear normally"),
            message = ccb.content.text("You untie the sleeves and put back on the top of the suit."),
            target = "xedra_enviro_suit",
        },
    },
}

ccb.content.define_item {
    id = "suit",
    name = ccb.content.text("suit"),
    description = ccb.content.text("A full-body cotton suit.  Makes the apocalypse a truly gentlemanly experience."),
    mass = "1587 g",
    volume = "4750 ml",
    price = "200 USD",
    survival_price = "5 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "12 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "12 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "350 ml",
            mass_limit = "1 kg",
            max_item_length = "12 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "350 ml",
            mass_limit = "1 kg",
            max_item_length = "12 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "10 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "10 cm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 7, 13 } },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = { 7, 10 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 7, 7 } },
        },
        warmth = 25,
        thickness = 0.8,
    },
}

ccb.content.define_item {
    id = "touring_suit",
    category = "armor",
    name = ccb.content.text("track touring suit"),
    description = ccb.content.text("A leather bodysuit with padding in high-impact areas, meant for motorcyclists out on the track.  The leather is stiff but makes the armor much sturdier and more protective than lighter counterparts."),
    mass = "4700 g",
    volume = "6500 ml",
    price = "580 USD",
    survival_price = "10 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "neutral" },
    materials = { "leather", "plastic_pad" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "light_red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "RAINPROOF", "OUTER", "POCKETS", "STURDY", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "plastic_pad", coverage = 90, thickness = 14.0 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 25, 25 },
            },
            {
                materials = {
                    { id = "plastic_pad", coverage = 80, thickness = 14.0 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 25, 25 },
            },
            {
                materials = {
                    { id = "plastic_pad", coverage = 80, thickness = 14.0 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 25, 25 },
            },
        },
        warmth = 25,
        thickness = 4.3,
        valid_mods = { "steel_padded" },
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "officer_uniform",
    name = ccb.content.text("dress uniform"),
    description = ccb.content.text("A military officer's dress uniform from before the Cataclysm, complete with rank and ribbons.  Just looking at it gives you an air of authority.  Perhaps not the most practical military wear, but a very stylish option."),
    mass = "1653 g",
    volume = "4750 ml",
    price = "224 USD",
    survival_price = "5 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "suit",
    color = "dark_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "700 ml", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "700 ml", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
    },
    flags = { "OVERSIZE", "VARSIZE", "POCKETS", "RAINPROOF", "STURDY" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 7, 13 } },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = { 7, 10 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 7, 7 } },
        },
        warmth = 15,
        thickness = 0.5,
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "mil_flight_suit",
    name = ccb.content.text("military flight suit"),
    description = ccb.content.text("A sage-green US military flight suit.  It has various insignia embroidered onto it."),
    mass = "1315 g",
    volume = "4687 ml",
    price = "220 USD 65 cent",
    survival_price = "5 USD",
    materials = { "nomex" },
    symbol = "[",
    looks_like = "touring_suit",
    color = "green",
    pockets = {
        { kind = "CONTAINER", capacity = "700 ml", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "700 ml", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
    },
    flags = { "VARSIZE", "POCKETS" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 1, 2 } },
            { covers = { "arm_l", "arm_r" }, coverage = 50, encumbrance = { 1, 1 } },
            { covers = { "leg_l", "leg_r" }, coverage = 80, encumbrance = { 1, 2 } },
        },
        warmth = 25,
        thickness = 0.8,
    },
}

ccb.content.define_item {
    id = "armor_nomad_plate",
    copy_from = "armor_lc_plate",
    name = ccb.content.plural_text("nomad plate armor", "nomad plate armors"),
    description = ccb.content.text("A full body multilayered suit of plate armor with a 4 mm thick chest piece.  The medium steel has been quenched, tempered and affixed over a full-body layered suit of weight-distributing straps.  The armor has an integrated breathable Lycra jumpsuit and the torso has a spall liner of aramid panels.  Electronics run below the surface and circulate cool air to the skin, drawing power from your internal CBM reservoir."),
    materials = { "qt_steel", "qt_steel_chain", "lycra", "kevlar" },
    inheritance = { add = { flags = { "NORMAL", "MUNDANE", "USES_BIONIC_POWER" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 2.8 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 2.0 },
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 22,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 0.55 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 15,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 0.55 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_plate_0", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the climate control on."),
            target = "armor_nomad_plate_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Your internal reservoir is empty."),
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_plate_on",
    copy_from = "armor_nomad_plate",
    name = ccb.content.plural_text("nomad plate armor (on)", "nomad plate armors (on)"),
    revert_to = "armor_nomad_plate",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The hum of the suit's climate control fades."),
            target = "armor_nomad_plate",
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_lightplate",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.plural_text("nomad light plate armor", "nomad light plate armors"),
    description = ccb.content.text("A full body multilayered light suit of plate armor with a 2 mm thick chest piece.  The medium steel has been quenched, tempered and affixed over a full-body layered suit of weight-distributing straps.  The armor has an integrated breathable Lycra jumpsuit and the torso has a spall liner of aramid panels.  Electronics run below the surface and circulate cool air to the skin, drawing power from your internal CBM reservoir."),
    materials = { "qt_steel", "qt_steel_chain", "lycra", "kevlar" },
    inheritance = { add = { flags = { "NORMAL", "MUNDANE", "USES_BIONIC_POWER" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 0.8 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 2.0 },
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 17,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 0.05 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 10,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 0.05 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_lightplate_0", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the climate control on."),
            target = "armor_nomad_lightplate_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Your internal reservoir is empty."),
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_lightplate_on",
    copy_from = "armor_nomad_lightplate",
    name = ccb.content.plural_text("nomad light plate armor (on)", "nomad light plate armors (on)"),
    revert_to = "armor_nomad_lightplate",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The hum of the suit's climate control fades."),
            target = "armor_nomad_lightplate",
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_heavyplate",
    copy_from = "armor_lc_heavyplate",
    name = ccb.content.plural_text("nomad heavy plate armor", "nomad heavy plate armors"),
    description = ccb.content.text("A full body multilayered heavy suit of plate armor with a 6 mm thick chest piece.  The medium steel has been quenched, tempered and affixed over a full-body layered suit of weight-distributing straps.  The armor has an integrated breathable Lycra jumpsuit and the torso has a spall liner of aramid panels.  Electronics run below the surface and circulate cool air to the skin, drawing power from your internal CBM reservoir."),
    materials = { "qt_steel", "qt_steel_chain", "lycra", "kevlar" },
    inheritance = { add = { flags = { "NORMAL", "MUNDANE", "USES_BIONIC_POWER" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 4.8 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 2.0 },
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 27,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 1.05 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 1.05 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 20,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_heavyplate_0", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the climate control on."),
            target = "armor_nomad_heavyplate_on",
            need_charges_message = ccb.content.text("Your internal reservoir is empty."),
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_heavyplate_on",
    copy_from = "armor_nomad_heavyplate",
    name = ccb.content.plural_text("nomad heavy plate armor (on)", "nomad heavy plate armors (on)"),
    revert_to = "armor_nomad_heavyplate",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The hum of the suit's climate control fades."),
            target = "armor_nomad_heavyplate",
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_chainmail",
    copy_from = "qt_chainmail_jumpsuit",
    name = ccb.content.plural_text("nomad chainmail", "suits of nomad chainmail"),
    mass = "17200 g",
    volume = "7000 ml",
    description = ccb.content.text("A full body multilayered chainmail outfit.  The medium steel has been quenched, tempered and affixed over a full-body layered suit of weight-distributing straps.  The armor has an integrated breathable Lycra jumpsuit and the torso has a spall liner of aramid panels.  Electronics run below the surface and circulate cool air to the skin, drawing power from your internal CBM reservoir."),
    materials = { "qt_steel_chain", "lycra", "kevlar" },
    inheritance = { add = { flags = { "NORMAL", "MUNDANE", "USES_BIONIC_POWER" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 2.0 },
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 16,
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_chainmail_0", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the climate control on."),
            target = "armor_nomad_chainmail_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Your internal reservoir is empty."),
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_chainmail_on",
    copy_from = "armor_nomad_chainmail",
    name = ccb.content.plural_text("nomad chainmail (on)", "suits of nomad chainmail (on)"),
    revert_to = "armor_nomad_chainmail",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The hum of the suit's climate control fades."),
            target = "armor_nomad_chainmail",
        },
    },
}

-- has no protective value
ccb.content.define_item {
    id = "string_dimension_chainmail_suit",
    category = "armor",
    name = ccb.content.text("zarad chainmail suit"),
    description = ccb.content.text("A fully customized chainmail suit.  Unlike your native Earth's steel chainmail, these oval links are much thinner and noticeably denser, giving this suit a ceremonial or decorative quality."),
    mass = "26634 g",
    volume = "3250 ml",
    length = "15 cm",
    price = "450 USD",
    survival_price = "80 USD",
    materials = { "unobtanium" },
    symbol = "[",
    looks_like = "qt_chainmail_suit",
    color = "white",
    flags = { "STURDY", "OUTER" },
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "9350 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2200 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3300 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "900 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    armor = {
        warmth = 0,
        portions = {
            {
                materials = { { id = "unobtanium", coverage = 100, thickness = 0.3 } },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

ccb.content.define_item {
    id = "string_dimension_biosuit",
    name = "gold-latticed biosuit",
    description = "A striated bodysuit constructed from a bilayer of stark-white metallic fabric, coated in a microscopically thin layer of gold.  Some of the fibers are more gold than others, giving it a barely perceptible hex pattern.  The textile bilayer is filled with liquid, giving it a squishy, cool-to-the-touch bodyfeel.",
    symbol = "[",
    color = "yellow",
    category = "armor",
    mass = "4000 g",
    volume = "12 L",
    price = "1 kUSD 175 USD",
    survival_price = "300 USD",
    flags = {
        "VARSIZE",
        "WATERPROOF",
        "RAINPROOF",
        "STURDY",
        "NO_REPAIR",
        "SKINTIGHT",
        "MUNDANE",
        "SOFT",
    },
    materials = {
        { id = "nanotubes", portions = 4 },
        { id = "alien_liquid", portions = 1 },
        { id = "gold", portions = 0.01 },
    },
    armor = {
        warmth = 0,
        environmental_protection = 20,
        portions = {
            {
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 7,
                materials = {
                    { id = "nanotubes", thickness = 4, coverage = 100 },
                    { id = "alien_liquid", thickness = 1, coverage = 100 },
                    { id = "gold", thickness = 0.01, coverage = 100 },
                },
            },
        },
    },
    artifact = {
        enchantments = { "ench_string_dimension_biosuit" },
    },
    subtype_order = { "armor", "artifact" },
}
