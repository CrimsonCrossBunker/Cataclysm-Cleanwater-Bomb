local ccb = require("ccb")

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36% leaving us with 6696 cm^2, and arms are 18% leaving us with 3348 cm^2.
-- Leather has a density of 1.1g/cm^3, thickness of 0.45 cm, coverage of 95% leaves us with 3 149 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 18% leaves us with 265 grams.
-- Totalled up this is 3 414 grams with some rounding
ccb.content.define_item {
    id = "armor_larmor_chest",
    category = "armor",
    name = ccb.content.plural_text("leather armor cuirass", "leather armor cuirasses"),
    description = ccb.content.text("A leather chest plate with attached shoulder guards."),
    mass = "3414 g",
    volume = "3500 ml",
    price = "60 USD",
    survival_price = "12 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    length = "60 cm",
    looks_like = "cuirass_bronze",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 95,
                encumbrance = 17,
                materials = { { id = "leather", coverage = 100, thickness = 4.5 } },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 90,
                encumbrance = 4,
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
        },
        warmth = 25,
        thickness = 4,
        valid_mods = { "steel_padded" },
    },
}

ccb.content.define_item {
    id = "xl_armor_larmor_chest",
    name = ccb.content.plural_text("leather armor cuirass", "leather armor cuirasses"),
    copy_from = "armor_larmor_chest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_larmor_chest_xs",
    copy_from = "armor_larmor_chest",
    name = ccb.content.plural_text("leather armor cuirass", "leather armor cuirasses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lc_mirror_armor",
    category = "armor",
    name = ccb.content.plural_text("mild steel mirror armor", "sets of mild steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  This set is crudely put together with square plates of mild steel."),
    mass = "1000 g",
    volume = "2 L",
    price = "200 USD",
    survival_price = "40 USD",
    materials = { "lc_steel", "leather" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "EXTRA_PLATING" },
    armor = {
        warmth = 20,
        portions = {
            {
                encumbrance = 5,
                coverage = 60,
                vitals_coverage = 50,
                covers = { "torso" },
                materials = {
                    { id = "leather", coverage = 10, thickness = 0.5 },
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_mirror_armor",
    name = ccb.content.plural_text("mild steel mirror armor", "sets of mild steel mirror armor"),
    copy_from = "cuirass_lightplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("mild steel mirror armor", "sets of mild steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("medium steel mirror armor", "sets of medium steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  This set is made with rectangular plates of medium steel."),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_mirror_armor",
    name = ccb.content.plural_text("medium steel mirror armor", "sets of medium steel mirror armor"),
    copy_from = "mc_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_mirror_armor",
    copy_from = "mc_mirror_armor",
    name = ccb.content.plural_text("medium steel mirror armor", "sets of medium steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("high steel mirror armor", "sets of high steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  Made of high steel plates, this set is well-formed and lightly polished for a neat finish."),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_mirror_armor",
    name = ccb.content.plural_text("high steel mirror armor", "sets of high steel mirror armor"),
    copy_from = "hc_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_mirror_armor",
    copy_from = "hc_mirror_armor",
    name = ccb.content.plural_text("high steel mirror armor", "sets of high steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("hardened steel mirror armor", "sets of hardened steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  Made of hardened steel, this set was created with an array of rectangular and circular plates, polished and lightly decorated.  Tough, durable, and made to protect."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_mirror_armor",
    name = ccb.content.plural_text("hardened steel mirror armor", "sets of hardened steel mirror armor"),
    copy_from = "ch_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_mirror_armor",
    copy_from = "ch_mirror_armor",
    name = ccb.content.plural_text("hardened steel mirror armor", "sets of hardened steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("tempered steel mirror armor", "sets of tempered steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  Masterfully crafted with tempered steel, this set features a prominent circular plate on the front that has been polished to a mirror-like sheen, flanked with supporting plates intricately joined to fit the body, all meticulously decorated.  Will protect you from serious harm, as well as the evil gazes of the undead."),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_mirror_armor",
    name = ccb.content.plural_text("tempered steel mirror armor", "sets of tempered steel mirror armor"),
    copy_from = "qt_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_mirror_armor",
    copy_from = "qt_mirror_armor",
    name = ccb.content.plural_text("tempered steel mirror armor", "sets of tempered steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36% leaving us with 6696 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 3 107 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 516 grams.
-- Totalled up this is 3 624 grams with some rounding
ccb.content.define_item {
    id = "armor_chitin_vest",
    category = "armor",
    name = ccb.content.text("chitinous scale mail vest"),
    description = ccb.content.text("A vest of chitin sections overlapping with each other, secured to a leather backing.  The odd irregular shapes make full coverage impossible, not helped by how poor of a material chitin is.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "3624 g",
    volume = "4 L",
    price = "460 USD",
    survival_price = "2 USD",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "green",
    length = "30 cm",
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
                encumbrance = 13,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_chitin_vest",
    name = ccb.content.text("chitinous scale mail vest"),
    copy_from = "armor_chitin_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armor_chitin_vest",
    copy_from = "armor_chitin_vest",
    looks_like = "armor_chitin_vest",
    name = ccb.content.text("chitinous scale mail vest"),
    flags = { "STURDY", "OUTER", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

-- An other-Earth interpretation of mirror armor, but made of 2 thick plates instead of 4 earth-thickness plates.
ccb.content.define_item {
    id = "string_dimension_mirror_cuirass",
    category = "armor",
    name = ccb.content.plural_text("do-āyneh cuirass", "do-āyneh cuirasses"),
    description = ccb.content.text("Somewhat resembling your Earth's mirror armor, this otherworldly cuirass is made up of two round metal plates on the chest and back, lashed together by steel chains around the torso and shoulder.  It covers less than Earth's ancient cuirass, but is notably thicker."),
    mass = "1200 g",
    volume = "2 L",
    price = "200 USD",
    survival_price = "40 USD",
    materials = { "qt_steel" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "white",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "EXTRA_PLATING" },
    armor = {
        warmth = 15,
        portions = {
            {
                encumbrance = 4,
                coverage = 50,
                vitals_coverage = 50,
                covers = { "torso" },
                materials = { { id = "qt_steel", coverage = 100, thickness = 3 } },
            },
        },
    },
}
