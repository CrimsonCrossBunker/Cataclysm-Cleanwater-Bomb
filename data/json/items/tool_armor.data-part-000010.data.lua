local ccb = require("ccb")

-- Based on the EOD 10 and EOD 9 helmets.
ccb.content.define_item {
    id = "helmet_eod",
    category = "armor",
    name = ccb.content.plural_text("EOD helmet", "EOD helmets"),
    description = ccb.content.text("An armored, electronically-shielded helmet containing a camera, a two-way radio, and a headlamp, all of which can be voice-activated for redundancy.  It is designed to protect against overpressure, fragmentation, impact, and heat."),
    mass = "3600 g",
    volume = "4 L",
    price = "16 kUSD 139 USD",
    survival_price = "100 USD",
    materials = { "kevlar_rigid", "plastic", "plastic_pad" },
    symbol = "[",
    color = "light_green",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "STURDY", "OUTER", "RAINPROOF", "PADDED", "WATCH", "ALARMCLOCK" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 4.0 },
                    { id = "plastic_pad", coverage = 100, thickness = 14.0 },
                },
                covers = { "head" },
                coverage = 100,
                layers = { "OUTER", "NORMAL" },
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 20.0 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 15,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 20.0 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 65,
        environmental_protection = 3,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn on headlamps"),
            message = ccb.content.text("\"Activating illumination.\""),
            target = "helmet_eod_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("\"Illumination disabled, low power.\""),
        },
    },
}

ccb.content.define_item {
    id = "helmet_eod_on",
    copy_from = "helmet_eod",
    name = ccb.content.plural_text("EOD helmet (on)", "EOD helmets (on)"),
    light = 350,
    revert_to = "helmet_eod",
    inheritance = { add = { flags = { "CHARGEDIM", "TRADER_AVOID", "TWO_WAY_RADIO", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "10 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off headlamps"),
            message = ccb.content.text("\"Disabling illumination.\""),
            target = "helmet_eod",
        },
    },
}

ccb.content.define_item {
    id = "dimensional_anchor",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("5-point anchor", "5-point anchors"),
    looks_like = "chestguard_hard",
    description = ccb.content.text("A featureless, disc-shaped device mounted on a harness.  The words \"X.E.D.R.A\" and \"5-point anchor\" are inscribed on its front and back."),
    price = "1 kUSD 500 USD",
    survival_price = "80 USD",
    materials = { "ceramic", "kevlar" },
    mass = "1250 g",
    volume = "4500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "OVERSIZE", "BELTED", "SOFT" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 2,
        portions = { { encumbrance = 2, coverage = 50, covers = { "torso" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("An LED light in the 5-point anchor flickers on."),
            target = "dimensional_anchor_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}

ccb.content.define_item {
    id = "dimensional_anchor_on",
    copy_from = "dimensional_anchor",
    name = ccb.content.plural_text("5-point anchor (on)", "5-point anchors (on)"),
    looks_like = "dimensional_anchor",
    description = ccb.content.text("The harness' shoulder-mounted LED glows with a soft green hue.  There's no further indication of anything happening."),
    revert_to = "dimensional_anchor",
    flags = { "DIMENSIONAL_ANCHOR", "OVERSIZE", "BELTED", "PORTAL_PROOF", "SOFT", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 100 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("An LED light in the 5-point anchor flickers off."),
            target = "dimensional_anchor",
        },
    },
}

ccb.content.define_item {
    id = "broken_dimensional_anchor",
    copy_from = "dimensional_anchor",
    name = ccb.content.plural_text("malfunctioning 5-point anchor", "malfunctioning 5-point anchors"),
    description = ccb.content.text("A battered, disc-shaped device mounted on a harness.  The inscriptions \"X.E.D.R.A\" and \"5-point anchor\" are barely legible on its radiation-stained front and back."),
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The 5-point anchor emits a low-pitched clicking alarm as its mounted LED light flashes yellow."),
            target = "broken_dimensional_anchor",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}

ccb.content.define_item {
    id = "ar_glasses_advanced_pat",
    name = ccb.content.plural_text("modified advanced AR glasses", "modified advanced AR glasses"),
    description = "An expensive model of augmented reality glasses, with adaptive light correction and some gadgets, designed to be compatible with corrective glasses.  An augmented reality overlay allows the user to zoom their view, and it displays handy information about local topology.  These have been modified by your friend Pat to function on long-distance radio waves (LoRa).  A battery pack, the internal parts of a tablet PC, and a two-way radio have been combined onto a hip-strapped unit.  Activate it to utilize software, start recording and transmitting with Pat's system, or hail Pat on the radio.",
    symbol = "[",
    color = "white",
    category = "clothing",
    looks_like = "glasses_safety",
    mass = "400 g",
    volume = "750 ml",
    price = "3 kUSD",
    survival_price = "4 USD",
    e_port = "phone",
    flags = {
        "ZOOM",
        "WATCH",
        "ALARMCLOCK",
        "OUTER",
        "FRAGILE",
        "SUN_GLASSES",
        "THERMOMETER",
        "WATER_BREAK",
        "PADDED",
        "ELECTRONIC",
        "CAN_USE_IN_DARK",
        "TWO_WAY_RADIO",
        "TRADER_AVOID",
    },
    materials = { "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "light_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "1 TB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    use_actions = {
        "CAMERA",
        "PORTABLE_GAME",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
        {
            kind = "transform",
            target = "ar_glasses_advanced_pat_on",
            ammo_scale = 0,
            message = "You turn the %s on and put in your earbud.",
            menu_text = "Connect to Pat's system and start transmitting data",
        },
    },
    tool = { charges_per_use = 1, ammo_types = "battery", transfer_rate = "30 MB" },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
                layers = { "BELTED" },
                coverage = 15,
                encumbrance = 5,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "ar_glasses_advanced_pat_on",
    copy_from = "ar_glasses_advanced_pat",
    name = ccb.content.plural_text("modified advanced AR glasses (on)", "pairs of modified advanced AR glasses (on)"),
    category = "clothing",
    revert_to = "ar_glasses_advanced_pat",
    flags = {
        "ZOOM",
        "WATCH",
        "ALARMCLOCK",
        "OUTER",
        "FRAGILE",
        "SUN_GLASSES",
        "THERMOMETER",
        "WATER_BREAK",
        "PADDED",
        "ELECTRONIC",
        "CAN_USE_IN_DARK",
        "TWO_WAY_RADIO",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
    },
    use_actions = {
        "CAMERA",
        "PORTABLE_GAME",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
        {
            kind = "transform",
            target = "ar_glasses_advanced_pat",
            ammo_scale = 0,
            message = "You turn the %s off and remove your earbud.",
            menu_text = "Disconnect from Pat's system and stop transmitting data",
        },
    },
    tool = { power_draw = "120 mW" },
    armor = {},
    subtype_order = { "tool", "armor" },
}
