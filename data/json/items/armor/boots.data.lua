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

ccb.content.define_item {
    id = "boots_western",
    copy_from = "boots",
    name = ccb.content.plural_text("western boots (pair)", "western boots (pair)"),
    description = ccb.content.text("Stiff leather boots with intricate embroidery and one-inch heels.  They look good, but these boots are made for walking, not running for your life.  Each boot is large enough to conceal a small holdout pistol."),
    survival_price = "7 USD 50 cent",
    materials = { "leather" },
    pockets = {
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "600 g", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "600 g", moves = 80 },
    },
    inheritance = { scale = { mass = 1.2, volume = 1.2, price = 2, encumbrance = 2 } },
    armor = {
        thickness = 2.5,
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
                    { id = "rubber", coverage = 20, thickness = 21.0 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    use_actions = { { kind = "holster" } },
}

ccb.content.define_item {
    id = "boots_winter",
    name = ccb.content.plural_text("winter boots (pair)", "winter boots (pair)"),
    description = ccb.content.text("Wool-lined boots designed for warmth."),
    mass = "1640 g",
    volume = "3500 ml",
    price = "70 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "wool", "plastic" },
    symbol = "[",
    looks_like = "boots_larmor",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 80,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l", "foot_arch_r", "foot_arch_l" },
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                    { id = "wool", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 25,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l" },
                materials = {
                    { id = "rubber", coverage = 100, thickness = 2.5 },
                    { id = "wool", coverage = 100, thickness = 2.5 },
                },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_winter",
    name = ccb.content.plural_text("winter boots (pair)", "winter boots (pair)"),
    copy_from = "boots_winter",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.3, volume = 1.3 } },
}

ccb.content.define_item {
    id = "xs_boots_winter",
    copy_from = "boots_winter",
    name = ccb.content.plural_text("winter boots (pair)", "winter boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "cleats",
    name = ccb.content.plural_text("cleats (pair)", "cleats (pair)"),
    description = ccb.content.text("Sport shoes with hard undersides and studs on the bottom designed to dig into grass."),
    mass = "860 g",
    volume = "1500 ml",
    price = "70 USD",
    survival_price = "7 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 15,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                    { id = "rubber", coverage = 20, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "golf_shoes",
    name = ccb.content.plural_text("golf shoes (pair)", "golf shoes (pair)"),
    description = ccb.content.text("Snug sport shoes with hard ridges on the bottom."),
    mass = "820 g",
    volume = "1500 ml",
    price = "65 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "light_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 15,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                coverage = 60,
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
    id = "clogs",
    name = ccb.content.plural_text("wooden clogs (pair)", "wooden clogs (pair)"),
    description = ccb.content.text("Known as klompen in the Netherlands and sabots in France, these wooden shoes have endured through the ages due to their simple design and durability."),
    mass = "916 g",
    volume = "1250 ml",
    price = "40 USD",
    survival_price = "1 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "leathersandals",
    color = "yellow",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 5,
        thickness = 4,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                encumbrance = 20,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_l", "foot_arch_r", "foot_heel_l", "foot_heel_r" },
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                encumbrance = 20,
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "clownshoes",
    name = ccb.content.plural_text("clown shoes (pair)", "clown shoes (pair)"),
    description = ccb.content.text("Gigantic shoes fit for a clown.  Incredibly difficult to walk in."),
    mass = "1140 g",
    volume = "3500 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_red",
    armor = {
        warmth = 20,
        thickness = 2.5,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_l",
                    "foot_toes_r",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 100, thickness = 1.25 },
                },
                encumbrance = 8,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 100, thickness = 1.25 },
                },
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

ccb.content.define_item {
    id = "dance_shoes",
    name = ccb.content.plural_text("dance shoes (pair)", "dance shoes (pair)"),
    description = ccb.content.text("Expensive black dance shoes with large heels."),
    mass = "870 g",
    volume = "1500 ml",
    price = "120 USD",
    survival_price = "1 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "dark_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 1 } },
                encumbrance = 5,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 1.0 } },
                coverage = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 20, thickness = 8.0 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "dress_shoes",
    name = ccb.content.plural_text("dress shoes (pair)", "dress shoes (pair)"),
    description = ccb.content.text("Fancy patent leather shoes.  Not designed for running."),
    mass = "870 g",
    volume = "1500 ml",
    price = "120 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "dark_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 10,
        thickness = 2.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
                encumbrance = 15,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 40,
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
    id = "flip_flops",
    name = ccb.content.plural_text("flip-flops (pair)", "flip-flops (pair)"),
    description = ccb.content.text("Simple sandals.  Somewhat difficult to run in."),
    mass = "62 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "sneakers",
    color = "blue",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_TALONS" },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "plastic", coverage = 100, thickness = 1 } },
                encumbrance = 15,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "plastic", coverage = 100, thickness = 4.0 } },
                coverage = 80,
            },
        },
    },
}

