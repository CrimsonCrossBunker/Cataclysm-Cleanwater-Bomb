local ccb = require("ccb")

ccb.content.define_item {
    id = "boots_fsurvivor",
    category = "armor",
    name = ccb.content.plural_text("survivor fireboots (pair)", "survivor fireboots (pair)"),
    description = ccb.content.text("A pair of customized, Kevlar-armored Nomex boots.  These will keep you alive, even when knee-deep in the flames."),
    mass = "1980 g",
    volume = "3 L",
    price = "240 USD",
    survival_price = "60 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar", "nomex" },
    symbol = "[",
    looks_like = "boots_combat",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 15,
        thickness = 5,
        environmental_protection = 10,
        portions = { { encumbrance = 35, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xl_boots_fsurvivor",
    name = ccb.content.plural_text("survivor fireboots (pair)", "survivor fireboots (pair)"),
    copy_from = "boots_fsurvivor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_boots_fsurvivor",
    copy_from = "boots_fsurvivor",
    name = ccb.content.plural_text("survivor fireboots (pair)", "survivor fireboots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_hsurvivor",
    category = "armor",
    name = ccb.content.plural_text("heavy survivor boots (pair)", "heavy survivor boots (pair)"),
    description = ccb.content.text("A pair of customized Kevlar boots that are heavily armored with steel.  Favoring protection over comfort, these will keep you alive, especially when knee-deep in the dead."),
    mass = "2254 g",
    volume = "3 L",
    price = "240 USD",
    survival_price = "80 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar", "steel" },
    symbol = "[",
    looks_like = "boots_combat",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 15,
        thickness = 5,
        environmental_protection = 5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l", "foot_arch_r",
                    "foot_arch_l", "foot_sole_r", "foot_sole_l",
                },
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 2.5 },
                    { id = "steel", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 35,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 2.5 },
                    { id = "steel", coverage = 50, thickness = 2.5 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_hsurvivor",
    name = ccb.content.plural_text("heavy survivor boots (pair)", "heavy survivor boots (pair)"),
    copy_from = "boots_hsurvivor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.2, volume = 1.2 } },
}

