local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_riding_peakless",
    copy_from = "helmet_riding",
    name = ccb.content.text("jockey skull cap"),
    description = ccb.content.text("A helmet designed to protect from falls and kicks involving horses."),
    mass = "650 g",
    volume = "1750 ml",
    armor = {},
    inheritance = { remove = { flags = { "SUN_GLASSES" } } },
}

ccb.content.define_item {
    id = "helmet_nasal",
    category = "armor",
    name = ccb.content.text("nasal helm"),
    description = ccb.content.text("An early medieval helmet with a projection guarding the nose, to better protect the face without obstructing vision.  Proper Viking gear, unlike the stereotypical horned helm."),
    mass = "907 g",
    volume = "2 L",
    price = "260 USD",
    survival_price = "30 USD",
    materials = { "iron", "leather" },
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
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_helmet_nasal",
    copy_from = "helmet_nasal",
    name = ccb.content.text("nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_nasal_xs",
    copy_from = "helmet_nasal",
    name = ccb.content.text("nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "lc_helmet_nasal",
    category = "armor",
    name = ccb.content.text("mild steel nasal helm"),
    description = ccb.content.text("An early medieval helmet with a projection guarding the nose, to better protect the face without obstructing vision.  Proper Viking gear, unlike the stereotypical horned helm.  This one is made in modern times out of steel."),
    mass = "1507 g",
    volume = "2 L",
    price = "260 USD",
    survival_price = "30 USD",
    materials = { "lc_steel", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "PADDED" },
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
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "leather", coverage = 50, thickness = 1 },
                },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "leather", coverage = 50, thickness = 1 },
                },
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_nose" },
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                coverage = 90,
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_lc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("mild steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("mild steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "mc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("medium steel nasal helm"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_helmet_nasal",
    copy_from = "mc_helmet_nasal",
    name = ccb.content.text("medium steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_helmet_nasal",
    copy_from = "mc_helmet_nasal",
    name = ccb.content.text("medium steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "hc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("high steel nasal helm"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_helmet_nasal",
    copy_from = "hc_helmet_nasal",
    name = ccb.content.text("high steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_helmet_nasal",
    copy_from = "hc_helmet_nasal",
    name = ccb.content.text("high steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "qt_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("tempered steel nasal helm"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_helmet_nasal",
    copy_from = "qt_helmet_nasal",
    name = ccb.content.text("tempered steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_helmet_nasal",
    copy_from = "qt_helmet_nasal",
    name = ccb.content.text("tempered steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "ch_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("hardened steel nasal helm"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_helmet_nasal",
    copy_from = "ch_helmet_nasal",
    name = ccb.content.text("hardened steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_helmet_nasal",
    copy_from = "ch_helmet_nasal",
    name = ccb.content.text("hardened steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_plate",
    category = "armor",
    name = ccb.content.text("great helm"),
    description = ccb.content.text("A medieval helmet that provides excellent protection to the entire head, at the cost of great encumbrance."),
    mass = "2175 g",
    volume = "2750 ml",
    price = "400 USD",
    survival_price = "50 USD",
    materials = { "steel", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 30 },
            { covers = { "eyes" }, rigid_only = true, coverage = 95, encumbrance = 20 },
        },
        warmth = 10,
        thickness = 5,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_helmet_plate",
    copy_from = "helmet_plate",
    name = ccb.content.text("great helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_plate_xs",
    copy_from = "helmet_plate",
    name = ccb.content.text("great helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_kettle",
    category = "armor",
    name = ccb.content.text("kettle helmet"),
    description = ccb.content.text("A wide-brimmed helmet that looks somewhat like a metal cowboy hat.  Sadly, it won't help protect your eyes from the sun."),
    mass = "2555 g",
    volume = "2050 ml",
    price = "300 USD",
    survival_price = "40 USD",
    materials = { "steel", "leather" },
    symbol = "n",
    looks_like = "helmet_barbute",
    color = "light_gray",
    variants = {
        {
            id = "morion",
            name = ccb.content.text("morion"),
            description = ccb.content.text("The tall crested helmet of a Spanish conquistador.  Heavy rusting implies it might be that many years old."),
            color = "dark_gray",
            weight = 0,
            append = false,
        },
    },
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
        },
        warmth = 5,
        thickness = 4,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_helmet_kettle",
    copy_from = "helmet_kettle",
    name = ccb.content.text("kettle helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_scrap",
    category = "armor",
    name = ccb.content.text("scrap helmet"),
    description = ccb.content.text("Loose metal scraps tied precariously to your head with frayed cords.  Gaps leave critical areas exposed and the uneven weight causes constant neck strain."),
    mass = "2400 g",
    volume = "1600 ml",
    price = "4 USD",
    survival_price = "2 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "budget_steel", "cotton" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    flags = { "OUTER" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 60, thickness = 2.2 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_ear_r" },
                coverage = 70,
                encumbrance_modifiers = { "IMBALANCED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_helmet_scrap",
    copy_from = "helmet_scrap",
    name = ccb.content.text("scrap helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_scrap_xs",
    copy_from = "helmet_scrap",
    name = ccb.content.text("scrap helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- The weight assumes one large sheet of about 75cm x 40cm x 1.5mm and one circular sheet with a diameter of 24cm as the crown, and one gambeson hood.
ccb.content.define_item {
    id = "helmet_metal_sheets_full",
    category = "armor",
    name = ccb.content.text("sheet metal great helm"),
    description = ccb.content.text("Massively heavy, extremely uncomfortable, very crude, and looks like a bucket with a slit cut out the front, but it'll keep zombie claws off your face.  Comes with a bevor to help spread the weight out onto your shoulders and protect your neck, and some cloth padding to keep your bell from being rung."),
    mass = "4570 g",
    volume = "2 L",
    price = "45 USD",
    survival_price = "50 cent",
    materials = { "lc_steel", "cotton" },
    repair_materials = { "steel" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "PADDED" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 40,
        thickness = 6.5,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 5 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 25,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_helmet_metal_sheets_full",
    copy_from = "helmet_metal_sheets_full",
    name = ccb.content.text("hardened sheet metal great helm"),
    description = ccb.content.text("It still looks like a bucket, but this crude great helm has at least been hardened for extra protection."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes one large sheet of about 75cm x 40cm x 1.5mm and one circular sheet with a diameter of 24cm as the crown, and one gambeson hood, but minus the weight of a 25cm x 30cm face cut out.
ccb.content.define_item {
    id = "helmet_metal_sheets",
    category = "armor",
    name = ccb.content.text("sheet metal helmet"),
    description = ccb.content.text("A helmet that looks like a crude bucket with the face cut out.  It comes with a bevor to distribute some of the weight to your shoulders, as well as cloth padding to keep your bell from being rung."),
    mass = "3690 g",
    volume = "2 L",
    price = "45 USD",
    survival_price = "50 cent",
    materials = { "lc_steel", "cotton" },
    repair_materials = { "lc_steel" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 35,
        thickness = 6.5,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 5 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead", "head_nape" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_helmet_metal_sheets",
    copy_from = "helmet_metal_sheets",
    name = ccb.content.text("hardened sheet metal helmet"),
    description = ccb.content.text("While the design is crude, this helmet has been hardened for added protection, while still leaving your face open so you can see properly."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "helmet_skid",
    category = "armor",
    name = ccb.content.text("skid lid"),
    description = ccb.content.text("A small metal helmet that covers the head and protects against cuts and percussion."),
    mass = "1315 g",
    volume = "1250 ml",
    price = "45 USD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic", "iron" },
    symbol = "[",
    looks_like = "helmet_bike",
    color = "dark_gray",
    flags = { "PADDED" },
    techniques = { "WBLOCK_1" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 65,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "pickelhaube",
    category = "armor",
    name = ccb.content.plural_text("pickelhaube", "pickelhauben"),
    description = ccb.content.text("A spiked helmet once worn by German military officers.  The spike is ornamental."),
    mass = "980 g",
    volume = "1750 ml",
    price = "240 USD",
    survival_price = "35 USD",
    accuracy = { grip = "none", length = "hand", surface = "point", balance = "clumsy" },
    materials = { "leather", "iron" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "dark_gray",
    flags = { "PADDED" },
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
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
    },
    melee_damage = { bash = 2, stab = 1 },
    armor = {
        warmth = 15,
        thickness = 3,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                subparts = { "head_crown" },
                covers = { "head" },
            },
            { coverage = 90, subparts = { "head_forehead" }, covers = { "head" } },
        },
    },
}

ccb.content.define_item {
    id = "helmet_corinthian",
    category = "armor",
    name = ccb.content.text("Corinthian helm"),
    description = ccb.content.text("An ancient Greek bronze helmet that provides excellent protection for the head, with slits for the eyes and mouth."),
    mass = "1310 g",
    volume = "2500 ml",
    price = "300 USD",
    survival_price = "35 USD",
    materials = { "bronze" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "yellow",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
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
                subparts = { "head_ear_l", "head_ear_r", "head_nape" },
                coverage = 50,
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 50, encumbrance = 0 },
            {
                covers = { "mouth" },
                subparts = { "mouth_nose", "mouth_cheeks" },
                rigid_only = true,
                coverage = 95,
                encumbrance = 0,
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_lips", "mouth_chin" },
                rigid_only = true,
                coverage = 75,
                encumbrance = 0,
            },
        },
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_helmet_corinthian",
    copy_from = "helmet_corinthian",
    name = ccb.content.text("Corinthian helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_corinthian_xs",
    copy_from = "helmet_corinthian",
    name = ccb.content.text("Corinthian helm"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "helmet_bronze",
    category = "armor",
    name = ccb.content.text("bronze helmet"),
    description = ccb.content.text("A solid, single piece closed bronze helmet with a slit for the eyes."),
    mass = "1110 g",
    volume = "2500 ml",
    price = "200 USD",
    survival_price = "25 USD",
    materials = { "bronze" },
    symbol = "[",
    looks_like = "helmet_corinthian",
    color = "yellow",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead" },
                encumbrance_modifiers = { "NONE" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 85, encumbrance = 10 },
            { covers = { "mouth" }, rigid_only = true, coverage = 85, encumbrance = 10 },
        },
        warmth = 10,
        thickness = 2,
    },
}

ccb.content.define_item {
    id = "xl_helmet_bronze",
    copy_from = "helmet_bronze",
    name = ccb.content.text("bronze helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_helmet_bronze",
    copy_from = "helmet_bronze",
    name = ccb.content.text("bronze helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "pot_xlhelmet",
    name = ccb.content.text("pot helmet"),
    description = ccb.content.text("A huge makeshift helmet made from a canning pot.  For the truly desperate man-bear-pig."),
    mass = "6425 g",
    volume = "25 L",
    price = "220 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "[",
    looks_like = "pot_helmet",
    copy_from = "pot_helmet",
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
            },
            { coverage = 80, covers = { "head" }, subparts = { "head_forehead" } },
            { coverage = 20, covers = { "head" }, subparts = { "head_ear_l", "head_ear_r" } },
        },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "pot_helmet_xs",
    copy_from = "pot_helmet",
    name = ccb.content.text("pot helmet"),
    description = ccb.content.text("A helmet made from a soup pot.  It's not very good protection, but it's better than nothing."),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
