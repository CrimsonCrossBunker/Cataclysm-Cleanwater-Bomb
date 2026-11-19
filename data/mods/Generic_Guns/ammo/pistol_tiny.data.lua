local ccb = require("ccb")

ccb.content.define_item {
    id = "tiny_pistol_ball",
    copy_from = "32_acp",
    name = ccb.content.plural_text("tiny pistol ammo, ball", "tiny pistol ammo, ball"),
    description = ccb.content.text("Minuscule pistol and rifle ammunition, for target practice or turn of the century sidearms.  Sold in great quantities preceding the riots.  'Ball' is an old term for full metal jacketed bullets which offer reduced fouling, better reliability, and slightly improved penetration compared to plain lead."),
    inheritance = { offset = { damage = { type = "bullet", amount = -2, penetration = 3 } } },
    ammunition = { type = "ammo_pistol_tiny", casing = "pistol_tiny_casing" },
}

ccb.content.define_item {
    id = "tiny_pistol_jhp",
    copy_from = "tiny_pistol_ball",
    name = ccb.content.plural_text("tiny pistol ammo, JHP", "tiny pistol ammo, JHP"),
    description = ccb.content.text("Minuscule pistol and rifle ammunition, for target practice or turn of the century sidearms.  Sold in great quantities preceding the riots.  Jacketed Hollow Points are defensive/duty projectiles that are more destructive to tissue than plain ball ammunition, and slightly reduce overpenetration concerns."),
    inheritance = { offset = { damage = { type = "bullet", amount = 2, penetration = -3 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_tiny_pistol_ball",
    copy_from = "tiny_pistol_ball",
    name = ccb.content.plural_text("tiny pistol ammo, ball (reloaded)", "tiny pistol ammo, ball (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_tiny_pistol_jhp",
    copy_from = "tiny_pistol_jhp",
    name = ccb.content.plural_text("tiny pistol ammo, JHP (reloaded)", "tiny pistol ammo, JHP (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_tiny_pistol_ball",
    copy_from = "tiny_pistol_ball",
    name = ccb.content.plural_text("tiny pistol ammo, ball (black powder)", "tiny pistol ammo, ball (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        scale = {
            price = 0.3,
            recoil = 0.57,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.57, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_tiny_pistol_jhp",
    copy_from = "tiny_pistol_jhp",
    name = ccb.content.plural_text("tiny pistol ammo, JHP (black powder)", "tiny pistol ammo, JHP (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        scale = {
            price = 0.3,
            recoil = 0.57,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.57, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "small_powder_blank",
    copy_from = "22_blank",
    name = ccb.content.plural_text("pistol blank", "pistol blank"),
    ammunition = {},
}

ccb.content.define_item {
    id = "matchhead_tiny_pistol_ball",
    copy_from = "bp_tiny_pistol_ball",
    name = ccb.content.plural_text("tiny pistol ammo, ball (matchhead powder)", "tiny pistol ammo, ball (matchhead powder)"),
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "matchhead_tiny_pistol_jhp",
    copy_from = "bp_tiny_pistol_jhp",
    name = ccb.content.plural_text("tiny pistol ammo, JHP (matchhead powder)", "tiny pistol ammo, JHP (matchhead powder)"),
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
