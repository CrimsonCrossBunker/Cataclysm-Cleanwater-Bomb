local ccb = require("ccb")

ccb.content.define_item {
    id = "bastsandals",
    name = ccb.content.plural_text("cord sandals (pair)", "cord sandals (pair)"),
    description = ccb.content.text("Lightweight sandals made from wound cord.  They offer little in the way of protection, but keep you cool during warmer months."),
    mass = "68 g",
    volume = "250 ml",
    price = "30 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "flip_flops",
    color = "brown",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_TALONS" },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 2.0 } },
                encumbrance = 10,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "boots",
    name = ccb.content.plural_text("boots (pair)", "boots (pair)"),
    description = ccb.content.text("Tough leather boots, for tough everyday work."),
    mass = "1060 g",
    volume = "2500 ml",
    price = "100 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 20,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.5 } },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots",
    name = ccb.content.plural_text("boots (pair)", "boots (pair)"),
    copy_from = "boots",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "xs_boots",
    copy_from = "boots",
    looks_like = "boots",
    name = ccb.content.plural_text("boots (pair)", "boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_bone",
    category = "armor",
    name = ccb.content.plural_text("occult boots (pair)", "occult boots (pair)"),
    description = ccb.content.text("Leather boots covered with tiny, finely-carved bones.  With each step, the bones collide with each other and produce a melodic clicking."),
    mass = "1824 g",
    volume = "4250 ml",
    price = "135 USD",
    survival_price = "15 USD",
    copy_from = "boots",
    symbol = "[",
    looks_like = "boots",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    armor = {
        thickness = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "bone", coverage = 80, thickness = 1.0 },
                },
                encumbrance = 16,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                    { id = "leather", coverage = 100, thickness = 0.1 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "boots_bunker",
    category = "armor",
    name = ccb.content.plural_text("turnout boots (pair)", "turnout boots (pair)"),
    description = ccb.content.text("A pair of steel-toed rubber boots, the sort worn by firefighters."),
    mass = "1930 g",
    volume = "3500 ml",
    price = "130 USD",
    survival_price = "15 USD",
    symbol = "[",
    looks_like = "boots_steel",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        warmth = 35,
        environmental_protection = 8,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_ankle_r",
                    "foot_ankle_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                materials = {
                    { id = "rubber", coverage = 100, thickness = 2.25 },
                    { id = "nomex", coverage = 100, thickness = 2.25 },
                },
                encumbrance = 40,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = {
                    { id = "rubber", coverage = 100, thickness = 2.25 },
                    { id = "nomex", coverage = 100, thickness = 2.25 },
                    { id = "steel", coverage = 100, thickness = 0.5 },
                },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                    { id = "nomex", coverage = 100, thickness = 0.1 },
                },
                coverage = 100,
            },
        },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the feet are 3% leaving us with 558 cm^2.
-- Chitin has a density of 1.37g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 196 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 43 grams.
-- Totalled up this is 239 grams with some rounding
ccb.content.define_item {
    id = "boots_chitin",
    category = "armor",
    name = ccb.content.plural_text("chitinous scale foot covers (pair)", "chitinous scale foot covers (pair)"),
    description = ccb.content.text("Sections of chitin attached to a leather backing meant to drape over existing foot wear.  Due to the nature of chitin, it cannot cover everything and isn't very protective.  Seems like it was made out of desperation."),
    mass = "239 g",
    volume = "400 ml",
    price = "135 USD",
    survival_price = "50 cent",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    color = "green",
    flags = { "OUTER" },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
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
    id = "xl_boots_chitin",
    name = ccb.content.plural_text("chitinous scale foot covers (pair)", "chitinous scale foot covers (pair)"),
    copy_from = "boots_chitin",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "xs_boots_chitin",
    copy_from = "boots_chitin",
    looks_like = "boots_chitin",
    name = ccb.content.plural_text("chitinous scale foot covers (pair)", "chitinous scale foot covers (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_acidchitin",
    copy_from = "boots_chitin",
    name = ccb.content.plural_text("biosilicified chitin boots (pair)", "biosilicified chitin boots (pair)"),
    description = ccb.content.text("Boots crafted from the carefully cleaned and pruned biosilicified exoskeletons of acidic ants.  Acid-resistant but brittle."),
    survival_price = "17 USD 50 cent",
    materials = { "acidchitin" },
    armor = {},
    inheritance = { offset = { melee_damage = { bash = 2 } } },
}

ccb.content.define_item {
    id = "xl_boots_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin boots (pair)", "biosilicified chitin boots (pair)"),
    copy_from = "boots_acidchitin",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "xs_boots_acidchitin",
    copy_from = "boots_acidchitin",
    name = ccb.content.plural_text("biosilicified chitin boots (pair)", "biosilicified chitin boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_combat",
    category = "armor",
    name = ccb.content.plural_text("combat boots (pair)", "combat boots (pair)"),
    description = ccb.content.text("Modern reinforced tactical combat boots.  Very durable."),
    mass = "1060 g",
    volume = "2 L",
    price = "70 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    symbol = "[",
    looks_like = "boots",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 25,
        thickness = 2.5,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.25 },
                    { id = "kevlar", coverage = 100, thickness = 1.25 },
                },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
}

