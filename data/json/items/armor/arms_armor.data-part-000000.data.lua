local ccb = require("ccb")

ccb.content.define_item {
    id = "2byarm_guard",
    category = "armor",
    name = ccb.content.plural_text("2-by-arm guards (pair)", "2-by-arm guards (pair)"),
    description = ccb.content.text("A pair of improvised arm guards made from broken pieces of a plank that are tied to your arms with rags and string.  They offer good protection, but are really uncomfortable to wear."),
    mass = "300 g",
    volume = "1500 ml",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "wood" },
    symbol = "[",
    looks_like = "arm_splint",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "OUTER", "WATER_FRIENDLY", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 9,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

-- The weight assumes four squares of carpet of about 25cm x 20cm.
ccb.content.define_item {
    id = "carpet_armguards",
    category = "armor",
    name = ccb.content.plural_text("carpet arm guards (pair)", "carpet arm guards (pair)"),
    description = ccb.content.text("Small squares of carpet rolled around your upper and lower arms.  Armor of the truly desperate or crafty."),
    mass = "1360 g",
    volume = "3 L",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "plastic", "carpet_pilling" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "red",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "NO_REPAIR" },
    armor = {
        warmth = 10,
        thickness = 4,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "carpet_pilling", coverage = 100, thickness = 3.0 },
                },
                covers = { "arm_l", "arm_r" },
                encumbrance = 5,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                subparts = { "arm_lower_r", "arm_lower_l", "arm_upper_r", "arm_upper_l" },
            },
        },
    },
}

-- The weight assumes two squares of carpet of about 25cm x 20cm.
ccb.content.define_item {
    id = "carpet_bracers",
    category = "armor",
    name = ccb.content.plural_text("carpet bracers (pair)", "carpet bracers (pair)"),
    description = ccb.content.text("Small squares of carpet rolled around your lower arms.  The bare minimum to hopefully stop a bite or two."),
    mass = "680 g",
    volume = "2 L",
    price = "10 cent",
    survival_price = "5 cent",
    materials = { "plastic", "carpet_pilling" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "red",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "NO_REPAIR" },
    armor = {
        warmth = 10,
        thickness = 4,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "carpet_pilling", coverage = 100, thickness = 3.0 },
                },
                covers = { "arm_l", "arm_r" },
                encumbrance = 3,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 arms are 18% leaving us with 3348 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 1 243 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 258 grams.
