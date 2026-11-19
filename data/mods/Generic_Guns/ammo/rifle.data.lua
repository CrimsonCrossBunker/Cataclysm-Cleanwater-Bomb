local ccb = require("ccb")

ccb.content.define_item {
    id = "rifle_ball",
    copy_from = "762_51",
    name = ccb.content.plural_text("rifle ammo, ball", "rifle ammo, ball"),
    description = ccb.content.text("Modern rifle ammunition, ubiquitous and affordable.  It's suitable for international conflicts, hunting small to large game, home defense, and these days, zombies.  'Ball' is an old term for full metal jacketed bullets which offer reduced fouling, better reliability, and slightly improved penetration compared to plain lead."),
    ammunition = { type = "ammo_rifle", casing = "rifle_casing" },
}

ccb.content.define_item {
    id = "rifle_AP",
    copy_from = "rifle_ball",
    name = ccb.content.plural_text("rifle ammo, AP", "rifle ammo, AP"),
    description = ccb.content.text("Modern rifle ammunition, ubiquitous and affordable.  It's suitable for international conflicts, hunting small to large game, home defense, and these days, zombies.  This 'armor piercing' variant features a mild steel penetrator for environmental friendliness, improved barrier penetration, and enhanced effect on armor."),
    inheritance = { offset = { damage = { type = "bullet", amount = -2, penetration = 4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_rifle_ball",
    copy_from = "rifle_ball",
    name = ccb.content.plural_text("rifle ammo, ball (reloaded)", "rifle ammo, ball (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_rifle_AP",
    copy_from = "rifle_AP",
    name = ccb.content.plural_text("rifle ammo, AP (reloaded)", "rifle ammo, AP (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_rifle_ball",
    copy_from = "rifle_ball",
    name = ccb.content.plural_text("rifle ammo, ball (black powder)", "rifle ammo, ball (black powder)"),
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
    id = "bp_rifle_AP",
    copy_from = "rifle_AP",
    name = ccb.content.plural_text("rifle ammo, AP (black powder)", "rifle ammo, AP (black powder)"),
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
    id = "rifle_ball_foreign",
    copy_from = "rifle_ball",
    name = ccb.content.plural_text("foreign rifle ammo, ball", "foreign rifle ammo, ball"),
    description = ccb.content.text("Foreign rifle ammo brought by the Exodii, and very common amongst them."),
    ammunition = { type = "ammo_rifle_foreign" },
}

ccb.content.define_item {
    id = "rifle_AP_foreign",
    copy_from = "rifle_AP",
    name = ccb.content.plural_text("foreign rifle ammo, AP", "foreign rifle ammo, AP"),
    description = ccb.content.text("Foreign armour piercing rifle ammo brought by the Exodii, common amongst them."),
    ammunition = { type = "ammo_rifle_foreign" },
}

ccb.content.define_item {
    id = "reloaded_rifle_ball_foreign",
    copy_from = "rifle_ball_foreign",
    name = ccb.content.plural_text("foreign rifle ammo, ball (reloaded)", "foreign rifle ammo, ball (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_rifle_AP_foreign",
    copy_from = "rifle_AP_foreign",
    name = ccb.content.plural_text("foreign rifle ammo, AP (reloaded)", "foreign rifle ammo, AP (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_rifle_ball_foreign",
    copy_from = "rifle_ball_foreign",
    name = ccb.content.plural_text("foreign rifle ammo, ball (black powder)", "foreign rifle ammo, ball (black powder)"),
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
    id = "bp_rifle_AP_foreign",
    copy_from = "rifle_AP_foreign",
    name = ccb.content.plural_text("foreign rifle ammo, ball (black powder)", "foreign rifle ammo, ball (black powder)"),
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
    id = "rifle_rail_ammo",
    copy_from = "12mm",
    name = ccb.content.plural_text("railgun rifle ammo", "railgun rifle ammo"),
    description = ccb.content.text("Projectile used for a railgun.  It's made of a ferromagnetic metal, probably cobalt."),
    ammunition = { type = "ammo_railgun" },
}

ccb.content.define_item {
    id = "rifle_ball_cannon",
    copy_from = "33naval_ball",
    name = ccb.content.plural_text("foreign cannon rifle ammo, ball", "foreign cannon rifle ammo, ball"),
    description = ccb.content.text("Foreign cannon rifle ammo brought by the Exodii, capable to destroy lightly armored vehicles, as well as highly armored mutants."),
    ammunition = { type = "ammo_rifle_cannon" },
}
