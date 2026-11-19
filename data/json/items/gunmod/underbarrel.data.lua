local ccb = require("ccb")

ccb.content.define_item {
    id = "ksg_aux_shotgun",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("KSG shotgun second magazine", "KSG shotgun second magazines"),
    description = ccb.content.text("The integrated second tube magazine of the Kel-Tec KSG, which holds 7 shots.  It's irremovable."),
    mass = "1550 g",
    volume = "1750 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "steel" },
    symbol = ":",
    color = "light_red",
    flags = { "RELOAD_ONE", "IRREMOVABLE", "PUMP_ACTION", "NO_TURRET", "EASY_CLEAN" },
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 7 } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "470 mm",
        ammunition = { "shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        dispersion = 425,
        durability = 7,
        handling = 20,
        reload_time = 150,
        blackpowder_tolerance = 56,
    },
    gunmod = {
        install_time = "0 s",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("shotgun", "gun_type_type") },
    },
}

ccb.content.define_item {
    id = "bipod",
    name = ccb.content.plural_text("bipod", "bipods"),
    description = ccb.content.text("Bipods are commonly used on rifles and machine guns to provide a forward rest and reduce motion.  Although they greatly improve handling of recoil, they are usable only on certain surfaces (or from the prone position), and are slow to equip."),
    mass = "400 g",
    volume = "500 ml",
    price = "680 USD",
    survival_price = "5 USD",
    accuracy = -1,
    materials = { "steel" },
    symbol = ":",
    color = "brown",
    flags = { "BIPOD", "SLOW_WIELD" },
    melee_damage = { bash = 10 },
    gunmod = {
        install_time = "1 m",
        location = ccb.content.text("bipod"),
        targets = {
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
        handling_modifier = 18,
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

-- based on stuff like the BLK LBL
ccb.content.define_item {
    id = "bipod_handguard",
    name = ccb.content.plural_text("bipod hand guard", "bipod hand guards"),
    description = ccb.content.text("Bipods are commonly used on rifles and machine guns to provide a forward rest and reduce motion.  Although they greatly improve handling of recoil, they are usable only on certain surfaces (or from the prone position).  This one is integrated into a high end hand guard, replacing the factory hand guard of your weapon, allowing for comfortable shooting with or without the bipod deployed.  Currently the bipod legs are stowed."),
    mass = "400 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "680 USD",
    survival_price = "5 USD",
    accuracy = -1,
    materials = { "aluminum" },
    symbol = ":",
    color = "brown",
    melee_damage = { bash = 10 },
    gunmod = {
        install_time = "20 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("rifle", "gun_type_type") },
        handling_modifier = 4,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You extend the bipod legs."),
            menu_text = ccb.content.text("Fold out"),
            target = "bipod_handguard_deployed",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "bipod_handguard_deployed",
    name = ccb.content.plural_text("bipod hand guard (deployed)", "bipod hand guards (deployed)"),
    description = ccb.content.text("Bipods are commonly used on rifles and machine guns to provide a forward rest and reduce motion.  Although they greatly improve handling of recoil, they are usable only on certain surfaces (or from the prone position).  This one is integrated into a high end hand guard, replacing the factory hand guard of your weapon, allowing for comfortable shooting with or without the bipod deployed.  Currently the bipod legs are out and are ready for use."),
    copy_from = "bipod_handguard",
    flags = { "BIPOD", "SLOW_WIELD" },
    gunmod = { handling_modifier = 18 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You collapse and fold the bipod legs."),
            menu_text = ccb.content.text("Put away"),
            target = "bipod_handguard",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

-- based on stuff like magpull and high end hand guards for AR-15s
-- even though these do accept front grips, we don't handle selecting which way to fire so going to assume that if you like your modern sleek hand guard you use that.
ccb.content.define_item {
    id = "modern_handguard",
    name = ccb.content.plural_text("high end hand guard", "high end hand guards"),
    description = ccb.content.text("A comfortable, high end hand guard with a set of optional mounts for accessories and equipment.  When installed, this replaces the original factory hand guard for the weapon, cutting down on excessive rails and weight.  This allows for comfortable, controlled firing of the weapon while keeping a sleek profile and avoiding bulky foregrips."),
    mass = "220 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "680 USD",
    survival_price = "5 USD",
    accuracy = -1,
    materials = { "aluminum", "plastic" },
    symbol = ":",
    color = "brown",
    melee_damage = { bash = 10 },
    gunmod = {
        install_time = "20 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("rifle", "gun_type_type") },
        handling_modifier = 6,
        dispersion_modifier = -5,
        weight_multiplier = 0.95,
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "combination_gun_shotgun",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("combination gun shotgun", "combination gun shotguns"),
    description = ccb.content.text("The integrated underbarrel shotgun of a combination gun which holds two shots.  It's irremovable."),
    mass = "2600 g",
    volume = "0 ml",
    price = "950 USD",
    survival_price = "5 USD",
    accuracy = -1,
    materials = { "steel" },
    symbol = ":",
    color = "light_red",
    flags = { "IRREMOVABLE", "RELOAD_ONE", "RELOAD_EJECT" },
    pockets = { { kind = "MAGAZINE", ammunition = { shot = 2 } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "508 mm",
        ammunition = { "shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        range = 2,
        dispersion = 345,
        durability = 10,
        clip_size = 2,
    },
    gunmod = {
        install_time = "0 s",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("rifle", "gun_type_type") },
    },
}

-- Daniel Defense Tornado
ccb.content.define_item {
    id = "grip",
    name = ccb.content.plural_text("forward grip", "forward grips"),
    description = ccb.content.text("A grip placed forward on the barrel allows for greater control.  Not as effective as a bipod but usable under all conditions."),
    mass = "68 g",
    volume = "119 ml",
    price = "60 USD",
    survival_price = "3 USD",
    materials = { "steel", "plastic" },
    symbol = ":",
    color = "brown",
    flags = { "PUMP_RAIL_COMPATIBLE" },
    gunmod = {
        install_time = "30 s",
        location = ccb.content.text("underbarrel"),
        targets = {
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        handling_modifier = 6,
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "grip_mod",
    copy_from = "grip",
    name = ccb.content.plural_text("modified forward grip", "modified forward grips"),
    description = ccb.content.text("A grip placed forward on the barrel allows for greater control.  Not as effective as a bipod but usable under all conditions.  This one was modified and customized to mount on pretty much any weapon, if you so want."),
    gunmod = {
        targets = {
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
}

ccb.content.define_item {
    id = "wooden_grip",
    name = ccb.content.plural_text("wood forward grip", "wood forward grips"),
    description = ccb.content.text("A wooden grip placed forward on the barrel allows for greater control.  Not as effective as a bipod but usable under all conditions.  This one was cleverly handmade by a desperate survivor or miserly enthusiast, it cannot be removed after installation."),
    mass = "94 g",
    volume = "119 ml",
    price = "2 USD",
    survival_price = "2 USD 50 cent",
    materials = { "wood" },
    symbol = ":",
    color = "brown",
    flags = { "PUMP_RAIL_COMPATIBLE", "IRREMOVABLE" },
    gunmod = {
        install_time = "15 m",
        location = ccb.content.text("underbarrel"),
        targets = {
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
        handling_modifier = 6,
    },
    minimum_skills = { { id = "weapon", count = 3 } },
}

-- underbarrel to interfere with other stuff in the underbarrel slot on the SKS.
ccb.content.define_item {
    id = "inter_bayonet",
    name = ccb.content.plural_text("integrated bayonet", "integrated bayonets"),
    description = ccb.content.text("The weapon's integrated bayonet."),
    mass = "1 g",
    volume = "92 ml",
    length = "22 cm",
    integral_length = "22 cm",
    price = "40 USD",
    survival_price = "5 USD",
    accuracy = -1,
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    qualities = { { id = "CUT", level = 1 }, { id = "COOK", level = 1 }, { id = "BUTCHER", level = -18 } },
    flags = { "SLOW_WIELD", "IRREMOVABLE", "ALLOWS_REMOTE_USE" },
    melee_damage = { stab = 10 },
    gunmod = {
        install_time = "0 s",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("shotgun", "gun_type_type"), ccb.content.text("rifle", "gun_type_type") },
        bayonet = true,
        to_hit_modifier = 3,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You fold in the bayonet.  It can no longer be used."),
            menu_text = ccb.content.text("Fold"),
            target = "inter_bayonet_folded",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "inter_bayonet_folded",
    name = ccb.content.plural_text("integrated bayonet (folded)", "integrated bayonets (folded)"),
    copy_from = "inter_bayonet",
    description = ccb.content.text("The weapon's integrated bayonet has been folded for storage."),
    length = "22 cm",
    integral_length = "0 cm",
    flags = { "IRREMOVABLE", "ALLOWS_REMOTE_USE" },
    melee_damage = {},
    gunmod = { modes = {} },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Unfold"),
            message = ccb.content.text("You fold out the bayonet.  It can be used."),
            target = "inter_bayonet",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "laser_sight",
    name = ccb.content.plural_text("underbarrel laser sight", "underbarrel laser sights"),
    description = ccb.content.text("A visible-light laser that mounts under a firearm's barrel to enhance ease and speed of target acquisition.  Aside from increased weight, there are no drawbacks."),
    mass = "70 g",
    volume = "40 ml",
    integral_volume = "0 ml",
    price = "100 USD",
    survival_price = "5 USD",
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    flags = { "PUMP_RAIL_COMPATIBLE", "LASER_SIGHT" },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("underbarrel"),
        sight_dispersion = 30,
        field_of_view = 3000,
        aim_speed_modifier = 15,
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("bow", "gun_type_type"),
            ccb.content.text("slingshot", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "weapon", count = 2 }, { id = "gun", count = 1 } },
}

ccb.content.define_item {
    id = "m203",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("M203A1", "M203A1"),
    description = ccb.content.text("The M203 was originally designed for use with M16 variants but today can be attached to almost any rifle.  It allows a single 40mm grenade to be loaded and fired."),
    mass = "1360 g",
    volume = "500 ml",
    price = "650 USD",
    survival_price = "10 USD",
    materials = { "steel", "plastic" },
    symbol = ":",
    color = "light_red",
    flags = { "NEVER_JAMS", "RELOAD_EJECT" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["40x46mm"] = 1 } } },
    faults = { { fault = "fault_gun_blackpowder" }, { fault = "fault_gun_dirt" } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "305 mm",
        ammunition = { "40x46mm" },
        skill = ccb.content.text("launcher", "gun_type_type"),
        dispersion = 300,
        durability = 10,
        blackpowder_tolerance = 60,
        clip_size = 1,
    },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("rifle", "gun_type_type") },
        incompatible_mods = {
            "knife_combat_army",
            "knife_combat",
            "enfield_bayonet",
            "knife_combat_marine",
            "sword_bayonet",
        },
    },
    minimum_skills = { { id = "weapon", count = 1 }, { id = "launcher", count = 1 } },
}

ccb.content.define_item {
    id = "m203_mod",
    copy_from = "m203",
    name = ccb.content.plural_text("modified M203", "modified M203s"),
    description = ccb.content.text("The M203 was originally designed for use with M16 variants but today can be attached to almost any rifle.  It allows a single 40mm grenade to be loaded and fired.  This one was modified and customized to mount on pretty much any weapon other than pistols and pump-action guns, if you so want."),
    gunmod = {
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
}

ccb.content.define_item {
    id = "m320_mod",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("M320 GLM", "M320 GLM"),
    description = ccb.content.text("The M320 Grenade Launcher Module offers the functionality of larger launchers in a very small package at the cost of decreased accuracy.  It can be either attached to a rifle or combined with a buttstock for standalone use."),
    mass = "1500 g",
    volume = "500 ml",
    price = "840 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = ":",
    color = "dark_gray",
    flags = { "NEVER_JAMS", "RELOAD_EJECT" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["40x46mm"] = 1 } } },
    faults = { { fault = "fault_gun_blackpowder" }, { fault = "fault_gun_dirt" } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "280 mm",
        ammunition = { "40x46mm" },
        skill = ccb.content.text("launcher", "gun_type_type"),
        dispersion = 270,
        durability = 10,
        blackpowder_tolerance = 60,
        clip_size = 1,
    },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("rifle", "gun_type_type") },
        incompatible_mods = {
            "knife_combat_army",
            "knife_combat",
            "enfield_bayonet",
            "knife_combat_marine",
            "sword_bayonet",
        },
    },
    minimum_skills = { { id = "weapon", count = 1 }, { id = "launcher", count = 1 } },
}

ccb.content.define_item {
    id = "m320_mod_mod",
    copy_from = "m320_mod",
    name = ccb.content.plural_text("modified M320 GLM", "modified M320 GLMs"),
    description = ccb.content.text("The M320 Grenade Launcher Module offers the functionality of larger launchers in a very small package at the cost of decreased accuracy.  It can be either attached to a rifle or combined with a buttstock for standalone use.  This one was modified and customized to mount on pretty much any weapon other than pistols and pump-action guns, if you so want."),
    gunmod = {
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
}

-- seems like this need to connect to the barrel of the rifle when mounting regurarly, so it can only really mount on rifles unless you make it stable with only the rail
ccb.content.define_item {
    id = "masterkey",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("masterkey shotgun", "masterkey shotguns"),
    description = ccb.content.text("A minimalist pump-action shotgun, which can be mounted under the barrel of many rifles.  It allows a total of four shotgun shells to be loaded and fired."),
    mass = "2600 g",
    volume = "1068 ml",
    price = "950 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = ":",
    color = "light_red",
    flags = { "RELOAD_ONE" },
    pockets = { { kind = "MAGAZINE", ammunition = { shot = 4 } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "254 mm",
        ammunition = { "shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        dispersion = 330,
        durability = 10,
        clip_size = 4,
    },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("rifle", "gun_type_type") },
        incompatible_mods = {
            "knife_combat_army",
            "knife_combat",
            "enfield_bayonet",
            "knife_combat_marine",
            "sword_bayonet",
        },
    },
    minimum_skills = { { id = "weapon", count = 1 }, { id = "shotgun", count = 1 } },
}

ccb.content.define_item {
    id = "masterkey_mod",
    copy_from = "masterkey",
    name = ccb.content.plural_text("modified masterkey shotgun", "modified masterkey shotguns"),
    description = ccb.content.text("A minimalist pump-action shotgun, which can be mounted under the barrel of many rifles.  It allows a total of four shotgun shells to be loaded and fired.  This one was modified and customized to mount on pretty much any weapon other than pistols and pump-action guns, if you so want."),
    gunmod = {
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
}

ccb.content.define_item {
    id = "m26_mass",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("M26-MASS shotgun", "M26-MASS shotguns"),
    description = ccb.content.text("The Modular Accessory Shotgun System is an underbarrel bolt-action shotgun that was inspired by the \"Masterkey\" and fixed most of its predecessor's problems.  It can be mounted under the barrel of a rifle, or used as a standalone weapon by attaching a pistol grip or collapsible buttstock module.  It feeds from three- or five-shot detachable magazines."),
    mass = "1220 g",
    volume = "1068 ml",
    length = "419 mm",
    price = "950 USD",
    survival_price = "20 USD 41 cent",
    materials = { "steel" },
    symbol = ":",
    color = "white",
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "m26_mass_mag_3", "m26_mass_mag_5" } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "197 mm",
        ammunition = { "shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        dispersion = 310,
        durability = 10,
        clip_size = 5,
    },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("underbarrel"),
        incompatible_mods = {
            "knife_combat_army",
            "knife_combat",
            "enfield_bayonet",
            "knife_combat_marine",
            "sword_bayonet",
        },
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "weapon", count = 1 }, { id = "shotgun", count = 1 } },
}

ccb.content.define_item {
    id = "pistol_bayonet",
    name = ccb.content.plural_text("pistol bayonet", "pistol bayonets"),
    description = ccb.content.text("A pistol bayonet is a stabbing weapon that can be attached to the front of a handgun, allowing a melee attack to deal piercing damage."),
    mass = "122 g",
    volume = "250 ml",
    price = "40 USD",
    survival_price = "10 USD",
    accuracy = -4,
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 15 } },
    flags = {},
    melee_damage = { stab = 6 },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("pistol", "gun_type_type") },
        bayonet = true,
    },
    minimum_skills = { { id = "weapon", count = 1 }, { id = "melee", count = 1 } },
}

