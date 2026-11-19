local ccb = require("ccb")

ccb.content.define_item {
    id = "barrel_ported",
    name = ccb.content.plural_text("ported barrel", "ported barrels"),
    description = ccb.content.text("A ported barrel redirects exhaust gases to compensate for muzzle climb, improving recoil but increasing noise and reducing accuracy slightly."),
    mass = "225 g",
    integral_mass = "0 g",
    volume = "200 ml",
    integral_volume = "0 ml",
    price = "720 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    flags = { "IRREMOVABLE" },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("barrel"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
        },
        incompatible_mods = {
            "crafted_suppressor", "filter_suppressor", "shot_suppressor", "suppressor",
            "mp5sd_suppressor", "suppressor_compact", "suppressor",
        },
        dispersion_modifier = 15,
        handling_modifier = 4,
        loudness_modifier = 8,
    },
    minimum_skills = { { id = "weapon", count = 5 } },
}

ccb.content.define_item {
    id = "barrel_small",
    name = ccb.content.plural_text("shortened barrel", "shortened barrels"),
    description = ccb.content.text("A shortened barrel results in markedly reduced accuracy and a minor increase in noise, but also greatly improves the ease with which the weapon can be carried and wielded."),
    volume = "0 ml",
    price = "120 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    flags = { "IRREMOVABLE", "ZERO_WEIGHT" },
    gunmod = {
        install_time = "0 s",
        location = ccb.content.text("barrel"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
        },
        dispersion_modifier = 75,
        loudness_modifier = 2,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "upstest",
    name = ccb.content.text_without_extraction("UPS test", "UPS test"),
    description = ccb.content.text_without_extraction("Test mod for UPS drain on mods, this should never spawn, if you see this, it's a bug.  50x more UPS drain."),
    mass = "450 g",
    volume = "500 ml",
    price = "200 USD",
    survival_price = "0 cent",
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    melee_damage = { bash = 5 },
    gunmod = {
        install_time = "0 s",
        location = ccb.content.text("barrel"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
        },
        damage_modifier = { type = "stab", amount = 500 },
        dispersion_modifier = 500,
        energy_drain_multiplier = 50.0,
    },
    minimum_skills = { { id = "gun", count = 1 } },
}
