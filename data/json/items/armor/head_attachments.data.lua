local ccb = require("ccb")

ccb.content.define_item {
    id = "nape_protector",
    category = "armor",
    name = ccb.content.text("nape protector"),
    description = ccb.content.text("A common nape protector intended to be attached on a hard hat or helmet to protect against the sun and dust."),
    mass = "15 g",
    volume = "150 ml",
    price = "50 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "cyan",
    flags = { "HELMET_NAPE_PROTECTOR", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 0.4,
        warmth = 4,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_nape", "head_ear_r", "head_ear_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mesh_nape_protector",
    category = "armor",
    name = ccb.content.text("mesh nape protector"),
    description = ccb.content.text("A common mesh nape protector intended to be attached on a hard hat or helmet to protect against the sun while letting the cold wind refresh your nape."),
    mass = "10 g",
    volume = "100 ml",
    price = "50 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "yellow",
    flags = { "HELMET_NAPE_PROTECTOR", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 0.1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 95,
                covers = { "head" },
                subparts = { "head_nape", "head_ear_r", "head_ear_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "kevlar_nape_protector",
    category = "armor",
    name = ccb.content.text("Kevlar nape protector"),
    description = ccb.content.text("A custom-made Kevlar strengthened nape protector intended to be attached on a hard hat or helmet to protect your nape against cuts and slashing attacks."),
    mass = "40 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "1 USD",
    materials = { "cotton", "kevlar" },
    symbol = "[",
    color = "dark_gray",
    flags = { "HELMET_NAPE_PROTECTOR", "CANT_WEAR", "OUTER" },
    armor = {
        warmth = 8,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.4 },
                    { id = "kevlar", coverage = 80, thickness = 1.5 },
                },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_nape", "head_ear_r", "head_ear_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_face",
    category = "armor",
    name = ccb.content.text("mild steel chainmail partial aventail"),
    description = ccb.content.text("A wide chainmail ring designed to attach to a cap helmet, hanging down to extend protection to the face and neck."),
    mass = "1 kg",
    volume = "300 ml",
    price = "50 USD 12 cent",
    survival_price = "10 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "HELMET_AVENTAIL", "CANT_WEAR" },
    armor = {
        warmth = 3,
        portions = {
            {
                covers = { "head" },
                subparts = { "head_nape", "head_throat" },
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
                encumbrance = 5,
                coverage = 90,
            },
            {
                covers = { "mouth", "muzzle", "beak" },
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
                encumbrance = 5,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_chainmail_face",
    copy_from = "lc_chainmail_face",
    name = ccb.content.text("mild steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_chainmail_face",
    copy_from = "lc_chainmail_face",
    name = ccb.content.text("mild steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mc_chainmail_face",
    copy_from = "lc_chainmail_face",
    name = ccb.content.text("medium steel chainmail partial aventail"),
    replace_materials = { lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_face",
    copy_from = "mc_chainmail_face",
    name = ccb.content.text("medium steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_chainmail_face",
    copy_from = "mc_chainmail_face",
    name = ccb.content.text("medium steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hc_chainmail_face",
    copy_from = "lc_chainmail_face",
    name = ccb.content.text("high steel chainmail partial aventail"),
    replace_materials = { lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_face",
    copy_from = "hc_chainmail_face",
    name = ccb.content.text("high steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_chainmail_face",
    copy_from = "hc_chainmail_face",
    name = ccb.content.text("high steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "qt_chainmail_face",
    copy_from = "lc_chainmail_face",
    name = ccb.content.text("tempered steel chainmail partial aventail"),
    replace_materials = { lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_face",
    copy_from = "qt_chainmail_face",
    name = ccb.content.text("tempered steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_chainmail_face",
    copy_from = "qt_chainmail_face",
    name = ccb.content.text("tempered steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "ch_chainmail_face",
    copy_from = "lc_chainmail_face",
    materials = { "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail partial aventail"),
    replace_materials = { lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_face",
    copy_from = "ch_chainmail_face",
    name = ccb.content.text("hardened steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_chainmail_face",
    copy_from = "ch_chainmail_face",
    name = ccb.content.text("hardened steel chainmail partial aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_aventail",
    category = "armor",
    name = ccb.content.text("mild steel chainmail aventail"),
    description = ccb.content.text("A wide chainmail draping designed to attach to a cap helmet, hanging down to extend protection to the face, neck and shoulders."),
    mass = "1300 g",
    volume = "450 ml",
    price = "50 USD 12 cent",
    survival_price = "13 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "HELMET_AVENTAIL", "CANT_WEAR" },
    armor = {
        warmth = 3,
        portions = {
            {
                covers = { "head", "arm_l", "arm_r" },
                subparts = { "head_nape", "head_throat", "arm_shoulder_r", "arm_shoulder_l" },
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
                encumbrance = 5,
                coverage = 90,
            },
            {
                covers = { "mouth", "muzzle", "beak" },
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
                encumbrance = 5,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_chainmail_aventail",
    copy_from = "lc_chainmail_aventail",
    name = ccb.content.text("mild steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_chainmail_aventail",
    copy_from = "lc_chainmail_aventail",
    name = ccb.content.text("mild steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mc_chainmail_aventail",
    copy_from = "lc_chainmail_aventail",
    name = ccb.content.text("medium steel chainmail aventail"),
    replace_materials = { lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_aventail",
    copy_from = "mc_chainmail_aventail",
    name = ccb.content.text("medium steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_chainmail_aventail",
    copy_from = "mc_chainmail_aventail",
    name = ccb.content.text("medium steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hc_chainmail_aventail",
    copy_from = "lc_chainmail_aventail",
    name = ccb.content.text("high steel chainmail aventail"),
    replace_materials = { lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_aventail",
    copy_from = "hc_chainmail_aventail",
    name = ccb.content.text("high steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_chainmail_aventail",
    copy_from = "hc_chainmail_aventail",
    name = ccb.content.text("high steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "qt_chainmail_aventail",
    copy_from = "lc_chainmail_aventail",
    name = ccb.content.text("tempered steel chainmail aventail"),
    replace_materials = { lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_aventail",
    copy_from = "qt_chainmail_aventail",
    name = ccb.content.text("tempered steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_chainmail_aventail",
    copy_from = "qt_chainmail_aventail",
    name = ccb.content.text("tempered steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "ch_chainmail_aventail",
    copy_from = "lc_chainmail_aventail",
    name = ccb.content.text("hardened steel chainmail aventail"),
    replace_materials = { lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_aventail",
    copy_from = "ch_chainmail_aventail",
    name = ccb.content.text("hardened steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_chainmail_aventail",
    copy_from = "ch_chainmail_aventail",
    name = ccb.content.text("hardened steel chainmail aventail"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "lc_steel_facemask",
    category = "armor",
    name = ccb.content.text("mild steel armored face mask"),
    description = ccb.content.text("A metal face mask designed to attach to a cap helmet to protect the lower half.  This is a crude, dull facsimile of the original masterpieces made of mild steel."),
    mass = "2 kg",
    volume = "300 ml",
    price = "50 USD 12 cent",
    survival_price = "13 USD",
    materials = { "lc_steel" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "HELMET_AVENTAIL", "CANT_WEAR" },
    armor = {
        warmth = 3,
        portions = {
            {
                covers = { "head" },
                subparts = { "head_forehead" },
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.2 } },
                encumbrance = 7,
                coverage = 100,
            },
            {
                covers = { "mouth" },
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.2 } },
                encumbrance = 7,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_steel_facemask",
    copy_from = "lc_steel_facemask",
    name = ccb.content.text("mild steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_steel_facemask",
    copy_from = "lc_steel_facemask",
    name = ccb.content.text("mild steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mc_steel_facemask",
    copy_from = "lc_steel_facemask",
    name = ccb.content.text("medium steel armored face mask"),
    description = ccb.content.text("A metal face mask designed to attach to a cap helmet to protect the lower half.  This one is made of medium steel, and at least has some ornamentation, but not much."),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_steel_facemask",
    copy_from = "mc_steel_facemask",
    name = ccb.content.text("medium steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_steel_facemask",
    copy_from = "mc_steel_facemask",
    name = ccb.content.text("medium steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hc_steel_facemask",
    copy_from = "lc_steel_facemask",
    name = ccb.content.text("high steel armored face mask"),
    description = ccb.content.text("A metal face mask designed to attach to a cap helmet to protect the lower half.  This one is made of high steel, and you've got it with a fancy mustache and everything."),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_steel_facemask",
    copy_from = "hc_steel_facemask",
    name = ccb.content.text("high steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_steel_facemask",
    copy_from = "hc_steel_facemask",
    name = ccb.content.text("high steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "qt_steel_facemask",
    copy_from = "ch_steel_facemask",
    name = ccb.content.text("tempered steel armored face mask"),
    description = ccb.content.text("A metal face mask designed to attach to a cap helmet to protect the lower half.  This one is made of tempered steel with gold inlays and a setting for a gemstone.  This isn't just surviving the apocalypse, this is about living truly apocalypse fancy."),
    replace_materials = { ch_steel = "qt_steel" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = false,
            volume_encumbrance = 0,
            capacity = "100 ml",
            mass_limit = "500 mg",
            moves = 250,
            description = ccb.content.text("Socket for a gemstone."),
            allowed_flags = { "GEMSTONE" },
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_steel_facemask",
    copy_from = "qt_steel_facemask",
    name = ccb.content.text("tempered steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_steel_facemask",
    copy_from = "qt_steel_facemask",
    name = ccb.content.text("tempered steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "ch_steel_facemask",
    copy_from = "lc_steel_facemask",
    materials = { "ch_steel", "gold" },
    name = ccb.content.text("hardened steel armored face mask"),
    description = ccb.content.text("A metal face mask designed to attach to a cap helmet to protect the lower half.  This one is made of hardened steel with fancy gold inlays, who says armor can't be stylish!"),
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_forehead" },
                materials = {
                    { id = "ch_steel", coverage = 100, thickness = 1.2 },
                    { id = "gold", coverage = 25, thickness = 0.1 },
                },
                encumbrance = 7,
                coverage = 100,
            },
            {
                covers = { "mouth" },
                materials = {
                    { id = "ch_steel", coverage = 100, thickness = 1.2 },
                    { id = "gold", coverage = 25, thickness = 0.1 },
                },
                encumbrance = 7,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_steel_facemask",
    copy_from = "ch_steel_facemask",
    name = ccb.content.text("hardened steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_steel_facemask",
    copy_from = "ch_steel_facemask",
    name = ccb.content.text("hardened steel armored face mask"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 1.3, price = 1.25 },
    },
}

-- Simulating https://shop.avon-protection.com/products/clear-outsert?variant=44365968310509
ccb.content.define_item {
    id = "outsert_clear",
    category = "armor",
    name = ccb.content.plural_text("clear outsert lens", "clear outsert lenses"),
    description = ccb.content.text("A simple and flexible transparent lens of plastic that clips into place over a panoramic gas mask's solitary eyepiece, providing extra protection from scratches, abrasions, and ballistic threats."),
    mass = "55 g",
    volume = "46 ml",
    length = "17 cm",
    price = "69 USD 50 cent",
    survival_price = "1 USD",
    materials = { "hard_plastic_transp" },
    symbol = "[",
    color = "light_gray",
    flags = { "PANORAMIC_OUTSERT", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 2.5,
        portions = {
            {
                materials = { { id = "thermo_resin", coverage = 100, thickness = 2.5 } },
                encumbrance = 0,
                coverage = 100,
                covers = { "eyes" },
            },
        },
    },
}

-- Simulating https://shop.avon-protection.com/products/sunlight-outsert?variant=44366007730413
ccb.content.define_item {
    id = "outsert_sunlight",
    copy_from = "outsert_clear",
    name = ccb.content.plural_text("sunlight outsert lens", "sunlight outsert lenses"),
    description = ccb.content.text("A tinted and flexible plastic outsert intended to be mounted over the eyepiece of a panoramic-view gas mask to protect the wearer from high-level UV light, sudden flashes, and overly bright flares."),
    mass = "37 g",
    volume = "31 ml",
    price = "80 USD 75 cent",
    armor = {
        thickness = 1,
        portions = {
            {
                materials = { { id = "thermo_resin", coverage = 100, thickness = 1 } },
                encumbrance = 2,
                coverage = 100,
                covers = { "eyes" },
            },
        },
    },
    inheritance = { add = { flags = { "SUN_GLASSES", "FLASH_PROTECTION" } } },
}

-- Simulating https://danasafetysupply.com/avon-protection-70501-688-breach-shade-5-outsert-fits-fm53-and-fm54-masks/
ccb.content.define_item {
    id = "outsert_breach",
    copy_from = "outsert_clear",
    name = ccb.content.plural_text("breach outsert lens", "breach outsert lenses"),
    description = ccb.content.text("A specialized lens designed to clip into place over the solitary eyepiece of a panoramic gas mask, providing eye protection to users deploying a cutting torch while also improving impact resistance."),
    mass = "43 g",
    volume = "36 ml",
    price = "170 USD 34 cent",
    survival_price = "1 USD 10 cent",
    qualities = { { id = "GLARE", level = 1 } },
    armor = {
        thickness = 1.5,
        portions = {
            {
                materials = { { id = "thermo_resin", coverage = 100, thickness = 1.5 } },
                encumbrance = 40,
                coverage = 100,
                covers = { "eyes" },
            },
        },
    },
    inheritance = { add = { flags = { "SUN_GLASSES", "FLASH_PROTECTION" } } },
}

-- Simulating https://www.avon-protection.com/media/drxes0hg/avon-protection_vision-correction-assembly_data-sheet_en.pdf
-- According to Avon's datasheet, the weight of the frame, without any lenses, is 8-gramms. Calculating the mass of 2 glass lenses of 4.6x3.7x0.3mm with a cubic density of 2500 kg per m3 and adding that to the weight of the frame yields our final result.
-- According to Avon's datasheet, the individual lenses are 46mm in horizontal width and 50mm in diagonal width, with 64mm inter-pupillary. Adding the horizontal width of two lenses doesn't add up to the total weight of the frame with the nose bridge factored in, so we sum it up to a round ten cm for the overall length.
ccb.content.define_item {
    id = "insert_vision_correction",
    copy_from = "outsert_clear",
    name = ccb.content.plural_text("vision correction assembly", "vision correction assemblies"),
    description = ccb.content.text("A detachable frame of prescription lenses intended for installation behind a panoramic gas mask's visor, providing an alternative vision-correcting solution to users with inherent eye issues rather than contact lenses."),
    mass = "33 g",
    volume = "17 ml",
    length = "10 cm",
    price = "119 USD 70 cent",
    survival_price = "1 USD 25 cent",
    materials = { { id = "glass", portions = 6 }, { id = "hard_plastic_transp", portions = 4 } },
    armor = {
        thickness = 3,
        portions = {
            {
                materials = { { id = "glass", coverage = 100, thickness = 3.0 } },
                encumbrance = 0,
                coverage = 75,
                covers = { "eyes" },
            },
        },
    },
    inheritance = {
        add = { flags = { "PANORAMIC_INSERT", "FIX_NEARSIGHT", "FIX_FARSIGHT", "SKINTIGHT" } },
        remove = { flags = { "PANORAMIC_OUTSERT" } },
    },
}
