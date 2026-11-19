local ccb = require("ccb")

ccb.content.define_item {
    id = "shot_00",
    copy_from = "shotshell_abstract",
    name = ccb.content.plural_text("12 gauge buckshot", "12 gauge buckshot"),
    mass = "43 g",
    description = ccb.content.text("A 12 gauge shotgun shell, filled with 9 pellets of 00 buck.  A very common and versatile round, they're useful for both self defense and for hunting.  The spread of the shot doesn't just increase your chances to have a projectile hit, it also causes a much larger wound, greatly increasing lethality.  It does struggle with range, and against body armor."),
    ascii_picture = "shot_00",
    price = "5 USD",
    survival_price = "8 USD",
    ammunition = {
        range = 18,
        damage = { type = "bullet", amount = 60 },
        shot_damage = { type = "bullet", amount = 15, penetration = 4 },
        projectile_count = 9,
        shot_spread = 300,
        recoil = 2500,
        loudness = 160,
        effects = { "COOKOFF", "SHOT" },
    },
}

ccb.content.define_item {
    id = "afs_shot_he",
    copy_from = "shot_slug",
    name = ccb.content.text("12 gauge explosive slug"),
    description = ccb.content.text("A shotgun shell shooting a small explosive.  Banned in several states.  While an explosive from a shotgun sounds impressive, its practical applications are limited at best.  The loss in mass in order to accommodate an explosive give it much less impact force compared to traditional ammunition.  The relatively small size of the slug can only accommodate a limited amount of explosives, resulting in a fairly underwhelming explosion.  These traits make it a utility tool for damaging barriers and disrupting other explosive devices, rather than something for anti-personnel use."),
    ascii_picture = "afs_shot_he",
    price = "30 USD",
    survival_price = "16 USD",
    inheritance = { add = { projectile_effects = { "EXPLOSIVE_HESHOT" } } },
    ammunition = { count = 5, damage = { type = "bullet", amount = 10, penetration = 0 } },
}
