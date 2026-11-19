local ccb = require("ccb")

ccb.content.define_item {
    id = "waterproof_gunmod",
    name = ccb.content.plural_text("firearm waterproofing", "firearm waterproofings"),
    description = ccb.content.text("A set of seals and gaskets that will allow a firearm to operate reliably while submerged in water."),
    mass = "220 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    price = "500 USD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic" },
    symbol = ":",
    color = "dark_gray",
    flags = { "WATERPROOF_GUN" },
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        install_time = "10 m",
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "gun_crossbow",
    name = ccb.content.plural_text("rail-mounted crossbow", "rail-mounted crossbows"),
    description = ccb.content.text("A kit to attach a pair of crossbow arms and a firing rail to the barrel of a long firearm.  It allows crossbow bolts to be fired."),
    mass = "1450 g",
    volume = "500 ml",
    price = "500 USD",
    survival_price = "15 USD",
    materials = { "steel", "wood" },
    symbol = ":",
    color = "light_red",
    flags = { "PRIMITIVE_RANGED_WEAPON", "NON_FOULING" },
    pockets = { { kind = "MAGAZINE", ammunition = { bolt = 1 } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        ammunition = { "bolt" },
        skill = ccb.content.text("rifle", "gun_type_type"),
        range = 8,
        damage = { type = "stab", amount = 3 },
        dispersion = 180,
        durability = 10,
        clip_size = 1,
    },
    gunmod = {
        install_time = "30 m",
        location = ccb.content.text("rail"),
        targets = {
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
        dispersion_modifier = 60,
    },
    minimum_skills = { { id = "weapon", count = 2 }, { id = "rifle", count = 1 } },
}

ccb.content.define_item {
    id = "makeshift_bayonet",
    copy_from = "spike",
    name = ccb.content.plural_text("makeshift bayonet", "makeshift bayonets"),
    description = ccb.content.text("A makeshift version of a bayonet that consists of a mere spike with some string."),
    length = "12 cm",
    integral_length = "12 cm",
    inheritance = { add = { flags = { "PUMP_RAIL_COMPATIBLE" } } },
    gunmod = {
        location = ccb.content.text("underbarrel"),
        targets = {
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
        bayonet = true,
        incompatible_mods = {
            "knife_combat_army", "knife_combat", "enfield_bayonet", "knife_combat_marine",
            "makeshift_bayonet", "sword_bayonet",
        },
        install_time = "5 m",
    },
}
