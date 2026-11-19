local ccb = require("ccb")

-- based off attributes of the EXODII BR
-- this makes damage the same as pamd68
ccb.content.define_item {
    id = "robofac_gun_exodii",
    looks_like = "retool_ar15_300blk",
    mass = "2400 g",
    volume = "1200 ml",
    integral_volume = "950 ml",
    integral_mass = "2400 g",
    integral_length = "30 cm",
    length = "55 cm",
    price = "500 USD",
    survival_price = "30 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    name = ccb.content.plural_text("HWP EXOTIC configuration", "HWP EXOTIC configuration"),
    flags = { "BIPOD", "SLOW_WIELD" },
    description = ccb.content.text("A Hub 01 Hybrid Weapons Platform quick swap conversion kit.  This version has a heavy barrel with an integrated bipod, threaded muzzle and \"EXODIC\" stamped into the metal.  The typo appears to be intentional."),
    gunmod = {
        barrel_length = "508 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("robofac_gun", "gun_type_type") },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1500 },
        },
        install_time = "1 m",
        ammo_types = { "123ln" },
        added_slots = { { id = "muzzle", count = 1 } },
        handling_modifier = 18,
        damage_modifier = { type = "bullet", amount = 2 },
        min_cycle_recoil = 3500,
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

ccb.content.define_item {
    id = "robofac_laser_sight",
    copy_from = "rail_laser_sight",
    name = ccb.content.plural_text("integral laser designator", "integral laser designators"),
    flags = { "LASER_SIGHT", "IRREMOVABLE" },
    gunmod = {},
}

ccb.content.define_item {
    id = "robofac_handguard",
    copy_from = "grip",
    name = ccb.content.plural_text("integrated front grip", "integrated front grips"),
    flags = { "PUMP_RAIL_COMPATIBLE", "IRREMOVABLE" },
    gunmod = { incompatible_mods = { "offset_grip" } },
}

ccb.content.define_item {
    id = "robofac_stock",
    copy_from = "adjustable_stock",
    name = ccb.content.plural_text("bullpup adjustable stock", "bullpup adjustable stocks"),
    flags = { "IRREMOVABLE" },
    gunmod = {},
}