ccb.content.define_item {
    id = "u_shotgun",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("underslung shotgun", "underslung shotguns"),
    description = ccb.content.text("A short shotgun with 2 barrels, which can be mounted under the barrel of many rifles.  It allows two shotgun shells to be loaded and fired."),
    mass = "1500 g",
    volume = "750 ml",
    price = "650 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = ":",
    color = "light_red",
    flags = { "RELOAD_ONE" },
    pockets = { { kind = "MAGAZINE", ammunition = { shot = 2 } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "419 mm",
        ammunition = { "shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        dispersion = 375,
        durability = 10,
        clip_size = 2,
    },
    gunmod = {
        install_time = "10 m",
        location = ccb.content.text("underbarrel"),
        incompatible_mods = {
            "knife_combat_army",
            "knife_combat",
            "enfield_bayonet",
            "knife_combat_marine",
            "sword_bayonet",
        },
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "weapon", count = 1 }, { id = "shotgun", count = 1 } },
}

ccb.content.define_item {
    id = "arisaka_monopod",
    name = ccb.content.plural_text("wire monopod, collapsed", "wire monopods, collapsed"),
    description = ccb.content.text("A folding wire monopod designed to attach to a Type 99 Arisaka's front barrel band, intended to give soldiers a stabler platform from which to shoot while prone.  Less effective than an actual bipod and ungainly long, it was largely cut from active issue relatively soon into the Second World War.  This one is currently stowed in the folded position and cannot aid you while firing."),
    mass = "120 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    integral_mass = "120 g",
    price = "200 USD",
    survival_price = "50 cent",
    accuracy = -1,
    materials = { "steel" },
    symbol = ":",
    color = "brown",
    melee_damage = { bash = 10 },
    gunmod = {
        install_time = "2 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("type99", "gun_type_type") },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You flip out the monopod and lock it into position."),
            menu_text = ccb.content.text("Fold out"),
            target = "arisaka_monopod_deployed",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "arisaka_monopod_deployed",
    name = ccb.content.plural_text("wire monopod, deployed", "wire monopods, deployed"),
    description = ccb.content.text("A folding wire monopod designed to attach to a Type 99 Arisaka's front barrel band, intended to give soldiers a stabler platform from which to shoot while prone.  Less effective than an actual bipod and ungainly long, it was largely cut from active issue relatively soon into the Second World War.  This one is currently locked in the unfolded position and will provide a measure of stability while firing."),
    copy_from = "arisaka_monopod",
    integral_volume = "250 ml",
    flags = { "BIPOD", "SLOW_WIELD" },
    gunmod = { handling_modifier = 6 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You unlock the monopod and stow it in its folded position."),
            menu_text = ccb.content.text("Put away"),
            target = "arisaka_monopod",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

-- The bipod is straight-up part of the rifle's housing, so it doesn't take up any space or weigh anything.
ccb.content.define_item {
    id = "scout_bipod",
    name = ccb.content.plural_text("integral polymer bipod", "integral polymer bipods"),
    description = ccb.content.text("The Steyr Scout's integral bipod is effectively part of the rifle's housing, causing its added weight to practically be zero.  However, the polymer construction and awkward design prevent it from being as useful as a normal bipod."),
    volume = "0 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "plastic" },
    symbol = ":",
    color = "blue",
    flags = { "IRREMOVABLE", "ZERO_WEIGHT" },
    melee_damage = { bash = 4 },
    gunmod = {
        install_time = "1 m",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("steyr_scout", "gun_type_type") },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You flip the bipod out from the rifle housing and lock it into position."),
            menu_text = ccb.content.text("Fold out"),
            target = "scout_bipod_deployed",
            moves = 90,
        },
    },
}

-- The bipod is straight-up part of the rifle's housing, so it doesn't take up any space or weigh anything.
ccb.content.define_item {
    id = "scout_bipod_deployed",
    name = ccb.content.plural_text("integral polymer bipod, deployed", "integral polymer bipods, deployed"),
    copy_from = "scout_bipod",
    integral_volume = "250 ml",
    flags = { "BIPOD", "SLOW_WIELD", "ZERO_WEIGHT" },
    gunmod = { handling_modifier = 12 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("With an ugly snap, you crack the bipod legs back into the rifle."),
            menu_text = ccb.content.text("Fold"),
            target = "scout_bipod",
            moves = 150,
        },
    },
}

