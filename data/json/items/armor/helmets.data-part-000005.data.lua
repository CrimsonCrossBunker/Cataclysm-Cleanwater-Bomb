local ccb = require("ccb")

ccb.content.define_item {
    id = "airsoft_helmet",
    category = "armor",
    name = ccb.content.text("airsoft helmet"),
    description = ccb.content.text("A lightweight helmet that is fashioned to look like a real military helmet, but is made of plastic and only protects against BB's and other light threats.  It has a military rail system for attachments."),
    mass = "455 g",
    volume = "1850 ml",
    price = "60 USD",
    survival_price = "10 USD",
    materials = { "plastic", "plastic_pad" },
    symbol = "[",
    looks_like = "helmet_army",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATERPROOF", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a face shield, or a front night vision attachment."),
            allowed_flags = { "HELMET_FACE_SHIELD", "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a rail-mounted mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD", "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 6 },
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 6 },
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "airsoft_helmet_stripped",
    copy_from = "airsoft_helmet",
    category = "armor",
    name = ccb.content.plural_text("airsoft helmet (stripped)", "airsoft helmets (stripped)"),
    description = ccb.content.text("A lightweight helmet that is fashioned to look like a real military helmet, but is made of plastic and only protects against BB's and other light threats.  This one has no attachment rails."),
    mass = "325 g",
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a rail-mounted mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD", "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "lc_helmet_turban",
    category = "armor",
    name = ccb.content.text("mild steel turban helmet"),
    description = ccb.content.text("A middle eastern helmet, cylindrical on the top with protection for the nose and ears but nothing lower.  This one is made in modern times out of steel."),
    mass = "2400 g",
    volume = "1500 ml",
    price = "260 USD",
    survival_price = "25 USD",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "600 ml",
            mass_limit = "2000 g",
            moves = 250,
            description = ccb.content.text("attachment for a partial or full aventail."),
            allowed_flags = { "HELMET_AVENTAIL" },
        },
    },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_nose" },
                coverage = 90,
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 3,
        thickness = 2.5,
    },
}

ccb.content.define_item {
    id = "xl_lc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("mild steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("mild steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("medium steel turban helmet"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_helmet_turban",
    copy_from = "mc_helmet_turban",
    name = ccb.content.text("medium steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_helmet_turban",
    copy_from = "mc_helmet_turban",
    name = ccb.content.text("medium steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("high steel turban helmet"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_helmet_turban",
    copy_from = "hc_helmet_turban",
    name = ccb.content.text("high steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_helmet_turban",
    copy_from = "hc_helmet_turban",
    name = ccb.content.text("high steel turban helmet"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "qt_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("tempered steel turban helmet"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_helmet_turban",
    copy_from = "qt_helmet_turban",
    name = ccb.content.text("tempered steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_helmet_turban",
    copy_from = "qt_helmet_turban",
    name = ccb.content.text("tempered steel turban helmet"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "ch_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("hardened steel turban helmet"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_helmet_turban",
    copy_from = "ch_helmet_turban",
    name = ccb.content.text("hardened steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_helmet_turban",
    copy_from = "ch_helmet_turban",
    name = ccb.content.text("hardened steel turban helmet"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "string_dimension_helmet_conical",
    category = "armor",
    name = ccb.content.text("lamba khud helm"),
    description = ccb.content.text("An unusual-looking conical helm.  The perfectly smooth steel cap covers the top of the head and the ears, forming a tall cone with a spike at the top.  Chainmail covers the rest of the head, leaving only the face open.  It is padded with a modern synthetic fabric."),
    mass = "1425 g",
    volume = "3500 ml",
    price = "400 USD",
    survival_price = "35 USD",
    materials = { { id = "qt_steel", portions = 3 }, { id = "nylon", portions = 1 } },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "white",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "PADDED" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 10,
        portions = {
            {
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 2 },
                    { id = "nylon", coverage = 100, thickness = 1 },
                },
            },
            {
                coverage = 100,
                covers = { "head" },
                subparts = { "head_nape", "mouth_cheeks", "head_throat" },
                materials = { { id = "qt_steel", coverage = 100, thickness = 1.2 } },
            },
        },
    },
}
