local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_sallet",
    category = "armor",
    name = ccb.content.plural_text("sallet helm", "sallet helms"),
    description = ccb.content.text("A popular German helmet of the late medieval era, the sallet covers the head and eyes.  Activate it to toggle the visor."),
    mass = "1800 g",
    volume = "2050 ml",
    price = "350 USD",
    survival_price = "45 USD",
    materials = { "steel", "leather" },
    symbol = "s",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 90, encumbrance = 20 },
            { covers = { "eyes" }, coverage = 60, encumbrance = 20 },
        },
        warmth = 15,
        thickness = 4,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "helmet_sallet_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "helmet_sallet_raised",
    category = "armor",
    copy_from = "helmet_sallet",
    name = ccb.content.plural_text("sallet helm (raised)", "sallet helms (raised)"),
    looks_like = "helmet_barbute",
    armor = { portions = { { covers = { "head" }, coverage = 90, encumbrance = 20 } } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "helmet_sallet",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "helmet_armet",
    category = "armor",
    name = ccb.content.plural_text("armet helm", "armet helms"),
    description = ccb.content.text("An iconic knightly helm of the late Middle Ages.  When you think of a knight's helmet, it looks something like this.  Activate it to toggle the visor."),
    mass = "2300 g",
    volume = "2050 ml",
    price = "550 USD",
    survival_price = "55 USD",
    materials = { "steel", "leather" },
    symbol = "s",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 40 },
            { covers = { "eyes" }, coverage = 70, encumbrance = 20 },
            { covers = { "mouth" }, coverage = 85, encumbrance = 30 },
        },
        warmth = 15,
        thickness = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "helmet_armet_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "helmet_armet_raised",
    category = "armor",
    copy_from = "helmet_armet",
    name = ccb.content.plural_text("armet helm (raised)", "armet helms (raised)"),
    looks_like = "helmet_barbute",
    armor = { portions = { { covers = { "head" }, coverage = 100, encumbrance = 45 } } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "helmet_armet",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_lighthelm_close",
    category = "armor",
    name = ccb.content.plural_text("mild steel light close helm", "mild steel light close helms"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to raise the visor."),
    mass = "2750 g",
    volume = "3 L",
    price = "550 USD",
    survival_price = "55 USD",
    materials = { "lc_steel" },
    symbol = "o",
    looks_like = "helmet_sallet",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY", "CONDUCTIVE" },
    max_worn = 1,
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.25 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "lc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("mild steel light close helm (raised)", "mild steel light close helms (raised)"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to lower the visor."),
    looks_like = "helmet_barbute",
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "lc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_lighthelm_close",
    name = ccb.content.plural_text("mild steel light close helm", "mild steel light close helms"),
    copy_from = "lc_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_lc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_lighthelm_close_raised",
    name = ccb.content.plural_text("mild steel light close helm (raised)", "mild steel light close helms (raised)"),
    copy_from = "lc_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_lc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("medium steel light close helm", "medium steel light close helms"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("medium steel light close helm (raised)", "medium steel light close helms (raised)"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "mc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_lighthelm_close",
    name = ccb.content.plural_text("medium steel light close helm", "medium steel light close helms"),
    copy_from = "mc_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_mc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_lighthelm_close_raised",
    name = ccb.content.plural_text("medium steel light close helm (raised)", "medium steel light close helms (raised)"),
    copy_from = "mc_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_mc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("high steel light close helm", "high steel light close helms"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "hc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("high steel light close helm (raised)", "high steel light close helms (raised)"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "hc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_lighthelm_close",
    name = ccb.content.plural_text("high steel light close helm", "high steel light close helms"),
    copy_from = "hc_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_hc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_lighthelm_close_raised",
    name = ccb.content.plural_text("high steel light close helm (raised)", "high steel light close helms (raised)"),
    copy_from = "hc_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_hc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("hardened steel light close helm", "hardened steel light close helms"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "ch_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("hardened steel light close helm (raised)", "hardened steel light close helms (raised)"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "ch_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_lighthelm_close",
    name = ccb.content.plural_text("hardened steel light close helm", "hardened steel light close helms"),
    copy_from = "ch_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_ch_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_lighthelm_close_raised",
    name = ccb.content.plural_text("hardened steel light close helm (raised)", "hardened steel light close helms (raised)"),
    copy_from = "ch_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_ch_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("tempered steel light close helm", "tempered steel light close helms"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "qt_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("tempered steel light close helm (raised)", "tempered steel light close helms (raised)"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "qt_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_lighthelm_close",
    name = ccb.content.plural_text("tempered steel light close helm", "tempered steel light close helms"),
    copy_from = "qt_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_qt_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_lighthelm_close_raised",
    name = ccb.content.plural_text("tempered steel light close helm (raised)", "tempered steel light close helms (raised)"),
    copy_from = "qt_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_qt_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_helm_close",
    category = "armor",
    name = ccb.content.plural_text("mild steel close helm", "mild steel close helms"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to raise the visor."),
    mass = "3750 g",
    volume = "3 L",
    price = "740 USD",
    survival_price = "74 USD",
    materials = { "lc_steel" },
    symbol = "o",
    looks_like = "helmet_sallet",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY", "CONDUCTIVE" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.75 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "lc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_helm_close_raised",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("mild steel close helm (raised)", "mild steel close helms (raised)"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to lower the visor."),
    looks_like = "helmet_barbute",
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "lc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_helm_close",
    name = ccb.content.plural_text("mild steel close helm", "mild steel close helms"),
    copy_from = "lc_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_lc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_helm_close_raised",
    name = ccb.content.plural_text("mild steel close helm (raised)", "mild steel close helms (raised)"),
    copy_from = "lc_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_lc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("medium steel close helm", "medium steel close helms"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("medium steel close helm (raised)", "medium steel close helms (raised)"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "mc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_helm_close",
    name = ccb.content.plural_text("medium steel close helm", "medium steel close helms"),
    copy_from = "mc_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_mc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_helm_close_raised",
    name = ccb.content.plural_text("medium steel close helm (raised)", "medium steel close helms (raised)"),
    copy_from = "mc_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_mc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("high steel close helm", "high steel close helms"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("high steel close helm (raised)", "high steel close helms (raised)"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "hc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_helm_close",
    name = ccb.content.plural_text("high steel close helm", "high steel close helms"),
    copy_from = "hc_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_hc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_helm_close_raised",
    name = ccb.content.plural_text("high steel close helm (raised)", "high steel close helms (raised)"),
    copy_from = "hc_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_hc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("hardened steel close helm", "hardened steel close helms"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "ch_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("hardened steel close helm (raised)", "hardened steel close helms (raised)"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "ch_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_helm_close",
    name = ccb.content.plural_text("hardened steel close helm", "hardened steel close helms"),
    copy_from = "ch_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_ch_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_helm_close_raised",
    name = ccb.content.plural_text("hardened steel close helm (raised)", "hardened steel close helms (raised)"),
    copy_from = "ch_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_ch_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("tempered steel close helm", "tempered steel close helms"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "qt_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("tempered steel close helm (raised)", "tempered steel close helms (raised)"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "qt_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_helm_close",
    name = ccb.content.plural_text("tempered steel close helm", "tempered steel close helms"),
    copy_from = "qt_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_qt_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_helm_close_raised",
    name = ccb.content.plural_text("tempered steel close helm (raised)", "tempered steel close helms (raised)"),
    copy_from = "qt_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_qt_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_heavyhelm_close",
    category = "armor",
    name = ccb.content.plural_text("mild steel heavy close helm", "mild steel heavy close helms"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to raise the visor."),
    mass = "4750 g",
    volume = "3 L",
    price = "935 USD",
    survival_price = "93 USD 50 cent",
    materials = { "lc_steel" },
    symbol = "o",
    looks_like = "helmet_sallet",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY", "CONDUCTIVE" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 2.25 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "lc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("mild steel heavy close helm (raised)", "mild steel heavy close helms (raised)"),
    looks_like = "helmet_barbute",
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "lc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_heavyhelm_close",
    name = ccb.content.plural_text("mild steel heavy close helm", "mild steel heavy close helms"),
    copy_from = "lc_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_lc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("mild steel heavy close helm (raised)", "mild steel heavy close helms (raised)"),
    copy_from = "lc_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_lc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("medium steel heavy close helm", "medium steel heavy close helms"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("medium steel heavy close helm (raised)", "medium steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "mc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_heavyhelm_close",
    name = ccb.content.plural_text("medium steel heavy close helm", "medium steel heavy close helms"),
    copy_from = "mc_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_mc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_heavyhelm_close_raised",
    name = ccb.content.plural_text("medium steel heavy close helm (raised)", "medium steel heavy close helms (raised)"),
    copy_from = "mc_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_mc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("high steel heavy close helm", "high steel heavy close helms"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "hc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("high steel heavy close helm (raised)", "high steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "hc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_heavyhelm_close",
    name = ccb.content.plural_text("high steel heavy close helm", "high steel heavy close helms"),
    copy_from = "hc_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_hc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_heavyhelm_close_raised",
    name = ccb.content.plural_text("high steel heavy close helm (raised)", "high steel heavy close helms (raised)"),
    copy_from = "hc_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_hc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("hardened steel heavy close helm", "hardened steel heavy close helms"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "hc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("hardened steel heavy close helm (raised)", "hardened steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "ch_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_heavyhelm_close",
    name = ccb.content.plural_text("hardened steel heavy close helm", "hardened steel heavy close helms"),
    copy_from = "ch_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_ch_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_heavyhelm_close_raised",
    name = ccb.content.plural_text("hardened steel heavy close helm (raised)", "hardened steel heavy close helms (raised)"),
    copy_from = "ch_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_ch_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("tempered steel heavy close helm", "tempered steel heavy close helms"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "qt_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("tempered steel heavy close helm (raised)", "tempered steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "qt_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_heavyhelm_close",
    name = ccb.content.plural_text("tempered steel heavy close helm", "tempered steel heavy close helms"),
    copy_from = "qt_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_qt_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_heavyhelm_close_raised",
    name = ccb.content.plural_text("tempered steel heavy close helm (raised)", "tempered steel heavy close helms (raised)"),
    copy_from = "qt_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_qt_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}