ccb.content.define_item {
    id = "flip_flops_exp",
    name = ccb.content.plural_text("expensive flip-flops (pair)", "expensive flip-flops (pair)"),
    description = ccb.content.text("These are upmarket \"luxury\" flip-flops.  Very difficult to run in."),
    mass = "170 g",
    volume = "250 ml",
    price = "105 USD",
    survival_price = "50 cent",
    materials = { "rubber", "leather" },
    symbol = "[",
    looks_like = "flip_flops",
    color = "brown",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS" },
    melee_damage = { bash = 1 },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1 } },
                encumbrance = 22,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "rubber", coverage = 100, thickness = 4.0 } },
                coverage = 80,
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags",
    name = ccb.content.plural_text("foot rags (pair)", "foot rags (pair)"),
    description = ccb.content.text("Rags tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "56 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "white",
    flags = { "SKINTIGHT", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 2,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_fur",
    name = ccb.content.plural_text("fur foot wraps (pair)", "fur foot wraps (pair)"),
    description = ccb.content.text("Fur pelts tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "135 g",
    volume = "500 ml",
    price = "7 USD",
    survival_price = "50 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 20,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_faux_fur",
    name = ccb.content.plural_text("faux fur foot wraps (pair)", "faux fur foot wraps (pair)"),
    description = ccb.content.text("Faux fur patches tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "135 g",
    volume = "500 ml",
    price = "7 USD",
    survival_price = "50 cent",
    materials = { "faux_fur" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 18,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_leather",
    name = ccb.content.plural_text("leather foot wraps (pair)", "leather foot wraps (pair)"),
    description = ccb.content.text("Leather patches tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "120 g",
    volume = "500 ml",
    price = "5 USD 25 cent",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "socks",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_wool",
    name = ccb.content.plural_text("wool foot wraps (pair)", "wool foot wraps (pair)"),
    description = ccb.content.text("Felt patches tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "56 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "blue",
    flags = { "SKINTIGHT", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 15,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "geta",
    name = ccb.content.plural_text("geta (pair)", "geta (pair)"),
    description = ccb.content.text("A simple pair of geta.  Traditional wooden Japanese sandals with a fabric thong similar to flip flops."),
    mass = "460 g",
    volume = "1 L",
    price = "65 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "clogs",
    color = "yellow",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 2 } },
                encumbrance = 10,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "wood", coverage = 100, thickness = 2.0 },
                    { id = "wood", coverage = 40, thickness = 4.0 },
                },
                coverage = 80,
            },
        },
    },
}

