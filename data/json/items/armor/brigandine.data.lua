local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_lc_brigandine",
    category = "armor",
    name = ccb.content.text("mild steel brigandine"),
    description = ccb.content.text("A vest made from tough fabric with steel plates riveted on the inside.  Can be comfortably worn over chainmail for extra protection."),
    mass = "6873 g",
    volume = "6137 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "canvas" },
    melee_damage = { bash = 6 },
    symbol = "[",
    looks_like = "armor_cuirass",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "VARSIZE" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "3 L",
            mass_limit = "3000 g",
            max_item_length = "60 cm",
            moves = 3000,
            description = ccb.content.text("Attachment for additional plating placed on top."),
            allowed_flags = { "EXTRA_PLATING" },
        },
    },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_brigandine",
    copy_from = "armor_lc_brigandine",
    name = ccb.content.text("mild steel brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_brigandine_xs",
    copy_from = "armor_lc_brigandine",
    name = ccb.content.text("mild steel brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_lc_brigandine_shoulders",
    category = "armor",
    name = ccb.content.plural_text("mild steel brigandine with shoulder guards", "mild steel brigandines with shoulder guards"),
    description = ccb.content.text("A vest made from tough fabric with steel plates riveted on the inside, with shoulder guards attached to it.  Can be comfortably worn over chainmail for extra protection."),
    mass = "7311 g",
    volume = "6593 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "lc_steel", "canvas" },
    melee_damage = { bash = 6 },
    symbol = "[",
    looks_like = "armor_lamellar",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "VARSIZE" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "3 L",
            mass_limit = "3000 g",
            max_item_length = "60 cm",
            moves = 3000,
            description = ccb.content.text("Attachment for additional plating placed on top."),
            allowed_flags = { "EXTRA_PLATING" },
        },
    },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 12,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 80,
                vitals_coverage = 100,
                encumbrance = 4,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_brigandine_shoulders",
    copy_from = "armor_lc_brigandine_shoulders",
    name = ccb.content.plural_text("mild steel brigandine with shoulder guards", "mild steel brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_brigandine_shoulders_xs",
    copy_from = "armor_lc_brigandine_shoulders",
    name = ccb.content.plural_text("mild steel brigandine with shoulder guards", "mild steel brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_lc_coat_brigandine",
    category = "armor",
    name = ccb.content.text("mild steel brigandine coat"),
    description = ccb.content.text("A coat made from tough fabric with steel plates riveted on the inside.  Can be comfortably worn over chainmail for extra protection."),
    mass = "7646 g",
    volume = "6880 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "lc_steel", "canvas" },
    melee_damage = { bash = 6 },
    symbol = "[",
    looks_like = "sleeveless_duster",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "VARSIZE", "ALLOWS_TAIL" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "3 L",
            mass_limit = "3000 g",
            max_item_length = "60 cm",
            moves = 3000,
            description = ccb.content.text("Attachment for additional plating placed on top."),
            allowed_flags = { "EXTRA_PLATING" },
        },
    },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 12,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 85,
                vitals_coverage = 100,
                encumbrance = 4,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_coat_brigandine",
    copy_from = "armor_lc_coat_brigandine",
    name = ccb.content.text("mild steel brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_coat_brigandine_xs",
    copy_from = "armor_lc_coat_brigandine",
    name = ccb.content.text("mild steel brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_lc_coat_brigandine_shoulders",
    category = "armor",
    name = ccb.content.plural_text("mild steel brigandine coat with shoulder guards", "mild steel brigandine coats with shoulder guards"),
    description = ccb.content.text("A coat made from tough fabric with steel plates riveted on the inside, with shoulder guards attached to it.  Can be comfortably worn over chainmail for extra protection."),
    mass = "8084 g",
    volume = "7336 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "lc_steel", "canvas" },
    melee_damage = { bash = 6 },
    symbol = "[",
    looks_like = "duster",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "VARSIZE", "ALLOWS_TAIL" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "3 L",
            mass_limit = "3000 g",
            max_item_length = "60 cm",
            moves = 3000,
            description = ccb.content.text("Attachment for additional plating placed on top."),
            allowed_flags = { "EXTRA_PLATING" },
        },
    },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 12,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 85,
                vitals_coverage = 100,
                encumbrance = 4,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 80,
                vitals_coverage = 100,
                encumbrance = 4,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_coat_brigandine_shoulders",
    copy_from = "armor_lc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("mild steel brigandine coat with shoulder guards", "mild steel brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_coat_brigandine_shoulders_xs",
    copy_from = "armor_lc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("mild steel brigandine coat with shoulder guards", "mild steel brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_mc_brigandine",
    name = ccb.content.text("medium steel brigandine"),
    copy_from = "armor_lc_brigandine",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_brigandine",
    copy_from = "armor_mc_brigandine",
    name = ccb.content.text("medium steel brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_brigandine_xs",
    copy_from = "armor_mc_brigandine",
    name = ccb.content.text("medium steel brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_mc_brigandine_shoulders",
    name = ccb.content.plural_text("medium steel brigandine with shoulder guards", "medium steel brigandines with shoulder guards"),
    copy_from = "armor_lc_brigandine_shoulders",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_brigandine_shoulders",
    copy_from = "armor_mc_brigandine_shoulders",
    name = ccb.content.plural_text("medium steel brigandine with shoulder guards", "medium steel brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_brigandine_shoulders_xs",
    copy_from = "armor_mc_brigandine_shoulders",
    name = ccb.content.plural_text("medium steel brigandine with shoulder guards", "medium steel brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_mc_coat_brigandine",
    name = ccb.content.text("medium steel brigandine coat"),
    copy_from = "armor_lc_coat_brigandine",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_coat_brigandine",
    copy_from = "armor_mc_coat_brigandine",
    name = ccb.content.text("medium steel brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_coat_brigandine_xs",
    copy_from = "armor_mc_coat_brigandine",
    name = ccb.content.text("medium steel brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_mc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("medium steel brigandine coat with shoulder guards", "medium steel brigandine coats with shoulder guards"),
    copy_from = "armor_lc_coat_brigandine_shoulders",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_coat_brigandine_shoulders",
    copy_from = "armor_mc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("medium steel brigandine coat with shoulder guards", "medium steel brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_coat_brigandine_shoulders_xs",
    copy_from = "armor_mc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("medium steel brigandine coat with shoulder guards", "medium steel brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_hc_brigandine",
    name = ccb.content.text("high steel brigandine"),
    copy_from = "armor_lc_brigandine",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_brigandine",
    copy_from = "armor_hc_brigandine",
    name = ccb.content.text("high steel brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_brigandine_xs",
    copy_from = "armor_hc_brigandine",
    name = ccb.content.text("high steel brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_hc_brigandine_shoulders",
    name = ccb.content.plural_text("high steel brigandine with shoulder guards", "high steel brigandines with shoulder guards"),
    copy_from = "armor_lc_brigandine_shoulders",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_brigandine_shoulders",
    copy_from = "armor_hc_brigandine_shoulders",
    name = ccb.content.plural_text("high steel brigandine with shoulder guards", "high steel brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_brigandine_shoulders_xs",
    copy_from = "armor_hc_brigandine_shoulders",
    name = ccb.content.plural_text("high steel brigandine with shoulder guards", "high steel brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_hc_coat_brigandine",
    name = ccb.content.text("high steel brigandine coat"),
    copy_from = "armor_lc_coat_brigandine",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_coat_brigandine",
    copy_from = "armor_hc_coat_brigandine",
    name = ccb.content.text("high steel brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_coat_brigandine_xs",
    copy_from = "armor_hc_coat_brigandine",
    name = ccb.content.text("high steel brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_hc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("high steel brigandine coat with shoulder guards", "high steel brigandine coats with shoulder guards"),
    copy_from = "armor_lc_coat_brigandine_shoulders",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_coat_brigandine_shoulders",
    copy_from = "armor_hc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("high steel brigandine coat with shoulder guards", "high steel brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_coat_brigandine_shoulders_xs",
    copy_from = "armor_hc_coat_brigandine_shoulders",
    name = ccb.content.plural_text("high steel brigandine coat with shoulder guards", "high steel brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_ch_brigandine",
    name = ccb.content.text("hardened brigandine"),
    copy_from = "armor_lc_brigandine",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_brigandine",
    copy_from = "armor_ch_brigandine",
    name = ccb.content.text("hardened brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_brigandine_xs",
    copy_from = "armor_ch_brigandine",
    name = ccb.content.text("hardened brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_ch_brigandine_shoulders",
    name = ccb.content.plural_text("hardened brigandine with shoulder guards", "hardened brigandines with shoulder guards"),
    copy_from = "armor_lc_brigandine_shoulders",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_brigandine_shoulders",
    copy_from = "armor_ch_brigandine_shoulders",
    name = ccb.content.plural_text("hardened brigandine with shoulder guards", "hardened brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_brigandine_shoulders_xs",
    copy_from = "armor_ch_brigandine_shoulders",
    name = ccb.content.plural_text("hardened brigandine with shoulder guards", "hardened brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_ch_coat_brigandine",
    name = ccb.content.text("hardened brigandine coat"),
    copy_from = "armor_lc_coat_brigandine",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_coat_brigandine",
    copy_from = "armor_ch_coat_brigandine",
    name = ccb.content.text("hardened brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_coat_brigandine_xs",
    copy_from = "armor_ch_coat_brigandine",
    name = ccb.content.text("hardened brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_ch_coat_brigandine_shoulders",
    name = ccb.content.plural_text("hardened brigandine coat with shoulder guards", "hardened brigandine coats with shoulder guards"),
    copy_from = "armor_lc_coat_brigandine_shoulders",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_coat_brigandine_shoulders",
    copy_from = "armor_ch_coat_brigandine_shoulders",
    name = ccb.content.plural_text("hardened brigandine coat with shoulder guards", "hardened brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_coat_brigandine_shoulders_xs",
    copy_from = "armor_ch_coat_brigandine_shoulders",
    name = ccb.content.plural_text("hardened brigandine coat with shoulder guards", "hardened brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_qt_brigandine",
    name = ccb.content.text("tempered brigandine"),
    copy_from = "armor_lc_brigandine",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_brigandine",
    copy_from = "armor_qt_brigandine",
    name = ccb.content.text("tempered brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_brigandine_xs",
    copy_from = "armor_qt_brigandine",
    name = ccb.content.text("tempered brigandine"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_qt_brigandine_shoulders",
    name = ccb.content.plural_text("tempered brigandine with shoulder guards", "tempered brigandines with shoulder guards"),
    copy_from = "armor_lc_brigandine_shoulders",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_brigandine_shoulders",
    copy_from = "armor_qt_brigandine_shoulders",
    name = ccb.content.plural_text("tempered brigandine with shoulder guards", "tempered brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_brigandine_shoulders_xs",
    copy_from = "armor_qt_brigandine_shoulders",
    name = ccb.content.plural_text("tempered brigandine with shoulder guards", "tempered brigandines with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_qt_coat_brigandine",
    name = ccb.content.text("tempered brigandine coat"),
    copy_from = "armor_lc_coat_brigandine",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_coat_brigandine",
    copy_from = "armor_qt_coat_brigandine",
    name = ccb.content.text("tempered brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_coat_brigandine_xs",
    copy_from = "armor_qt_coat_brigandine",
    name = ccb.content.text("tempered brigandine coat"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_qt_coat_brigandine_shoulders",
    name = ccb.content.plural_text("tempered brigandine coat with shoulder guards", "tempered brigandine coats with shoulder guards"),
    copy_from = "armor_lc_coat_brigandine_shoulders",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_coat_brigandine_shoulders",
    copy_from = "armor_qt_coat_brigandine_shoulders",
    name = ccb.content.plural_text("tempered brigandine coat with shoulder guards", "tempered brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_coat_brigandine_shoulders_xs",
    copy_from = "armor_qt_coat_brigandine_shoulders",
    name = ccb.content.plural_text("tempered brigandine coat with shoulder guards", "tempered brigandine coats with shoulder guards"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_lc_brigandine",
    category = "armor",
    name = ccb.content.plural_text("mild steel splint arm guards (pair)", "mild steel splint arm guards (pair)"),
    description = ccb.content.text("A pair of arm guards made of tough fabric sandwiched between alternating strips of steel.  Can be comfortably worn over chainmail for extra protection."),
    mass = "1744 g",
    volume = "2138 ml",
    length = "30 cm",
    price = "300 USD",
    survival_price = "10 USD",
    materials = { "lc_steel", "canvas" },
    symbol = "[",
    looks_like = "armguard_hard",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "STURDY", "ABLATIVE_CHAINMAIL_ARMS", "VARSIZE" },
    armor = {
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 90, thickness = 0.8 },
                },
                covers = { "arm_l", "arm_r" },
                encumbrance = 6,
                coverage = 100,
                melee_coverage = 100,
                ranged_coverage = 100,
                vitals_coverage = 90,
                subparts = { "arm_lower_r", "arm_lower_l", "arm_upper_r", "arm_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armguard_lc_brigandine",
    copy_from = "armguard_lc_brigandine",
    name = ccb.content.plural_text("mild steel splint arm guards (pair)", "mild steel splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armguard_lc_brigandine_xs",
    copy_from = "armguard_lc_brigandine",
    name = ccb.content.plural_text("mild steel splint arm guards (pair)", "mild steel splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_mc_brigandine",
    name = ccb.content.plural_text("medium steel splint arm guards (pair)", "medium steel splint arm guards (pair)"),
    copy_from = "armguard_lc_brigandine",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armguard_mc_brigandine",
    copy_from = "armguard_mc_brigandine",
    name = ccb.content.plural_text("medium steel splint arm guards (pair)", "medium steel splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armguard_mc_brigandine_xs",
    copy_from = "armguard_mc_brigandine",
    name = ccb.content.plural_text("medium steel splint arm guards (pair)", "medium steel splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_hc_brigandine",
    name = ccb.content.plural_text("high steel splint arm guards (pair)", "high steel splint arm guards (pair)"),
    copy_from = "armguard_lc_brigandine",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armguard_hc_brigandine",
    copy_from = "armguard_hc_brigandine",
    name = ccb.content.plural_text("high steel splint arm guards (pair)", "high steel splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armguard_hc_brigandine_xs",
    copy_from = "armguard_hc_brigandine",
    name = ccb.content.plural_text("high steel splint arm guards (pair)", "high steel splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_ch_brigandine",
    name = ccb.content.plural_text("hardened splint arm guards (pair)", "hardened splint arm guards (pair)"),
    copy_from = "armguard_lc_brigandine",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armguard_ch_brigandine",
    copy_from = "armguard_ch_brigandine",
    name = ccb.content.plural_text("hardened splint arm guards (pair)", "hardened splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armguard_ch_brigandine_xs",
    copy_from = "armguard_ch_brigandine",
    name = ccb.content.plural_text("hardened splint arm guards (pair)", "hardened splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armguard_qt_brigandine",
    name = ccb.content.plural_text("tempered splint arm guards (pair)", "tempered splint arm guards (pair)"),
    copy_from = "armguard_lc_brigandine",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armguard_qt_brigandine",
    copy_from = "armguard_qt_brigandine",
    name = ccb.content.plural_text("tempered splint arm guards (pair)", "tempered splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armguard_qt_brigandine_xs",
    copy_from = "armguard_qt_brigandine",
    name = ccb.content.plural_text("tempered splint arm guards (pair)", "tempered splint arm guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_lc_brigandine",
    category = "armor",
    name = ccb.content.plural_text("mild steel splint leg guards (pair)", "mild steel splint leg guards (pair)"),
    description = ccb.content.text("A pair of leg guards made of tough fabric sandwiched between alternating strips of steel.  Can be comfortably worn over chainmail for extra protection."),
    mass = "2674 g",
    volume = "3278 ml",
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "lc_steel", "canvas" },
    symbol = "[",
    looks_like = "armor_lc_leg_guard",
    color = "light_gray",
    flags = { "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_LEGS", "VARSIZE" },
    armor = {
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 90, thickness = 0.8 },
                },
                covers = { "leg_l", "leg_r" },
                encumbrance = 6,
                coverage = 100,
                melee_coverage = 100,
                ranged_coverage = 100,
                vitals_coverage = 90,
                subparts = { "leg_lower_r", "leg_lower_l", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_legguard_lc_brigandine",
    copy_from = "legguard_lc_brigandine",
    name = ccb.content.plural_text("mild steel splint leg guards (pair)", "mild steel splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "legguard_lc_brigandine_xs",
    copy_from = "legguard_lc_brigandine",
    name = ccb.content.plural_text("mild steel splint leg guards (pair)", "mild steel splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_mc_brigandine",
    name = ccb.content.plural_text("medium steel splint leg guards (pair)", "medium steel splint leg guards (pair)"),
    copy_from = "legguard_lc_brigandine",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_legguard_mc_brigandine",
    copy_from = "legguard_mc_brigandine",
    name = ccb.content.plural_text("medium steel splint leg guards (pair)", "medium steel splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "legguard_mc_brigandine_xs",
    copy_from = "legguard_mc_brigandine",
    name = ccb.content.plural_text("medium steel splint leg guards (pair)", "medium steel splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_hc_brigandine",
    name = ccb.content.plural_text("high steel splint leg guards (pair)", "high steel splint leg guards (pair)"),
    copy_from = "legguard_lc_brigandine",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_legguard_hc_brigandine",
    copy_from = "legguard_hc_brigandine",
    name = ccb.content.plural_text("high steel splint leg guards (pair)", "high steel splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "legguard_hc_brigandine_xs",
    copy_from = "legguard_hc_brigandine",
    name = ccb.content.plural_text("high steel splint leg guards (pair)", "high steel splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_ch_brigandine",
    name = ccb.content.plural_text("hardened splint leg guards (pair)", "hardened splint leg guards (pair)"),
    copy_from = "legguard_lc_brigandine",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_legguard_ch_brigandine",
    copy_from = "legguard_ch_brigandine",
    name = ccb.content.plural_text("hardened splint leg guards (pair)", "hardened splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "legguard_ch_brigandine_xs",
    copy_from = "legguard_ch_brigandine",
    name = ccb.content.plural_text("hardened splint leg guards (pair)", "hardened splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "legguard_qt_brigandine",
    name = ccb.content.plural_text("tempered splint leg guards (pair)", "tempered splint leg guards (pair)"),
    copy_from = "legguard_lc_brigandine",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_legguard_qt_brigandine",
    copy_from = "legguard_qt_brigandine",
    name = ccb.content.plural_text("tempered splint leg guards (pair)", "tempered splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "legguard_qt_brigandine_xs",
    copy_from = "legguard_qt_brigandine",
    name = ccb.content.plural_text("tempered splint leg guards (pair)", "tempered splint leg guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lc_vambrace_brigandine",
    category = "armor",
    name = ccb.content.plural_text("mild steel splint vambraces (pair)", "mild steel splint vambraces (pair)"),
    description = ccb.content.text("A pair of vambraces made of tough fabric sandwiched between alternating strips of steel.  Can be comfortably worn over chainmail for extra protection."),
    mass = "600 g",
    volume = "1400 ml",
    length = "12 cm",
    price = "300 USD",
    survival_price = "10 USD",
    materials = { "lc_steel", "canvas" },
    symbol = "[",
    looks_like = "armguard_bronze",
    color = "light_gray",
    flags = { "OUTER", "BLOCK_WHILE_WORN", "STURDY", "ABLATIVE_CHAINMAIL_ARMS", "VARSIZE" },
    armor = {
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 90, thickness = 0.8 },
                },
                covers = { "arm_l", "arm_r" },
                encumbrance = 4,
                coverage = 100,
                melee_coverage = 100,
                ranged_coverage = 100,
                vitals_coverage = 90,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_vambrace_brigandine",
    copy_from = "lc_vambrace_brigandine",
    name = ccb.content.plural_text("mild steel splint vambraces (pair)", "mild steel splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_vambrace_brigandine",
    copy_from = "lc_vambrace_brigandine",
    name = ccb.content.plural_text("mild steel splint vambraces (pair)", "mild steel splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_vambrace_brigandine",
    name = ccb.content.plural_text("medium steel splint vambraces (pair)", "medium steel splint vambraces (pair)"),
    copy_from = "lc_vambrace_brigandine",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_vambrace_brigandine",
    copy_from = "mc_vambrace_brigandine",
    name = ccb.content.plural_text("medium steel splint vambraces (pair)", "medium steel splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_vambrace_brigandine",
    copy_from = "mc_vambrace_brigandine",
    name = ccb.content.plural_text("medium steel splint vambraces (pair)", "medium steel splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_vambrace_brigandine",
    name = ccb.content.plural_text("high steel splint vambraces (pair)", "high steel splint vambraces (pair)"),
    copy_from = "lc_vambrace_brigandine",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_vambrace_brigandine",
    copy_from = "hc_vambrace_brigandine",
    name = ccb.content.plural_text("high steel splint vambraces (pair)", "high steel splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_vambrace_brigandine",
    copy_from = "hc_vambrace_brigandine",
    name = ccb.content.plural_text("high steel splint vambraces (pair)", "high steel splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_vambrace_brigandine",
    name = ccb.content.plural_text("hardened splint vambraces (pair)", "hardened splint vambraces (pair)"),
    copy_from = "lc_vambrace_brigandine",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_vambrace_brigandine",
    copy_from = "ch_vambrace_brigandine",
    name = ccb.content.plural_text("hardened splint vambraces (pair)", "hardened splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_vambrace_brigandine",
    copy_from = "ch_vambrace_brigandine",
    name = ccb.content.plural_text("hardened splint vambraces (pair)", "hardened splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_vambrace_brigandine",
    name = ccb.content.plural_text("tempered splint vambraces (pair)", "tempered splint vambraces (pair)"),
    copy_from = "lc_vambrace_brigandine",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_vambrace_brigandine",
    copy_from = "qt_vambrace_brigandine",
    name = ccb.content.plural_text("tempered splint vambraces (pair)", "tempered splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_vambrace_brigandine",
    copy_from = "qt_vambrace_brigandine",
    name = ccb.content.plural_text("tempered splint vambraces (pair)", "tempered splint vambraces (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lc_greaves_brigandine",
    category = "armor",
    name = ccb.content.plural_text("mild steel splint greaves (pair)", "mild steel splint greaves (pair)"),
    description = ccb.content.text("A pair of greaves made of tough fabric sandwiched between alternating strips of steel.  Can be comfortably worn over chainmail for extra protection."),
    mass = "600 g",
    volume = "1400 ml",
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "lc_steel", "canvas" },
    symbol = "[",
    looks_like = "legguard_metal",
    color = "light_gray",
    flags = { "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_LEGS", "VARSIZE" },
    armor = {
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 90, thickness = 0.8 },
                },
                covers = { "leg_l", "leg_r" },
                encumbrance = 4,
                coverage = 100,
                melee_coverage = 100,
                ranged_coverage = 100,
                vitals_coverage = 90,
                subparts = { "leg_lower_r", "leg_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_greaves_brigandine",
    copy_from = "lc_greaves_brigandine",
    name = ccb.content.plural_text("mild steel splint greaves (pair)", "mild steel splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_greaves_brigandine",
    copy_from = "lc_greaves_brigandine",
    name = ccb.content.plural_text("mild steel splint greaves (pair)", "mild steel splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_greaves_brigandine",
    name = ccb.content.plural_text("medium steel splint greaves (pair)", "medium steel splint greaves (pair)"),
    copy_from = "lc_greaves_brigandine",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_greaves_brigandine",
    copy_from = "mc_greaves_brigandine",
    name = ccb.content.plural_text("medium steel splint greaves (pair)", "medium steel splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_greaves_brigandine",
    copy_from = "mc_greaves_brigandine",
    name = ccb.content.plural_text("medium steel splint greaves (pair)", "medium steel splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_greaves_brigandine",
    name = ccb.content.plural_text("high steel splint greaves (pair)", "high steel splint greaves (pair)"),
    copy_from = "lc_greaves_brigandine",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_greaves_brigandine",
    copy_from = "hc_greaves_brigandine",
    name = ccb.content.plural_text("high steel splint greaves (pair)", "high steel splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_greaves_brigandine",
    copy_from = "hc_greaves_brigandine",
    name = ccb.content.plural_text("high steel splint greaves (pair)", "high steel splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_greaves_brigandine",
    name = ccb.content.plural_text("hardened splint greaves (pair)", "hardened splint greaves (pair)"),
    copy_from = "lc_greaves_brigandine",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_greaves_brigandine",
    copy_from = "ch_greaves_brigandine",
    name = ccb.content.plural_text("hardened splint greaves (pair)", "hardened splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_greaves_brigandine",
    copy_from = "ch_greaves_brigandine",
    name = ccb.content.plural_text("hardened splint greaves (pair)", "hardened splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_greaves_brigandine",
    name = ccb.content.plural_text("tempered splint greaves (pair)", "tempered splint greaves (pair)"),
    copy_from = "lc_greaves_brigandine",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_greaves_brigandine",
    copy_from = "qt_greaves_brigandine",
    name = ccb.content.plural_text("tempered splint greaves (pair)", "tempered splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_greaves_brigandine",
    copy_from = "qt_greaves_brigandine",
    name = ccb.content.plural_text("tempered splint greaves (pair)", "tempered splint greaves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lc_brigandine_hands",
    category = "armor",
    name = ccb.content.plural_text("mild steel brigandine gloves (pair)", "mild steel brigandine gloves (pair)"),
    description = ccb.content.text("A pair of gloves made of tough fabric, with steel plates of various size and shape riveted for additional protection, while still remaining relatively unhindering."),
    mass = "684 g",
    volume = "750 ml",
    price = "50 USD 12 cent",
    survival_price = "25 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    melee_damage = { bash = 3 },
    materials = { "canvas", "lc_steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER", "VARSIZE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 95, thickness = 1.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                coverage = 100,
                encumbrance = 12,
            },
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 85, thickness = 1.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "canvas", coverage = 100, thickness = 1.5 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_brigandine_hands",
    copy_from = "lc_brigandine_hands",
    name = ccb.content.plural_text("mild steel brigandine gloves (pair)", "mild steel brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "lc_brigandine_hands_xs",
    copy_from = "lc_brigandine_hands",
    name = ccb.content.plural_text("mild steel brigandine gloves (pair)", "mild steel brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_brigandine_hands",
    name = ccb.content.plural_text("medium steel brigandine gloves (pair)", "medium steel brigandine gloves (pair)"),
    copy_from = "lc_brigandine_hands",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_brigandine_hands",
    copy_from = "mc_brigandine_hands",
    name = ccb.content.plural_text("medium steel brigandine gloves (pair)", "medium steel brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mc_brigandine_hands_xs",
    copy_from = "mc_brigandine_hands",
    name = ccb.content.plural_text("medium steel brigandine gloves (pair)", "medium steel brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_brigandine_hands",
    name = ccb.content.plural_text("high steel brigandine gloves (pair)", "high steel brigandine gloves (pair)"),
    copy_from = "lc_brigandine_hands",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_brigandine_hands",
    copy_from = "hc_brigandine_hands",
    name = ccb.content.plural_text("high steel brigandine gloves (pair)", "high steel brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hc_brigandine_hands_xs",
    copy_from = "hc_brigandine_hands",
    name = ccb.content.plural_text("high steel brigandine gloves (pair)", "high steel brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_brigandine_hands",
    name = ccb.content.plural_text("hardened brigandine gloves (pair)", "hardened brigandine gloves (pair)"),
    copy_from = "lc_brigandine_hands",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_brigandine_hands",
    copy_from = "ch_brigandine_hands",
    name = ccb.content.plural_text("hardened brigandine gloves (pair)", "hardened brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "ch_brigandine_hands_xs",
    copy_from = "ch_brigandine_hands",
    name = ccb.content.plural_text("hardened brigandine gloves (pair)", "hardened brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_brigandine_hands",
    name = ccb.content.plural_text("tempered brigandine gloves (pair)", "tempered brigandine gloves (pair)"),
    copy_from = "lc_brigandine_hands",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_brigandine_hands",
    copy_from = "qt_brigandine_hands",
    name = ccb.content.plural_text("tempered brigandine gloves (pair)", "tempered brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "qt_brigandine_hands_xs",
    copy_from = "qt_brigandine_hands",
    name = ccb.content.plural_text("tempered brigandine gloves (pair)", "tempered brigandine gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lc_knee_guards",
    category = "armor",
    name = ccb.content.plural_text("mild steel knee guards (pair)", "mild steel knee guards (pair)"),
    description = ccb.content.text("A pair of thin knee guards, forged from steel.  Can be comfortably worn over chainmail for extra protection."),
    mass = "157 g",
    volume = "800 ml",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_gray",
    flags = { "STURDY", "OUTER", "ABLATIVE_CHAINMAIL_KNEES" },
    armor = {
        thickness = 1.2,
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
    id = "xl_lc_knee_guards",
    copy_from = "lc_knee_guards",
    name = ccb.content.plural_text("mild steel knee guards (pair)", "mild steel knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "lc_knee_guards_xs",
    copy_from = "lc_knee_guards",
    name = ccb.content.plural_text("mild steel knee guards (pair)", "mild steel knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_knee_guards",
    name = ccb.content.plural_text("medium steel knee guards (pair)", "medium steel knee guards (pair)"),
    copy_from = "lc_knee_guards",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_knee_guards",
    copy_from = "mc_knee_guards",
    name = ccb.content.plural_text("medium steel knee guards (pair)", "medium steel knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mc_knee_guards_xs",
    copy_from = "mc_knee_guards",
    name = ccb.content.plural_text("medium steel knee guards (pair)", "medium steel knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_knee_guards",
    name = ccb.content.plural_text("high steel knee guards (pair)", "high steel knee guards (pair)"),
    copy_from = "lc_knee_guards",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_knee_guards",
    copy_from = "hc_knee_guards",
    name = ccb.content.plural_text("high steel knee guards (pair)", "high steel knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hc_knee_guards_xs",
    copy_from = "hc_knee_guards",
    name = ccb.content.plural_text("high steel knee guards (pair)", "high steel knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_knee_guards",
    name = ccb.content.plural_text("hardened knee guards (pair)", "hardened knee guards (pair)"),
    copy_from = "lc_knee_guards",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_knee_guards",
    copy_from = "ch_knee_guards",
    name = ccb.content.plural_text("hardened knee guards (pair)", "hardened knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "ch_knee_guards_xs",
    copy_from = "ch_knee_guards",
    name = ccb.content.plural_text("hardened knee guards (pair)", "hardened knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_knee_guards",
    name = ccb.content.plural_text("tempered knee guards (pair)", "tempered knee guards (pair)"),
    copy_from = "lc_knee_guards",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_knee_guards",
    copy_from = "qt_knee_guards",
    name = ccb.content.plural_text("tempered knee guards (pair)", "tempered knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "qt_knee_guards_xs",
    copy_from = "qt_knee_guards",
    name = ccb.content.plural_text("tempered knee guards (pair)", "tempered knee guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lc_elbow_guards",
    category = "armor",
    name = ccb.content.plural_text("mild steel elbow guards (pair)", "mild steel elbow guards (pair)"),
    description = ccb.content.text("A pair of thin elbow guards, forged from steel.  Can be comfortably worn over chainmail for extra protection."),
    mass = "103 g",
    volume = "600 ml",
    price = "35 USD",
    survival_price = "2 USD 50 cent",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armguard_hard",
    color = "light_gray",
    flags = { "STURDY", "OUTER", "ABLATIVE_CHAINMAIL_ELBOWS" },
    armor = {
        thickness = 1.2,
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
    id = "xl_lc_elbow_guards",
    copy_from = "lc_elbow_guards",
    name = ccb.content.plural_text("mild steel elbow guards (pair)", "mild steel elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "lc_elbow_guards_xs",
    copy_from = "lc_elbow_guards",
    name = ccb.content.plural_text("mild steel elbow guards (pair)", "mild steel elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_elbow_guards",
    name = ccb.content.plural_text("medium steel elbow guards (pair)", "medium steel elbow guards (pair)"),
    copy_from = "lc_elbow_guards",
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_elbow_guards",
    copy_from = "mc_elbow_guards",
    name = ccb.content.plural_text("medium steel elbow guards (pair)", "medium steel elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mc_elbow_guards_xs",
    copy_from = "mc_elbow_guards",
    name = ccb.content.plural_text("medium steel elbow guards (pair)", "medium steel elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_elbow_guards",
    name = ccb.content.plural_text("high steel elbow guards (pair)", "high steel elbow guards (pair)"),
    copy_from = "lc_elbow_guards",
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_elbow_guards",
    copy_from = "hc_elbow_guards",
    name = ccb.content.plural_text("high steel elbow guards (pair)", "high steel elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hc_elbow_guards_xs",
    copy_from = "hc_elbow_guards",
    name = ccb.content.plural_text("high steel elbow guards (pair)", "high steel elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_elbow_guards",
    name = ccb.content.plural_text("hardened elbow guards (pair)", "hardened elbow guards (pair)"),
    copy_from = "lc_elbow_guards",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_elbow_guards",
    copy_from = "ch_elbow_guards",
    name = ccb.content.plural_text("hardened elbow guards (pair)", "hardened elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "ch_elbow_guards_xs",
    copy_from = "ch_elbow_guards",
    name = ccb.content.plural_text("hardened elbow guards (pair)", "hardened elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_elbow_guards",
    name = ccb.content.plural_text("tempered elbow guards (pair)", "tempered elbow guards (pair)"),
    copy_from = "lc_elbow_guards",
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_elbow_guards",
    copy_from = "qt_elbow_guards",
    name = ccb.content.plural_text("tempered elbow guards (pair)", "tempered elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "qt_elbow_guards_xs",
    copy_from = "qt_elbow_guards",
    name = ccb.content.plural_text("tempered elbow guards (pair)", "tempered elbow guards (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