-- Based on https://stores.sjcguns.com/sjc-full-size-m-p-frame-weight/, which was selected as an 'average' WRT weight.  This model does not extend beyond the barrel or the slide, and so is compatible with compensators, suppressors, etc.  Realistically every distinct model and chambering of pistol would need a custom-made weight, but that level of granularity doesn't seem to square with that of existing gunmods.
ccb.content.define_item {
    id = "muzzle_weight",
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
        targets = { ccb.content.text("smg", "gun_type_type") },
    },
    minimum_skills = { { id = "weapon", count = 3 }, { id = "gun", count = 1 } },
}

ccb.content.define_item {
    id = "ree_33_tripod",
    name = ccb.content.plural_text("heavy-duty tripod", "heavy-duty tripods"),
    description = ccb.content.text("Massive tripod, used by Exodii naval rifle so it can be used by lightweight units, providing firearm support.  Allows using naval rifle while prone."),
    mass = "6000 g",
    volume = "5800 ml",
    length = "66 cm",
    survival_price = "5 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "neutral" },
    materials = { "steel" },
    symbol = ":",
    color = "brown",
    flags = { "BIPOD", "SLOW_WIELD" },
    melee_damage = { bash = 12 },
    gunmod = {
        install_time = "5 m",
        prone_strength_modifier = -83,
        location = ccb.content.text("bipod"),
        targets = { ccb.content.text("ree_33", "gun_type_type") },
        handling_modifier = 18,
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "mounted_flashlight",
    name = ccb.content.plural_text("mounted flashlight", "mounted flashlights"),
    description = ccb.content.text("Precisely manufactured flashlight that can be mounted on any modern gun.  You still can use it without attaching it to anything if you happen to never find a handheld one."),
    mass = "68 g",
    volume = "150 ml",
    length = "63 mm",
    price = "350 USD",
    survival_price = "4 USD",
    materials = { "steel", "plastic" },
    symbol = ":",
    color = "brown",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    subtype_order = { "tool", "gunmod" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    gunmod = {
        install_time = "4 m",
        location = ccb.content.text("underbarrel"),
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
            message = ccb.content.text("You turn on the %s."),
            target = "mounted_flashlight_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- about 1.5 h of work off a single battery
ccb.content.define_item {
    id = "mounted_flashlight_on",
    copy_from = "mounted_flashlight",
    name = ccb.content.plural_text("mounted flashlight (on)", "mounted flashlights (on)"),
    revert_to = "mounted_flashlight",
    light = 160,
    inheritance = { add = { flags = { "CHARGEDIM", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "gunmod" },
    tool = { power_draw = "2700 mW" },
    gunmod = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
            target = "mounted_flashlight",
            ammo_scale = 0,
        },
    },
}
