local ccb = require("ccb")

ccb.content.define_item {
    id = "pistol_ball",
    copy_from = "40fmj",
    name = ccb.content.plural_text("pistol ammo, ball", "pistol ammo, ball"),
    description = ccb.content.text("Modern ubiquitous medium pistol ammo, popularized by usage in two wars and almost a century of post-war defensive and duty usage.  'Ball' is an old term for full metal jacketed bullets which offer reduced fouling, better reliability, and slightly improved penetration compared to plain lead."),
    ammunition = { type = "ammo_pistol", casing = "pistol_casing" },
}

ccb.content.define_item {
    id = "pistol_jhp",
    copy_from = "pistol_ball",
    name = ccb.content.plural_text("pistol ammo, JHP", "pistol ammo, JHP"),
    description = ccb.content.text("Modern ubiquitous medium pistol ammo, popularized by usage in two wars and almost a century of post-war defensive and duty usage.  Jacketed Hollow Points are defensive/duty projectiles that are more destructive to tissue than plain ball ammunition, and slightly reduce overpenetration concerns."),
    inheritance = { offset = { damage = { type = "bullet", amount = 3, penetration = -6 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_pistol_ball",
    copy_from = "pistol_ball",
    name = ccb.content.plural_text("pistol ammo, ball (reloaded)", "pistol ammo, ball (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_pistol_jhp",
    copy_from = "pistol_jhp",
    name = ccb.content.plural_text("pistol ammo, JHP (reloaded)", "pistol ammo, JHP (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_pistol_ball",
    copy_from = "pistol_ball",
    name = ccb.content.plural_text("pistol ammo, ball (black powder)", "pistol ammo, ball (black powder)"),
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
    id = "bp_pistol_jhp",
    copy_from = "pistol_jhp",
    name = ccb.content.plural_text("pistol ammo, JHP (black powder)", "pistol ammo, JHP (black powder)"),
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
    id = "matchhead_pistol_ball",
    copy_from = "bp_pistol_ball",
    name = ccb.content.plural_text("pistol ammo, ball (matchhead powder)", "pistol ammo, ball (matchhead powder)"),
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "matchhead_pistol_jhp",
    copy_from = "bp_pistol_jhp",
    name = ccb.content.plural_text("pistol ammo, JHP (matchhead powder)", "pistol ammo, JHP (matchhead powder)"),
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
