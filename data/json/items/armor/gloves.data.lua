local ccb = require("ccb")

ccb.content.define_item {
    id = "beekeeping_gloves",
    name = ccb.content.plural_text("beekeeping gloves (pair)", "beekeeping gloves (pair)"),
    description = ccb.content.text("A pair of white beekeeping gloves made out of smooth leather."),
    mass = "120 g",
    volume = "250 ml",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 30,
        thickness = 2,
        environmental_protection = 2,
        portions = { { encumbrance = 10, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "boxing_gloves",
    name = ccb.content.plural_text("boxing gloves (pair)", "boxing gloves (pair)"),
    description = ccb.content.text("A pair of big, red, 8 oz. boxing gloves made from thick leather."),
    mass = "453 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "10 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "red",
    flags = { "VARSIZE", "OVERSIZE", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 3,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 70,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "chainmail_junk_hands",
    category = "armor",
    name = ccb.content.plural_text("chainmail gloves (pair)", "chainmail gloves (pair)"),
    description = ccb.content.text("A pair of customized chainmail gloves that fully enclose the hands.  The metal shows signs of rust and corrosion."),
    mass = "957 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "25 USD",
    materials = { "budget_steel_chain" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        thickness = 2,
        portions = {
            {
                materials = { { id = "budget_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_hands",
    category = "armor",
    name = ccb.content.plural_text("mild steel chainmail gloves (pair)", "mild steel chainmail gloves (pair)"),
    description = ccb.content.text("A pair of customized steel chainmail gloves that fully enclose the hands."),
    mass = "957 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "25 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        thickness = 2,
        portions = {
            {
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_chainmail_hands",
    copy_from = "lc_chainmail_hands",
    name = ccb.content.plural_text("mild steel chainmail gloves (pair)", "mild steel chainmail gloves (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_lc_chainmail_hands",
    copy_from = "lc_chainmail_hands",
    name = ccb.content.plural_text("mild steel chainmail gloves (pair)", "mild steel chainmail gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_chainmail_hands",
    copy_from = "lc_chainmail_hands",
    name = ccb.content.plural_text("medium steel chainmail gloves (pair)", "medium steel chainmail gloves (pair)"),
    replace_materials = { lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_hands",
    copy_from = "mc_chainmail_hands",
    name = ccb.content.plural_text("medium steel chainmail gloves (pair)", "medium steel chainmail gloves (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_mc_chainmail_hands",
    copy_from = "mc_chainmail_hands",
    name = ccb.content.plural_text("medium steel chainmail gloves (pair)", "medium steel chainmail gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_chainmail_hands",
    copy_from = "lc_chainmail_hands",
    name = ccb.content.plural_text("high steel chainmail gloves (pair)", "high steel chainmail gloves (pair)"),
    replace_materials = { lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_hands",
    copy_from = "hc_chainmail_hands",
    name = ccb.content.plural_text("high steel chainmail gloves (pair)", "high steel chainmail gloves (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_hc_chainmail_hands",
    copy_from = "hc_chainmail_hands",
    name = ccb.content.plural_text("high steel chainmail gloves (pair)", "high steel chainmail gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_chainmail_hands",
    copy_from = "lc_chainmail_hands",
    name = ccb.content.plural_text("hardened steel chainmail gloves (pair)", "hardened steel chainmail gloves (pair)"),
    replace_materials = { lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_hands",
    copy_from = "ch_chainmail_hands",
    name = ccb.content.plural_text("hardened steel chainmail gloves (pair)", "hardened steel chainmail gloves (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_ch_chainmail_hands",
    copy_from = "ch_chainmail_hands",
    name = ccb.content.plural_text("hardened steel chainmail gloves (pair)", "hardened steel chainmail gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_chainmail_hands",
    copy_from = "lc_chainmail_hands",
    materials = { "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail gloves (pair)", "tempered steel chainmail gloves (pair)"),
    replace_materials = { lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_hands",
    copy_from = "qt_chainmail_hands",
    name = ccb.content.plural_text("tempered steel chainmail gloves (pair)", "tempered steel chainmail gloves (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_qt_chainmail_hands",
    copy_from = "qt_chainmail_hands",
    name = ccb.content.plural_text("tempered steel chainmail gloves (pair)", "tempered steel chainmail gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "fire_gauntlets",
    category = "armor",
    name = ccb.content.plural_text("fire gauntlets (pair)", "fire gauntlets (pair)"),
    description = ccb.content.text("A heavy pair of gloves, used by firefighters and metalworkers for heat protection."),
    mass = "572 g",
    volume = "1 L",
    price = "82 USD",
    survival_price = "5 USD",
    materials = { "leather", "nomex" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY", "WATERPROOF" },
    armor = {
        warmth = 25,
        thickness = 3,
        environmental_protection = 6,
        portions = { { encumbrance = 50, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

-- Human hands assumed to be about 1 sq ft total, or 929 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, total coverage of 44% leaves us with 190 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 71 grams.
-- Totalled up this is 261 grams with some rounding
ccb.content.define_item {
    id = "gauntlets_chitin",
    category = "armor",
    name = ccb.content.plural_text("chitinous scale mail gauntlets (pair)", "chitinous scale mail gauntlets (pair)"),
    description = ccb.content.text("A pair of gauntlets made from loose sections of chitin attached to a leather backing.  Due to the poor material qualities of chitin, it doesn't cover everything and isn't very protective."),
    mass = "261 g",
    volume = "300 ml",
    price = "380 USD",
    survival_price = "50 cent",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "gauntlets_larmor",
    color = "green",
    flags = { "OUTER" },
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                encumbrance = 12,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = {
                    "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r", "paw_default_back_l",
                    "paw_default_back_r", "paw_default_wrist_l", "paw_default_wrist_r",
                },
            },
            {
                materials = {
                    { id = "chitin", coverage = 40, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = {
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "paw_default_fingers_l",
                    "paw_default_fingers_r",
                },
            },
            {
                materials = { { id = "leather", coverage = 100, thickness = 0.7 } },
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = { "hand_palm_r", "hand_palm_l", "hand_palm_l", "hand_palm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gauntlets_chitin",
    name = ccb.content.plural_text("chitinous scale mail gauntlets (pair)", "chitinous scale mail gauntlets (pair)"),
    copy_from = "gauntlets_chitin",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gauntlets_chitin",
    copy_from = "gauntlets_chitin",
    name = ccb.content.plural_text("chitinous scale mail gauntlets (pair)", "chitinous scale mail gauntlets (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gauntlets_acidchitin",
    copy_from = "gauntlets_chitin",
    name = ccb.content.plural_text("biosilicified chitin gauntlets (pair)", "biosilicified chitin gauntlets (pair)"),
    description = ccb.content.text("A pair of gauntlets crafted from the carefully cleaned and pruned biosilicified exoskeletons of acidic ants.  Acid-resistant but brittle."),
    materials = { "acidchitin" },
    survival_price = "17 USD 50 cent",
    armor = {},
    inheritance = { offset = { melee_damage = { bash = 1 } } },
}

ccb.content.define_item {
    id = "xl_gauntlets_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin gauntlets (pair)", "biosilicified chitin gauntlets (pair)"),
    copy_from = "gauntlets_acidchitin",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gauntlets_acidchitin",
    copy_from = "gauntlets_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin gauntlets (pair)", "biosilicified chitin gauntlets (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_claws",
    name = ccb.content.plural_text("claw gloves (pair)", "claw gloves (pair)"),
    description = ccb.content.text("A pair of well-made black stretch vinyl gloves, with black steel claws connected to the fingers.  Used in BDSM performances or as part of a costume."),
    mass = "160 g",
    volume = "270 ml",
    price = "60 USD",
    survival_price = "1 USD 40 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "gloves_medical",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "WATERPROOF" },
    melee_damage = { cut = 1 },
    armor = {
        thickness = 0.5,
        environmental_protection = 4,
        portions = { { encumbrance = 15, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gauntlet_fencing",
    category = "armor",
    name = ccb.content.text("fencing gauntlet"),
    description = ccb.content.text("A single suede glove with a sturdy cotton wrist, padded back, and well-fitting fingers."),
    mass = "175 g",
    volume = "250 ml",
    price = "64 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather", "cotton" },
    symbol = "[",
    color = "white",
    flags = { "STURDY" },
    armor = {
        warmth = 15,
        thickness = 2.0,
        environmental_protection = 1,
        portions = { { encumbrance = 4, coverage = 100, covers = { "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gauntlet_fencing_l",
    category = "armor",
    name = ccb.content.plural_text("fencing gauntlet (left)", "fencing gauntlets (left)"),
    description = ccb.content.text("A single suede glove with a sturdy cotton wrist, padded back, and well-fitting fingers.  This one is left-handed."),
    mass = "175 g",
    volume = "250 ml",
    price = "64 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather", "cotton" },
    symbol = "[",
    color = "white",
    flags = { "STURDY" },
    armor = {
        warmth = 15,
        thickness = 2.0,
        environmental_protection = 1,
        portions = { { encumbrance = 4, coverage = 100, covers = { "hand_l" } } },
    },
}

ccb.content.define_item {
    id = "gauntlets_larmor",
    category = "armor",
    name = ccb.content.plural_text("leather armor gauntlets (pair)", "leather armor gauntlets (pair)"),
    description = ccb.content.text("A pair of heavy fingerless leather gloves."),
    mass = "350 g",
    volume = "750 ml",
    price = "34 USD",
    survival_price = "7 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "ALLOWS_NATURAL_ATTACKS", "DURABLE_MELEE" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 75,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r", "paw_default_wrist_l", "paw_default_wrist_r" },
            },
            {
                encumbrance = 4,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = {
                    "hand_palm_l", "hand_palm_r", "hand_back_l", "hand_back_r", "paw_default_palm_l",
                    "paw_default_palm_r", "paw_default_back_l", "paw_default_back_r",
                },
            },
            {
                encumbrance = 0,
                coverage = 50,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
                subparts = {
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "paw_default_fingers_l",
                    "paw_default_fingers_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gauntlets_larmor",
    name = ccb.content.plural_text("leather armor gauntlets (pair)", "leather armor gauntlets (pair)"),
    copy_from = "gauntlets_larmor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gauntlets_larmor",
    copy_from = "gauntlets_larmor",
    looks_like = "gauntlets_larmor",
    name = ccb.content.plural_text("leather armor gauntlets (pair)", "leather armor gauntlets (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_fingerless",
    name = ccb.content.plural_text("fingerless leather gloves (pair)", "fingerless leather gloves (pair)"),
    description = ccb.content.text("A pair of leather gloves without fingers."),
    mass = "100 g",
    volume = "250 ml",
    price = "14 USD",
    survival_price = "1 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 10,
        thickness = 0.5,
        portions = {
            {
                coverage = 75,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r", "hand_back_l", "hand_back_r" },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
            },
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gloves_fingerless_mod",
    category = "armor",
    name = ccb.content.plural_text("armored fingerless leather gloves (pair)", "armored fingerless leather gloves (pair)"),
    description = ccb.content.text("A pair of leather gloves without fingers.  These have been crudely reinforced with steel guards across the back."),
    mass = "380 g",
    volume = "500 ml",
    price = "90 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel", "leather" },
    symbol = "[",
    looks_like = "gloves_fingerless",
    color = "dark_gray",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 5,
        thickness = 0.5,
        portions = {
            {
                coverage = 90,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r" },
                materials = {
                    { id = "leather", coverage = 80, thickness = 0.5 },
                    { id = "steel", coverage = 100, thickness = 0.25 },
                },
            },
            {
                encumbrance = 3,
                coverage = 75,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                materials = { { id = "leather", coverage = 100, thickness = 0.5 } },
            },
            {
                encumbrance = 3,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                materials = { { id = "leather", coverage = 100, thickness = 0.5 } },
            },
            {
                encumbrance = 0,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                materials = { { id = "leather", coverage = 100, thickness = 0.5 } },
            },
        },
    },
}

-- The weight assumes four small sheets of about 10cm x 10cm.
ccb.content.define_item {
    id = "mitten_gaunt_metal_sheets",
    category = "armor",
    name = ccb.content.plural_text("sheet metal gauntlets (pair)", "sheet metal gauntlets (pair)"),
    description = ccb.content.text("A pair of small sheets of metal, one attached to the back of the hand, and one tied to the back of your fingers, leaving the index finger untied for trigger pulling.  Your handwriting will suffer, but they'll keep your fingers attached."),
    mass = "480 g",
    volume = "1250 ml",
    price = "4 USD",
    survival_price = "1 USD",
    symbol = "[",
    looks_like = "lc_mitten_gaunt",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    color = "light_gray",
    flags = { "OUTER" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 5,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_wrist_l",
                    "hand_wrist_r",
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "hand_back_l",
                    "hand_back_r",
                },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_mitten_gaunt_metal_sheets",
    copy_from = "mitten_gaunt_metal_sheets",
    name = ccb.content.plural_text("hardened steel sheet metal gauntlets (pair)", "hardened steel sheet metal gauntlets (pair)"),
    description = ccb.content.text("These crude mitten gauntlets have been hardened to keep the zombie dogs from biting your fingers off."),
    materials = { "ch_steel" },
    armor = {
        portions = {
            {
                materials = { { id = "ch_steel", coverage = 100, thickness = 1.5 } },
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_wrist_l",
                    "hand_wrist_r",
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "hand_back_l",
                    "hand_back_r",
                },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "gloves_fur",
    name = ccb.content.plural_text("fur gloves (pair)", "fur gloves (pair)"),
    description = ccb.content.text("A pair of warm fur gloves."),
    mass = "410 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "brown",
    armor = {
        warmth = 70,
        thickness = 3,
        portions = {
            {
                encumbrance = 30,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_fur",
    name = ccb.content.plural_text("fur gloves (pair)", "fur gloves (pair)"),
    copy_from = "gloves_fur",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.6, volume = 1.6 } },
}

ccb.content.define_item {
    id = "xs_gloves_fur",
    copy_from = "gloves_fur",
    looks_like = "gloves_fur",
    name = ccb.content.plural_text("fur gloves (pair)", "fur gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_faux_fur",
    name = ccb.content.plural_text("faux fur gloves (pair)", "faux fur gloves (pair)"),
    description = ccb.content.text("A pair of warm faux fur gloves."),
    mass = "410 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    materials = { "faux_fur" },
    symbol = "[",
    looks_like = "gloves_fur",
    color = "brown",
    armor = {
        warmth = 55,
        thickness = 3,
        portions = {
            {
                encumbrance = 30,
                coverage = 95,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_faux_fur",
    name = ccb.content.plural_text("faux fur gloves (pair)", "faux fur gloves (pair)"),
    copy_from = "gloves_faux_fur",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.6, volume = 1.6 } },
}

ccb.content.define_item {
    id = "xs_gloves_faux_fur",
    copy_from = "gloves_faux_fur",
    name = ccb.content.plural_text("faux fur gloves (pair)", "faux fur gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "glove_jackson",
    name = ccb.content.text("white glove"),
    description = ccb.content.text("A single white glove covered with hundreds of rhinestones."),
    mass = "59 g",
    volume = "250 ml",
    price = "500 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "white",
    flags = { "WATER_FRIENDLY" },
    armor = {
        warmth = 20,
        thickness = 0.5,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_fingers_l",
                    "hand_fingers_r",
                    "hand_back_l",
                    "hand_back_r",
                    "hand_palm_l",
                    "hand_palm_r",
                },
            },
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gloves_leather",
    name = ccb.content.plural_text("leather gloves (pair)", "leather gloves (pair)"),
    description = ccb.content.text("A thin pair of black leather gloves."),
    mass = "160 g",
    volume = "250 ml",
    price = "45 USD",
    survival_price = "1 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    armor = {
        warmth = 25,
        thickness = 0.5,
        valid_mods = { "steel_padded" },
        portions = {
            {
                encumbrance = 10,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_leather",
    name = ccb.content.plural_text("leather gloves (pair)", "leather gloves (pair)"),
    copy_from = "gloves_leather",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_leather",
    copy_from = "gloves_leather",
    looks_like = "gloves_leather",
    name = ccb.content.plural_text("leather gloves (pair)", "leather gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- 10 oz.
ccb.content.define_item {
    id = "gloves_denim",
    name = ccb.content.plural_text("denim gloves (pair)", "denim gloves (pair)"),
    description = ccb.content.text("A pair of denim gloves.  Not very comfortable but slightly warmer and more sturdier than ones that would be made from cotton."),
    mass = "150 g",
    volume = "400 ml",
    price = "30 USD",
    survival_price = "5 USD",
    materials = { "denim" },
    symbol = "[",
    color = "light_blue",
    looks_like = "gloves_leather",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = { { encumbrance = 5, coverage = 100, covers = { "hand_l", "hand_r" } } },
        warmth = 15,
        thickness = 0.65,
    },
}

ccb.content.define_item {
    id = "gloves_denim_fingerless",
    name = ccb.content.plural_text("fingerless denim gloves (pair)", "fingerless denim gloves (pair)"),
    description = ccb.content.text("A pair of fingerless denim gloves.  Much less cumbersome this way, but not as protective or warm."),
    mass = "122 g",
    volume = "270 ml",
    survival_price = "3 USD 50 cent",
    materials = { "denim" },
    symbol = "[",
    color = "light_blue",
    looks_like = "gloves_leather",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                coverage = 75,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r", "hand_back_l", "hand_back_r" },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
            },
            {
                coverage = 30,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
        warmth = 10,
        thickness = 0.65,
    },
}

ccb.content.define_item {
    id = "gloves_light",
    name = ccb.content.plural_text("light gloves (pair)", "light gloves (pair)"),
    description = ccb.content.text("A pair of cotton gloves."),
    mass = "118 g",
    volume = "250 ml",
    price = "11 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "light_blue",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = {
            {
                encumbrance = 2,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_light",
    name = ccb.content.plural_text("light gloves (pair)", "light gloves (pair)"),
    copy_from = "gloves_light",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_light",
    copy_from = "gloves_light",
    looks_like = "gloves_light",
    name = ccb.content.plural_text("light gloves (pair)", "light gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_liner",
    name = ccb.content.plural_text("glove liners (pair)", "glove liners (pair)"),
    description = ccb.content.text("A pair of thin cotton gloves.  Often used as a liner beneath other gloves."),
    mass = "63 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "light_gray",
    flags = { "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 1,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_liner",
    name = ccb.content.plural_text("glove liners (pair)", "glove liners (pair)"),
    copy_from = "gloves_liner",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_gloves_liner",
    copy_from = "gloves_liner",
    looks_like = "gloves_liner",
    name = ccb.content.plural_text("glove liners (pair)", "glove liners (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_medical",
    name = ccb.content.plural_text("medical gloves (pair)", "medical gloves (pair)"),
    description = ccb.content.text("A pair of thin latex gloves, designed to limit the spread of disease.  Too fragile to protect you from much else."),
    mass = "3 g",
    volume = "5 ml",
    price = "10 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "white",
    flags = { "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT", "SOFT", "FRAGILE", "NO_REPAIR" },
    armor = {
        thickness = 0.1,
        environmental_protection = 2,
        portions = { { encumbrance = 1, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_black",
    name = ccb.content.plural_text("black gloves (pair)", "black gloves (pair)"),
    description = ccb.content.text("A pair of black cotton gloves."),
    mass = "118 g",
    volume = "250 ml",
    price = "11 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "dark_gray",
    flags = { "VARSIZE" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = { { encumbrance = 2, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_plate",
    category = "armor",
    name = ccb.content.plural_text("armored gauntlets (pair)", "armored gauntlets (pair)"),
    description = ccb.content.text("An extremely heavy set of armor-plated leather gloves."),
    mass = "980 g",
    volume = "1500 ml",
    price = "400 USD",
    survival_price = "30 USD",
    materials = { "steel", "leather" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "DURABLE_MELEE" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 20,
        thickness = 4,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 20,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 100, thickness = 2.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 100, thickness = 2.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 80, thickness = 2.0 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_plate",
    name = ccb.content.plural_text("armored gauntlets (pair)", "armored gauntlets (pair)"),
    copy_from = "gloves_plate",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_plate",
    copy_from = "gloves_plate",
    looks_like = "gloves_plate",
    name = ccb.content.plural_text("armored gauntlets (pair)", "armored gauntlets (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_rubber",
    name = ccb.content.plural_text("rubber gloves (pair)", "rubber gloves (pair)"),
    description = ccb.content.text("A pair of rubber gloves, often used while cleaning with caustic materials."),
    mass = "20 g",
    volume = "250 ml",
    price = "13 USD",
    survival_price = "50 cent",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "yellow",
    flags = { "WATERPROOF", "SOFT" },
    armor = {
        warmth = 10,
        thickness = 0.35,
        environmental_protection = 8,
        portions = { { encumbrance = 4, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_tactical",
    category = "armor",
    name = ccb.content.plural_text("tactical gloves (pair)", "tactical gloves (pair)"),
    description = ccb.content.text("A pair of flame- and cut-resistant aramid fabric gloves.  Commonly used by police and military units."),
    mass = "220 g",
    volume = "500 ml",
    price = "52 USD",
    survival_price = "15 USD",
    materials = { "kevlar", "leather" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 1.5,
        environmental_protection = 2,
        portions = { { encumbrance = 13, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_winter",
    name = ccb.content.plural_text("winter gloves (pair)", "winter gloves (pair)"),
    description = ccb.content.text("A pair of padded cotton gloves.  Toasty!"),
    mass = "218 g",
    volume = "750 ml",
    price = "65 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "light_blue",
    armor = {
        warmth = 70,
        thickness = 4,
        portions = { { encumbrance = 40, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_wool",
    name = ccb.content.plural_text("wool gloves (pair)", "wool gloves (pair)"),
    description = ccb.content.text("A warm pair of wool gloves."),
    mass = "100 g",
    volume = "250 ml",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "gloves_winter",
    color = "blue",
    armor = {
        warmth = 60,
        thickness = 3,
        portions = { { encumbrance = 20, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "xl_gloves_wool",
    name = ccb.content.plural_text("wool gloves (pair)", "wool gloves (pair)"),
    copy_from = "gloves_wool",
    flags = { "OVERSIZE", "PREFIX_XL" },
    armor = {},
    inheritance = { scale = { mass = 1.4, volume = 1.4 } },
}

ccb.content.define_item {
    id = "xs_gloves_wool",
    copy_from = "gloves_wool",
    looks_like = "gloves_wool",
    name = ccb.content.plural_text("wool gloves (pair)", "wool gloves (pair)"),
    flags = { "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "gloves_wool_fingerless",
    name = ccb.content.plural_text("fingerless wool gloves (pair)", "fingerless wool gloves (pair)"),
    description = ccb.content.text("A warm pair of wool gloves without fingers.  Less encumbering, but provides significantly less warmth."),
    mass = "75 g",
    volume = "250 ml",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "gloves_wool",
    color = "blue",
    flags = { "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 40,
        thickness = 3,
        portions = {
            {
                encumbrance = 7,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_wrist_l",
                    "hand_wrist_r",
                    "hand_back_l",
                    "hand_back_r",
                    "hand_palm_l",
                    "hand_palm_r",
                },
            },
            {
                coverage = 67,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_wool_fingerless",
    name = ccb.content.plural_text("fingerless wool gloves (pair)", "fingerless wool gloves (pair)"),
    copy_from = "gloves_wool_fingerless",
    flags = { "OVERSIZE", "PREFIX_XL" },
    armor = {},
    inheritance = { scale = { mass = 1.4, volume = 1.4 } },
}

ccb.content.define_item {
    id = "xs_gloves_wool_fingerless",
    copy_from = "gloves_wool_fingerless",
    name = ccb.content.plural_text("fingerless wool gloves (pair)", "fingerless wool gloves (pair)"),
    flags = { "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75 } },
}

ccb.content.define_item {
    id = "gloves_work",
    name = ccb.content.plural_text("work gloves (pair)", "work gloves (pair)"),
    description = ccb.content.text("A tough pair of gloves, for tough everyday work."),
    mass = "195 g",
    volume = "250 ml",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "leather", "cotton" },
    symbol = "[",
    looks_like = "gloves_leather",
    color = "brown",
    flags = { "WATERPROOF", "STURDY", "VARSIZE" },
    armor = {
        warmth = 25,
        thickness = 2,
        environmental_protection = 5,
        portions = { { encumbrance = 20, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_cut_resistant",
    category = "armor",
    name = ccb.content.plural_text("cut-resistant gloves (pair)", "cut-resistant gloves (pair)"),
    description = ccb.content.text("A pair of cut-resistant gloves, useful for butchery or routine work with bladed objects."),
    mass = "240 g",
    volume = "250 ml",
    price = "90 USD",
    survival_price = "1 USD",
    materials = { "kevlar" },
    symbol = "[",
    looks_like = "gloves_work",
    color = "light_gray",
    flags = { "STURDY", "VARSIZE" },
    armor = {
        warmth = 10,
        thickness = 2,
        environmental_protection = 1,
        portions = { { encumbrance = 20, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_wraps",
    name = ccb.content.plural_text("hand wraps (pair)", "hand wraps (pair)"),
    description = ccb.content.text("Long pieces of cloth that are meant to be wrapped around your hands.  They provide small amounts of protection while punching and performing other general mischief."),
    mass = "100 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "white",
    flags = { "SKINTIGHT", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = { { coverage = 80, covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_wraps_fur",
    name = ccb.content.plural_text("fur hand wraps (pair)", "fur hand wraps (pair)"),
    description = ccb.content.text("Pieces of animal pelt that are meant to be wrapped around your hands.  They provide small amounts of protection while punching and performing other general mischief."),
    mass = "250 g",
    volume = "500 ml",
    price = "7 USD",
    survival_price = "10 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "gloves_wraps",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 80,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gloves_wraps_leather",
    name = ccb.content.plural_text("leather hand wraps (pair)", "leather hand wraps (pair)"),
    description = ccb.content.text("Pieces of leather that are meant to be wrapped around your hands.  They provide small amounts of protection while punching and performing other general mischief."),
    mass = "200 g",
    volume = "500 ml",
    price = "5 USD 25 cent",
    survival_price = "10 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "gloves_wraps",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 10,
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 80,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gloves_wraps_wool",
    name = ccb.content.plural_text("wool hand wraps (pair)", "wool hand wraps (pair)"),
    description = ccb.content.text("Long pieces of wool that are meant to be wrapped around your hands.  They provide small amounts of protection while punching and performing other general mischief."),
    mass = "100 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "gloves_wraps",
    color = "blue",
    flags = { "SKINTIGHT", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 15,
        thickness = 2,
        portions = {
            {
                encumbrance = 2,
                coverage = 80,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "long_glove_white",
    name = ccb.content.plural_text("extra long white gloves (pair)", "extra long white gloves (pair)"),
    description = ccb.content.text("Long white costume gloves."),
    mass = "400 g",
    volume = "1 L",
    price = "11 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        portions = {
            { covers = { "hand_l", "hand_r" }, coverage = 100, encumbrance = 2 },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r", "arm_lower_l", "arm_lower_r" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
                coverage = 50,
            },
        },
        warmth = 10,
        thickness = 0.2,
    },
}

ccb.content.define_item {
    id = "mittens",
    name = ccb.content.plural_text("mittens (pair)", "mittens (pair)"),
    description = ccb.content.text("A pair of warm but cumbersome mittens."),
    mass = "364 g",
    volume = "750 ml",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "gloves_wool",
    color = "blue",
    flags = { "OVERSIZE", "OUTER" },
    armor = {
        warmth = 70,
        thickness = 1,
        portions = {
            {
                encumbrance = 80,
                coverage = 100,
                covers = { "hand_l", "hand_r", "paw_default_l", "paw_default_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "nomex_gloves",
    name = ccb.content.plural_text("flame-resistant gloves (pair)", "flame-resistant gloves (pair)"),
    description = ccb.content.text("A snug-fitting pair of gloves made from thin and lightweight Nomex fabric."),
    mass = "190 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "1 USD",
    materials = { "nomex" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 1,
        environmental_protection = 2,
        portions = { { encumbrance = 6, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "santa_gloves",
    name = ccb.content.plural_text("Santa gloves (pair)", "Santa gloves (pair)"),
    description = ccb.content.text("A pair of red gloves with white faux fur trim.  Keeps your hands warm and your holiday spirit bright."),
    mass = "400 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "faux_fur" },
    symbol = "[",
    looks_like = "gloves_fur",
    color = "red",
    armor = {
        warmth = 30,
        thickness = 0.5,
        portions = { { encumbrance = 10, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "sockmitts",
    name = ccb.content.plural_text("sock mitts (pair)", "sock mitts (pair)"),
    description = ccb.content.text("A pair of improvised gloves made from socks with holes poked through them."),
    mass = "32 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "mittens",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_back_l",
                    "hand_back_r",
                    "hand_wrist_l",
                    "hand_wrist_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "wool_sockmitts",
    copy_from = "sockmitts",
    name = ccb.content.plural_text("wool sock mitts (pair)", "wool sock mitts (pair)"),
    description = ccb.content.text("A pair of improvised gloves made from wool socks with holes poked through them."),
    mass = "44 g",
    volume = "250 ml",
    materials = { "wool" },
    armor = {
        warmth = 30,
        thickness = 0.3,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_back_l",
                    "hand_back_r",
                    "hand_wrist_l",
                    "hand_wrist_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "nomex_sockmitts",
    copy_from = "sockmitts",
    name = ccb.content.plural_text("Nomex sock mitts (pair)", "Nomex sock mitts (pair)"),
    description = ccb.content.text("A pair of improvised gloves made from Nomex socks with holes poked through them."),
    mass = "200 g",
    volume = "750 ml",
    materials = { "nomex" },
    color = "light_gray",
    armor = {
        warmth = 5,
        thickness = 1,
        environmental_protection = 2,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_back_l",
                    "hand_back_r",
                    "hand_wrist_l",
                    "hand_wrist_r",
                },
            },
        },
    },
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "stockings_tent_arms",
    name = ccb.content.plural_text("tentacle sleeves (pair)", "tentacle sleeves (pair)"),
    description = ccb.content.text("Long cotton tubes sized to fit over tentacles and help protect them from the cold."),
    mass = "360 g",
    volume = "1500 ml",
    price = "4 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = { { encumbrance = 10, coverage = 75, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "winter_gloves_army",
    name = ccb.content.plural_text("army winter gloves (pair)", "army winter gloves (pair)"),
    description = ccb.content.text("A pair of padded gloves.  Favored by the military."),
    mass = "218 g",
    volume = "750 ml",
    price = "81 USD 25 cent",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "white",
    armor = {
        warmth = 50,
        thickness = 2,
        portions = { { encumbrance = 20, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_white",
    name = ccb.content.plural_text("white gloves (pair)", "white gloves (pair)"),
    description = ccb.content.text("A pair of white costume gloves made out of cotton."),
    copy_from = "gloves_liner",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        thickness = 0.2,
        portions = { { encumbrance = 5, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_skeleton",
    name = ccb.content.plural_text("skeleton gloves (pair)", "skeleton gloves (pair)"),
    description = ccb.content.text("A pair of black costume gloves with a skeletal hand pattern printed on them."),
    copy_from = "gloves_liner",
    mass = "23 g",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        thickness = 0.1,
        warmth = 5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_golf",
    name = ccb.content.plural_text("golfing gloves (pair)", "golfing gloves (pair)"),
    description = ccb.content.text("A thin pair of black leather golfing gloves."),
    mass = "150 g",
    volume = "250 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "gloves_light",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "SKINTIGHT" },
    armor = {
        warmth = 20,
        thickness = 0.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_back_l",
                    "hand_back_r",
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_fingers_l",
                    "hand_fingers_r",
                },
            },
            {
                coverage = 80,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gloves_eod",
    category = "armor",
    name = ccb.content.plural_text("EOD overhand protectors (pair)", "EOD overhand protectors (pair)"),
    description = ccb.content.text("A pair of fragmentation resistant pads for wearing over the backs of one's hands, providing protection from shrapnel in case things go wrong.  Sold as an accessory for explosive ordnance disposal suits, but not often used due to the difficulty in armoring the entire hand and retaining dexterity."),
    mass = "610 g",
    volume = "1000 ml",
    price = "700 USD",
    survival_price = "80 USD",
    materials = { "kevlar_layered" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER", "NO_SALVAGE" },
    max_worn = 1,
    armor = {
        warmth = 10,
        portions = {
            {
                encumbrance = 10,
                coverage = 40,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r" },
                materials = {
                    {
                        id = "kevlar_layered",
                        coverage = 100,
                        thickness = 3,
                        ignore_sheet_thickness = true,
                    },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_demi_gaunt",
    category = "armor",
    name = ccb.content.plural_text("mild steel demi-gauntlets (pair)", "mild steel demi-gauntlets (pair)"),
    description = ccb.content.text("A pair of leather gloves with chainmail protecting the fingers and palm, and plating over the back of the hand and wrist."),
    mass = "750 g",
    volume = "750 ml",
    price = "400 USD",
    survival_price = "30 USD",
    symbol = "[",
    looks_like = "fire_gauntlets",
    materials = { "lc_steel", "lc_steel_chain" },
    color = "light_gray",
    flags = { "STURDY", "OUTER" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 15,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 10,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                materials = {
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                materials = {
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_demi_gaunt",
    copy_from = "lc_demi_gaunt",
    name = ccb.content.plural_text("mild steel demi-gauntlets (pair)", "mild steel demi-gauntlets (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "mc_demi_gaunt",
    copy_from = "lc_demi_gaunt",
    name = ccb.content.plural_text("medium steel demi-gauntlets (pair)", "medium steel demi-gauntlets (pair)"),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_demi_gaunt",
    copy_from = "mc_demi_gaunt",
    name = ccb.content.plural_text("medium steel demi-gauntlets (pair)", "medium steel demi-gauntlets (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "hc_demi_gaunt",
    copy_from = "lc_demi_gaunt",
    name = ccb.content.plural_text("high steel demi-gauntlets (pair)", "high steel demi-gauntlets (pair)"),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_demi_gaunt",
    name = ccb.content.plural_text("high steel demi-gauntlets (pair)", "high steel demi-gauntlets (pair)"),
    copy_from = "hc_demi_gaunt",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "ch_demi_gaunt",
    copy_from = "lc_demi_gaunt",
    name = ccb.content.plural_text("hardened steel demi-gauntlets (pair)", "hardened steel demi-gauntlets (pair)"),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_demi_gaunt",
    name = ccb.content.plural_text("hardened steel demi-gauntlets (pair)", "hardened steel demi-gauntlets (pair)"),
    copy_from = "ch_demi_gaunt",
    materials = { "qt_steel", "qt_steel_chain" },
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "qt_demi_gaunt",
    copy_from = "lc_demi_gaunt",
    name = ccb.content.plural_text("tempered steel demi-gauntlets (pair)", "tempered steel demi-gauntlets (pair)"),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_demi_gaunt",
    name = ccb.content.plural_text("tempered steel demi-gauntlets (pair)", "tempered steel demi-gauntlets (pair)"),
    copy_from = "qt_demi_gaunt",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "lc_mitten_gaunt",
    category = "armor",
    name = ccb.content.plural_text("mild steel mitten gauntlets (pair)", "mild steel mitten gauntlets (pair)"),
    description = ccb.content.text("A pair of leather mittens with chainmail protecting the fingers and palm, and steel plating over the back of the hand, fingers, and wrist for additional protection."),
    mass = "1250 g",
    volume = "1250 ml",
    price = "400 USD",
    survival_price = "30 USD",
    symbol = "[",
    looks_like = "fire_gauntlets",
    materials = { "lc_steel", "lc_steel_chain" },
    color = "light_gray",
    flags = { "STURDY", "DURABLE_MELEE", "OUTER" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 15,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 20,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                materials = {
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 1.25 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_mitten_gaunt",
    copy_from = "lc_mitten_gaunt",
    name = ccb.content.plural_text("mild steel mitten gauntlets (pair)", "mild steel mitten gauntlets (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "mc_mitten_gaunt",
    copy_from = "lc_mitten_gaunt",
    name = ccb.content.plural_text("medium steel mitten gauntlets (pair)", "medium steel mitten gauntlets (pair)"),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_mitten_gaunt",
    copy_from = "mc_mitten_gaunt",
    name = ccb.content.plural_text("medium steel mitten gauntlets (pair)", "medium steel mitten gauntlets (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "hc_mitten_gaunt",
    copy_from = "lc_mitten_gaunt",
    name = ccb.content.plural_text("high steel mitten gauntlets (pair)", "high steel mitten gauntlets (pair)"),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_mitten_gaunt",
    copy_from = "hc_mitten_gaunt",
    name = ccb.content.plural_text("high steel mitten gauntlets (pair)", "high steel mitten gauntlets (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "ch_mitten_gaunt",
    copy_from = "lc_mitten_gaunt",
    name = ccb.content.plural_text("hardened steel mitten gauntlets (pair)", "hardened steel mitten gauntlets (pair)"),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_mitten_gaunt",
    copy_from = "ch_mitten_gaunt",
    name = ccb.content.plural_text("hardened steel mitten gauntlets (pair)", "hardened steel mitten gauntlets (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "qt_mitten_gaunt",
    copy_from = "lc_mitten_gaunt",
    name = ccb.content.plural_text("tempered steel mitten gauntlets (pair)", "tempered steel mitten gauntlets (pair)"),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_mitten_gaunt",
    copy_from = "qt_mitten_gaunt",
    name = ccb.content.plural_text("tempered steel mitten gauntlets (pair)", "tempered steel mitten gauntlets (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "gloves_airsoft",
    category = "armor",
    name = ccb.content.plural_text("airsoft gloves (pair)", "airsoft gloves (pair)"),
    description = ccb.content.text("A pair of fingerless gloves with hard plastic reinforcing the backs of the hands to protect against BB pellets and other light projectiles."),
    mass = "200 g",
    volume = "300 ml",
    price = "40 USD",
    survival_price = "10 USD",
    materials = { "leather", "thermo_resin" },
    symbol = "[",
    looks_like = "gloves_tactical",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 5,
        portions = {
            {
                encumbrance = 4,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r", "hand_palm_l", "hand_palm_r" },
                materials = { { id = "leather", coverage = 100, thickness = 0.6 } },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.6 },
                    { id = "thermo_resin", coverage = 95, thickness = 1 },
                },
            },
            {
                encumbrance = 0,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.6 },
                    { id = "thermo_resin", coverage = 50, thickness = 0.5 },
                },
            },
        },
    },
}