ccb.content.define_item {
    id = "heels",
    name = ccb.content.plural_text("heels (pair)", "heels (pair)"),
    description = ccb.content.text("A pair of high heels.  Difficult to even walk in."),
    mass = "640 g",
    volume = "750 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "dark_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 6 },
    variant_kind = "generic",
    variants = {
        {
            id = "heels_stiletto",
            name = ccb.content.plural_text("stiletto heels (pair)", "stiletto heels (pair)"),
            description = ccb.content.text("A traditional pair of tall, high-heeled shoes with a tapered, slender heel, which makes strutting fashionable, walking a challenge, and running an impossibility.  These days, they'd probably be more useful to stab a zombie's eyes out than as footwear."),
            weight = 10,
        },
        {
            id = "heels_block",
            name = ccb.content.plural_text("block heels (pair)", "block heels (pair)"),
            description = ccb.content.text("These are a pair of chunky, broad-based shoes with a sturdy block-like heel, and while they don't do you any favors in the mobility department, they're at least more comfortable to trudge about in than their peers and won't likely cause irreversible damage to your feet."),
            weight = 10,
        },
        {
            id = "heels_wedge",
            name = ccb.content.plural_text("wedges (pair)", "wedges (pair)"),
            description = ccb.content.text("A pair of tall, high-heeled, open-toed shoes with thick wedges running the length of the shoe, serving as its heels."),
            weight = 10,
        },
        {
            id = "heels_platform",
            name = ccb.content.plural_text("platform heels (pair)", "platform heels (pair)"),
            description = ccb.content.text("A pair of heavy, thick-soled high-heeled shoes with a ridiculously tall heel supported by an ankle strap and chunky soles.  A great choice for when you've given up on basic biomechanical function and decided that you're more than willing to risk long-term damage to your feet for the sake of a ridiculous fashion statement in the ruins of America."),
            weight = 10,
        },
        {
            id = "heels_flag",
            name = ccb.content.plural_text("liberty's heels (pair)", "liberty's heels (pair)"),
            description = ccb.content.text("The shoes of patriotic ladies around the nation, these open-toed heels glitter with small golden stars embroidered along their sides, with a pair of decorative flaps styled with the image of a miniature American flag unfurling from each ankle, like wings.  The footwear's heels consist of an adorably tiny reproduction of the Statue of Liberty situated beneath each sole, with their arms razed and supporting the shoe's heels.  Each of the statues' dresses is inscribed with the legend, \"America Gives You Wings!\""),
        },
    },
    armor = {
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_toes_r", "foot_toes_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1 } },
                encumbrance = 50,
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                    { id = "rubber", coverage = 5, thickness = 80.0 },
                },
                coverage = 100,
            },
        },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "knee_high_boots",
    name = ccb.content.plural_text("knee-high boots (pair)", "knee-high boots (pair)"),
    description = ccb.content.text("Very long leather boots that cover the lower legs, they are cumbersome to wear."),
    mass = "1520 g",
    volume = "3750 ml",
    length = "33 cm",
    price = "80 USD",
    survival_price = "12 USD 50 cent",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots_larmor",
    color = "black",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    variant_kind = "generic",
    variants = {
        { id = "generic_knee_high_boots", weight = 10 },
        {
            id = "jackboots",
            name = ccb.content.plural_text("jackboots (pair)", "jackboots (pair)"),
            description = ccb.content.text("A pair of sturdy, over-the-knee, laceless boots fitted with a rubberized sole: these imposing combat boots provide good traction despite their encumbering nature.  Most commonly associated with totalitarian regimes due to their use by Nazi soldiers, this style of boot is warm, protective, and produces a deeply satisfying sound while marching."),
            weight = 10,
        },
        {
            id = "chelsea_boots",
            name = ccb.content.plural_text("Chelsea boots (pair)", "Chelsea boots (pair)"),
            description = ccb.content.text("A pair of knee-length, laceless boots formed from calfskin with an elastic side panel that's designed to stretch away to facilitate simple donning and doffing, these stylish stompers are a time-old gift from Victorian-age England.  Intended for you to fashionably saunter down roadways rather than sprint for your life, this style of boot became a style staple within London during the 1960s, where they were synonymous with the mod crowd."),
            weight = 10,
        },
    },
    armor = {
        warmth = 20,
        thickness = 2,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
                encumbrance = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_l", "foot_ankle_r",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
}

ccb.content.define_item {
    id = "motor_police_boots",
    category = "armor",
    name = ccb.content.plural_text("motorcycle police boots (pair)", "motorcycle police boots (pair)"),
    description = ccb.content.text("Custom-made knee-high leather boots issued to motor officers.  Warm, durable and quite tough."),
    mass = "1520 g",
    volume = "3750 ml",
    price = "80 USD",
    survival_price = "12 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    symbol = "[",
    looks_like = "knee_high_boots",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "OUTER", "STURDY" },
    melee_damage = { bash = 1 },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
                encumbrance = 15,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_l", "foot_ankle_r",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
        warmth = 20,
        thickness = 2,
        environmental_protection = 2,
    },
}

-- weight is based on an average of between 1 and 2 lbs for various hiking sandals IRL.
ccb.content.define_item {
    id = "leathersandals",
    name = ccb.content.plural_text("leather sandals (pair)", "leather sandals (pair)"),
    description = ccb.content.text("Sturdy leather hiking sandals with a heel strap.  Offers little in the way of protection, but keeps you cool during warmer months."),
    mass = "675 g",
    volume = "250 ml",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    symbol = "[",
    looks_like = "flip_flops",
    color = "brown",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_TALONS" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.5 } },
                encumbrance = 8,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_ankle_r",
                    "foot_ankle_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 1.5 } },
                coverage = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 95,
            },
        },
    },
}

ccb.content.define_item {
    id = "lowtops",
    name = ccb.content.plural_text("lowtop tennis shoes (pair)", "lowtop tennis shoes (pair)"),
    description = ccb.content.text("Lightweight shoes made of cloth and rubber."),
    mass = "114 g",
    volume = "750 ml",
    price = "15 USD",
    survival_price = "2 USD 50 cent",
    symbol = "[",
    looks_like = "sneakers",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 1.5 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 1.5 } },
                coverage = 10,
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

