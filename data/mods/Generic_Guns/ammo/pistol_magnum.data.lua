local ccb = require("ccb")

ccb.content.define_item {
    id = "pistol_magnum_ball",
    copy_from = "44fmj",
    name = ccb.content.plural_text("magnum ammo, ball", "magnum ammo, ball"),
    description = ccb.content.text("Magnum ammunition, developed from early handgun hunting efforts and popularized by law enforcement usage.  It is more powerful than common pistol ammo.  'Ball' is an old term for full metal jacketed bullets which offer reduced fouling, better reliability, and slightly improved penetration compared to plain lead."),
    ammunition = { type = "ammo_pistol_magnum", casing = "pistol_magnum_casing" },
}

ccb.content.define_item {
    id = "pistol_magnum_jhp",
    copy_from = "pistol_magnum_ball",
    name = ccb.content.plural_text("magnum ammo, JHP", "magnum ammo, JHP"),
    description = ccb.content.text("Magnum ammunition, developed from early handgun hunting efforts and popularized by law enforcement usage.  It is more powerful than common pistol ammo.  Jacketed Hollow Points are defensive/duty projectiles that are more destructive to tissue than plain ball ammunition, and slightly reduce overpenetration concerns."),
    inheritance = { offset = { damage = { type = "bullet", amount = 3, penetration = -6 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_pistol_magnum_ball",
    copy_from = "pistol_magnum_ball",
    name = ccb.content.plural_text("magnum ammo, ball (reloaded)", "magnum ammo, ball (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_pistol_magnum_jhp",
    copy_from = "pistol_magnum_jhp",
    name = ccb.content.plural_text("magnum ammo, JHP (reloaded)", "magnum ammo, JHP (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_pistol_magnum_ball",
    copy_from = "pistol_magnum_ball",
    name = ccb.content.plural_text("magnum ammo, ball (black powder)", "magnum ammo, ball (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        scale = {
            price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_pistol_magnum_jhp",
    copy_from = "pistol_magnum_jhp",
    name = ccb.content.plural_text("magnum ammo, JHP (black powder)", "magnum ammo, JHP (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        scale = {
            price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}
