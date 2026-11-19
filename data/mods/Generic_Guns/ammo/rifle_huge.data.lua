local ccb = require("ccb")

ccb.content.define_item {
    id = "rifle_huge_ball",
    copy_from = "50bmg",
    name = ccb.content.plural_text("huge rifle ammo, ball", "huge rifle ammo, ball"),
    description = ccb.content.text("Huge rifle ammunition like this bridges the gap between light cannons and big game rifles.  It's suitable for taking on light vehicles and other materiel, or hunting extremely large game.  'Ball' is an old term for full metal jacketed bullets which offer reduced fouling, better reliability, and slightly improved penetration compared to plain lead."),
    ammunition = { type = "ammo_rifle_huge", casing = "rifle_huge_casing" },
}

ccb.content.define_item {
    id = "rifle_huge_AP",
    copy_from = "rifle_huge_ball",
    name = ccb.content.plural_text("huge rifle ammo, AP", "huge rifle ammo, AP"),
    description = ccb.content.text("Huge rifle ammunition like this bridges the gap between light cannons and big game rifles.  It's suitable for taking on light vehicles and other materiel, or hunting extremely large game.  These armor piercing munitions feature tungsten steel penetrators for use against light-skinned vehicles."),
    inheritance = { offset = { damage = { type = "bullet", amount = -10, penetration = 20 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_rifle_huge_ball",
    copy_from = "rifle_huge_ball",
    name = ccb.content.plural_text("huge rifle ammo, ball (reloaded)", "huge rifle ammo, ball (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_rifle_huge_AP",
    copy_from = "rifle_huge_AP",
    name = ccb.content.plural_text("huge rifle ammo, AP (reloaded)", "huge rifle ammo, AP (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_rifle_huge_ball",
    copy_from = "rifle_huge_ball",
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
    id = "bp_rifle_huge_AP",
    copy_from = "rifle_huge_AP",
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
