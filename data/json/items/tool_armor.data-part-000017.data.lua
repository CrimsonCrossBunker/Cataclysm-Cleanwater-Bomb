local ccb = require("ccb")

-- 2019 commercial models can operate at under 0.375W with the IR illuminator on
ccb.content.define_item {
    id = "goggles_nv_on",
    copy_from = "goggles_nv",
    name = ccb.content.plural_text("light amp goggles (on)", "light amp goggles (on)"),
    description = ccb.content.text("A pair of battery-powered goggles that use a infrared LED in conjunction with a IR camera, allowing you to see in the dark.  It is turned on, and continually draining batteries.  Use it to turn them off."),
    materials = { "plastic", "steel" },
    revert_to = "goggles_nv",
    inheritance = { add = { flags = { "TRADER_AVOID", "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "375 mW" },
    armor = {
        warmth = 15,
        portions = { { encumbrance = 20, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "goggles_nv",
        },
    },
}

ccb.content.define_item {
    id = "basic_papr_belt_off",
    name = ccb.content.plural_text("PAPR blower (off)", "PAPR blowers (off)"),
    description = "A blower unit for a powered air purifying respirator system.  It has been attached to a basic rubber and plastic belt.  When active and loaded with a charged battery and a filter canister, it can be paired with a prepared PAPR mask to provide excellent protection against chemical, biological, radiological, and nuclear threats.",
    symbol = "[",
    color = "black",
    looks_like = "leather_belt",
    mass = "918 g",
    volume = "1000 ml",
    price = "300 USD",
    survival_price = "5 USD",
    flags = { "BELTED", "OVERSIZE", "ELECTRONIC", "WATER_BREAK_ACTIVE" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "medium_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "basic_papr_belt_on",
            need_charges = 1,
            message = "You activate your %s and the fan starts to audibly whoosh.",
            need_charges_message = "The batteries are dead.",
        },
    },
    tool = {
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 50,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "basic_papr_belt_on",
    copy_from = "basic_papr_belt_off",
    name = ccb.content.plural_text("PAPR blower (on)", "PAPR blowers (on)"),
    description = "An active blower unit for a powered air purifying respirator system.  It has been attached to a basic rubber and plastic belt.  If paired with a prepared PAPR mask, this will provide excellent protection against chemical, biological, radiological, and nuclear threats.  The fan is audibly blowing.",
    symbol = "[",
    color = "black",
    looks_like = "leather_belt",
    mass = "918 g",
    volume = "1000 ml",
    revert_to = "basic_papr_belt_off",
    flags = {
        "BELTED",
        "OVERSIZE",
        "ELECTRONIC",
        "TRADER_AVOID",
        "WATER_BREAK",
        "SPAWN_ACTIVE",
        "PAPR_BLOWER",
    },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "medium_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "basic_papr_belt_off",
            ammo_scale = 0,
            message = "You turn off the %s.",
            menu_text = "Turn off",
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_id = "humming",
            sound_variant = "machinery",
            sound_type = "movement",
            volume = 12,
            message = "whooooo…",
        },
    },
    tool = {
        turns_per_charge = 240,
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 50,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "military_papr_blower_off",
    name = ccb.content.plural_text("military PAPR blower (off)", "military PAPR blowers (off)"),
    description = "A sturdy blower unit for a powered air purifying respirator system.  Its large triangular body is designed to be worn on the back.  When active and loaded with a charged battery and a filter canister, it can be paired with a prepared PAPR mask to provide excellent protection against chemical, biological, radiological, and nuclear threats.",
    symbol = "[",
    color = "black",
    looks_like = "backpack",
    mass = "653 g",
    volume = "3589 ml",
    price = "1400 USD",
    survival_price = "15 USD",
    flags = { "BELTED", "OVERSIZE", "ELECTRONIC" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_papr_blower_on",
            need_charges = 1,
            message = "You activate your %s and the fan starts to audibly whoosh.",
            need_charges_message = "The batteries are dead.",
        },
    },
    tool = {
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 40,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "military_papr_blower_on",
    copy_from = "military_papr_blower_off",
    name = ccb.content.plural_text("military PAPR blower (on)", "military PAPR blowers (on)"),
    description = "An active, sturdy blower unit for a powered air purifying respirator system.  Its large triangular body is designed to be worn on the back.  When paired with a prepared PAPR mask, this will provide excellent protection against chemical, biological, radiological, and nuclear threats.  The fan is audibly blowing.",
    symbol = "[",
    color = "black",
    looks_like = "backpack",
    mass = "653 g",
    volume = "3589 ml",
    revert_to = "military_papr_blower_off",
    flags = { "BELTED", "OVERSIZE", "ELECTRONIC", "TRADER_AVOID", "SPAWN_ACTIVE", "PAPR_BLOWER" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_papr_blower_off",
            ammo_scale = 0,
            message = "You turn off the %s.",
            menu_text = "Turn off",
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_id = "humming",
            sound_variant = "machinery",
            sound_type = "movement",
            volume = 12,
            message = "whooooo…",
        },
    },
    tool = {
        turns_per_charge = 240,
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 40,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "molle_papr_blower_off",
    name = ccb.content.plural_text("modular PAPR blower (off)", "modular PAPR blowers (off)"),
    description = "A blower unit for a powered air purifying respirator system, built from a flexible silicon and butyl rubber blend.  Its components are arranged linearly in a narrow strip close to the body and is outfitted with straps to wear it about the waist.  If paired with the appropriate straps, it can also attached to any compatible MOLLE system.  When active and loaded with a charged battery and a filter canister, it can be paired with a prepared PAPR mask to provide excellent protection against chemical, biological, radiological, and nuclear threats.",
    symbol = "[",
    color = "dark_gray",
    looks_like = "backpack",
    mass = "920 g",
    volume = "3000 ml",
    price = "1600 USD",
    survival_price = "20 USD",
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "ELECTRONIC" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "butyl_rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "molle_papr_blower_on",
            need_charges = 1,
            message = "You activate your %s and the fan starts to audibly whoosh.",
            need_charges_message = "The batteries are dead.",
        },
    },
    tool = {
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 30,
                volume_encumbrance = 0.35,
                encumbrance = 2,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "molle_papr_blower_on",
    copy_from = "molle_papr_blower_off",
    name = ccb.content.plural_text("modular PAPR blower (on)", "modular PAPR blowers (on)"),
    description = "An active blower unit for a powered air purifying respirator system, built from a flexible silicon and butyl rubber blend.  Its components are arranged linearly in a narrow strip close to the body and is outfitted with straps to wear it about the waist.  If paired with the appropriate straps, it can also attached to any compatible MOLLE system.  When paired with a prepared PAPR mask, this will provide excellent protection against chemical, biological, radiological, and nuclear threats.  The fan is quietly blowing.",
    symbol = "[",
    color = "dark_gray",
    looks_like = "backpack",
    mass = "920 g",
    volume = "3000 ml",
    revert_to = "molle_papr_blower_off",
    flags = {
        "WATER_FRIENDLY",
        "BELTED",
        "OVERSIZE",
        "ELECTRONIC",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
        "PAPR_BLOWER",
    },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "butyl_rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "molle_papr_blower_off",
            ammo_scale = 0,
            message = "You turn off the %s.",
            menu_text = "Turn off",
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_id = "humming",
            sound_variant = "machinery",
            sound_type = "movement",
            volume = 12,
            message = "whooooo…",
        },
    },
    tool = {
        turns_per_charge = 240,
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 30,
                volume_encumbrance = 0.35,
                encumbrance = 2,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}
