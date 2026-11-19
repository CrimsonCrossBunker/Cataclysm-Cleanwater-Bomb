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
