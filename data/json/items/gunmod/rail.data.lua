local ccb = require("ccb")

ccb.content.define_item {
    id = "offset_sight_rail",
    name = ccb.content.plural_text("offset sight rail", "offset sight rails"),
    description = ccb.content.text("An additional rail set at 45° for attaching a secondary optic."),
    mass = "40 g",
    volume = "125ml",
    price = "60 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    gunmod = {
        install_time = "2 m",
        location = ccb.content.text("rail"),
        targets = {
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        added_slots = { { id = "sights", count = 1 } },
    },
    minimum_skills = { { id = "gun", count = 1 } },
}

ccb.content.define_item {
    id = "rail_laser_sight",
    name = ccb.content.plural_text("rail laser sight", "rail laser sights"),
    description = ccb.content.text("A small visible-light laser that mounts on a firearm's accessory rail to enhance ease and speed of target acquisition.  Aside from increased weight, there are no drawbacks."),
    mass = "120 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    price = "120 USD",
    survival_price = "5 USD",
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    flags = { "LASER_SIGHT" },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("rail"),
        sight_dispersion = 30,
        field_of_view = 3000,
        aim_speed_modifier = 15,
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "weapon", count = 2 }, { id = "gun", count = 1 } },
}

ccb.content.define_item {
    id = "mipim",
    name = ccb.content.plural_text("army flashlight-laser module", "army flashlight-laser modules"),
    description = ccb.content.text("Officially designated as Mini Integrated Pointing Illumination Module (MIPIM), also known as AN/PEQ-16, it is a little squarey box, mounted on a firearm side rail, that combines both laser sight and flashlight."),
    mass = "68 g",
    volume = "360 ml",
    length = "104 mm",
    price = "2200 USD",
    survival_price = "15 USD",
    materials = { "steel", "plastic" },
    symbol = ":",
    color = "brown",
    flags = { "LASER_SIGHT" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "gunmod" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("rail"),
        sight_dispersion = 30,
        field_of_view = 3000,
        aim_speed_modifier = 15,
        targets = {
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        visible_when_installed = true,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn on flashlight"),
            message = ccb.content.text("You turn the module's flashlight on."),
            target = "mipim_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
    minimum_skills = { { id = "weapon", count = 2 }, { id = "gun", count = 1 } },
}

-- about 30 m of work off a single battery
ccb.content.define_item {
    id = "mipim_on",
    copy_from = "mipim",
    name = ccb.content.plural_text("army flashlight-laser module (on)", "army flashlight-laser modules (on)"),
    revert_to = "mipim",
    light = 160,
    inheritance = { add = { flags = { "CHARGEDIM", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "gunmod" },
    tool = { power_draw = "31 W" },
    gunmod = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off flashlight"),
            message = ccb.content.text("You turn the module's flashlight off."),
            target = "mipim",
            ammo_scale = 0,
        },
    },
}

ccb.content.define_item {
    id = "offset_grip",
    name = ccb.content.plural_text("offset grip", "offset grips"),
    description = ccb.content.text("An angled grip set at 45° that attaches to a side rail, allowing for a grip while leaving the underbarrel rail free, or on guns that have integral bipods."),
    mass = "125 g",
    volume = "250 ml",
    price = "300 USD",
    survival_price = "2 USD",
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    gunmod = {
        install_time = "2 m",
        location = ccb.content.text("rail"),
        handling_modifier = 4,
        targets = {
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
        },
        incompatible_mods = {
            "combination_gun_shotgun", "grip", "grip_mod", "wooden_grip", "m203", "m203_mod", "m320_mod",
            "m320_mod_mod", "masterkey", "masterkey_mod", "m26_mass", "rm121aux", "rm121aux_mod",
            "u_shotgun", "robofac_handguard",
        },
    },
    minimum_skills = { { id = "gun", count = 2 } },
}

-- Based on https://stores.sjcguns.com/sjc-full-size-m-p-frame-weight/, which was selected as an 'average' WRT weight.  This model does not extend beyond the barrel or the slide, and so is compatible with compensators, suppressors, etc.  Realistically every distinct model and chambering of pistol would need a custom-made weight, but that level of granularity doesn't seem to square with that of existing gunmods.
-- added this cause basically no pistols have an underbarrel slot even if they have a rail under the barrel
ccb.content.define_item {
    id = "muzzle_pistol_weight",
    name = ccb.content.plural_text("muzzle weight", "muzzle weights"),
    description = ccb.content.text("A small weight attached below the barrel of a firearm to reduce muzzle climb, increasing bulk but allowing for faster follow-up shots.  Mainly used on competition handguns, but it can be added to combat pistols, too."),
    mass = "179 g",
    volume = "68 ml",
    length = "68 mm",
    integral_length = "0 cm",
    price = "175 USD",
    survival_price = "2 USD",
    materials = { "aluminum" },
    symbol = ":",
    color = "white",
    gunmod = {
        handling_modifier = 2,
        install_time = "1 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("pistol", "gun_type_type") },
    },
    minimum_skills = { { id = "weapon", count = 3 }, { id = "gun", count = 1 } },
}
