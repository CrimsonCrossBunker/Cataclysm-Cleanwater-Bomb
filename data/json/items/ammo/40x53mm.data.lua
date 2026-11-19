local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "40x53mm_grenade",
    abstract = true,
    copy_from = "40x46mm_grenade",
    name = ccb.content.text_without_extraction("40x53mm grenade"),
    mass = "340 g",
    volume = "137 ml",
    length = "112 mm",
    ammunition = { count = 10, type = "40x53mm", range = 60, recoil = 26250, casing = "40x53mm_m169_casing" },
}

ccb.content.define_item {
    id = "40x53mm_m1001",
    name = ccb.content.plural_text("40x53mm M1001 flechette", "40x53mm M1001 flechette"),
    mass = "340 g",
    volume = "137 ml",
    length = "112 mm",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    symbol = "=",
    description = ccb.content.text("A 40x53mm canister shot load, with 113 17-grain flechettes."),
    ascii_picture = "40x53mm_m1001",
    ammunition = {
        count = 10,
        type = "40x53mm",
        damage = { type = "bullet", amount = 65 },
        shot_damage = { type = "bullet", amount = 5 },
        projectile_count = 117,
        shot_spread = 400,
        recoil = 18750,
        casing = "40x53mm_m169_casing",
        effects = { "SHOT" },
    },
}

ccb.content.define_item {
    id = "40x53mm_m430a1",
    copy_from = "40x53mm_grenade",
    name = ccb.content.plural_text("40x53mm M430A1 HEDP", "40x53mm M430A1 HEDP"),
    description = ccb.content.text("A high velocity 40x53mm high explosive dual-purpose grenade.  It can penetrate 3 inches of steel armor, and the fragmentation of the projectile body also makes it suitable for use against infantry."),
    ascii_picture = "40x53mm_m430a1",
    volume = "132 ml",
    inheritance = { add = { projectile_effects = { "EXPLOSIVE_m430a1" } } },
    ammunition = { damage = { type = "bullet", amount = 250, penetration = 45 } },
}

ccb.content.define_item {
    id = "40x53mm_buckshot_m169",
    copy_from = "40x53mm_flechette_m169",
    name = ccb.content.plural_text("40x53mm buckshot, reloaded", "40x53mm buckshot, reloaded"),
    description = ccb.content.text("An improvised 40x53mm buckshot load somewhat resembling M576."),
    ascii_picture = "40x53mm_improvised",
    ammunition = { damage = { type = "bullet", amount = 141 } },
}

ccb.content.define_item {
    id = "40x53mm_slug_m169",
    copy_from = "40x53mm_grenade",
    name = ccb.content.plural_text("40x53mm slug, reloaded", "40x53mm slugs, reloaded"),
    description = ccb.content.text("An improvised 40x53mm load resembling an oversized shotgun slug."),
    ascii_picture = "40x53mm_improvised",
    inheritance = { scale = { price = 0.7, dispersion = 1.1 } },
    ammunition = { damage = { type = "bullet", amount = 141, penetration = 6 } },
}

ccb.content.define_item {
    id = "40x53mm_flechette_m169",
    copy_from = "40x53mm_m1001",
    name = ccb.content.plural_text("40x53mm flechette, reloaded", "40x53mm flechette, reloaded"),
    description = ccb.content.text("An improvised 40x53mm flechette load containing 115 steel darts, similar to a M1001 flechette load."),
    ascii_picture = "40x53mm_improvised",
    inheritance = { scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_40x53mm_buckshot_m169",
    copy_from = "bp_40x53mm_flechette_m169",
    name = ccb.content.plural_text("40x53mm buckshot, black powder", "40x53mm buckshot, black powder"),
    description = ccb.content.text("An improvised 40x53mm buckshot load somewhat resembling M576."),
    ammunition = { damage = { type = "bullet", amount = 119 } },
}

ccb.content.define_item {
    id = "bp_40x53mm_slug_m169",
    copy_from = "40x53mm_grenade",
    name = ccb.content.plural_text("40x53mm slug, black powder", "40x53mm slugs, black powder"),
    description = ccb.content.text("An improvised 40x53mm load resembling an oversized shotgun slug."),
    ascii_picture = "40x53mm_improvised",
    inheritance = {
        add = { projectile_effects = { "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.3, recoil = 0.76, dispersion = 1.2 },
    },
    ammunition = { damage = { type = "bullet", amount = 119, penetration = 3 } },
}

ccb.content.define_item {
    id = "bp_40x53mm_flechette_m169",
    copy_from = "40x53mm_m1001",
    name = ccb.content.plural_text("40x53mm flechette, black powder", "40x53mm flechette, black powder"),
    description = ccb.content.text("An improvised 40x53mm flechette load containing 115 steel darts, similar to a M1001 flechette load."),
    ascii_picture = "40x53mm_improvised",
    inheritance = {
        add = { projectile_effects = { "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.3, recoil = 0.76, dispersion = 1.2 },
    },
    ammunition = { damage = { type = "bullet", amount = 114, penetration = 6 } },
}
