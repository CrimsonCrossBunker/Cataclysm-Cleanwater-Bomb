local ccb = require("ccb")

ccb.content.define_item {
    id = "attachable_ear_muffs",
    category = "armor",
    name = ccb.content.plural_text("attachable ear muffs", "attachable ear muffs"),
    description = ccb.content.text("A pair of ear muffs attachable to a hard hat or helmet to reduce noise exposures to safe levels.  Activate to put ear muffs into a working position, blocking most sounds."),
    mass = "185 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "80 cent",
    materials = { "thermo_resin", "cotton" },
    symbol = "[",
    color = "yellow",
    flags = { "HELMET_EAR_ATTACHMENT", "CANT_WEAR" },
    armor = {
        thickness = 1,
        warmth = 8,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_ear_r", "head_ear_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Press tightly to ears"),
            target = "attachable_ear_muffs_on",
            message = ccb.content.text("You put the ear muffs tightly to your ears."),
            moves = 100,
        },
    },
}

ccb.content.define_item {
    id = "attachable_ear_muffs_on",
    name = ccb.content.plural_text("attachable ear muffs (on)", "attachable ear muffs (on)"),
    description = ccb.content.text("A pair of ear muffs attachable to a hard hat or helmet to reduce noise exposures to safe levels.  Activate to put ear muffs into a standby position, letting you clearly hear again."),
    copy_from = "attachable_ear_muffs",
    inheritance = { add = { flags = { "DEAF" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Put away from ears"),
            target = "attachable_ear_muffs",
            message = ccb.content.text("You put the ear muffs away from your ears."),
            moves = 100,
        },
    },
}

ccb.content.define_item {
    id = "ballistic_mandible_guard",
    category = "armor",
    name = ccb.content.plural_text("ballistic mandible guard", "ballistic mandible guard"),
    description = ccb.content.text("A ballistic jaw guard designed to be attached on a military helmet, but easily adjustable to helmets with any kind of rail system installed."),
    mass = "250 g",
    volume = "250 ml",
    price = "60 USD",
    survival_price = "2 USD 50 cent",
    materials = { "thermo_resin" },
    symbol = "[",
    color = "dark_gray",
    flags = { "HELMET_MANDIBLE_GUARD", "CANT_WEAR" },
    armor = { thickness = 1, portions = { { encumbrance = 12, coverage = 100, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "plastic_mandible_guard",
    category = "armor",
    name = ccb.content.plural_text("plastic mandible guard", "plastic mandible guard"),
    description = ccb.content.text("A plastic jaw guard designed to be strapped to any common hard hat or helmet, it was probably part of some costume before the world ended."),
    mass = "250 g",
    volume = "200 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_MANDIBLE_GUARD_STRAPPED", "CANT_WEAR" },
    armor = { thickness = 1, portions = { { encumbrance = 10, coverage = 95, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "plastic_chin_guard",
    category = "armor",
    name = ccb.content.plural_text("plastic chin guard", "plastic chin guard"),
    description = ccb.content.text("A common plastic chin guard designed to be attached to the straps of any common hard hat or helmet."),
    mass = "5 g",
    volume = "10 ml",
    price = "1 USD",
    survival_price = "1 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_gray",
    flags = { "HELMET_MANDIBLE_GUARD_STRAPPED", "CANT_WEAR" },
    armor = {
        thickness = 0.1,
        portions = { { coverage = 60, covers = { "mouth" }, subparts = { "mouth_chin" } } },
    },
}

ccb.content.define_item {
    id = "counterweight_pouch",
    category = "armor",
    name = ccb.content.plural_text("counterweight pouch", "counterweight pouch"),
    description = ccb.content.text("A counterweight pouch attachable to the back of a hard hat or helmet to balance the weight on your head.  You can store batteries or some other very small items in it."),
    mass = "150 g",
    volume = "150 ml",
    price = "4 USD",
    survival_price = "10 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "green",
    flags = { "HELMET_BACK_POUCH", "CANT_WEAR" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "250 g",
            max_item_length = "4 cm",
            moves = 250,
        },
    },
    armor = {
        thickness = 0.1,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 10, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "sun_shield",
    category = "armor",
    name = ccb.content.text("sun shield"),
    description = ccb.content.text("A common sun shield intended to be put over a hard hat to protect the user from the sun."),
    mass = "98 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_gray",
    flags = { "CANT_WEAR" },
    armor = {},
}

ccb.content.define_item {
    id = "shield_visor",
    category = "armor",
    name = ccb.content.text("shield visor"),
    description = ccb.content.text("A common shield visor intended to be attached on a hard hat or helmet."),
    mass = "40 g",
    volume = "150 ml",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR" },
    armor = { thickness = 1, portions = { { encumbrance = 2, coverage = 90, covers = { "eyes" } } } },
}

ccb.content.define_item {
    id = "face_shield",
    category = "armor",
    name = ccb.content.text("face shield"),
    description = ccb.content.text("A thermoplastic face shield with a mounting bracket intended to be attached over a hard hat or helmet."),
    mass = "170 g",
    volume = "250 ml",
    price = "8 USD",
    survival_price = "1 USD",
    materials = { "thermo_resin" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 1.5,
        portions = { { encumbrance = 4, coverage = 100, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "face_shield_eod",
    category = "armor",
    name = ccb.content.text("EOD face shield"),
    description = ccb.content.text("A thick polycarbonate and plexiglass face shield with a mounting bracket intended to be attached to a ballistic helmet for protection from blast and fragmentation in 'non-permissive environments'."),
    mass = "229 g",
    volume = "250 ml",
    price = "836 USD",
    survival_price = "24 USD",
    materials = { "thermo_resin" },
    symbol = "[",
    color = "light_gray",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 4.5,
        portions = { { encumbrance = 14, coverage = 100, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "face_shield_plastic",
    category = "armor",
    name = ccb.content.text("plastic face shield"),
    description = ccb.content.text("A plastic face shield with a mounting bracket intended to be attached over a hard hat or helmet.  It doesn't protects you as much as one made from thermoplastic, but it's cheaper and more common."),
    mass = "120 g",
    volume = "250 ml",
    price = "6 USD 50 cent",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 4, coverage = 100, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "military_nvg",
    category = "armor",
    name = ccb.content.plural_text("night vision goggles", "night vision goggles"),
    description = ccb.content.text("Last generation double-tube night vision device, designed to be mounted on a compatible helmet.  Currently raised up and out of the way."),
    mass = "680 g",
    volume = "1200 ml",
    price = "10000 USD",
    survival_price = "15 USD",
    materials = { "plastic", "steel", "glass" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    flags = { "HELMET_FRONT_ATTACHMENT", "CANT_WEAR", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        thickness = 1,
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 0, rigid_only = true },
            { covers = { "head" }, encumbrance = 8, coverage = 70, subparts = { "head_forehead" } },
        },
    },
    artifact = { enchantments = { "nvg_normal" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "military_nvg_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- AN/PVS-7
ccb.content.define_item {
    id = "military_nvg_on",
    copy_from = "military_nvg",
    name = ccb.content.plural_text("night vision goggles (on)", "night vision goggles (on)"),
    description = ccb.content.text("Last generation single-tube night vision device, designed to be mounted on a compatible helmet.  Limited field of view while activated.  It is turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "military_nvg",
    inheritance = { add = { flags = { "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "140 mW" },
    armor = { portions = { { covers = { "eyes" }, coverage = 100, encumbrance = 20, rigid_only = true } } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "military_nvg",
        },
    },
}

ccb.content.define_item {
    id = "advanced_gpnvg",
    category = "armor",
    name = ccb.content.plural_text("panoramic night vision goggles", "panoramic night vision goggles"),
    description = ccb.content.text("Advanced GPNVG with four image intensifier tubes, allowing for a large field of view at night, designed to be mounted on a compatible helmet.  Currently raised up and out of the way."),
    mass = "765 g",
    volume = "1600 ml",
    price = "47000 USD",
    survival_price = "30 USD",
    materials = { "plastic", "steel", "glass" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "HELMET_FRONT_ATTACHMENT", "CANT_WEAR", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        thickness = 1,
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 0, rigid_only = true },
            {
                covers = { "head" },
                encumbrance = 12,
                coverage = 80,
                subparts = { "head_forehead", "head_crown" },
            },
        },
    },
    artifact = { enchantments = { "nvg_good" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "advanced_gpnvg_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- GPNVG-18
ccb.content.define_item {
    id = "advanced_gpnvg_on",
    copy_from = "advanced_gpnvg",
    name = ccb.content.plural_text("panoramic night vision goggles (on)", "panoramic night vision goggles (on)"),
    description = ccb.content.text("Advanced GPNVG with four image intensifier tubes, allowing for a large field of view at night, designed to be mounted on a compatible helmet.  It is turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "advanced_gpnvg",
    inheritance = { add = { flags = { "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "180 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 15, rigid_only = true },
            { covers = { "head" }, encumbrance = 3, coverage = 80, subparts = { "head_crown" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "advanced_gpnvg",
        },
    },
}

ccb.content.define_item {
    id = "enhanced_nvg",
    category = "armor",
    name = ccb.content.plural_text("enhanced night vision goggles", "enhanced night vision goggles"),
    description = ccb.content.text("New and rare high-resolution thermal NVG device, designed to be mounted on a compatible helmet.  Lets you see in the dark, and detects heat signatures emitted by (un)living organisms.  Currently raised up and out of the way."),
    mass = "720 g",
    volume = "1400 ml",
    price = "10000 USD",
    survival_price = "35 USD",
    materials = { "plastic", "steel", "glass" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "HELMET_FRONT_ATTACHMENT", "CANT_WEAR", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        thickness = 1,
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 0, rigid_only = true },
            {
                covers = { "head" },
                encumbrance = 10,
                coverage = 70,
                subparts = { "head_forehead", "head_crown" },
            },
        },
    },
    artifact = { enchantments = { "nvg_good", "THERMAL_VISION_GOOD" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "enhanced_nvg_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- AN/PSQ-42
ccb.content.define_item {
    id = "enhanced_nvg_on",
    copy_from = "enhanced_nvg",
    name = ccb.content.plural_text("enhanced night vision goggles (on)", "enhanced night vision goggles (on)"),
    description = ccb.content.text("New and rare high-resolution thermal NVG device, designed to be mounted on a compatible helmet.  Lets you see in the dark, and detects heat signatures emitted by (un)living organisms.  It is turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "enhanced_nvg",
    inheritance = { add = { flags = { "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "320 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 10, rigid_only = true },
            { covers = { "head" }, encumbrance = 3, coverage = 80, subparts = { "head_crown" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "enhanced_nvg",
        },
    },
}

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
