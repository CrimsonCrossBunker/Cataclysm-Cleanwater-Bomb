local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_under",
    copy_from = "m320_mod",
    name = ccb.content.plural_text("underbarrel launcher", "underbarrel launchers"),
    description = ccb.content.text("A stubby single shot launcher with a large bore barrel, suitable for launching grenades or flares.  This launcher can be attached to a rifle or other suitable platform, and includes its own set of sights.  In more recent years, variants were sold commercially to ostensibly launch flares.  With the right cartridges, this would be devastating against hard or soft targets.  The launcher can be detached and its sights reattached to the could be disassembled and attached to a suitable rifle, if so desired."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_grenade = 1 }, rigid = true } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        ammunition = { "ammo_grenade" },
        skill = ccb.content.text("launcher", "gun_type_type"),
        dispersion = 270,
        durability = 10,
        clip_size = 1,
    },
    gunmod = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Deploy as stand-alone"),
            target = "grenade_pistol",
            message = ccb.content.text("You make the launcher ready for detached use."),
        },
    },
}

ccb.content.define_item {
    id = "grenade_under_mod",
    copy_from = "m320_mod_mod",
    name = ccb.content.plural_text("underbarrel launcher (modified)", "underbarrel launcher (modified)"),
    description = ccb.content.text("A stubby single shot launcher for launching grenades or flares.  This launcher can be attached to a rifle or other suitable platform, and includes its own set of sights.  In more recent years, variants were sold commercially to ostensibly launch flares.  With the right cartridges, this would be devastating against hard or soft targets.  A crude homemade bracket has been attached, allowing a wider variety of hosts."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_grenade = 1 }, rigid = true } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        ammunition = { "ammo_grenade" },
        skill = ccb.content.text("launcher", "gun_type_type"),
        dispersion = 270,
        durability = 10,
        clip_size = 1,
    },
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
    id = "shotgun_under",
    copy_from = "masterkey",
    name = ccb.content.plural_text("underbarrel shotgun", "underbarrel shotguns"),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 4 }, rigid = true } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        ammunition = { "ammo_shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        dispersion = 330,
        durability = 10,
        clip_size = 4,
    },
    gunmod = {},
}

ccb.content.define_item {
    id = "shotgun_under_mod",
    copy_from = "masterkey_mod",
    name = ccb.content.plural_text("modified underbarrel shotgun", "modified underbarrel shotguns"),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 4 }, rigid = true } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        ammunition = { "ammo_shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        dispersion = 330,
        durability = 10,
        clip_size = 4,
    },
    gunmod = {},
}

ccb.content.define_item {
    id = "rifle_shotgun_combination_shotgun",
    copy_from = "combination_gun_shotgun",
    name = ccb.content.plural_text("combination gun shotgun", "combination gun shotguns"),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 2 }, rigid = true } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        ammunition = { "ammo_shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        range = 2,
        dispersion = 345,
        durability = 10,
        clip_size = 2,
    },
    gunmod = {},
}

ccb.content.define_item {
    id = "arredondo_chute",
    copy_from = "arredondo_chute",
    name = ccb.content.plural_text("speedloader chute", "speedloader chutes"),
    description = ccb.content.text("A metal ramp that is installed near a shotgun's feeding port to index speedloader tubes."),
    gunmod = {
        location = ccb.content.text("loading port"),
        compatible_ammo = { "ammo_shot" },
        magazine_adapters = { { ammo_type = "ammo_shot", magazines = { "shot_speedloader" } } },
    },
}