ccb.content.define_item {
    id = "mocassins",
    name = ccb.content.plural_text("moccasins (pair)", "moccasins (pair)"),
    description = ccb.content.text("A type of traditional Native American footwear sewn out of prepared leather or pelts."),
    mass = "230 g",
    volume = "500 ml",
    price = "50 USD",
    survival_price = "2 USD 50 cent",
    materials = { "fur", "leather" },
    symbol = "[",
    looks_like = "leathersandals",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF" },
    armor = {
        warmth = 20,
        thickness = 1.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                encumbrance = 2,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "motorbike_boots",
    category = "armor",
    name = ccb.content.plural_text("motorcycle boots (pair)", "motorcycle boots (pair)"),
    description = ccb.content.text("A pair of durable boots used by dirt bikers and motorcyclists."),
    mass = "1800 g",
    volume = "2 L",
    price = "80 USD",
    survival_price = "7 USD 50 cent",
    materials = { "kevlar", "cotton" },
    symbol = "[",
    looks_like = "boots_steel",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 35,
        thickness = 2.5,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
                encumbrance = 30,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_l", "foot_ankle_r",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.25 },
                    { id = "kevlar", coverage = 100, thickness = 1.25 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "roller_blades",
    name = ccb.content.plural_text("rollerblades (pair)", "rollerblades (pair)"),
    description = ccb.content.text("A pair of inline skates.  Very fast on flat floors, but they make it hard to move on rough terrain, take hits, or dodge effectively."),
    mass = "1640 g",
    volume = "3750 ml",
    price = "85 USD",
    survival_price = "25 USD",
    materials = { "plastic", "cotton" },
    symbol = "[",
    looks_like = "rollerskates",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "ROLLER_INLINE", "REQUIRES_BALANCE" },
    armor = {
        warmth = 20,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_r", "foot_ankle_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.5 },
                    { id = "plastic", coverage = 95, thickness = 1.5 },
                },
                encumbrance = 25,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "rollerskates",
    name = ccb.content.plural_text("rollerskates (pair)", "rollerskates (pair)"),
    description = ccb.content.text("An old-fashioned pair of leather rollerskates with steel frames.  While quite fast on flat floors, they make it difficult to take hits or to move on rough terrain."),
    mass = "2720 g",
    volume = "3 L",
    price = "85 USD",
    survival_price = "15 USD",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "roller_blades",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "ROLLER_QUAD", "REQUIRES_BALANCE" },
    melee_damage = { bash = 6 },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_r", "foot_ankle_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.5 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                encumbrance = 25,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "wood", coverage = 90, thickness = 4.0 },
                    { id = "steel", coverage = 20, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "shoes_birchbark",
    name = ccb.content.plural_text("birchbark shoes (pair)", "birchbark shoes (pair)"),
    description = ccb.content.text("Simple shoes woven from strips of birch bark.  Not very comfortable, but better than going barefoot."),
    mass = "345 g",
    volume = "500 ml",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "clogs",
    color = "light_gray",
    flags = { "VARSIZE" },
    armor = {
        warmth = 10,
        thickness = 1.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "wood", coverage = 100, thickness = 1.0 } },
                encumbrance = 15,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "wood", coverage = 100, thickness = 1.0 } },
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "wood", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "shoes_bowling",
    name = ccb.content.plural_text("bowling shoes (pair)", "bowling shoes (pair)"),
    description = ccb.content.text("A pair of flat-soled shoes designed to give you a grip on slippery surfaces."),
    mass = "840 g",
    volume = "1500 ml",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "light_blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1 },
                    { id = "leather", coverage = 100, thickness = 1 },
                },
                encumbrance = 10,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1 },
                },
                coverage = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 3.0 },
                },
                coverage = 100,
            },
        },
    },
}

-- Denim part is 10 oz.
ccb.content.define_item {
    id = "shoes_denim",
    name = ccb.content.plural_text("denim sneakers (pair)", "denim sneakers (pair)"),
    description = ccb.content.text("A pair of denim shoes.  They are cool and that's about it."),
    mass = "340 g",
    volume = "1500 ml",
    price = "50 USD",
    survival_price = "3 USD 50 cent",
    materials = { "rubber", "cotton", "denim" },
    symbol = "[",
    color = "light_blue",
    looks_like = "sneakers",
    flags = { "VARSIZE" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.5 },
                    { id = "denim", coverage = 100, thickness = 0.65 },
                },
                encumbrance = 5,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.5 },
                    { id = "denim", coverage = 100, thickness = 0.65 },
                },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 3.0 },
                },
                coverage = 100,
            },
        },
        warmth = 25,
    },
}

ccb.content.define_item {
    id = "slippers",
    name = ccb.content.plural_text("slippers (pair)", "slippers (pair)"),
    description = ccb.content.text("Soft shoes that keep your feet warm.  Not suitable for running."),
    mass = "70 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "brown",
    flags = { "VARSIZE" },
    armor = {
        warmth = 25,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.5 } },
                encumbrance = 30,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.5 } },
                coverage = 90,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.5 } },
                coverage = 10,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.5 },
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "sneakers",
    name = ccb.content.plural_text("sneakers (pair)", "sneakers (pair)"),
    description = ccb.content.text("Guaranteed to make you run faster and jump higher!"),
    mass = "454 g",
    volume = "1500 ml",
    price = "100 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "rubber" },
    symbol = "[",
    looks_like = "shoes_bowling",
    color = "light_blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 1 } },
                encumbrance = 4,
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