-- Denim part is 12 oz.
ccb.content.define_item {
    id = "boots_denim",
    name = ccb.content.plural_text("denim boots (pair)", "denim boots (pair)"),
    description = ccb.content.text("A pair of boots extending towards your lower leg, completely lined with denim.  Looks cool and has above average protection."),
    mass = "1120 g",
    volume = "3 L",
    price = "60 USD",
    survival_price = "6 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    symbol = "{",
    color = "light_blue",
    looks_like = "boots",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "denim", coverage = 100, thickness = 0.8 },
                },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
        warmth = 20,
    },
}

ccb.content.define_item {
    id = "foot_protectors_eod",
    category = "armor",
    name = ccb.content.plural_text("EOD foot protectors (pair)", "EOD foot protectors (pair)"),
    description = ccb.content.text("Armored foot protectors constructed from steel and Nomex for use by explosive ordnance disposal technicians."),
    mass = "1220 g",
    volume = "3 L",
    price = "500 USD",
    survival_price = "70 USD",
    materials = { "plastic_pad", "nomex" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 14,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                encumbrance = 34,
                materials = {
                    { id = "nomex", coverage = 100, thickness = 1 },
                    { id = "plastic_pad", coverage = 100, thickness = 15 },
                },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_l", "foot_heel_l", "foot_ankle_r",
                    "foot_heel_r", "foot_arch_r", "foot_arch_l",
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "toecaps",
    category = "armor",
    name = ccb.content.plural_text("toecaps (pair)", "toecaps (pair)"),
    description = ccb.content.text("Rubbery overshoes that cover your toes with sturdy, OSHA compliant steel toes."),
    mass = "907 g",
    volume = "1 L",
    price = "25 USD",
    survival_price = "6 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "plastic", "steel" },
    symbol = "[",
    color = "brown",
    flags = { "OUTER", "STURDY" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 10,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                encumbrance = 10,
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "boots_fur",
    name = ccb.content.plural_text("fur boots (pair)", "fur boots (pair)"),
    description = ccb.content.text("Boots lined with fur for warmth."),
    mass = "1890 g",
    volume = "4500 ml",
    price = "140 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather", "fur" },
    symbol = "[",
    looks_like = "boots",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 60,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "fur", coverage = 100, thickness = 1.5 },
                },
                encumbrance = 20,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_fur",
    name = ccb.content.plural_text("fur boots (pair)", "fur boots (pair)"),
    copy_from = "boots_fur",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.15, volume = 1.15 } },
}

ccb.content.define_item {
    id = "xs_boots_fur",
    copy_from = "boots_fur",
    name = ccb.content.plural_text("fur boots (pair)", "fur boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_faux_fur",
    name = ccb.content.plural_text("faux fur boots (pair)", "faux fur boots (pair)"),
    description = ccb.content.text("Boots lined with fur for warmth."),
    mass = "1890 g",
    volume = "4500 ml",
    price = "140 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "cotton", "faux_fur" },
    symbol = "[",
    looks_like = "boots_fur",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 40,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.5 },
                    { id = "faux_fur", coverage = 100, thickness = 1.5 },
                },
                encumbrance = 20,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_faux_fur",
    name = ccb.content.plural_text("faux fur boots (pair)", "faux fur boots (pair)"),
    copy_from = "boots_faux_fur",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.15, volume = 1.15 } },
}

