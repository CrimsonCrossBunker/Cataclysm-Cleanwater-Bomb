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