ccb.content.define_item {
    id = "straw_sandals",
    name = ccb.content.plural_text("straw sandals (pair)", "straw sandals (pair)"),
    description = ccb.content.text("Sandals made from straw rope.  Not very comfortable, but can keep your feet safe."),
    mass = "70 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "leathersandals",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_TALONS" },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "paper", coverage = 100, thickness = 1.0 } },
                encumbrance = 10,
                coverage = 30,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "paper", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "thigh_high_boots",
    name = ccb.content.plural_text("thigh-high boots (pair)", "thigh-high boots (pair)"),
    description = ccb.content.text("Very long leather boots that reach past the knees, they are cumbersome to wear."),
    mass = "1540 g",
    volume = "4250 ml",
    price = "80 USD",
    survival_price = "5 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots_larmor",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 20,
        thickness = 2,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_r", "foot_ankle_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
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
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                encumbrance = 0,
                coverage = 50,
                covers = { "leg_r", "leg_l" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "roller_shoes_off",
    name = ccb.content.plural_text("heelys (off) (pair)", "heelys (off) (pair)"),
    description = ccb.content.text("A pair of sneakers with integrated wheels.  Currently the wheels are retracted, making these essentially normal lace-up athletic shoes."),
    mass = "840 g",
    volume = "1500 ml",
    price = "100 USD",
    survival_price = "12 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
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
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Extend wheels"),
            target = "roller_shoes_on",
            message = ccb.content.text("You pop the wheels out."),
            moves = 500,
        },
    },
}

ccb.content.define_item {
    id = "roller_shoes_on",
    name = ccb.content.plural_text("heelys (on) (pair)", "heelys (on) (pair)"),
    description = ccb.content.text("A pair of sneakers with integrated wheels, currently the wheels are out, allowing you to swiftly roll around on flat terrain.  You should probably pop them back in before you try fighting or going off-road."),
    mass = "840 g",
    volume = "1500 ml",
    price = "100 USD",
    survival_price = "12 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_blue",
    flags = { "VARSIZE", "ROLLER_ONE", "REQUIRES_BALANCE" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
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
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Retract wheels"),
            target = "roller_shoes_off",
            message = ccb.content.text("You pop the wheels back in."),
            moves = 500,
        },
    },
}