ccb.content.define_item {
    id = "xs_boots_faux_fur",
    copy_from = "boots_faux_fur",
    name = ccb.content.plural_text("faux fur boots (pair)", "faux fur boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_hiking",
    name = ccb.content.plural_text("hiking boots (pair)", "hiking boots (pair)"),
    description = ccb.content.text("Tough yet light leather boots, intended for outdoor activity."),
    mass = "960 g",
    volume = "2 L",
    price = "140 USD",
    survival_price = "5 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather", "plastic" },
    symbol = "[",
    looks_like = "boots",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 30,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "boots_larmor",
    category = "armor",
    name = ccb.content.plural_text("leather armor boots (pair)", "leather armor boots (pair)"),
    description = ccb.content.text("Thick leather boots made specifically to protect the feet.  Light yet tough."),
    mass = "902 g",
    volume = "2 L",
    price = "125 USD",
    survival_price = "17 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 25,
        thickness = 5,
        environmental_protection = 2,
        portions = { { encumbrance = 18, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xl_boots_larmor",
    name = ccb.content.plural_text("leather armor boots (pair)", "leather armor boots (pair)"),
    copy_from = "boots_larmor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.3, volume = 1.3 } },
}

ccb.content.define_item {
    id = "xs_boots_larmor",
    copy_from = "boots_larmor",
    name = ccb.content.plural_text("leather armor boots (pair)", "leather armor boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_plate",
    category = "armor",
    name = ccb.content.plural_text("armored boots (pair)", "armored boots (pair)"),
    description = ccb.content.text("An extremely heavy set of armor plated boots."),
    mass = "1890 g",
    volume = "3250 ml",
    price = "500 USD",
    survival_price = "60 USD",
    symbol = "[",
    looks_like = "boots_steel",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 20,
        thickness = 4,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l", "foot_arch_r",
                    "foot_arch_l", "foot_sole_r", "foot_sole_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 28,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 50, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_plate",
    name = ccb.content.plural_text("armored boots (pair)", "armored boots (pair)"),
    copy_from = "boots_plate",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "xs_boots_plate",
    copy_from = "boots_plate",
    name = ccb.content.plural_text("armored boots (pair)", "armored boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_rubber",
    name = ccb.content.plural_text("rubber boots (pair)", "rubber boots (pair)"),
    description = ccb.content.text("A pair of rubber boots, often used while cleaning with caustic materials."),
    mass = "980 g",
    volume = "3500 ml",
    price = "80 USD",
    survival_price = "5 USD",
    symbol = "[",
    looks_like = "boots",
    color = "dark_gray",
    flags = { "WATERPROOF" },
    armor = {
        warmth = 10,
        thickness = 3,
        environmental_protection = 12,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "rubber", coverage = 100, thickness = 3.0 } },
                encumbrance = 30,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "rubber", coverage = 100, thickness = 6.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "boots_scrap",
    category = "armor",
    name = ccb.content.plural_text("scrap boots (pair)", "scrap boots (pair)"),
    description = ccb.content.text("Boots made of random metal scraps attached to simple cloth wraps.  They're very uncomfortable, but provide some level of protection."),
    mass = "2400 g",
    volume = "2 L",
    price = "4 USD",
    survival_price = "2 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "budget_steel", "cotton" },
    symbol = "[",
    looks_like = "boots_steel",
    color = "light_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 10,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "budget_steel", coverage = 55, thickness = 1.8 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 24,
                coverage = 65,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "budget_steel", coverage = 55, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                coverage = 65,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_scrap",
    name = ccb.content.plural_text("scrap boots (pair)", "scrap boots (pair)"),
    copy_from = "boots_scrap",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.3, volume = 1.3 } },
}

ccb.content.define_item {
    id = "xs_boots_scrap",
    copy_from = "boots_scrap",
    name = ccb.content.plural_text("scrap boots (pair)", "scrap boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- The weight assumes two small sheets of about 20cm x 10cm and two small sheets of about 30cm x 10 cm.
ccb.content.define_item {
    id = "sabaton_metal_sheets",
    category = "armor",
    name = ccb.content.plural_text("sheet metal sabatons (pair)", "sheet metal sabatons (pair)"),
    description = ccb.content.text("Some sheets of metal hammered to fit over the top of your foot and around your ankles, meant to be worn over boots.  They make walking a fair bit more awkward, but they'll keep your toes from being stomped on."),
    mass = "1180 g",
    volume = "750 ml",
    price = "4 USD",
    survival_price = "2 USD",
    symbol = "[",
    looks_like = "lc_sabaton",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    color = "light_gray",
    flags = { "STURDY", "OUTER" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                coverage = 95,
                encumbrance = 15,
                layers = { "OUTER" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_sabaton_metal_sheets",
    copy_from = "sabaton_metal_sheets",
    name = ccb.content.plural_text("hardened steel sheet metal sabatons (pair)", "hardened steel sheet metal sabatons (pair)"),
    description = ccb.content.text("Sabatons made of sheet metal, hardened to protect your feet if you drop something heavy on them.  No relation to the band, aside from being very metal."),
    materials = { "ch_steel" },
    armor = {
        portions = {
            {
                materials = { { id = "ch_steel", coverage = 100, thickness = 1.5 } },
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                coverage = 95,
                encumbrance = 15,
                layers = { "OUTER" },
            },
        },
    },
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "boots_steel",
    category = "armor",
    name = ccb.content.plural_text("steeltoed boots (pair)", "steeltoed boots (pair)"),
    description = ccb.content.text("Leather boots with a steel toe, intended for use by workers."),
    mass = "1320 g",
    volume = "3 L",
    price = "120 USD",
    survival_price = "10 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    symbol = "[",
    looks_like = "boots_combat",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "NONCONDUCTIVE" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 30,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_ankle_r",
                    "foot_ankle_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.5 } },
                encumbrance = 20,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.5 },
                    { id = "steel", coverage = 100, thickness = 0.5 },
                },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "sneakers_steel",
    category = "armor",
    name = ccb.content.plural_text("steeltoed sneakers (pair)", "steeltoed sneakers (pair)"),
    description = ccb.content.text("A descendant of the classic steeltoed boot, this modern footwear has become popular among working class people over the last couple of decades."),
    mass = "900 g",
    volume = "1500 ml",
    length = "254 mm",
    price = "120 USD",
    survival_price = "9 USD 25 cent",
    materials = { "nylon", "plastic", "steel" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_blue",
    flags = { "NONCONDUCTIVE", "WATERPROOF", "VARSIZE" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 18,
        thickness = 2.5,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 1 } },
                encumbrance = 8,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "steel", coverage = 100, thickness = 0.5 },
                },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 1.0 } },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}
