local ccb = require("ccb")

-- based off attributes of an m4 with integrated muzzle break
ccb.content.define_item {
    id = "robofac_gun_ar",
    looks_like = "retool_ar15_300blk",
    mass = "750 g",
    volume = "500 ml",
    integral_volume = "250 ml",
    integral_mass = "750 g",
    integral_length = "20 cm",
    length = "45 cm",
    price = "500 USD",
    survival_price = "30 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    name = ccb.content.plural_text("HWP assault configuration", "HWP assault configuration"),
    description = ccb.content.text("A Hub 01 Hybrid Weapons Platform quick swap conversion kit.  This version has a long barrel with \"5.56 NATO ASSAULT\" stamped into the metal and an integrated muzzle brake."),
    gunmod = {
        barrel_length = "443 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("robofac_gun", "gun_type_type") },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 900, quantity = 3 },
        },
        install_time = "1 m",
        ammo_types = { "223" },
        dispersion_modifier = 15,
        handling_modifier = 4,
        loudness_modifier = 14,
        min_cycle_recoil = 1350,
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

ccb.content.define_item {
    id = "xedra_gun_ar",
    copy_from = "robofac_gun_ar",
    name = ccb.content.plural_text("rifled barrel", "rifled barrel"),
    flags = { "IRREMOVABLE" },
    description = ccb.content.text("This weapon is fitted with a long barrel with \"5.56 NATO ASSAULT\" stamped into the metal and an integrated muzzle brake."),
    gunmod = { targets = { ccb.content.text("xedra_gun", "gun_type_type") } },
}

-- based off attributes of an smg with integrated silencer
-- this gives similar attributes to other 9mm pdws
ccb.content.define_item {
    id = "robofac_gun_smg",
    looks_like = "retool_ar15_300blk",
    mass = "500 g",
    volume = "500 ml",
    integral_volume = "250 ml",
    integral_mass = "500 g",
    integral_length = "15 cm",
    length = "40 cm",
    price = "500 USD",
    survival_price = "30 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    name = ccb.content.plural_text("HWP personal defense configuration", "HWP personal defense configuration"),
    description = ccb.content.text("A Hub 01 Hybrid Weapons Platform quick swap conversion kit.  This version has a short barrel with \"9mm Parabellum PDW\" stamped into the metal and an integrated silencer."),
    gunmod = {
        barrel_length = "432 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("robofac_gun", "gun_type_type") },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 900, quantity = 4 },
        },
        install_time = "1 m",
        ammo_types = { "9mm" },
        handling_modifier = 2,
        loudness_modifier = -50,
        damage_modifier = { type = "bullet", amount = 4 },
        range_modifier = 20,
        min_cycle_recoil = 450,
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- based off attributes of an smg with integrated silencer
-- this gives similar attributes to other pdws
ccb.content.define_item {
    id = "robofac_gun_57",
    looks_like = "retool_ar15_300blk",
    mass = "500 g",
    volume = "500 ml",
    integral_volume = "250 ml",
    integral_mass = "500 g",
    integral_length = "15 cm",
    length = "40 cm",
    price = "500 USD",
    survival_price = "30 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    name = ccb.content.plural_text("HWP personal 5.7x28mm configuration", "HWP personal 5.7x28mm configuration"),
    description = ccb.content.text("A Hub 01 Hybrid Weapons Platform quick swap conversion kit.  This version has a short barrel with \"5.7mm NATO PDW\" stamped into the metal and an integrated silencer."),
    gunmod = {
        barrel_length = "432 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("robofac_gun", "gun_type_type") },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 900, quantity = 3 },
        },
        install_time = "1 m",
        ammo_types = { "57" },
        handling_modifier = 2,
        loudness_modifier = -50,
        damage_modifier = { type = "bullet", amount = 4 },
        range_modifier = 20,
        min_cycle_recoil = 81,
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- based off attributes of a dmr with integrated flash hider
ccb.content.define_item {
    id = "robofac_gun_dmr",
    looks_like = "retool_ar15_300blk",
    mass = "1000 g",
    volume = "500 ml",
    integral_volume = "250 ml",
    integral_mass = "1000 g",
    integral_length = "30 cm",
    length = "55 cm",
    price = "500 USD",
    survival_price = "30 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    name = ccb.content.plural_text("HWP designated marksman configuration", "HWP designated marksman configuration"),
    description = ccb.content.text("A Hub 01 Hybrid Weapons Platform quick swap conversion kit.  This version has a long barrel with \"7.62 NATO DMR\" stamped into the metal and an integrated flash hider."),
    gunmod = {
        barrel_length = "610 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("robofac_gun", "gun_type_type") },
        modes = { { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 } },
        install_time = "1 m",
        ammo_types = { "308" },
        dispersion_modifier = 12,
        handling_modifier = 2,
        loudness_modifier = -10,
        damage_modifier = { type = "bullet", amount = -1 },
        min_cycle_recoil = 2700,
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- based off attributes of a shotgun barrel with integrated choke
ccb.content.define_item {
    id = "robofac_gun_shotgun",
    looks_like = "retool_ar15_300blk",
    mass = "1000 g",
    volume = "500 ml",
    integral_volume = "250 ml",
    integral_mass = "1000 g",
    integral_length = "25 cm",
    length = "50 cm",
    price = "500 USD",
    survival_price = "30 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    name = ccb.content.plural_text("HWP close quarters configuration", "HWP close quarters configuration"),
    flags = { "CHOKE" },
    description = ccb.content.text("A Hub 01 Hybrid Weapons Platform quick swap conversion kit.  This version has a long barrel with \"00 CQC\" stamped into the metal and an integrated choke."),
    gunmod = {
        barrel_length = "546 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("robofac_gun", "gun_type_type") },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 900, quantity = 2 },
        },
        install_time = "1 m",
        ammo_types = { "shot" },
        damage_modifier = { type = "bullet", amount = 2 },
        shot_spread_modifier = -0.3,
        min_cycle_recoil = 1250,
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- based on M26-MASS; shot_spread_multiplier_modifier is increased due the short barrel
ccb.content.define_item {
    id = "robofac_gun_shotgun_breach",
    copy_from = "robofac_gun_shotgun",
    integral_volume = "175 ml",
    integral_mass = "650 g",
    integral_length = "12 cm",
    length = "42 cm",
    flags = {},
    name = ccb.content.plural_text("HWP breacher configuration", "HWP breacher configuration"),
    description = ccb.content.text("A Hub 01 Hybrid Weapons Platform quick swap conversion kit.  This version looks like the close quarters configuration, but has a shortened barrel with \"00 BREACH\" stamped into the metal."),
    gunmod = { targets = { ccb.content.text("robofac_gun", "gun_type_type") }, barrel_length = "197 mm" },
}

ccb.content.define_item {
    id = "xedra_gun_shotgun",
    copy_from = "robofac_gun_shotgun",
    name = ccb.content.plural_text("unrifled barrel", "unrifled barrel"),
    flags = { "IRREMOVABLE" },
    description = ccb.content.text("This weapon is fitted with long barrel with \"00 CQC\" stamped into the metal."),
    gunmod = { targets = { ccb.content.text("xedra_gun", "gun_type_type") } },
}
