local ccb = require("ccb")

ccb.content.define_item {
    id = "chainmail_junk_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "budget_steel_chain" },
    name = ccb.content.text("chainmail armor"),
    description = ccb.content.text("A fully customized chainmail suit.  The metal shows signs of rust and corrosion.  Combine with a gambeson or other padded layer for optimal protection."),
    armor = {
        portions = {
            {
                materials = { { id = "budget_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 97,
                encumbrance = 14,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_suit",
    copy_from = "base_chainmail_suit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_suit",
    copy_from = "xl_chainmail_suit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_suit_xs",
    copy_from = "xs_chainmail_suit",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail armor"),
    armor = {},
}

ccb.content.define_item {
    id = "chainmail_suit_faraday",
    copy_from = "qt_chainmail_suit",
    name = ccb.content.text("faraday chainmail suit"),
    description = ccb.content.text("A fully customized chainmail suit that can be worn over your normal clothing.  The suit is conductively interconnected with a cage covering the face, protecting against electricity."),
    armor = {
        portions = {
            {
                materials = { { id = "qt_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = { { id = "qt_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head" },
                coverage = 100,
                encumbrance = 30,
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "cotton", coverage = 100, thickness = 0.001 },
                },
                covers = { "eyes" },
                coverage = 95,
                ranged_coverage = 10,
                encumbrance = 2,
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "cotton", coverage = 100, thickness = 0.001 },
                },
                covers = { "mouth", "muzzle", "beak" },
                coverage = 95,
                ranged_coverage = 10,
                encumbrance = 0,
                breathability = "GOOD",
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "qt_steel_chain", coverage = 100, thickness = 1.2 } },
                encumbrance = 10,
                coverage = 100,
            },
        },
    },
    inheritance = { add = { flags = { "ELECTRIC_IMMUNE" } } },
}

ccb.content.define_item {
    id = "xl_chainmail_suit_faraday",
    copy_from = "chainmail_suit_faraday",
    name = ccb.content.text("faraday chainmail suit"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
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
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "chainmail_suit_faraday_xs",
    copy_from = "chainmail_suit_faraday",
    looks_like = "chainmail_suit_faraday",
    name = ccb.content.text("faraday chainmail suit"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
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
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Should be somewhat more difficult to repair than ordinary plastic
ccb.content.define_item {
    id = "cleansuit",
    repair_like = "bunker_coat",
    name = ccb.content.text("cleansuit"),
    description = ccb.content.text("A simple hazardous materials handling suit.  Though somewhat restrictive and fragile, wearing it will provide excellent protection against ambient radiation."),
    mass = "2100 g",
    volume = "2500 ml",
    price = "77 USD",
    survival_price = "12 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "white",
    length = "12 cm",
    flags = { "VARSIZE", "WATERPROOF", "HOOD", "RAINPROOF", "RAD_RESIST", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 1,
        environmental_protection = 10,
        portions = {
            {
                encumbrance = 25,
                coverage = 100,
                covers = { "leg_l", "leg_r", "foot_l", "foot_r", "head", "torso", "arm_l", "arm_r" },
            },
        },
    },
}