-- Totalled up this is 1 501 grams with some rounding
ccb.content.define_item {
    id = "armguard_chitin",
    category = "armor",
    name = ccb.content.plural_text("chitinous scale mail sleeves (pair)", "chitinous scale mail sleeves (pair)"),
    description = ccb.content.text("A pair of sleeves of chitin sections overlapping with each other, secured to a leather backing.  The odd irregular shapes make full coverage impossible, not helped by how poor of a material chitin is.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "1501 g",
    volume = "1330 ml",
    price = "130 USD",
    survival_price = "1 USD",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "armguard_larmor",
    color = "green",
    length = "15 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
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
    id = "xl_armguard_chitin",
    copy_from = "armguard_chitin",
    name = ccb.content.plural_text("chitinous scale mail sleeves (pair)", "chitinous scale mail sleeves (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.23 } },
}

ccb.content.define_item {
    id = "xs_armguard_chitin",
    copy_from = "armguard_chitin",
    name = ccb.content.plural_text("chitinous scale mail sleeves (pair)", "chitinous scale mail sleeves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_acidchitin",
    copy_from = "armguard_chitin",
    survival_price = "12 USD 50 cent",
    name = ccb.content.plural_text("biosilicified chitin arm guards (pair)", "biosilicified chitin arm guards (pair)"),
    description = ccb.content.text("A pair of arm guards crafted from the carefully cleaned and pruned biosilicified exoskeletons of acidic ants.  Acid-resistant but brittle."),
    materials = { "acidchitin" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armguard_acidchitin",
    copy_from = "armguard_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin arm guards (pair)", "biosilicified chitin arm guards (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "xs_armguard_acidchitin",
    copy_from = "armguard_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin arm guards (pair)", "biosilicified chitin arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "cloth_arms_padded",
    category = "armor",
    name = ccb.content.plural_text("cloth-padded sleeves (pair)", "cloth-padded sleeves (pair)"),
    description = ccb.content.text("The sleeves of a thick cotton shirt, with a bunch of cloth sewn in to act as extra padding.  They're quite lonely, no longer being attached to each other by the rest of the shirt."),
    mass = "400 g",
    volume = "1500 ml",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "light_gray",
    flags = { "VARSIZE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 8,
            },
        },
        warmth = 35,
        thickness = 3,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "armguard_hard",
    category = "armor",
    name = ccb.content.plural_text("hard arm guards (pair)", "hard arm guards (pair)"),
    description = ccb.content.text("A pair of neoprene arm sleeves covered with molded plastic sheaths."),
    mass = "350 g",
    volume = "3 L",
    price = "35 USD",
    survival_price = "10 USD",
    materials = { "plastic", "neoprene" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "dark_gray",
    flags = { "OUTER", "WATER_FRIENDLY", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 20,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 5,
                subparts = { "arm_lower_r", "arm_lower_l" },
                materials = {
                    { id = "neoprene", coverage = 100, thickness = 1.5 },
                    { id = "plastic", coverage = 90, thickness = 1.5 },
                },
                coverage = 100,
                vitals_coverage = 90,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_r", "arm_elbow_l" },
                materials = {
                    { id = "neoprene", coverage = 100, thickness = 1.5 },
                    { id = "plastic", coverage = 50, thickness = 1.5 },
                },
                coverage = 100,
                vitals_coverage = 90,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
                materials = {
                    { id = "neoprene", coverage = 100, thickness = 1.5 },
                    { id = "plastic", coverage = 90, thickness = 1.5 },
                },
                coverage = 80,
                vitals_coverage = 90,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armguard_hard",
    name = ccb.content.plural_text("hard arm guards (pair)", "hard arm guards (pair)"),
    mass = "550 g",
    volume = "4 L",
    copy_from = "armguard_hard",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xs_armguard_hard",
    copy_from = "armguard_hard",
    name = ccb.content.plural_text("hard arm guards (pair)", "hard arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 arms are 18% leaving us with 3348 cm^2.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 72% leaves us with 1061 grams.
ccb.content.define_item {
    id = "armguard_larmor",
    category = "armor",
    name = ccb.content.plural_text("leather arm guards (pair)", "leather arm guards (pair)"),
    description = ccb.content.text("A pair of tough leather arm guards.  Light and comfortable."),
    mass = "1061 g",
    volume = "2 L",
    price = "40 USD",
    survival_price = "10 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "brown",
    flags = { "STURDY", "OUTER", "BLOCK_WHILE_WORN", "WATER_FRIENDLY" },
    armor = {
        warmth = 25,
        thickness = 4,
        valid_mods = { "steel_padded" },
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 5,
                coverage = 90,
                melee_coverage = 95,
                ranged_coverage = 95,
                vitals_coverage = 90,
                subparts = {
                    "arm_lower_r",
                    "arm_lower_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                    "arm_upper_l",
                    "arm_upper_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armguard_larmor",
    name = ccb.content.plural_text("leather arm guards (pair)", "leather arm guards (pair)"),
    copy_from = "armguard_larmor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armguard_larmor",
    copy_from = "armguard_larmor",
    name = ccb.content.plural_text("leather arm guards (pair)", "leather arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- The weight assumes four sheets of about 25cm x 20cm x 1.5mm.
ccb.content.define_item {
    id = "armguard_metal",
    category = "armor",
    name = ccb.content.plural_text("sheet metal arm guards (pair)", "sheet metal arm guards (pair)"),
    description = ccb.content.text("A pair of arm guards hammered out from metal, avoiding joints.  Perfect for the Post-Apocalyptic Warrior look."),
    mass = "2300 g",
    volume = "2750 ml",
    price = "300 USD",
    survival_price = "10 USD",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    symbol = "[",
    looks_like = "armguard_hard",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 7,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 70,
                subparts = { "arm_lower_r", "arm_lower_l", "arm_upper_r", "arm_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_armguard_metal",
    copy_from = "armguard_metal",
    name = ccb.content.plural_text("hardened steel sheet metal arm guards (pair)", "hardened steel sheet metal arm guards (pair)"),
    description = ccb.content.text("A pair of arm guards hammered out from sheet metal, hardened for extra protection.  Still manages that Post-Apocalyptic Warrior look."),
    materials = { "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes two sheets of about 25cm x 20cm x 1.5mm.
ccb.content.define_item {
    id = "armguard_metal_sheets_bracer",
    category = "armor",
    name = ccb.content.plural_text("mild steel sheet metal bracers (pair)", "mild steel sheet metal bracers (pair)"),
    description = ccb.content.text("A pair of arm guards hammered out from metal, only covering your forearms."),
    mass = "1150 g",
    volume = "1 L",
    price = "150 USD",
    survival_price = "5 USD",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    symbol = "[",
    looks_like = "armor_lc_armguard",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 3,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 70,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_armguard_metal_sheets_bracer",
    copy_from = "armguard_metal_sheets_bracer",
    name = ccb.content.plural_text("hardened steel sheet metal bracers (pair)", "hardened steel sheet metal bracers (pair)"),
    description = ccb.content.text("A pair of forearm guards hammered out from sheet metal, hardened for extra protection."),
    materials = { "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes four sheets of about 15cm x 15cm x 1.5mm.
ccb.content.define_item {
    id = "armguard_metal_sheets_shoulders",
    category = "armor",
    name = ccb.content.plural_text("mild steel sheet metal pauldrons (pair)", "mild steel sheet metal pauldrons (pair)"),
    description = ccb.content.text("Two half-cylinders of sheet metal jutting out over your shoulders and two more underneath.  They make it impossible to raise your arms fully, but they'll keep your arms attached to you."),
    mass = "1400 g",
    volume = "2 L",
    price = "5 USD",
    survival_price = "4 USD",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    symbol = "m",
    color = "light_gray",
    length = "50 cm",
    flags = { "OUTER", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 10,
                coverage = 95,
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_armguard_metal_sheets_shoulders",
    copy_from = "armguard_metal_sheets_shoulders",
    name = ccb.content.plural_text("hardened sheet metal pauldrons (pair)", "hardened sheet metal pauldrons (pair)"),
    description = ccb.content.text("A pair of crude pauldrons made out of sheet metal and hardened for reinforcement."),
    materials = { "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes two sheets of about 15cm x 15cm x 1.5mm.
ccb.content.define_item {
    id = "armguard_metal_sheets_elbows",
    category = "armor",
    name = ccb.content.plural_text("mild steel sheet metal elbow guards (pair)", "mild steel sheet metal elbow guards (pair)"),
    description = ccb.content.text("Two small half-cylinders of sheet metal cut down and hammered to fit over your elbows.  Very brutal, just needs spikes."),
    mass = "700 g",
    volume = "1 L",
    price = "5 USD",
    survival_price = "4 USD",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    symbol = "m",
    looks_like = "elbow_pads",
    color = "light_gray",
    length = "50 cm",
    flags = { "OUTER", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 2,
                coverage = 95,
                subparts = { "arm_elbow_l", "arm_elbow_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_armguard_metal_sheets_elbows",
    copy_from = "armguard_metal_sheets_elbows",
    name = ccb.content.plural_text("hardened sheet metal elbow guards (pair)", "hardened sheet metal elbow guards (pair)"),
    description = ccb.content.text("Elbow guards of sheet metal, hardened to make sure you never bang your funny bone on the table again."),
    materials = { "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "xl_armguard_metal",
    name = ccb.content.plural_text("sheet metal arm guards (pair)", "sheet metal arm guards (pair)"),
    copy_from = "armguard_metal",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armguard_metal",
    copy_from = "armguard_metal",
    name = ccb.content.plural_text("sheet metal arm guards (pair)", "sheet metal arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_paper",
    category = "armor",
    name = ccb.content.plural_text("paper arm guards (pair)", "paper arm guards (pair)"),
    description = ccb.content.text("Arm guards made of stacked paper sheets held together with duct tape."),
    mass = "360 g",
    volume = "500 ml",
    price = "2 USD 30 cent",
    survival_price = "2 USD 50 cent",
    materials = { "paper" },
    symbol = "[",
    looks_like = "armguard_larmor",
    color = "blue",
    flags = { "OUTER", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 4,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "improvised_armguard_tire",
    category = "armor",
    name = ccb.content.plural_text("improvised tire arm guards (pair)", "improvised tire arm guards (pair)"),
    description = ccb.content.text("Arm guards made of thick chunks of tire held together with duct tape."),
    mass = "2400 g",
    volume = "2 L",
    price = "23 USD",
    survival_price = "2 USD 50 cent",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "armguard_larmor",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "NONCONDUCTIVE" },
    armor = {
        warmth = 5,
        thickness = 4,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 4,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "armguard_scrap",
    category = "armor",
    name = ccb.content.plural_text("scrap arm guards (pair)", "scrap arm guards (pair)"),
    description = ccb.content.text("Jagged metal scraps crudely strapped to lower arms.  Gaps expose skin and swinging feels like lifting weights."),
    mass = "2500 g",
    volume = "1800 ml",
    price = "4 USD",
    survival_price = "2 USD",
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "uneven" },
    materials = { "budget_steel", "cotton" },
    symbol = "[",
    looks_like = "armguard_metal",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 1, cut = 1 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 60, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                encumbrance = 8,
                coverage = 70,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armguard_scrap",
    name = ccb.content.plural_text("scrap arm guards (pair)", "scrap arm guards (pair)"),
    mass = "3412 g",
    volume = "6 L",
    copy_from = "armguard_scrap",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xs_armguard_scrap",
    copy_from = "armguard_scrap",
    name = ccb.content.plural_text("scrap arm guards (pair)", "scrap arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_tire",
    category = "armor",
    name = ccb.content.plural_text("tire arm guards (pair)", "tire arm guards (pair)"),
    description = ccb.content.text("A pair of arm guards made from thick chunks of tire secured by simple strings; the loose collection of rubber plates provides decent but not the most convenient protection."),
    mass = "4800 g",
    volume = "4750 ml",
    price = "200 USD",
    survival_price = "5 USD",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "armguard_metal",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "NONCONDUCTIVE" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 14,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "arm_lower_r", "arm_lower_l", "arm_upper_r", "arm_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armguard_tire",
    name = ccb.content.plural_text("tire arm guards (pair)", "tire arm guards (pair)"),
    copy_from = "armguard_tire",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armguard_tire",
    copy_from = "armguard_tire",
    name = ccb.content.plural_text("tire arm guards (pair)", "tire arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_soft",
    category = "armor",
    name = ccb.content.plural_text("neoprene arm sleeves (pair)", "neoprene arm sleeves (pair)"),
    description = ccb.content.text("A pair of soft neoprene arm sleeves.  Often used in contact sports."),
    mass = "258 g",
    volume = "1500 ml",
    price = "12 USD",
    survival_price = "5 USD",
    materials = { "neoprene", "cotton" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "light_red",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = {
        warmth = 20,
        thickness = 2,
        environmental_protection = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 5,
                subparts = { "arm_lower_r", "arm_lower_l", "arm_elbow_r", "arm_elbow_l" },
                coverage = 100,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
                coverage = 80,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armguard_soft",
    name = ccb.content.plural_text("neoprene arm sleeves (pair)", "neoprene arm sleeves (pair)"),
    mass = "330 g",
    volume = "1750 ml",
    copy_from = "armguard_soft",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xs_armguard_soft",
    copy_from = "armguard_soft",
    name = ccb.content.plural_text("neoprene arm sleeves (pair)", "neoprene arm sleeves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gambeson_sleeve",
    category = "armor",
    name = ccb.content.plural_text("gambeson sleeves (pair)", "gambeson sleeves (pair)"),
    description = ccb.content.text("A pair of arm sleeves made from heavy quilted fabric."),
    mass = "1380 g",
    volume = "500 ml",
    price = "12 USD",
    survival_price = "4 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 50,
        thickness = 5,
        valid_mods = { "steel_padded" },
        portions = { { encumbrance = 20, coverage = 100, covers = { "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "xl_gambeson_sleeve",
    name = ccb.content.plural_text("gambeson sleeves (pair)", "gambeson sleeves (pair)"),
    copy_from = "gambeson_sleeve",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_gambeson_sleeve",
    name = ccb.content.plural_text("gambeson sleeves (pair)", "gambeson sleeves (pair)"),
    copy_from = "gambeson_sleeve",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- skip second entry for arm encumbrance
ccb.content.define_item {
    id = "k_gambeson_sleeve",
    category = "armor",
    name = ccb.content.plural_text("Kevlar gambeson sleeves (pair)", "Kevlar gambeson sleeves (pair)"),
    description = ccb.content.text("A pair arm sleeves made from aramid, with strips of soft body armor sewn on top to simulate quilting."),
    mass = "986 g",
    volume = "840 ml",
    price = "12 USD",
    survival_price = "4 USD",
    materials = { { id = "kevlar_layered", portions = 6 }, { id = "kevlar", portions = 4 } },
    symbol = "[",
    looks_like = "arm_warmers",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 50,
        thickness = 3.2,
        valid_mods = { "steel_padded" },
        portions = {
            {
                materials = {
                    {
                        id = "kevlar_layered",
                        coverage = 95,
                        thickness = 3.4,
                        ignore_sheet_thickness = true,
                    },
                    { id = "kevlar", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    {
                        id = "kevlar_layered",
                        coverage = 70,
                        thickness = 3.4,
                        ignore_sheet_thickness = true,
                    },
                    { id = "kevlar", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_k_gambeson_sleeve",
    name = ccb.content.plural_text("Kevlar gambeson sleeves (pair)", "Kevlar gambeson sleeves (pair)"),
    copy_from = "k_gambeson_sleeve",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_k_gambeson_sleeve",
    name = ccb.content.plural_text("Kevlar gambeson sleeves (pair)", "Kevlar gambeson sleeves (pair)"),
    copy_from = "k_gambeson_sleeve",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
