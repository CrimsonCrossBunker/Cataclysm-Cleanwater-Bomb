local ccb = require("ccb")

ccb.content.define_item {
    id = "2byshin_guard",
    category = "armor",
    name = ccb.content.plural_text("2-by-shin guards (pair)", "2-by-shin guards (pair)"),
    description = ccb.content.text("A pair of improvised shin guards made from broken pieces of a plank that are tied to your shins with rags and string."),
    mass = "300 g",
    volume = "1500 ml",
    price = "5 USD",
    survival_price = "50 cent",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "wood" },
    symbol = "[",
    looks_like = "leg_splint",
    color = "brown",
    flags = { "OUTER", "WATER_FRIENDLY", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 9,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "leg_lower_r", "leg_lower_l" },
            },
        },
    },
}

-- The weight assumes four squares of carpet of about 25cm x 30cm.
ccb.content.define_item {
    id = "carpet_legguards",
    category = "armor",
    name = ccb.content.plural_text("carpet leg guards (pair)", "carpet leg guards (pair)"),
    description = ccb.content.text("Small squares of carpet rolled around your shins and thighs.  Perfect for wading through the local furniture store."),
    mass = "2040 g",
    volume = "3 L",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "plastic", "carpet_pilling" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "red",
    flags = { "OUTER", "NO_REPAIR" },
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
                covers = { "leg_l", "leg_r" },
                encumbrance = 5,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                subparts = { "leg_lower_r", "leg_lower_l", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

-- The weight assumes two squares of carpet of about 25cm x 30cm.
ccb.content.define_item {
    id = "carpet_greaves",
    category = "armor",
    name = ccb.content.plural_text("carpet greaves (pair)", "carpet greaves (pair)"),
    description = ccb.content.text("Small squares of carpet rolled around your shins.  These might protect you from the corner of a table."),
    mass = "1020 g",
    volume = "2 L",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "plastic", "carpet_pilling" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "red",
    flags = { "OUTER", "NO_REPAIR" },
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
                covers = { "leg_l", "leg_r" },
                encumbrance = 3,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                subparts = { "leg_lower_r", "leg_lower_l" },
            },
        },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the legs are 36% leaving us with 6696 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 3 107 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 516 grams.
-- Totalled up this is 3 623 grams with some rounding
ccb.content.define_item {
    id = "legguard_chitin",
    category = "armor",
    name = ccb.content.plural_text("chitinous scale mail leggings", "chitinous scale mail leggings"),
    description = ccb.content.text("A pair of sleeves of chitin sections overlapping with each other, secured to a leather backing.  The odd irregular shapes make full coverage impossible, not helped by how poor of a material chitin is.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "3623 g",
    volume = "2864 ml",
    price = "130 USD",
    survival_price = "1 USD",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "legguard_hard",
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
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_legguard_chitin",
    copy_from = "legguard_chitin",
    name = ccb.content.plural_text("chitinous scale mail leggings", "chitinous scale mail leggings"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_legguard_chitin",
    copy_from = "legguard_chitin",
    name = ccb.content.plural_text("chitinous scale mail leggings", "chitinous scale mail leggings"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_acidchitin",
    copy_from = "legguard_chitin",
    looks_like = "legguard_chitin",
    survival_price = "12 USD 50 cent",
    name = ccb.content.plural_text("biosilicified chitin leg guards (pair)", "biosilicified chitin leg guards (pair)"),
    description = ccb.content.text("A pair of leg guards crafted from the carefully cleaned and pruned biosilicified exoskeletons of acidic ants.  Acid-resistant but brittle."),
    materials = { "acidchitin" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_legguard_acidchitin",
    copy_from = "legguard_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin leg guards (pair)", "biosilicified chitin leg guards (pair)"),
    materials = { "acidchitin" },
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_legguard_acidchitin",
    copy_from = "legguard_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin leg guards (pair)", "biosilicified chitin leg guards (pair)"),
    materials = { "acidchitin" },
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Fire-resistant outerwear ain't cheap.
ccb.content.define_item {
    id = "bunker_pants",
    category = "armor",
    name = ccb.content.plural_text("turnout trousers", "turnout trousers"),
    description = ccb.content.text("A heavy pair of protective overalls worn by firefighters as protection against heat."),
    mass = "2290 g",
    volume = "5 L",
    price = "815 USD",
    survival_price = "5 USD",
    materials = { "nomex", "kevlar", "lycra" },
    symbol = "[",
    looks_like = "pants_cargo",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "3250 ml",
            mass_limit = "4 kg",
            max_item_length = "30 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "3250 ml",
            mass_limit = "4 kg",
            max_item_length = "30 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "16 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "16 cm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "POCKETS", "STURDY", "WATERPROOF", "OUTER" },
    armor = {
        warmth = 30,
        thickness = 2,
        valid_mods = { "steel_padded" },
        environmental_protection = 6,
        portions = { { encumbrance = { 24, 30 }, coverage = 100, covers = { "leg_l", "leg_r" } } },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_legs",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("base chainmail leggings", "base chainmail leggings"),
    description = ccb.content.text("Customized chainmail leggings.  Their straps keep everything in place, and the lack of toes and heels allows them to work perfectly well with footwear."),
    mass = "4212 g",
    volume = "1500 ml",
    length = "11 cm",
    price = "75 USD",
    survival_price = "20 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER", "BLOCK_WHILE_WORN" },
    pockets = {
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
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_legs",
    abstract = true,
    copy_from = "base_chainmail_legs",
    name = ccb.content.text_without_extraction("chainmail leggings", "chainmail leggings"),
    pockets = {
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
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_legs",
    abstract = true,
    copy_from = "base_chainmail_legs",
    name = ccb.content.text_without_extraction("chainmail leggings", "chainmail leggings"),
    pockets = {
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

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_half_legs",
    abstract = true,
    copy_from = "base_chainmail_legs",
    name = ccb.content.text_without_extraction("base chainmail half-leggings", "base chainmail half-leggings"),
    description = ccb.content.text("Customized partial chainmail leggings only covering the front and sides of the legs.  The zigzagging lace at the back keeps everything in place, and the lack of toes and heels allows them to work perfectly well with footwear."),
    mass = "3159 g",
    volume = "1125 ml",
    length = "10 cm",
    price = "56 USD 25 cent",
    survival_price = "15 USD",
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                coverage = 75,
                encumbrance = 11,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_half_legs",
    abstract = true,
    copy_from = "base_chainmail_half_legs",
    name = ccb.content.text_without_extraction("chainmail half-leggings", "chainmail half-leggings"),
    pockets = {
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
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_half_legs",
    abstract = true,
    copy_from = "base_chainmail_half_legs",
    name = ccb.content.text_without_extraction("chainmail half-leggings", "chainmail half-leggings"),
    pockets = {
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
    id = "chainmail_junk_legs",
    copy_from = "base_chainmail_legs",
    replace_materials = { steel = "budget_steel_chain" },
    name = ccb.content.plural_text("chainmail leggings", "chainmail leggings"),
    description = ccb.content.text("Customized chainmail leggings.  Their straps keep everything in place, and the lack of toes and heels allows them to work perfectly well with footwear.  The metal shows signs of rust and corrosion, and some chain links have fallen away."),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_legs",
    copy_from = "base_chainmail_legs",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail leggings", "mild steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_legs",
    copy_from = "xl_chainmail_legs",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail leggings", "mild steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_lc_chainmail_legs",
    copy_from = "xs_chainmail_legs",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail leggings", "mild steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_legs",
    copy_from = "base_chainmail_legs",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail leggings", "medium steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_legs",
    copy_from = "xl_chainmail_legs",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail leggings", "medium steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_mc_chainmail_legs",
    copy_from = "xs_chainmail_legs",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail leggings", "medium steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_legs",
    copy_from = "base_chainmail_legs",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail leggings", "high steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_legs",
    copy_from = "xl_chainmail_legs",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail leggings", "high steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_hc_chainmail_legs",
    copy_from = "xs_chainmail_legs",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail leggings", "high steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_legs",
    copy_from = "base_chainmail_legs",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail leggings", "hardened steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_legs",
    copy_from = "xl_chainmail_legs",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail leggings", "hardened steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_ch_chainmail_legs",
    copy_from = "xs_chainmail_legs",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail leggings", "hardened steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_legs",
    copy_from = "base_chainmail_legs",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail leggings", "tempered steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_legs",
    copy_from = "xl_chainmail_legs",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail leggings", "tempered steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_qt_chainmail_legs",
    copy_from = "xs_chainmail_legs",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail leggings", "tempered steel chainmail leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_half_legs",
    copy_from = "base_chainmail_half_legs",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail half-leggings", "mild steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_half_legs",
    copy_from = "xl_chainmail_half_legs",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail half-leggings", "mild steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_lc_chainmail_half_legs",
    copy_from = "xs_chainmail_half_legs",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail half-leggings", "mild steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_half_legs",
    copy_from = "base_chainmail_half_legs",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail half-leggings", "medium steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_half_legs",
    copy_from = "xl_chainmail_half_legs",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail half-leggings", "medium steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_mc_chainmail_half_legs",
    copy_from = "xs_chainmail_half_legs",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail half-leggings", "medium steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_half_legs",
    copy_from = "base_chainmail_half_legs",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail half-leggings", "high steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_half_legs",
    copy_from = "xl_chainmail_half_legs",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail half-leggings", "high steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_hc_chainmail_half_legs",
    copy_from = "xs_chainmail_half_legs",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail half-leggings", "high steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_half_legs",
    copy_from = "base_chainmail_half_legs",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail half-leggings", "hardened steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_half_legs",
    copy_from = "xl_chainmail_half_legs",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail half-leggings", "hardened steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_ch_chainmail_half_legs",
    copy_from = "xs_chainmail_half_legs",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail half-leggings", "hardened steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_half_legs",
    copy_from = "base_chainmail_half_legs",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail half-leggings", "tempered steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_half_legs",
    copy_from = "xl_chainmail_half_legs",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail half-leggings", "tempered steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_qt_chainmail_half_legs",
    copy_from = "xs_chainmail_half_legs",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail half-leggings", "tempered steel chainmail half-leggings"),
    armor = {},
}

ccb.content.define_item {
    id = "leggings_thessalonian",
    category = "armor",
    name = ccb.content.plural_text("cataphract leggings", "cataphract leggings"),
    description = ccb.content.text("This leg armor, made of interlocking plates of burnished bronze, appears to be either a high-quality recreation or a genuine artifact.  Despite having an ancient design, it is in mint condition aside from some battle damage.  It covers from the upper thigh to the lower shin, and is of extremely high quality."),
    mass = "5212 g",
    volume = "1500 ml",
    price = "75 USD",
    survival_price = "30 USD",
    materials = { "fancy_bronze", "leather" },
    symbol = "[",
    looks_like = "chainmail_legs",
    color = "brown",
    flags = { "VARSIZE", "OUTER", "STURDY", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 18,
        thickness = 5,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 14,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 100,
                subparts = {
                    "leg_lower_r",
                    "leg_lower_l",
                    "leg_knee_r",
                    "leg_knee_l",
                    "leg_upper_r",
                    "leg_upper_l",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "chaps_leather",
    name = ccb.content.plural_text("leather chaps", "leather chaps"),
    description = ccb.content.text("A pair of black leather chaps.  Very tough and light, but doesn't offer any storage."),
    mass = "1414 g",
    volume = "1250 ml",
    price = "210 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "pants_leather",
    color = "dark_gray",
    flags = { "OUTER" },
    armor = {
        warmth = 10,
        thickness = 3,
        portions = {
            {
                encumbrance = 3,
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_r", "leg_knee_l" },
            },
            {
                coverage = 20,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
            {
                coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "chaps_cut_resistant",
    category = "armor",
    name = ccb.content.plural_text("chainsaw chaps", "chainsaw chaps"),
    description = ccb.content.text("A pair of tough chaps made of Kevlar.  Chainsaw kickbacks are potentially fatal; personal protective equipment like these chaps help protect your femoral arteries.  The layered Kevlar is designed to fray on contact with the chain and bind up the tool."),
    mass = "1519 g",
    copy_from = "chaps_leather",
    price = "78 USD",
    materials = { "kevlar" },
    armor = {},
}

ccb.content.define_item {
    id = "fencing_pants",
    category = "armor",
    name = ccb.content.plural_text("fencing pants", "fencing pants"),
    description = ccb.content.text("A pair of reinforced pants used by fencers to prevent injuries.  They don't cover the lower leg."),
    mass = "450 g",
    volume = "2 L",
    price = "25 USD",
    survival_price = "5 USD",
    materials = { "cotton", "nylon" },
    symbol = "[",
    looks_like = "pants",
    color = "white",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 100,
        },
    },
    flags = { "VARSIZE" },
    armor = {
        warmth = 25,
        thickness = 2.5,
        portions = {
            {
                encumbrance = { 7, 9 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = {
                    "leg_hip_l",
                    "leg_hip_r",
                    "leg_knee_l",
                    "leg_knee_r",
                    "leg_upper_r",
                    "leg_upper_l",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "knee_pads",
    category = "armor",
    name = ccb.content.plural_text("knee pads (pair)", "knee pads (pair)"),
    description = ccb.content.text("A pair of knee pads made of stout plastic and cloth."),
    mass = "210 g",
    volume = "1500 ml",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "plastic", "cotton" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "OUTER" },
    armor = {
        thickness = 5,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 0,
                coverage = 90,
                melee_coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 90,
                subparts = { "leg_knee_r", "leg_knee_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "legguard_bronze",
    category = "armor",
    name = ccb.content.plural_text("bronze greaves (pair)", "bronze greaves (pair)"),
    description = ccb.content.text("A pair of bronze leg guards with a simple leather lining."),
    mass = "2520 g",
    volume = "5500 ml",
    price = "400 USD",
    survival_price = "7 USD 50 cent",
    materials = { "bronze", "leather" },
    symbol = "[",
    looks_like = "armor_lc_leg_guard",
    color = "yellow",
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 15,
        thickness = 4,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 5,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 70,
                subparts = { "leg_lower_r", "leg_lower_l", "leg_knee_r", "leg_knee_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_legguard_bronze",
    copy_from = "legguard_bronze",
    name = ccb.content.plural_text("bronze greaves (pair)", "bronze greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_legguard_bronze",
    copy_from = "legguard_bronze",
    name = ccb.content.plural_text("bronze greaves (pair)", "bronze greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_hard",
    category = "armor",
    name = ccb.content.plural_text("hard leg guards (pair)", "hard leg guards (pair)"),
    description = ccb.content.text("A pair of polyurethane leg guards with neoprene backing."),
    mass = "625 g",
    volume = "3 L",
    price = "34 USD",
    survival_price = "5 USD",
    materials = { "plastic", "neoprene" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "dark_gray",
    flags = { "OUTER", "WATER_FRIENDLY", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 20,
        thickness = 4,
        environmental_protection = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 4,
                coverage = 90,
                melee_coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 90,
                subparts = {
                    "leg_lower_r",
                    "leg_lower_l",
                    "leg_knee_r",
                    "leg_knee_l",
                    "leg_upper_r",
                    "leg_upper_l",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "legguard_metal",
    category = "armor",
    name = ccb.content.plural_text("iron greaves (pair)", "iron greaves (pair)"),
    description = ccb.content.text("A pair of iron leg guards with a simple leather lining."),
    mass = "2260 g",
    volume = "5500 ml",
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "armor_lc_leg_guard",
    color = "light_gray",
    flags = { "OUTER", "WATER_FRIENDLY", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 3,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 70,
                subparts = { "leg_lower_r", "leg_lower_l", "leg_knee_r", "leg_knee_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_legguard_metal",
    copy_from = "legguard_metal",
    name = ccb.content.plural_text("iron greaves (pair)", "iron greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_legguard_metal",
    copy_from = "legguard_metal",
    name = ccb.content.plural_text("iron greaves (pair)", "iron greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- The weight assumes four sheets of about 25cm x 30cm x 1.5mm.
ccb.content.define_item {
    id = "legguard_metal_sheets",
    category = "armor",
    name = ccb.content.plural_text("sheet metal leg guards (pair)", "sheet metal leg guards (pair)"),
    description = ccb.content.text("A pair of leg guards hammered out of metal and shaped to tie on to the upper and lower leg, avoiding joints.  Perfect for the Post-Apocalyptic Warrior look."),
    mass = "3500 g",
    volume = "2500 ml",
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armor_lc_leg_guard",
    color = "light_gray",
    flags = { "OUTER", "WATER_FRIENDLY", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 7,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 95,
                vitals_coverage = 70,
                subparts = { "leg_lower_r", "leg_lower_l", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_legguard_metal_sheets",
    copy_from = "legguard_metal_sheets",
    name = ccb.content.plural_text("hardened sheet metal leg guards (pair)", "hardened sheet metal leg guards (pair)"),
    description = ccb.content.text("These crude leg guards have been hardened to further protect your legs from the mighty coffee table, destroyer of shins."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes two sheets of about 25cm x 30cm x 1.5mm.
ccb.content.define_item {
    id = "legguard_metal_sheets_greaves",
    category = "armor",
    name = ccb.content.plural_text("sheet metal greaves (pair)", "sheet metal greaves (pair)"),
    description = ccb.content.text("A pair of shin guards hammered out of metal and shaped to tie on to the lower leg."),
    mass = "1750 g",
    volume = "1200 ml",
    price = "200 USD",
    survival_price = "5 USD",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armor_lc_leg_guard",
    color = "light_gray",
    flags = { "OUTER", "WATER_FRIENDLY", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 3,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 95,
                vitals_coverage = 70,
                subparts = { "leg_lower_r", "leg_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_legguard_metal_sheets_greaves",
    copy_from = "legguard_metal_sheets_greaves",
    name = ccb.content.plural_text("hardened sheet metal greaves (pair)", "hardened sheet metal greaves (pair)"),
    description = ccb.content.text("These crude greaves have been hardened to further protect your shins."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes 2 sheets of about 30cm x 50cm x 1.5mm and 2 sheets of about 30cm x 25cm x 1.5mm
ccb.content.define_item {
    id = "legguard_metal_sheets_hip",
    category = "armor",
    name = ccb.content.text("sheet metal skirt"),
    description = ccb.content.text("Four cut-down sheets of metal hanging off your waist to keep your hip and groin safe.  They're held in place rather loosely, but still get in the way a lot when running."),
    mass = "4900 g",
    volume = "2 L",
    price = "5 USD",
    survival_price = "4 USD",
    materials = { "lc_steel" },
    symbol = "m",
    color = "light_gray",
    length = "50 cm",
    flags = { "OUTER", "WATER_FRIENDLY", "ALLOWS_TAIL" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 12,
                coverage = 95,
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_legguard_metal_sheets_hip",
    copy_from = "legguard_metal_sheets_hip",
    name = ccb.content.text("hardened sheet metal skirt"),
    description = ccb.content.text("This loose skirt made from several cut-down sheets of metal has been hardened to provide maximum protection for your most vulnerable area."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes 3 sheets of about 15cm x 15cm x 1.5mm.
ccb.content.define_item {
    id = "legguard_metal_sheets_knees",
    category = "armor",
    name = ccb.content.plural_text("sheet metal knee guards (pair)", "sheet metal knee guards (pair)"),
    description = ccb.content.text("Two small half-cylinders of sheet metal cut down and hammered to fit over the front of your knees.  They make kneeling painful, but don't impede running much."),
    mass = "700 g",
    volume = "1 L",
    price = "5 USD",
    survival_price = "4 USD",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    symbol = "m",
    looks_like = "knee_pads",
    color = "light_gray",
    length = "50 cm",
    flags = { "OUTER", "WATER_FRIENDLY", "ALLOWS_TAIL" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 2,
                coverage = 95,
                subparts = { "leg_knee_l", "leg_knee_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_legguard_metal_sheets_knees",
    copy_from = "legguard_metal_sheets_knees",
    name = ccb.content.plural_text("hardened sheet metal knee guards (pair)", "hardened sheet metal knee guards (pair)"),
    description = ccb.content.text("Knee guards of sheet metal, hardened to protect your kneecaps from any feral with a bat."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "xl_legguard_metal_sheets",
    copy_from = "legguard_metal_sheets",
    name = ccb.content.plural_text("sheet metal leg guards (pair)", "sheet metal leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_legguard_metal_sheets",
    copy_from = "legguard_metal_sheets",
    name = ccb.content.plural_text("sheet metal leg guards (pair)", "sheet metal leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_paper",
    category = "armor",
    name = ccb.content.plural_text("paper leg guards (pair)", "paper leg guards (pair)"),
    description = ccb.content.text("Leg guards made of stacked paper sheets held together with duct tape."),
    mass = "370 g",
    volume = "500 ml",
    price = "2 USD 30 cent",
    survival_price = "50 cent",
    materials = { "paper" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "blue",
    flags = { "OUTER" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 4,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "leg_lower_r", "leg_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "improvised_legguard_tire",
    category = "armor",
    name = ccb.content.plural_text("improvised tire leg guards (pair)", "improvised tire leg guards (pair)"),
    description = ccb.content.text("Leg guards made of thick chunks of tire held together with duct tape."),
    mass = "2400 g",
    volume = "2 L",
    price = "23 USD",
    survival_price = "2 USD 50 cent",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "NONCONDUCTIVE" },
    armor = {
        warmth = 5,
        thickness = 4,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 4,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "leg_lower_r", "leg_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "legguard_scrap",
    category = "armor",
    name = ccb.content.plural_text("scrap leg guards (pair)", "scrap leg guards (pair)"),
    description = ccb.content.text("Jagged metal scraps crudely lashed to legs with frayed strings.  Gaps leave skin exposed, and walking feels like dragging anvils, but they're better than nothing."),
    mass = "3800 g",
    volume = "3 L",
    price = "4 USD",
    survival_price = "2 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "budget_steel", "cotton" },
    symbol = "[",
    looks_like = "legguard_metal",
    color = "light_gray",
    flags = { "OUTER", "ALLOWS_TAIL", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 3, cut = 1 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 60, thickness = 1.8 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 70,
                encumbrance = 15,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_legguard_scrap",
    copy_from = "legguard_scrap",
    name = ccb.content.plural_text("scrap leg guards (pair)", "scrap leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_legguard_scrap",
    copy_from = "legguard_scrap",
    name = ccb.content.plural_text("scrap leg guards (pair)", "scrap leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_tire",
    category = "armor",
    name = ccb.content.plural_text("tire leg guards (pair)", "tire leg guards (pair)"),
    description = ccb.content.text("A pair of leg guards made from thick chunks of tire secured by simple strings; the loose collection of rubber plates provides decent but not the most convenient protection."),
    mass = "4800 g",
    volume = "5 L",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "legguard_metal",
    color = "light_gray",
    flags = { "OUTER", "NONCONDUCTIVE", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 14,
                coverage = 80,
                melee_coverage = 80,
                ranged_coverage = 80,
                vitals_coverage = 0,
                subparts = { "leg_lower_r", "leg_lower_l", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_legguard_tire",
    copy_from = "legguard_tire",
    name = ccb.content.plural_text("tire leg guards (pair)", "tire leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_legguard_tire",
    copy_from = "legguard_tire",
    name = ccb.content.plural_text("tire leg guards (pair)", "tire leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Mid-heavyweight 14 oz denim jeans.
ccb.content.define_item {
    id = "motorbike_pants",
    category = "armor",
    name = ccb.content.plural_text("motorcycle jeans", "motorcycle jeans"),
    description = ccb.content.text("A pair of thick jeans interwoven with Kevlar for added durability and sporting integrated kneepads and flank protection, typically worn by motorcyclists to protect from road rash."),
    mass = "1340 g",
    volume = "2500 ml",
    price = "100 USD",
    survival_price = "7 USD 50 cent",
    materials = { "kevlar", "denim", "plastic_pad" },
    symbol = "[",
    looks_like = "jeans",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "POCKETS" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    armor = {
        warmth = 15,
        thickness = 2,
        environmental_protection = 2,
        portions = {
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 0.3 },
                    { id = "denim", coverage = 100, thickness = 0.6 },
                },
                encumbrance = { 10, 14 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = {
                    "leg_hip_l",
                    "leg_upper_l",
                    "leg_lower_l",
                    "leg_hip_r",
                    "leg_upper_r",
                    "leg_lower_r",
                },
            },
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 0.3 },
                    { id = "denim", coverage = 100, thickness = 0.6 },
                    { id = "plastic_pad", coverage = 100, thickness = 12 },
                },
                encumbrance = { 0, 0 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "jeans_mod",
    name = ccb.content.plural_text("armored jeans", "armored jeans"),
    description = ccb.content.text("A pair of jeans reinforced with hard plastic knee pads and metal sheets.  The end product is not very sturdy and somewhat cumbersome, but protective."),
    mass = "3810 g",
    volume = "3500 ml",
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "denim", "plastic", "lc_steel" },
    symbol = "[",
    looks_like = "motorbike_pants",
    color = "light_blue",
    flags = { "VARSIZE", "POCKETS", "BLOCK_WHILE_WORN" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    armor = {
        warmth = 20,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = { 12, 16 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = {
                    "leg_hip_l",
                    "leg_upper_l",
                    "leg_lower_l",
                    "leg_hip_r",
                    "leg_upper_r",
                    "leg_lower_r",
                },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.65 },
                    { id = "lc_steel", coverage = 80, thickness = 1.5 },
                },
            },
            {
                encumbrance = { 2, 2 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r" },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.65 },
                    { id = "cotton", coverage = 100, thickness = 2.5 },
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "jeans_mod_ch",
    name = ccb.content.plural_text("hardened armored jeans", "hardened armored jeans"),
    copy_from = "jeans_mod",
    description = ccb.content.text("A pair of jeans reinforced with hard plastic knee pads and hardened steel sheets.  Although its high protection outweighs its encumbrance, it's not really sturdy."),
    price = "150 USD",
    survival_price = "12 USD 50 cent",
    materials = { "denim", "plastic", "ch_steel" },
    symbol = "[",
    looks_like = "motorbike_pants",
    color = "blue",
    armor = {
        portions = {
            {
                encumbrance = { 12, 16 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = {
                    "leg_hip_l",
                    "leg_upper_l",
                    "leg_lower_l",
                    "leg_hip_r",
                    "leg_upper_r",
                    "leg_lower_r",
                },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.65 },
                    { id = "ch_steel", coverage = 80, thickness = 1.5 },
                },
            },
            {
                encumbrance = { 2, 2 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r" },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.65 },
                    { id = "cotton", coverage = 100, thickness = 1 },
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "trousers_eod",
    category = "armor",
    name = ccb.content.plural_text("EOD trousers", "EOD trousers"),
    description = ccb.content.text("This is a heavy pair of trousers armored in Kevlar, Nomex, and foam padding, for use by explosive ordnance disposal technicians.  While it offers near complete coverage in fragmentation resistant materials, it still offers insufficient protection from ballistic threats."),
    mass = "6400 g",
    volume = "7 L",
    price = "10 kUSD 60 USD",
    survival_price = "120 USD",
    materials = { "kevlar", "nomex" },
    symbol = "[",
    color = "light_green",
    flags = { "STURDY", "OUTER", "RAINPROOF" },
    max_worn = 1,
    armor = {
        warmth = 65,
        environmental_protection = 2,
        thickness = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 100, thickness = 7.4 },
                    { id = "plastic_pad", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
                encumbrance = 80,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 4 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "trousers_eod_light",
    category = "armor",
    name = ccb.content.plural_text("tactical EOD trousers", "tactical EOD trousers"),
    description = ccb.content.text("This is a heavy pair of trousers armored in Kevlar, Nomex, and foam padding, for use by explosive ordnance disposal technicians in 'non-permissive environments'.  While it offers near complete coverage in fragmentation resistant materials, it still offers insufficient protection from ballistic threats.  These trousers are lighter than normal EOD armor to provide more maneuverability."),
    mass = "3000 g",
    volume = "7 L",
    price = "2 kUSD 734 USD 40 cent",
    survival_price = "33 USD",
    materials = { "kevlar", "nomex" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER", "RAINPROOF" },
    max_worn = 1,
    armor = {
        warmth = 40,
        environmental_protection = 2,
        thickness = 7,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 100, thickness = 4.4 },
                    { id = "plastic_pad", coverage = 100, thickness = 2 },
                },
                encumbrance = 40,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "armor_lc_light_leg_guard",
    category = "armor",
    name = ccb.content.text("mild steel light leg guard"),
    description = ccb.content.text("A light leg guard, 1.25 mm at the thickest.  This one has been made with mild steel."),
    mass = "2500 g",
    volume = "2916 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "armor_lc_leg_guard",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        sided = true,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 85, thickness = 0.75 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                vitals_coverage = 85,
                encumbrance = 8,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.8 },
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
    id = "xl_armor_lc_light_leg_guard",
    name = ccb.content.text("mild steel light leg guard"),
    copy_from = "armor_lc_light_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_light_leg_guard",
    copy_from = "armor_lc_light_leg_guard",
    name = ccb.content.text("medium steel light leg guard"),
    description = ccb.content.text("A light leg guard, 1.25 mm at the thickest.  Made with tougher medium steel, this offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_light_leg_guard",
    name = ccb.content.text("medium steel light leg guard"),
    copy_from = "armor_mc_light_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_light_leg_guard",
    copy_from = "armor_lc_light_leg_guard",
    name = ccb.content.text("high steel light leg guard"),
    description = ccb.content.text("A light leg guard, 1.25 mm at the thickest.  Made with high steel offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_light_leg_guard",
    name = ccb.content.text("high steel light leg guard"),
    copy_from = "armor_hc_light_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_light_leg_guard",
    copy_from = "armor_lc_light_leg_guard",
    materials = { "ch_steel", "ch_steel_chain" },
    name = ccb.content.text("hardened light leg guard"),
    description = ccb.content.text("A light leg guard, 1.25 mm at the thickest.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_light_leg_guard",
    name = ccb.content.text("hardened light leg guard"),
    copy_from = "armor_ch_light_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_light_leg_guard",
    copy_from = "armor_lc_light_leg_guard",
    name = ccb.content.text("tempered light leg guard"),
    description = ccb.content.text("A light leg guard, 1.25 mm at the thickest.  The medium steel has been quenched and tempered, offering top of the line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_light_leg_guard",
    name = ccb.content.text("tempered light leg guard"),
    copy_from = "armor_qt_light_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_leg_guard",
    category = "armor",
    name = ccb.content.text("mild steel leg guard"),
    description = ccb.content.text("A leg guard, 1.75 mm at the thickest.  This one has been made with mild steel."),
    mass = "3333 g",
    volume = "2916 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        sided = true,
        thickness = 4,
        portions = {
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
                encumbrance = 12,
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
    id = "xl_armor_lc_leg_guard",
    name = ccb.content.text("mild steel leg guard"),
    copy_from = "armor_lc_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_leg_guard",
    copy_from = "armor_lc_leg_guard",
    name = ccb.content.text("medium steel leg guard"),
    description = ccb.content.text("A leg guard, 1.75 mm at the thickest.  Made with tougher medium steel, this offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_leg_guard",
    name = ccb.content.text("medium steel leg guard"),
    copy_from = "armor_mc_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_leg_guard",
    copy_from = "armor_lc_leg_guard",
    name = ccb.content.text("high steel leg guard"),
    description = ccb.content.text("A leg guard, 1.75 mm at the thickest.  Made with high steel offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_leg_guard",
    name = ccb.content.text("high steel leg guard"),
    copy_from = "armor_hc_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_leg_guard",
    copy_from = "armor_lc_leg_guard",
    name = ccb.content.text("hardened leg guard"),
    description = ccb.content.text("A leg guard, 1.75 mm at the thickest.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_leg_guard",
    name = ccb.content.text("hardened leg guard"),
    copy_from = "armor_ch_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_leg_guard",
    copy_from = "armor_lc_leg_guard",
    name = ccb.content.text("tempered leg guard"),
    description = ccb.content.text("A leg guard, 1.75 mm at the thickest.  The medium steel has been quenched and tempered, offering top of the line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_leg_guard",
    name = ccb.content.text("tempered leg guard"),
    copy_from = "armor_qt_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_heavy_leg_guard",
    category = "armor",
    name = ccb.content.text("mild steel heavy leg guard"),
    description = ccb.content.text("A heavy leg guard, 2.25 mm at the thickest.  This one has been made with mild steel."),
    mass = "4166 g",
    volume = "2916 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        sided = true,
        thickness = 6,
        portions = {
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
                encumbrance = 15,
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
    id = "xl_armor_lc_heavy_leg_guard",
    name = ccb.content.text("mild steel heavy leg guard"),
    copy_from = "armor_lc_heavy_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_heavy_leg_guard",
    copy_from = "armor_lc_heavy_leg_guard",
    name = ccb.content.text("medium steel heavy leg guard"),
    description = ccb.content.text("A heavy leg guard, 2.25 mm at the thickest.  Made with tougher medium steel, this offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_heavy_leg_guard",
    name = ccb.content.text("medium steel heavy leg guard"),
    copy_from = "armor_mc_heavy_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_heavy_leg_guard",
    copy_from = "armor_lc_heavy_leg_guard",
    name = ccb.content.text("high steel heavy leg guard"),
    description = ccb.content.text("A heavy leg guard, 2.25 mm at the thickest.  Made with high steel offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_heavy_leg_guard",
    name = ccb.content.text("high steel heavy leg guard"),
    copy_from = "armor_hc_heavy_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_heavy_leg_guard",
    copy_from = "armor_lc_heavy_leg_guard",
    name = ccb.content.text("hardened heavy leg guard"),
    description = ccb.content.text("A heavy leg guard, 2.25 mm at the thickest.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_heavy_leg_guard",
    name = ccb.content.text("hardened heavy leg guard"),
    copy_from = "armor_ch_heavy_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_heavy_leg_guard",
    copy_from = "armor_lc_heavy_leg_guard",
    name = ccb.content.text("tempered heavy leg guard"),
    description = ccb.content.text("A heavy leg guard, 2.25 mm at the thickest.  The medium steel has been quenched and tempered, offering top of the line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_heavy_leg_guard",
    name = ccb.content.text("tempered heavy leg guard"),
    copy_from = "armor_qt_heavy_leg_guard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "survivor_adhoc_leather_pants",
    category = "armor",
    name = ccb.content.plural_text("leather-padded pants", "leather-padded pants"),
    description = ccb.content.text("A pair of tough canvas pants with sections from leather pants affixed, excluding the joints.  Offers mild protection without compromising mobility too much, but a lot of the pockets have been removed to make room for the leather."),
    mass = "1970 g",
    volume = "2500 ml",
    survival_price = "12 USD",
    looks_like = "technician_pants_gray",
    materials = { "canvas", "leather" },
    symbol = "[",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                    { id = "leather", coverage = 95, thickness = 0.75 },
                    { id = "leather", coverage = 90, thickness = 0.75 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r", "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                encumbrance = { 8, 10 },
            },
            {
                materials = { { id = "canvas", coverage = 100, thickness = 0.5 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
        },
        warmth = 25,
        thickness = 2.0,
    },
}

ccb.content.define_item {
    id = "canvas_pants_padded",
    repair_like = "jeans",
    category = "armor",
    name = ccb.content.plural_text("cloth-padded pants", "cloth-padded pants"),
    description = ccb.content.text("A pair of tough canvas pants with sections of cotton sewn onto it in a crossing pattern, clearly done by an amateur."),
    mass = "1970 g",
    volume = "2500 ml",
    survival_price = "12 USD",
    looks_like = "technician_pants_gray",
    materials = { "canvas", "cotton" },
    symbol = "[",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                    { id = "cotton", coverage = 90, thickness = 1 },
                    { id = "cotton", coverage = 90, thickness = 1 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r", "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                encumbrance = { 6, 8 },
            },
            {
                materials = { { id = "canvas", coverage = 100, thickness = 0.5 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
        },
        warmth = 25,
        thickness = 2.0,
    },
}

ccb.content.define_item {
    id = "armor_riot_leg",
    category = "armor",
    name = ccb.content.plural_text("riot leg guards (pair)", "riot leg guards (pair)"),
    description = ccb.content.text("Hard leg guards used by riot police."),
    mass = "500 g",
    volume = "2500 ml",
    price = "100 USD",
    survival_price = "7 USD 50 cent",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "dark_gray",
    length = "40 cm",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "PADDED", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 20,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                encumbrance = 3,
                coverage = 90,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 5 },
                    { id = "thermo_resin", coverage = 90, thickness = 1.75 },
                },
                subparts = { "leg_knee_l", "leg_knee_r", "leg_lower_l", "leg_lower_r" },
            },
            {
                covers = { "foot_l", "foot_r" },
                encumbrance = 2,
                coverage = 75,
                materials = { { id = "thermo_resin", coverage = 100, thickness = 1.5 } },
                subparts = { "foot_arch_l", "foot_arch_r", "foot_ankle_r", "foot_ankle_l" },
            },
        },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 legs are 36% leaving us with 6696 cm^2.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 95% leaves us with 2799 grams.
ccb.content.define_item {
    id = "legguard_larmor",
    category = "armor",
    name = ccb.content.plural_text("leather leg guards (pair)", "leather leg guards (pair)"),
    description = ccb.content.text("A pair of tough leather leg guards.  Light and comfortable."),
    mass = "2799 g",
    volume = "4 L",
    price = "40 USD",
    survival_price = "10 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "legguard_bronze",
    color = "brown",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY" },
    armor = {
        warmth = 25,
        thickness = 4,
        valid_mods = { "steel_padded" },
        portions = { { covers = { "leg_l", "leg_r" }, encumbrance = 7, coverage = 95 } },
    },
}

ccb.content.define_item {
    id = "xl_legguard_larmor",
    name = ccb.content.plural_text("leather leg guards (pair)", "leather leg guards (pair)"),
    copy_from = "legguard_larmor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_legguard_larmor",
    copy_from = "legguard_larmor",
    name = ccb.content.plural_text("leather leg guards (pair)", "leather leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
