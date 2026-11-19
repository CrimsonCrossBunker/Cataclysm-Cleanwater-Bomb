local ccb = require("ccb")

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
