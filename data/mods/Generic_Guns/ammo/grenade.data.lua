local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_ammo",
    abstract = true,
    copy_from = "40x46mm_grenade",
    name = ccb.content.text("grenade cartridge"),
    ammunition = { type = "ammo_grenade", casing = "grenade_casing" },
}

ccb.content.define_item {
    id = "grenade_ammo_hedp",
    copy_from = "grenade_ammo",
    name = ccb.content.text("HEDP grenade cartridge"),
    description = ccb.content.text("A grenade cartridge with a high explosive dual purpose load, capable of producing good penetration and a high number of damaging fragments.  Good for armored or soft targets."),
    inheritance = { add = { projectile_effects = { "FRAG_20x66", "EXPLOSIVE", "SPECIAL_COOKOFF" } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "grenade_ammo_beanbag",
    copy_from = "grenade_ammo",
    name = ccb.content.text("beanbag grenade cartridge"),
    description = ccb.content.text("A less-lethal beanbag grenade cartridge that delivers strong impact on target, causing major pain and disorientation.  May still injure or kill."),
    inheritance = { add = { projectile_effects = { "LARGE_BEANBAG" } } },
    ammunition = { damage = { type = "bullet", amount = 20 } },
}

ccb.content.define_item {
    id = "grenade_ammo_flare",
    copy_from = "grenade_ammo",
    name = ccb.content.text("flare grenade cartridge"),
    description = ccb.content.text("A signal flare grenade cartridge.  It will burn brightly for up to a minute, and will also leave a streak of smoke cover in its wake."),
    inheritance = { add = { projectile_effects = { "TRAIL", "NO_EMBED" } } },
    ammunition = { drop = "handflare_lit" },
}

ccb.content.define_item {
    id = "grenade_ammo_shot",
    copy_from = "grenade_ammo",
    name = ccb.content.text("buckshot grenade cartridge"),
    description = ccb.content.text("A grenade cartridge with a powerful buckshot load, designed to provide some defensive options when carrying a grenade launcher."),
    inheritance = { add = { projectile_effects = { "SHOT" } } },
    ammunition = { range = 12, damage = { type = "bullet", amount = 85 }, recoil = 525 },
}

ccb.content.define_item {
    id = "grenade_ammo_smoke",
    copy_from = "grenade_ammo",
    name = ccb.content.text("smoke grenade cartridge"),
    description = ccb.content.text("A grenade cartridge grenade designed to provide smoke cover."),
    inheritance = { add = { projectile_effects = { "TRAIL", "NO_EMBED" } } },
    ammunition = { drop = "smokebomb_act" },
}

ccb.content.define_item {
    id = "grenade_ammo_teargas",
    copy_from = "grenade_ammo",
    name = ccb.content.text("teargas grenade cartridge"),
    description = ccb.content.text("A grenade cartridge with a teargas load.  It will disburse a cloud of highly incapacitating gas."),
    inheritance = { add = { projectile_effects = { "NO_EMBED" } } },
    ammunition = { drop = "gasbomb_act" },
}

ccb.content.define_item {
    id = "grenade_ammo_slug",
    copy_from = "grenade_ammo",
    name = ccb.content.text("slug grenade cartridge"),
    description = ccb.content.text("A grenade cartridge loaded with a massive bullet.  Say goodbye to your shoulder, I guess."),
    inheritance = { add = { projectile_effects = { "LARGE_BEANBAG" } } },
    ammunition = { damage = { type = "bullet", amount = 130 }, recoil = 875 },
}
