local ccb = require("ccb")

ccb.content.define_item {
    id = "bandolier_pistol",
    copy_from = "bandolier_pistol",
    name = ccb.content.text("pistol bandolier"),
    pockets = {
        {
            ammunition = { ammo_pistol_tiny = 18, ammo_pistol = 18, ammo_pistol_magnum = 18 },
            moves = 20,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "bandolier_rifle",
    copy_from = "bandolier_rifle",
    name = ccb.content.text("rifle bandolier"),
    pockets = { { ammunition = { ammo_rifle = 16, ammo_rifle_huge = 16 }, moves = 20 } },
    armor = {},
}

ccb.content.define_item {
    id = "bandolier_shotgun",
    copy_from = "bandolier_shotgun",
    name = ccb.content.text("waist shotgun bandolier"),
    pockets = { { ammunition = { ammo_shot = 25, signal_flare = 25 }, moves = 25 } },
    armor = {},
}

ccb.content.define_item {
    id = "torso_bandolier_shotgun",
    copy_from = "torso_bandolier_shotgun",
    name = ccb.content.text("torso shotgun bandolier"),
    pockets = { { ammunition = { ammo_shot = 50, signal_flare = 50 }, moves = 35 } },
    armor = {},
}

ccb.content.define_item {
    id = "flintlock_pouch",
    copy_from = "flintlock_pouch",
    name = ccb.content.plural_text("paper cartridge pouch", "paper cartridge pouches"),
    pockets = { { ammunition = { ammo_black_powder = 14, blunderbuss = 14 }, moves = 20 } },
    armor = {},
}

ccb.content.define_item {
    id = "bandolier_wrist",
    copy_from = "bandolier_wrist",
    name = ccb.content.text("wrist bandolier"),
    pockets = { { ammunition = { ammo_pistol_magnum = 4, ammo_rifle = 4 }, moves = 20 } },
    armor = {},
}

ccb.content.define_item {
    id = "grenade_pouch",
    copy_from = "grenade_pouch",
    name = ccb.content.plural_text("grenade pouch", "grenade pouches"),
    pockets = { { ammunition = { ammo_grenade = 4 }, moves = 20 } },
    armor = {},
}

ccb.content.define_item {
    id = "ammo_pouch",
    copy_from = "ammo_pouch",
    name = ccb.content.plural_text("ammo pouch", "ammo pouches"),
    pockets = {
        {
            ammunition = {
                pebble = 60,
                ammo_black_powder = 60,
                ammo_pistol_tiny = 60,
                ammo_pistol = 60,
                ammo_pistol_magnum = 60,
                ammo_rifle = 60,
                ammo_rifle_huge = 60,
                ammo_shot = 60,
                stimpack_ammo = 60,
                ampoule = 60,
                blunderbuss = 60,
                paintball = 60,
            },
            moves = 35,
        },
    },
    armor = {},
}