ccb.content.define_item {
    id = "xs_boots_hsurvivor",
    copy_from = "boots_hsurvivor",
    name = ccb.content.plural_text("heavy survivor boots (pair)", "heavy survivor boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_hsurvivor",
    category = "armor",
    name = ccb.content.plural_text("heavy survivor gloves (pair)", "heavy survivor gloves (pair)"),
    description = ccb.content.text("A pair of customized, steel-backed Kevlar gloves.  These are designed for protection first."),
    mass = "1344 g",
    volume = "1 L",
    price = "180 USD",
    survival_price = "30 USD",
    materials = { "kevlar", "steel" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        warmth = 15,
        thickness = 4,
        environmental_protection = 5,
        portions = {
            {
                encumbrance = 30,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r" },
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 100, thickness = 2.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 50, thickness = 2.0 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                materials = { { id = "kevlar", coverage = 100, thickness = 2.0 } },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 90, thickness = 2.0 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_hsurvivor",
    name = ccb.content.plural_text("heavy survivor gloves (pair)", "heavy survivor gloves (pair)"),
    copy_from = "gloves_hsurvivor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_hsurvivor",
    copy_from = "gloves_hsurvivor",
    name = ccb.content.plural_text("heavy survivor gloves (pair)", "heavy survivor gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_fsurvivor",
    category = "armor",
    name = ccb.content.plural_text("survivor firegloves (pair)", "survivor firegloves (pair)"),
    description = ccb.content.text("A pair of customized, Kevlar-armored Nomex gloves.  These are a post-apocalyptic extension of what firefighters wore pre-Cataclysm."),
    mass = "410 g",
    volume = "1 L",
    price = "180 USD",
    survival_price = "25 USD",
    materials = { "kevlar_layered", "nomex" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 10,
        portions = { { encumbrance = 30, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "xl_gloves_fsurvivor",
    name = ccb.content.plural_text("survivor firegloves (pair)", "survivor firegloves (pair)"),
    copy_from = "gloves_fsurvivor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_fsurvivor",
    copy_from = "gloves_fsurvivor",
    name = ccb.content.plural_text("survivor firegloves (pair)", "survivor firegloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hood_fsurvivor",
    category = "armor",
    name = ccb.content.text("survivor firehood"),
    description = ccb.content.text("A customized armored Nomex and Kevlar hood, strong and durable."),
    mass = "1220 g",
    volume = "1500 ml",
    price = "580 USD",
    survival_price = "40 USD",
    materials = { "kevlar_layered", "nomex" },
    symbol = "[",
    looks_like = "hood_survivor",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 15,
        thickness = 5,
        environmental_protection = 10,
        portions = { { encumbrance = 30, coverage = 100, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "xl_hood_fsurvivor",
    copy_from = "hood_fsurvivor",
    name = ccb.content.text("survivor firehood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hood_fsurvivor",
    copy_from = "hood_fsurvivor",
    name = ccb.content.text("survivor firehood"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "fsurvivor_suit",
    category = "armor",
    name = ccb.content.text("survivor firesuit"),
    description = ccb.content.text("Heavy, hand-built combination armor made from a cut-down bulletproof vest and a reinforced flame-resistant Nomex jumpsuit.  Protects the wearer from fire and the elements."),
    mass = "6800 g",
    volume = "11500 ml",
    price = "2 kUSD",
    survival_price = "50 USD",
    materials = { "kevlar_layered", "nomex" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "light_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "3 kg", moves = 120 },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "RAINPROOF", "STURDY", "OBSOLETE" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 10, 26 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 10, 14 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 10, 10 } },
        },
        warmth = 15,
        thickness = 4,
        valid_mods = { "steel_padded" },
        environmental_protection = 10,
    },
}

ccb.content.define_item {
    id = "xl_fsurvivor_suit",
    name = ccb.content.text("survivor firesuit"),
    copy_from = "fsurvivor_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_fsurvivor_suit",
    copy_from = "fsurvivor_suit",
    name = ccb.content.text("survivor firesuit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hsurvivor_suit",
    category = "armor",
    name = ccb.content.text("heavy survivor suit"),
    description = ccb.content.text("A heavy, hand-built combination armor made from a reinforced bulletproof vest and a metal-plated leather jumpsuit.  Protects from the elements as well as from harm."),
    mass = "15500 g",
    volume = "12 L",
    price = "2 kUSD",
    survival_price = "70 USD",
    materials = { "kevlar_layered", "steel", "leather" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "dark_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "3 kg", moves = 120 },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "HOOD", "RAINPROOF", "STURDY", "OBSOLETE" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 17, 31 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 17, 21 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 17, 17 } },
        },
        warmth = 15,
        thickness = 6,
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "xlhsurvivor_suit",
    copy_from = "hsurvivor_suit",
    name = ccb.content.text("heavy survivor suit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xshsurvivor_suit",
    copy_from = "hsurvivor_suit",
    name = ccb.content.text("heavy survivor suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lsurvivor_armor",
    category = "armor",
    name = ccb.content.text("mercenary body armor"),
    description = ccb.content.text("Custom-made armor that combines a level II vest with a combat shirt and adds extra padding to the arms for safety.  Fairly lightweight and ergonomic and has numerous pockets for storage."),
    mass = "3000 g",
    volume = "6 L",
    price = "600 USD",
    survival_price = "40 USD",
    materials = { "kevlar_layered", "kevlar", "nylon" },
    symbol = "[",
    looks_like = "combat_shirt",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            description = ccb.content.text("Shoulder pouch."),
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            description = ccb.content.text("Shoulder pouch."),
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            description = ccb.content.text("Reinforced pen pouch."),
            capacity = "10 ml",
            mass_limit = "150 g",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            description = ccb.content.text("Front torso pouch."),
            capacity = "250 ml",
            mass_limit = "500 g",
            max_item_length = "13 cm",
            moves = 150,
        },
        {
            kind = "CONTAINER",
            description = ccb.content.text("Front torso pouch."),
            capacity = "250 ml",
            mass_limit = "500 g",
            max_item_length = "13 cm",
            moves = 150,
        },
        {
            kind = "CONTAINER",
            description = ccb.content.text("Lower back pouch."),
            capacity = "1000 ml",
            mass_limit = "2500 g",
            max_item_length = "18 cm",
            moves = 250,
        },
    },
    flags = { "STURDY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.7 },
                    {
                        id = "kevlar_layered",
                        coverage = 95,
                        thickness = 3.3,
                        ignore_sheet_thickness = true,
                    },
                },
                encumbrance = { 4, 5 },
                coverage = 100,
                vitals_coverage = 70,
                covers = { "torso" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.3 },
                    { id = "kevlar", coverage = 90, thickness = 2.2 },
                },
                encumbrance = { 4, 5 },
                coverage = 100,
                vitals_coverage = 30,
                covers = { "arm_l", "arm_r" },
            },
        },
        warmth = 10,
        thickness = 4,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_lsurvivor_armor",
    name = ccb.content.text("mercenary body armor"),
    copy_from = "lsurvivor_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lsurvivor_armor",
    copy_from = "lsurvivor_armor",
    name = ccb.content.text("mercenary body armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lsurvivor_suit",
    category = "armor",
    name = ccb.content.text("light survivor suit"),
    description = ccb.content.text("A lightweight, hand-built combination armor made from a cut-down bulletproof vest and a reinforced fabric jumpsuit.  Protects from the elements as well as from harm."),
    mass = "5100 g",
    volume = "10500 ml",
    price = "1 kUSD 100 USD",
    survival_price = "50 USD",
    materials = { "kevlar_layered", "cotton" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "green",
    pockets = {
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "HOOD", "RAINPROOF", "STURDY", "OBSOLETE" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 7, 15 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 7, 7 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 7, 7 } },
        },
        warmth = 15,
        thickness = 4,
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "xl_lsurvivor_suit",
    name = ccb.content.text("light survivor suit"),
    copy_from = "lsurvivor_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "survivor_suit",
    category = "armor",
    name = ccb.content.text("survivor suit"),
    description = ccb.content.text("A hand-built combination armor made from a bulletproof vest and a reinforced leather jumpsuit.  Protects from the elements as well as from harm."),
    mass = "6800 g",
    volume = "11500 ml",
    price = "1 kUSD 500 USD",
    survival_price = "50 USD",
    materials = { "kevlar_layered", "leather" },
    symbol = "[",
    looks_like = "touring_suit",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "HOOD", "RAINPROOF", "STURDY", "OBSOLETE" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 12, 20 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 12, 17 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 12, 12 } },
        },
        warmth = 15,
        thickness = 4,
        valid_mods = { "steel_padded" },
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "xlsurvivor_suit",
    category = "armor",
    name = ccb.content.text("survivor suit"),
    description = ccb.content.text("A massive hand-built combination armor made from a bulletproof vest and a reinforced leather jumpsuit.  Protects from the elements as well as from harm."),
    mass = "12400 g",
    volume = "18 L",
    price = "1 kUSD 500 USD",
    survival_price = "40 USD",
    materials = { "kevlar_layered", "leather" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
    },
    flags = {
        "OVERSIZE",
        "PREFIX_XL",
        "VARSIZE",
        "WATERPROOF",
        "POCKETS",
        "HOOD",
        "RAINPROOF",
        "STURDY",
        "OBSOLETE",
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 17, 30 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 17, 22 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 17, 17 } },
        },
        warmth = 15,
        thickness = 4,
        valid_mods = { "steel_padded" },
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "wsurvivor_suit",
    category = "armor",
    name = ccb.content.text("winter survivor suit"),
    description = ccb.content.text("A warm and heavy hand-built combination armor made from a reinforced bulletproof vest and an insulated leather jumpsuit.  Protects from the elements as well as from harm."),
    mass = "7800 g",
    volume = "14 L",
    price = "2 kUSD",
    survival_price = "50 USD",
    materials = { "kevlar_layered", "fur" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "light_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "3 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "3 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "HOOD", "RAINPROOF", "STURDY", "OBSOLETE" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 20, 28 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 20, 25 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 20, 20 } },
        },
        warmth = 75,
        thickness = 5,
        valid_mods = { "steel_padded" },
        environmental_protection = 5,
    },
}

ccb.content.define_item {
    id = "xl_wsurvivor_suit",
    name = ccb.content.text("winter survivor suit"),
    copy_from = "wsurvivor_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "wsurvivor_suit_nofur",
    name = ccb.content.text("winter survivor suit"),
    description = ccb.content.text("A warm and heavy hand-built combination armor made from a reinforced bulletproof vest and a faux fur insulated leather jumpsuit.  Protects from the elements as well as from harm."),
    copy_from = "wsurvivor_suit",
    materials = { "kevlar_layered", "faux_fur" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "pink",
    armor = { warmth = 65 },
}

ccb.content.define_item {
    id = "xl_wsurvivor_suit_nofur",
    name = ccb.content.text("winter survivor suit"),
    copy_from = "wsurvivor_suit",
    materials = { "kevlar_layered", "faux_fur" },
    color = "pink",
    armor = { warmth = 65 },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "h20survivor_suit",
    category = "armor",
    name = ccb.content.text("survivor wetsuit"),
    description = ccb.content.text("A lightweight, hand-built combination armor made from a cut-down bulletproof vest and a reinforced neoprene wetsuit.  Protects from the elements as well as from harm."),
    mass = "6400 g",
    volume = "7 L",
    price = "1 kUSD 100 USD",
    survival_price = "50 USD",
    materials = { "kevlar", "plastic", "neoprene" },
    symbol = "[",
    looks_like = "wetsuit",
    color = "dark_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "6 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "3 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "3 L", mass_limit = "6 kg", moves = 200 },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "POCKETS", "HOOD", "RAINPROOF", "STURDY", "OBSOLETE" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 10, 16 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 10, 14 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 10, 10 } },
        },
        warmth = 15,
        thickness = 3,
        environmental_protection = 10,
    },
}