ccb.content.define_item {
    id = "chainmail_junk_feet",
    category = "armor",
    name = ccb.content.plural_text("chainmail chausses (pair)", "chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail.  The metal shows signs of rust and corrosion."),
    mass = "1801 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "20 USD",
    materials = { "budget_steel_chain", "leather" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "budget_steel_chain", coverage = 100, thickness = 1.2 },
                },
                encumbrance = 14,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_feet",
    category = "armor",
    name = ccb.content.plural_text("mild steel chainmail chausses (pair)", "mild steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    mass = "1801 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "20 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                encumbrance = 14,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("mild steel chainmail chausses (pair)", "mild steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_lc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("mild steel chainmail chausses (pair)", "mild steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("medium steel chainmail chausses (pair)", "medium steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_feet",
    copy_from = "mc_chainmail_feet",
    name = ccb.content.plural_text("medium steel chainmail chausses (pair)", "medium steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_mc_chainmail_feet",
    copy_from = "mc_chainmail_feet",
    looks_like = "chainmail_feet",
    name = ccb.content.plural_text("medium steel chainmail chausses (pair)", "medium steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("high steel chainmail chausses (pair)", "high steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_feet",
    copy_from = "hc_chainmail_feet",
    name = ccb.content.plural_text("high steel chainmail chausses (pair)", "high steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_hc_chainmail_feet",
    copy_from = "hc_chainmail_feet",
    name = ccb.content.plural_text("high steel chainmail chausses (pair)", "high steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("hardened steel chainmail chausses (pair)", "hardened steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_feet",
    copy_from = "ch_chainmail_feet",
    name = ccb.content.plural_text("hardened steel chainmail chausses (pair)", "hardened steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_ch_chainmail_feet",
    copy_from = "ch_chainmail_feet",
    name = ccb.content.plural_text("hardened steel chainmail chausses (pair)", "hardened steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("tempered steel chainmail chausses (pair)", "tempered steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_feet",
    copy_from = "qt_chainmail_feet",
    name = ccb.content.plural_text("tempered steel chainmail chausses (pair)", "tempered steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_qt_chainmail_feet",
    copy_from = "qt_chainmail_feet",
    name = ccb.content.plural_text("tempered steel chainmail chausses (pair)", "tempered steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "nomex_socks",
    name = ccb.content.plural_text("flame-resistant socks (pair)", "flame-resistant socks (pair)"),
    description = ccb.content.text("A snug-fitting pair of stockings made from thin and lightweight Nomex fabric."),
    mass = "200 g",
    volume = "750 ml",
    price = "20 USD",
    survival_price = "1 USD",
    materials = { "nomex" },
    symbol = "[",
    looks_like = "socks",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 1,
        environmental_protection = 2,
        portions = { { encumbrance = 6, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xlnomex_socks",
    name = ccb.content.plural_text("flame-resistant socks (pair)", "flame-resistant socks (pair)"),
    mass = "300 g",
    volume = "1000 ml",
    copy_from = "nomex_socks",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xsnomex_socks",
    copy_from = "nomex_socks",
    name = ccb.content.plural_text("flame-resistant socks (pair)", "flame-resistant socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "socks",
    name = ccb.content.plural_text("socks (pair)", "socks (pair)"),
    description = ccb.content.text("Socks.  Put 'em on your feet."),
    mass = "32 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xlsocks",
    name = ccb.content.plural_text("socks (pair)", "socks (pair)"),
    mass = "58 g",
    volume = "250 ml",
    copy_from = "socks",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xssocks",
    copy_from = "socks",
    name = ccb.content.plural_text("socks (pair)", "socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "socks_ankle",
    name = ccb.content.plural_text("ankle socks (pair)", "ankle socks (pair)"),
    description = ccb.content.text("Short socks, commonly used for sports.  These are designed to protect your feet from friction, not temperature."),
    mass = "25 g",
    volume = "200 ml",
    price = "1 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "light_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        thickness = 0.3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_sole_r", "foot_sole_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 0.3 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.3 } },
                coverage = 60,
            },
        },
    },
}

ccb.content.define_item {
    id = "socks_bag",
    name = ccb.content.plural_text("bag socks (pair)", "bag socks (pair)"),
    description = ccb.content.text("A pair of disposable plastic bags, adapted to be used as socks."),
    mass = "6 g",
    volume = "250 ml",
    price = "50 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "socks",
    color = "light_blue",
    flags = { "WATERPROOF", "OVERSIZE", "SOFT" },
    armor = {
        thickness = 0.01,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_sole_r", "foot_sole_l",
                },
                materials = { { id = "plastic", coverage = 100, thickness = 0.01 } },
                encumbrance = 3,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.01 } },
                coverage = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "socks_bowling",
    name = ccb.content.plural_text("disposable bowling socks (pair)", "disposable bowling socks (pair)"),
    description = ccb.content.text("Cheap socks designed to be worn once and then thrown away.  They keep your feet clean, but are too thin to give any protection."),
    mass = "20 g",
    volume = "250 ml",
    price = "50 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "white",
    flags = { "SKINTIGHT" },
    armor = { warmth = 2, portions = { { coverage = 80, covers = { "foot_l", "foot_r" } } } },
}

-- NO_SALVAGE is to prevent an infinite yarn/wool exploit because the salvage system sucks.
ccb.content.define_item {
    id = "socks_wool",
    name = ccb.content.plural_text("wool socks (pair)", "wool socks (pair)"),
    description = ccb.content.text("Warm socks made of wool."),
    mass = "44 g",
    volume = "250 ml",
    price = "12 USD",
    survival_price = "1 USD 50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "socks",
    color = "blue",
    flags = { "VARSIZE", "SKINTIGHT", "NO_SALVAGE" },
    armor = {
        warmth = 30,
        thickness = 0.3,
        portions = { { encumbrance = 5, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xlsocks_wool",
    name = ccb.content.plural_text("wool socks (pair)", "wool socks (pair)"),
    mass = "77 g",
    volume = "500 ml",
    copy_from = "socks_wool",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xssocks_wool",
    copy_from = "socks_wool",
    name = ccb.content.plural_text("wool socks (pair)", "wool socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Variants ordered by color, and then pattern of striped, polka dot, floral, checkered
ccb.content.define_item {
    id = "stockings",
    name = ccb.content.plural_text("stockings (pair)", "stockings (pair)"),
    description = ccb.content.text("Long cotton socks that reach above the knees to help protect from the cold."),
    mass = "90 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    variant_kind = "generic",
    variants = {
        {
            id = "stockings_black",
            name = ccb.content.plural_text("black stockings (pair)", "black stockings (pair)"),
            description = ccb.content.text("This one is colored black."),
            color = "dark_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_white",
            name = ccb.content.plural_text("white stockings (pair)", "white stockings (pair)"),
            description = ccb.content.text("This one is colored white."),
            color = "light_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_white_striped",
            name = ccb.content.plural_text("striped stockings (pair)", "striped stockings (pair)"),
            description = ccb.content.text("This one is black, with white stripes.  Or is it white with black stripes?"),
            color = "light_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_red",
            name = ccb.content.plural_text("red stockings (pair)", "red stockings (pair)"),
            description = ccb.content.text("This one is colored red."),
            color = "red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_red_polka_dot",
            name = ccb.content.plural_text("red polka dot stockings (pair)", "red polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored red with a polka dot pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_red_floral",
            name = ccb.content.plural_text("red floral stockings (pair)", "red floral stockings (pair)"),
            description = ccb.content.text("This one is colored in various shades of red with a floral pattern."),
            color = "red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_yellow",
            name = ccb.content.plural_text("yellow stockings (pair)", "yellow stockings (pair)"),
            description = ccb.content.text("This one is colored yellow."),
            color = "yellow",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_green",
            name = ccb.content.plural_text("green stockings (pair)", "green stockings (pair)"),
            description = ccb.content.text("This one is colored green."),
            color = "green",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_orange_striped",
            name = ccb.content.plural_text("orange striped stockings (pair)", "orange striped stockings (pair)"),
            description = ccb.content.text("This one is colored orange with a striped pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue",
            name = ccb.content.plural_text("blue stockings (pair)", "blue stockings (pair)"),
            description = ccb.content.text("This one is colored blue."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue_striped",
            name = ccb.content.plural_text("blue striped stockings (pair)", "blue striped stockings (pair)"),
            description = ccb.content.text("This one is colored blue and white with a striped pattern."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue_floral",
            name = ccb.content.plural_text("blue floral stockings (pair)", "blue floral stockings (pair)"),
            description = ccb.content.text("This one is colored in various shades of blue with a floral pattern."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue_checkered",
            name = ccb.content.plural_text("blue checkered stockings (pair)", "blue checkered stockings (pair)"),
            description = ccb.content.text("This one is colored blue and black with a checkered pattern."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple",
            name = ccb.content.plural_text("purple stockings (pair)", "purple stockings (pair)"),
            description = ccb.content.text("This one is colored purple."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple_striped",
            name = ccb.content.plural_text("purple striped stockings (pair)", "purple striped stockings (pair)"),
            description = ccb.content.text("This one is colored purple and white with a striped pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple_polka_dot",
            name = ccb.content.plural_text("purple polka dot stockings (pair)", "purple polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored purple with a polka dot pattern."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple_floral",
            name = ccb.content.plural_text("purple floral stockings (pair)", "purple floral stockings (pair)"),
            description = ccb.content.text("This one is colored in various shades of purple with a floral pattern."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_pink",
            name = ccb.content.plural_text("pink stockings (pair)", "pink stockings (pair)"),
            description = ccb.content.text("This one is colored pink."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_pink_striped",
            name = ccb.content.plural_text("pink striped stockings (pair)", "pink striped stockings (pair)"),
            description = ccb.content.text("This one is colored pink and white with a striped pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_pink_polka_dot",
            name = ccb.content.plural_text("pink polka dot stockings (pair)", "pink polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored pink with a polka dot pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_green_striped",
            name = ccb.content.plural_text("green striped stockings (pair)", "green striped stockings (pair)"),
            description = ccb.content.text("This one is colored green and white with a striped pattern."),
            color = "green",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_gray_striped",
            name = ccb.content.plural_text("gray striped stockings (pair)", "gray striped stockings (pair)"),
            description = ccb.content.text("This one is colored gray and white with a striped pattern."),
            color = "light_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_brown",
            name = ccb.content.plural_text("brown stockings (pair)", "brown stockings (pair)"),
            description = ccb.content.text("This one is colored brown."),
            color = "brown",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_brown_polka_dot",
            name = ccb.content.plural_text("brown polka dot stockings (pair)", "brown polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored brown with a polka dot pattern."),
            color = "brown",
            append = true,
            weight = 3,
        },
    },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            { encumbrance = 5, coverage = 100, covers = { "foot_l", "foot_r" } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = 4,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 60,
            },
        },
    },
}

ccb.content.define_item {
    id = "stockings_tent_legs",
    name = ccb.content.plural_text("tentacle stockings (pair)", "tentacle stockings (pair)"),
    description = ccb.content.text("Six long cotton tubes sized to fit over tentacles and help protect them from the cold."),
    mass = "300 g",
    volume = "1500 ml",
    price = "12 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "OVERSIZE", "MUTATED_ANATOMY_ONLY" },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 8,
                coverage = 100,
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "tabi_dress",
    name = ccb.content.plural_text("tabi (pair)", "tabi (pair)"),
    description = ccb.content.text("A pair of split toe black tabi socks.  Usually worn as a part of traditional Japanese clothing.  The big toe is separated from the others by the fabric to be comfortably worn with thonged footwear."),
    mass = "50 g",
    volume = "250 ml",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "tabi_gi",
    name = ccb.content.plural_text("gi tabi (pair)", "gi tabi (pair)"),
    description = ccb.content.text("A pair of split toe white tabi socks, as used by martial arts practitioners.  Usually worn as a part of traditional Japanese clothing.  The big toe is separated from the others by the fabric to be comfortably worn with thonged footwear."),
    mass = "50 g",
    volume = "250 ml",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "lc_sabaton",
    name = ccb.content.text("mild steel sabaton"),
    description = ccb.content.text("A flexible set of jointed lames that can be worn over footwear for additional protection, traditionally worn by mounted knights."),
    mass = "750 g",
    volume = "750 ml",
    price = "400 USD",
    survival_price = "30 USD",
    symbol = "[",
    looks_like = "boots_steel",
    materials = { "lc_steel" },
    color = "light_gray",
    flags = { "STURDY", "OUTER" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 0,
        sided = true,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.25 } },
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("mild steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "mc_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("medium steel sabaton"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_sabaton",
    copy_from = "mc_sabaton",
    name = ccb.content.text("medium steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "hc_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("high steel sabaton"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_sabaton",
    copy_from = "hc_sabaton",
    name = ccb.content.text("high steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "ch_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("hardened steel sabaton"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_sabaton",
    copy_from = "ch_sabaton",
    name = ccb.content.text("hardened steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "qt_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("tempered steel sabaton"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_sabaton",
    copy_from = "qt_sabaton",
    name = ccb.content.text("tempered steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "espadrilles",
    name = ccb.content.plural_text("espadrilles", "espadrilles"),
    description = ccb.content.text("Originating from the Pyrenees and made from a rope sole and cloth, these shoes are perfect for the hot weather, sipping Sangria and dodging tourists."),
    looks_like = "leathersandals",
    price = "20 USD",
    survival_price = "10 USD",
    symbol = "[",
    materials = { "cotton" },
    volume = "600 ml",
    mass = "300 g",
    flags = { "VARSIZE" },
    armor = {
        warmth = 2,
        portions = {
            {
                layers = { "NORMAL" },
                encumbrance = 4,
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l" },
                materials = { { id = "cotton", thickness = 1 } },
            },
            {
                layers = { "NORMAL" },
                encumbrance = 0,
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l", "foot_sole_r", "foot_sole_l" },
                materials = { { id = "dry_plant", thickness = 6 } },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_espadrilles",
    copy_from = "espadrilles",
    name = ccb.content.plural_text("espadrilles", "espadrilles"),
    armor = {},
    inheritance = { add = { flags = { "PREFIX_XL", "OVERSIZE" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_espadrilles",
    copy_from = "espadrilles",
    name = ccb.content.plural_text("espadrilles", "espadrilles"),
    armor = {},
    inheritance = { add = { flags = { "PREFIX_XS", "UNDERSIZE" } }, scale = { mass = 0.5, volume = 0.5 } },
}

ccb.content.define_item {
    id = "jikatabi",
    name = ccb.content.plural_text("jika-tabi (pair)", "jika-tabi (pair)"),
    description = ccb.content.text("A pair of thin traditional Japanese split toed boots sewn out of leather."),
    mass = "230 g",
    volume = "500 ml",
    price = "30 USD",
    survival_price = "3 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF" },
    armor = {
        warmth = 20,
        thickness = 1.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "leather", coverage = 100, thickness = 0.4 } },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "jikatabi_sneakers",
    name = ccb.content.plural_text("jika-tabi sneakers (pair)", "jika-tabi sneakers (pair)"),
    description = ccb.content.text("A pair of comfortable modern split toed jika-tabi shoes with a rubber base.  Also known as ninja shoes.  Though originally developed for laborers in Japan, in the west they are usually found being used in outdoor martial arts practice."),
    mass = "300 g",
    volume = "500 ml",
    price = "40 USD",
    survival_price = "4 USD",
    materials = { "canvas", "rubber" },
    symbol = "[",
    looks_like = "sneakers",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "canvas", coverage = 100, thickness = 1 } },
                encumbrance = 2,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "canvas", coverage = 100, thickness = 0.4 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "canvas", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "canvas", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}
