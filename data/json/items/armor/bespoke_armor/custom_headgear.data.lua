local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_nomad",
    name = ccb.content.plural_text("nomad cowl", "nomad cowls"),
    description = ccb.content.text("A denim cowl with additional leather padding stitched onto the head with integrated protection from a plastic visor, sun brim, and filter cartridge intake, designed for long travels.  The design includes some clever shaping that allows it to offer a lot of coverage without interfering too much with vision and breathing."),
    mass = "470 g",
    volume = "2500 ml",
    survival_price = "2 USD 50 cent",
    materials = { "denim", "leather", "plastic" },
    symbol = "[",
    looks_like = "balclava",
    color = "white",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_SM" },
            default_magazine = "gasfilter_sm",
        },
    },
    flags = { "VARSIZE", "SUN_GLASSES", "RAINPROOF", "PADDED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_s" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "denim", coverage = 100, thickness = 2.0 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_nape", "head_ear_l", "head_ear_r", "head_forehead" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = { { id = "denim", coverage = 100, thickness = 2.0 } },
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 5,
            },
        },
        warmth = 15,
        thickness = 3,
        environmental_protection = 4,
        filtered_protection = 7,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "xl_helmet_nomad",
    copy_from = "helmet_nomad",
    name = ccb.content.text("nomad cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_helmet_nomad",
    copy_from = "helmet_nomad",
    name = ccb.content.text("nomad cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Strictly speaking, this probably won't cover your neck or forehead, but for now it covers 100% for the purposes of environmental protection.
ccb.content.define_item {
    id = "hood_survivor",
    category = "armor",
    name = ccb.content.text("handmade traveler hood"),
    description = ccb.content.text("A sturdy leather hood.  While the loose material won't do much to protect you, it's fairly durable and can help protect from chemical attacks."),
    mass = "600 g",
    volume = "2 L",
    survival_price = "20 USD",
    materials = { "leather_treated", "vinyl" },
    symbol = "[",
    looks_like = "hood_rain",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 15,
        thickness = 0.4,
        environmental_protection = 5,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}

-- Strictly speaking, this probably won't cover your neck or forehead, but for now it covers 100% for the purposes of environmental protection.
ccb.content.define_item {
    id = "hood_wsurvivor",
    category = "armor",
    name = ccb.content.text("handmade winter traveler hood"),
    description = ccb.content.text("A sturdy leather hood lined with fur for warmth.  While the loose material won't do much to protect you, it's fairly durable and can help protect from chemical attacks."),
    mass = "870 g",
    volume = "1500 ml",
    survival_price = "25 USD",
    materials = { "leather_treated", "fur", "vinyl" },
    symbol = "[",
    looks_like = "hood_survivor",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 70,
        thickness = 0.6,
        environmental_protection = 5,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "xl_hood_wsurvivor",
    copy_from = "hood_wsurvivor",
    name = ccb.content.text("handmade winter traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hood_wsurvivor",
    copy_from = "hood_wsurvivor",
    name = ccb.content.text("handmade winter traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hood_xlsurvivor",
    copy_from = "hood_survivor",
    name = ccb.content.text("handmade traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hood_xssurvivor",
    copy_from = "hood_survivor",
    name = ccb.content.text("handmade traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hood_wsurvivor_nofur",
    name = ccb.content.text("handmade faux fur traveler hood"),
    description = ccb.content.text("A sturdy leather hood lined with faux fur for warmth.  While the loose material won't do much to protect you, it's fairly durable and can help protect from chemical attacks."),
    copy_from = "hood_wsurvivor",
    materials = { "leather_treated", "fur", "vinyl" },
    symbol = "[",
    looks_like = "hood_wsurvivor",
    color = "pink",
    armor = {},
}

ccb.content.define_item {
    id = "xl_hood_wsurvivor_nofur",
    copy_from = "hood_wsurvivor_nofur",
    name = ccb.content.text("handmade faux fur traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hood_wsurvivor_nofur",
    copy_from = "hood_wsurvivor_nofur",
    name = ccb.content.text("handmade faux fur traveler hood"),
    flags = { "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

-- I based these changes on the OKZK cap, as a general design but with a few changes and considerations. I removed the ballistic kevlar primarily due to it being unsuitable for headwear
ccb.content.define_item {
    id = "helmet_scavenger",
    name = ccb.content.plural_text("mercenary cowl", "mercenary cowls"),
    description = ccb.content.text("A sturdy canvas hat and cowl extending down to the neck, fitted with a shade brim, plastic eye visor and integrated filter cartridge intake built into the mouth section.  Provides smoke protection, and is cleverly designed to be relatively unencumbering and protective."),
    mass = "695 g",
    volume = "2500 ml",
    price = "550 USD",
    survival_price = "35 USD",
    materials = { "canvas", "plastic" },
    symbol = "[",
    looks_like = "mask_gas",
    color = "white",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_SM" },
            default_magazine = "gasfilter_sm",
        },
    },
    flags = { "VARSIZE", "SUN_GLASSES", "RAINPROOF", "PADDED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_s" },
    armor = {
        portions = {
            {
                materials = { { id = "canvas", coverage = 100, thickness = 1.5 } },
                covers = { "head" },
                subparts = { "head_crown", "head_nape", "head_ear_l", "head_ear_r", "head_forehead" },
                coverage = 100,
                encumbrance = 16,
            },
            {
                materials = { { id = "canvas", coverage = 100, thickness = 1.5 } },
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 5,
            },
        },
        warmth = 15,
        thickness = 2,
        environmental_protection = 4,
        filtered_protection = 7,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "xl_helmet_scavenger",
    copy_from = "helmet_scavenger",
    name = ccb.content.text("scavenger cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_scavenger_xs",
    copy_from = "helmet_scavenger",
    name = ccb.content.text("scavenger cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "helmet_nomad_papr",
    name = ccb.content.plural_text("advanced nomad cowl", "advanced nomad cowls"),
    description = ccb.content.text("A denim cowl with additional leather padding stitched onto the head with integrated protection from a sun brim, a plastic face-shield sealed with rubber gaskets, a filter cartridge intake, and several rubber-tube connections for a powered air purifying respirator system, all designed for long travels.  The design includes some clever shaping that allows it to offer a lot of coverage without interfering too much with vision and breathing."),
    mass = "600 g",
    volume = "2500 ml",
    survival_price = "4 USD 50 cent",
    materials = {
        { id = "denim", portions = 8 },
        { id = "leather", portions = 3 },
        { id = "plastic", portions = 8 },
    },
    symbol = "[",
    looks_like = "helmet_nomad",
    color = "white",
    flags = { "VARSIZE", "SUN_GLASSES", "RAINPROOF", "PADDED", "SLEEP_IGNORE", "PAPR_MASK" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "denim", coverage = 100, thickness = 2.0 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_nape", "head_ear_l", "head_ear_r", "head_forehead" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = { { id = "denim", coverage = 100, thickness = 2.0 } },
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 3,
            },
        },
        warmth = 10,
        thickness = 3,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "PAPR_MASK_ACTIVATE" },
    tick_actions = { "PAPR_MASK" },
}
