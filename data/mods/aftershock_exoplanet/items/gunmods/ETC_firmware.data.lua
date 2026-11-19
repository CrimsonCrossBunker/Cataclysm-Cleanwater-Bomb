local ccb = require("ccb")

ccb.content.define_item {
    id = "firmware_overpressure",
    looks_like = "electrolaser_conversion",
    name = ccb.content.plural_text("ETC firmware (overpressure)", "ETC firmware (overpressure)"),
    description = ccb.content.text("Custom firmware for the electrical ignition system of caseless firearms.  Tweaks the ignition timing to maximize pressure in the chamber, increasing muzzle velocity and armor penetration at the cost of increased wear on the weapon."),
    mass = "12 g",
    volume = "50 ml",
    length = "1 cm",
    integral_length = "0 cm",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        damage_modifier = { type = "bullet", amount = 10 },
        range_multiplier = 1.2,
        location = ccb.content.text("ETCfirmware"),
        targets = {
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
        },
        install_time = "15 m",
        effects = { "MATCHHEAD" },
    },
}

ccb.content.define_item {
    id = "firmware_subsonic",
    copy_from = "firmware_overpressure",
    name = ccb.content.plural_text("ETC firmware (subsonic)", "ETC firmware (subsonic)"),
    description = ccb.content.text("Custom firmware for the electrical ignition system of caseless firearms.  Tweaks the ignition timing to ensure that fired bullets remain subsonic, reducing noise at the cost of range and armor penetration."),
    gunmod = {
        damage_modifier = { type = "bullet", amount = -6 },
        loudness_modifier = -40,
        range_multiplier = 0.6,
    },
}

ccb.content.define_item {
    id = "firmware_incendiary",
    copy_from = "firmware_overpressure",
    name = ccb.content.plural_text("ETC firmware (incendiary)", "ETC firmware (incendiary)"),
    description = ccb.content.text("Custom firmware for the electrical ignition system of caseless firearms.  Increases the potency of the heat ignition system, causing bullets to melt and be subsequently fired as globules of superheated metal.  The projectiles will set targets on fire, at the cost of direct damage, range, and weapon durability."),
    gunmod = {
        damage_modifier = { { type = "bullet", amount = -16 }, { type = "heat", amount = 5 } },
        effects = { "MATCHHEAD", "IGNITE" },
        dispersion_modifier = 60,
        range_multiplier = 0.6,
    },
}
