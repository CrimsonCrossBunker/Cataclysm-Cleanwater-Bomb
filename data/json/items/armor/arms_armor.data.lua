local ccb = require("ccb")

ccb.content.define_item {
    id = "xl_chainmail_arms",
    abstract = true,
    copy_from = "base_chainmail_arms",
    name = ccb.content.plural_text("chainmail sleeves (pair)", "chainmail sleeves (pair)"),
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
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
    },
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_chainmail_arms",
    abstract = true,
    copy_from = "base_chainmail_arms",
    name = ccb.content.plural_text("chainmail sleeves (pair)", "chainmail sleeves (pair)"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "550 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
    },
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "chainmail_junk_arms",
    copy_from = "base_chainmail_arms",
    replace_materials = { steel = "budget_steel_chain" },
    name = ccb.content.plural_text("chainmail sleeves (pair)", "chainmail sleeves (pair)"),
    description = ccb.content.text("Customized chainmail arm protection.  The metal shows signs of rust and corrosion.  Both sleeves have straps to connect them with each other.  They don't cover the hands, making them less cumbersome and allowing them to be worn with gloves."),
    armor = {
        portions = {
            {
                materials = { { id = "budget_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_r", "arm_lower_l", "arm_shoulder_r", "arm_shoulder_l" },
                coverage = 95,
                encumbrance = 14,
            },
            {
                materials = { { id = "budget_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r", "arm_upper_l", "arm_upper_r" },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_arms",
    copy_from = "base_chainmail_arms",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail sleeves (pair)", "mild steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_arms",
    copy_from = "xl_chainmail_arms",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail sleeves (pair)", "mild steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_lc_chainmail_arms",
    copy_from = "xs_chainmail_arms",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.plural_text("mild steel chainmail sleeves (pair)", "mild steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_arms",
    copy_from = "base_chainmail_arms",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail sleeves (pair)", "medium steel chainmail sleeves (pair)"),
    armor = {
        portions = {
            {
                materials = { { id = "mc_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_chainmail_arms",
    copy_from = "xl_chainmail_arms",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail sleeves (pair)", "medium steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_mc_chainmail_arms",
    copy_from = "xs_chainmail_arms",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.plural_text("medium steel chainmail sleeves (pair)", "medium steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_arms",
    copy_from = "base_chainmail_arms",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail sleeves (pair)", "high steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_arms",
    copy_from = "xl_chainmail_arms",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail sleeves (pair)", "high steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_hc_chainmail_arms",
    copy_from = "xs_chainmail_arms",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.plural_text("high steel chainmail sleeves (pair)", "high steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_arms",
    copy_from = "base_chainmail_arms",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail sleeves (pair)", "hardened steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_arms",
    copy_from = "xl_chainmail_arms",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail sleeves (pair)", "hardened steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_ch_chainmail_arms",
    copy_from = "xs_chainmail_arms",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.plural_text("hardened steel chainmail sleeves (pair)", "hardened steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_arms",
    copy_from = "base_chainmail_arms",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail sleeves (pair)", "tempered steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_arms",
    copy_from = "xl_chainmail_arms",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail sleeves (pair)", "tempered steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_qt_chainmail_arms",
    copy_from = "xs_chainmail_arms",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.plural_text("tempered steel chainmail sleeves (pair)", "tempered steel chainmail sleeves (pair)"),
    armor = {},
}

ccb.content.define_item {
    id = "elbow_pads",
    category = "armor",
    name = ccb.content.plural_text("elbow pads (pair)", "elbow pads (pair)"),
    description = ccb.content.text("A pair of elbow pads made of stout plastic and cloth."),
    mass = "110 g",
    volume = "750 ml",
    price = "35 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "cotton" },
    symbol = "[",
    looks_like = "armguard_hard",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "OUTER" },
    armor = {
        thickness = 5,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 0,
                coverage = 90,
                melee_coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 90,
                subparts = { "arm_elbow_r", "arm_elbow_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "armguard_bronze",
    category = "armor",
    name = ccb.content.plural_text("bronze vambraces (pair)", "bronze vambraces (pair)"),
    description = ccb.content.text("A pair of bronze arm guards with a simple leather lining."),
    mass = "2270 g",
    volume = "5250 ml",
    price = "400 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "bronze", "leather" },
    symbol = "[",
    looks_like = "armor_lc_armguard",
    color = "yellow",
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 15,
        thickness = 4,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 5,
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
    id = "xl_armguard_bronze",
    copy_from = "armguard_bronze",
    name = ccb.content.plural_text("bronze vambraces (pair)", "bronze vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armguard_bronze",
    copy_from = "armguard_bronze",
    name = ccb.content.plural_text("bronze vambraces (pair)", "bronze vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "vambrace_larmor",
    category = "armor",
    name = ccb.content.plural_text("leather vambraces (pair)", "leather vambraces (pair)"),
    description = ccb.content.text("A pair of light leather arm guards, made for archery."),
    mass = "362 g",
    volume = "1 L",
    price = "20 USD",
    survival_price = "5 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "armguard_larmor",
    color = "brown",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 2,
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
    id = "xl_vambrace_larmor",
    name = ccb.content.plural_text("leather vambraces (pair)", "leather vambraces (pair)"),
    mass = "531 g",
    volume = "1250 ml",
    copy_from = "vambrace_larmor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xs_vambrace_larmor",
    copy_from = "vambrace_larmor",
    looks_like = "vambrace_larmor",
    name = ccb.content.plural_text("leather vambraces (pair)", "leather vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_cut_resistant",
    name = ccb.content.plural_text("cut-resistant arm sleeves (pair)", "cut-resistant arm sleeves (pair)"),
    description = ccb.content.text("A long pair of cut-resistant Kevlar sleeves with thumbholes.  Useful for chainsaw protection."),
    mass = "450 g",
    copy_from = "armguard_soft",
    price = "12 USD",
    materials = { "kevlar" },
    armor = {},
}

ccb.content.define_item {
    id = "armor_lc_lightarmguard",
    category = "armor",
    name = ccb.content.text("mild steel light arm guard"),
    description = ccb.content.text("A light armguard, 1.25 mm at the thickest.  This one has been made with mild steel."),
    mass = "2500 g",
    volume = "2916 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    symbol = "[",
    looks_like = "armguard_metal",
    materials = { "lc_steel", "lc_steel_chain" },
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        sided = true,
        thickness = 2,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 0.75 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r" },
                coverage = 100,
                vitals_coverage = 85,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 0.7 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
                coverage = 100,
                vitals_coverage = 80,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 0.75 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 100,
                encumbrance = 8,
                vitals_coverage = 95,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_lightarmguard",
    name = ccb.content.text("mild steel light arm guard"),
    copy_from = "armor_lc_lightarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_lightarmguard",
    copy_from = "armor_lc_lightarmguard",
    materials = { "mc_steel", "mc_steel_chain" },
    name = ccb.content.text("medium steel light arm guard"),
    description = ccb.content.text("A light armguard, 1.25 mm at the thickest.  Made with tougher medium steel, this offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_lightarmguard",
    name = ccb.content.text("medium steel light arm guard"),
    copy_from = "armor_mc_lightarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_lightarmguard",
    copy_from = "armor_lc_lightarmguard",
    materials = { "hc_steel", "hc_steel_chain" },
    name = ccb.content.text("high steel light arm guard"),
    description = ccb.content.text("A light armguard, 1.25 mm at the thickest.  Made with high steel offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_lightarmguard",
    name = ccb.content.text("high steel light arm guard"),
    copy_from = "armor_hc_lightarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_lightarmguard",
    copy_from = "armor_lc_lightarmguard",
    materials = { "ch_steel", "ch_steel_chain" },
    name = ccb.content.text("hardened steel light arm guard"),
    description = ccb.content.text("A light armguard, 1.25 mm at the thickest.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_lightarmguard",
    name = ccb.content.text("hardened steel light arm guard"),
    copy_from = "armor_ch_lightarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_lightarmguard",
    copy_from = "armor_lc_lightarmguard",
    materials = { "qt_steel", "qt_steel_chain" },
    name = ccb.content.text("tempered steel light arm guard"),
    description = ccb.content.text("A light armguard, 1.25 mm at the thickest.  The medium steel has been quenched and tempered, offering top of the line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_lightarmguard",
    name = ccb.content.text("tempered steel light arm guard"),
    copy_from = "armor_qt_lightarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_armguard",
    category = "armor",
    name = ccb.content.text("mild steel arm guard"),
    description = ccb.content.text("An armguard, 1.75 mm at the thickest.  This one has been made with mild steel."),
    mass = "3333 g",
    volume = "2916 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    symbol = "[",
    looks_like = "armguard_larmor",
    materials = { "lc_steel", "lc_steel_chain" },
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
                    { id = "lc_steel", coverage = 97, thickness = 1.15 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 100,
                vitals_coverage = 100,
                encumbrance = 10,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 94, thickness = 1.15 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r", "arm_elbow_l", "arm_elbow_r" },
                coverage = 100,
                vitals_coverage = 90,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_armguard",
    name = ccb.content.text("mild steel arm guard"),
    copy_from = "armor_lc_armguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_armguard",
    copy_from = "armor_lc_armguard",
    name = ccb.content.text("medium steel arm guard"),
    description = ccb.content.text("An armguard, 1.75 mm at the thickest.  Made with tougher medium steel, this offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_armguard",
    name = ccb.content.text("medium steel arm guard"),
    copy_from = "armor_mc_armguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_armguard",
    copy_from = "armor_lc_armguard",
    name = ccb.content.text("high steel arm guard"),
    materials = { "hc_steel", "hc_steel_chain" },
    description = ccb.content.text("An armguard, 1.75 mm at the thickest.  Made with high steel offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_armguard",
    name = ccb.content.text("high steel arm guard"),
    copy_from = "armor_hc_armguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_armguard",
    copy_from = "armor_lc_armguard",
    materials = { "ch_steel", "ch_steel_chain" },
    name = ccb.content.text("hardened steel arm guard"),
    description = ccb.content.text("An armguard, 1.75 mm at the thickest.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_armguard",
    name = ccb.content.text("hardened steel arm guard"),
    copy_from = "armor_ch_armguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_armguard",
    copy_from = "armor_lc_armguard",
    name = ccb.content.text("tempered steel arm guard"),
    materials = { "qt_steel", "qt_steel_chain" },
    description = ccb.content.text("An armguard, 1.75 mm at the thickest.  The medium steel has been quenched and tempered, offering top of the line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_armguard",
    name = ccb.content.text("tempered steel arm guard"),
    copy_from = "armor_qt_armguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_heavyarmguard",
    category = "armor",
    name = ccb.content.text("mild steel heavy arm guard"),
    description = ccb.content.text("A heavy armguard, 2.25 mm at the thickest.  This one has been made with mild steel."),
    mass = "4166 g",
    volume = "2916 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "lc_steel", "lc_steel_chain" },
    symbol = "[",
    looks_like = "armguard_larmor",
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
                    { id = "lc_steel", coverage = 100, thickness = 1.65 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                vitals_coverage = 100,
                coverage = 100,
                encumbrance = 15,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 96, thickness = 1.65 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r", "arm_elbow_l", "arm_elbow_r" },
                coverage = 100,
                vitals_coverage = 95,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_heavyarmguard",
    name = ccb.content.text("mild steel heavy arm guard"),
    copy_from = "armor_lc_heavyarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_heavyarmguard",
    copy_from = "armor_lc_heavyarmguard",
    name = ccb.content.text("medium steel heavy arm guard"),
    description = ccb.content.text("A heavy armguard, 2.25 mm at the thickest.  Made with tougher medium steel, this offers solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_heavyarmguard",
    name = ccb.content.text("medium steel heavy arm guard"),
    copy_from = "armor_mc_heavyarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_heavyarmguard",
    copy_from = "armor_lc_heavyarmguard",
    name = ccb.content.text("high steel heavy arm guard"),
    description = ccb.content.text("A heavy armguard, 2.25 mm at the thickest.  Made with high steel offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_heavyarmguard",
    name = ccb.content.text("high steel heavy arm guard"),
    copy_from = "armor_hc_heavyarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_heavyarmguard",
    copy_from = "armor_lc_heavyarmguard",
    name = ccb.content.text("hardened steel heavy arm guard"),
    description = ccb.content.text("A heavy armguard, 2.25 mm at the thickest.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_heavyarmguard",
    name = ccb.content.text("hardened steel heavy arm guard"),
    copy_from = "armor_ch_heavyarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_heavyarmguard",
    copy_from = "armor_lc_heavyarmguard",
    name = ccb.content.text("tempered steel heavy arm guard"),
    description = ccb.content.text("A heavy armguard, 2.25 mm at the thickest.  The medium steel has been quenched and tempered, offering top of the line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_heavyarmguard",
    name = ccb.content.text("tempered steel heavy arm guard"),
    copy_from = "armor_qt_heavyarmguard",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "survivor_adhoc_leather_sleeves",
    category = "armor",
    name = ccb.content.plural_text("leather-padded sleeves", "leather-padded sleeves"),
    description = ccb.content.text("Armor made of combined pre-Cataclysm clothing.  Sections from leather clothing are tightened and affixed to the sleeves of a thick cotton shirt, excluding the joints."),
    mass = "300 g",
    volume = "500 ml",
    survival_price = "10 USD",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "armguard_soft",
    color = "light_red",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                materials = { { id = "cotton", coverage = 100, thickness = 1.0 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 50,
                encumbrance = 0,
            },
            {
                materials = { { id = "cotton", coverage = 100, thickness = 1.0 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 95, thickness = 1.5 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r" },
                coverage = 100,
                encumbrance = 8,
            },
        },
        warmth = 35,
        thickness = 2.5,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "armor_riot_arm",
    category = "armor",
    name = ccb.content.plural_text("riot arm guards (pair)", "riot arm guards (pair)"),
    description = ccb.content.text("Hard arm guards used by riot police."),
    mass = "500 g",
    volume = "2500 ml",
    price = "100 USD",
    survival_price = "7 USD 50 cent",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "armguard_hard",
    color = "dark_gray",
    length = "40 cm",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "PADDED", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 20,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 3,
                coverage = 90,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 5 },
                    { id = "thermo_resin", coverage = 90, thickness = 1.75 },
                },
                subparts = { "arm_lower_l", "arm_lower_r", "arm_elbow_l", "arm_elbow_r" },
            },
        },
    },
}
