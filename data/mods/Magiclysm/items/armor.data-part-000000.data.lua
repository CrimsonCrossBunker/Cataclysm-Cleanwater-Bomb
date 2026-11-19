local ccb = require("ccb")

ccb.content.define_item {
    id = "quiver",
    name = ccb.content.text("quiver"),
    copy_from = "quiver",
    pockets = { { ammunition = { arrow = 20, bolt = 20, arrow_orichalcum = 20 }, moves = 20 } },
    armor = {},
}

ccb.content.define_item {
    id = "quiver_large",
    name = ccb.content.text("large quiver"),
    copy_from = "quiver_large",
    pockets = { { ammunition = { arrow = 60, bolt = 60, arrow_orichalcum = 60 }, moves = 20 } },
    armor = {},
}

ccb.content.define_item {
    id = "quiver_birchbark",
    name = ccb.content.text("birchbark quiver"),
    copy_from = "quiver_birchbark",
    pockets = { { ammunition = { arrow = 20, bolt = 20, arrow_orichalcum = 20 }, moves = 20 } },
    armor = {},
}

ccb.content.define_item {
    id = "quiver_large_birchbark",
    name = ccb.content.text("large birchbark quiver"),
    copy_from = "quiver_large_birchbark",
    pockets = { { ammunition = { arrow = 60, bolt = 60, arrow_orichalcum = 60 }, moves = 20 } },
    armor = {},
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 arms are 18% leaving us with 3348 cm^2.
-- Demon chitin has a density of 0.356g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 305 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 258 grams.
-- Totalled up this is 663 grams with some rounding
ccb.content.define_item {
    id = "armguard_demonchitin",
    name = ccb.content.plural_text("demonous chitin scale mail sleeves (pair)", "demonous chitin scale mail sleeves (pairs)"),
    description = ccb.content.text("A pair of sleeves of chitin sections overlapping with each other, secured to a leather backing.  The odd irregular shapes make full coverage impossible, but at least it's made with a tough chitin.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "663 g",
    volume = "4500 ml",
    price = "130 USD",
    survival_price = "20 USD",
    materials = { { id = "demon_chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "green",
    length = "15 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "demon_chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armguard_demonchitin",
    name = ccb.content.plural_text("pair of demon chitin arm guards", "pairs of demon chitin arm guards"),
    copy_from = "armguard_demonchitin",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36%, both arms are 18%, both legs are 36% leaving us with 16740 cm^2.
-- Demon chitin has a density of 0.356g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 1 526 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 1 289 grams.
-- Totalled up this is 2 815 grams with some rounding
ccb.content.define_item {
    id = "armor_demonchitin",
    name = ccb.content.text("demonous chitin scale mail suit"),
    description = ccb.content.text("A full body suit of chitin sections overlapping with each other, secured to a leather backing.  The odd irregular shapes make full coverage impossible, but at least it's made with a strong chitin.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "2815 g",
    volume = "20 L",
    price = "1 kUSD 200 USD",
    survival_price = "50 USD",
    materials = { { id = "demon_chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "green",
    length = "60 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 20,
        environmental_protection = 8,
        portions = {
            {
                materials = {
                    { id = "demon_chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = {
                    { id = "demon_chitin", coverage = 80, thickness = 3.2 },
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
    id = "xl_armor_demonchitin",
    name = ccb.content.text("demon chitin armor"),
    copy_from = "armor_demonchitin",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the head is 9% leaving us with 1 674 cm^2.
-- Demon chitin has a density of 0.356 g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 153 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 129 grams.
-- Totalled up this is 287 grams with some rounding
ccb.content.define_item {
    id = "helmet_demonchitin",
    name = ccb.content.text("demonous chitin scale mail hood"),
    description = ccb.content.text("Chitin sections overlapping with each other secured to a leather backing in the shape of a hood.  The odd irregular shapes make full coverage impossible, but at least it's made with a strong chitin.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "287 g",
    volume = "2 L",
    price = "380 USD",
    survival_price = "10 USD",
    materials = { { id = "demon_chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "helmet_larmor",
    color = "green",
    armor = {
        portions = {
            {
                materials = {
                    { id = "demon_chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "head" },
                subparts = {
                    "head_crown",
                    "head_forehead",
                    "head_ear_l",
                    "head_ear_r",
                    "head_nape",
                    "head_throat",
                },
                coverage = 95,
            },
        },
        warmth = 20,
        environmental_protection = 8,
    },
}

ccb.content.define_item {
    id = "xl_helmet_demonchitin",
    name = ccb.content.text("demon chitin helmet"),
    copy_from = "helmet_demonchitin",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- Human hands assumed to be about 1 sq ft total, or 929 cm^2.
-- Demon chitin has a density of 0.356g/cm^3, thickness of 0.32 cm, total coverage of 44% leaves us with 85 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 71 grams.
-- Totalled up this is 156 grams with some rounding
ccb.content.define_item {
    id = "gauntlets_demonchitin",
    copy_from = "gauntlets_chitin",
    name = ccb.content.plural_text("demonous chitin scale mail gauntlets (pair)", "demonous chitin scale mail gauntlets (pairs)"),
    description = ccb.content.text("A pair of gauntlets made from loose sections of chitin attached to a leather backing.  Due to the poor material qualities of chitin, it doesn't cover everything but is at least protective."),
    mass = "156 g",
    volume = "1 L",
    price = "380 USD",
    survival_price = "5 USD",
    materials = { { id = "demon_chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "gauntlets_larmor",
    color = "green",
    flags = { "OUTER" },
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "demon_chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                encumbrance = 12,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
            },
            {
                materials = {
                    { id = "demon_chitin", coverage = 40, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
            {
                materials = { { id = "leather", coverage = 100, thickness = 0.7 } },
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_r", "hand_palm_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gauntlets_demonchitin",
    name = ccb.content.plural_text("pair of demon chitin gauntlets", "pairs of demon chitin gauntlets"),
    copy_from = "gauntlets_demonchitin",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the feet are 3% leaving us with 558 cm^2.
-- Demon chitin has a density of 0.356g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 51 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 43 grams.
-- Totalled up this is 94 grams with some rounding
ccb.content.define_item {
    id = "boots_demonchitin",
    name = ccb.content.plural_text("demonous chitin scale foot covers (pair)", "demonous chitin scale foot covers (pairs)"),
    description = ccb.content.text("Sections of chitin attached to a leather backing meant to drape over existing foot wear.  Due to the nature of chitin, it cannot cover everything but it is very protective.  Seems like it was made out of desperation."),
    mass = "94 g",
    volume = "400 ml",
    price = "135 USD",
    survival_price = "50 cent",
    materials = { { id = "demon_chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    color = "green",
    flags = { "OUTER" },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "demon_chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l", "foot_toes_l", "foot_toes_r" },
                encumbrance = 9,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_demonchitin",
    name = ccb.content.plural_text("pair of demon chitin boots", "pairs of demon chitin boots"),
    copy_from = "boots_demonchitin",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}
