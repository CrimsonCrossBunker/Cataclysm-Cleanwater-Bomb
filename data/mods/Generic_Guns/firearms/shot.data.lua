local ccb = require("ccb")

ccb.content.define_item {
    id = "shot_double",
    copy_from = "shotgun_d",
    name = ccb.content.text("double-barreled shotgun"),
    description = ccb.content.text("An old-fashioned double barreled shotgun, with a trigger for each barrel.  Follow up shots are incredibly quick with this, but reloading is a bit slow.  Shotshells come in many varieties, and shotguns are suitable for anything from some large game to small birds."),
    variants = {},
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 2 }, rigid = true } },
    gun = { ammunition = { "ammo_shot" } },
}

ccb.content.define_item {
    id = "shot_pipe_double",
    copy_from = "pipe_double_shotgun",
    name = ccb.content.text("double-barrel pipe shotgun"),
    variants = {},
    description = ccb.content.text("A crudely handmade double barreled shotgun, with a trigger for each barrel.  Follow up shots are incredibly quick with this, but reloading is slow, as there are no extractors or ejectors.  Shotshells come in many varieties, and shotguns are suitable for anything from some large game to small birds."),
    gun = { ammunition = { "ammo_shot" } },
}

ccb.content.define_item {
    id = "shot_pump",
    copy_from = "remington_870",
    name = ccb.content.text("sporting shotgun"),
    description = ccb.content.text("A simple, popular design, sporting shotguns are used by law enforcement, civilians and occasionally militaries.  Its internal magazine is small by modern standards, and reloading can be quite slow.  Shotshells come in many varieties, and shotguns are suitable for anything from some large game to small birds."),
    variants = {},
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 6 }, rigid = true } },
    gun = { ammunition = { "ammo_shot" }, clip_size = 6 },
}

ccb.content.define_item {
    id = "shot_short_pump",
    copy_from = "mossberg_590_shockwave",
    name = ccb.content.text("short shotgun"),
    description = ccb.content.text("A simple, shotgun without a stock used by law enforcement and occasionally militaries.  Its internal magazine is small, and reloading can be quite slow.  Shotshells come in many varieties, and shotguns are suitable for anything from some large game to small birds."),
    variants = {},
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 4 }, rigid = true } },
    gun = { ammunition = { "ammo_shot" }, clip_size = 4 },
}

ccb.content.define_item {
    id = "shot_tactical",
    copy_from = "saiga_12",
    name = ccb.content.text("tactical shotgun"),
    description = ccb.content.text("A detachable magazine fed shotgun, mostly oriented towards overly enthusiastic civilians.  Featuring rails and a menacing black appearance, this sort of shotgun doesn't really look like it has a sporting use.  The magazines reduce lengthy reloading times associated with shotguns.  Though known for being somewhat finicky, these can be tuned to run with some reliability."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "shot_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_shot" } },
}

ccb.content.define_item {
    id = "bio_shotgun_gun",
    copy_from = "bio_shotgun_gun",
    name = ccb.content.text("bionic shotgun"),
    variants = {},
    gun = { ammunition = { "ammo_shot" } },
}

ccb.content.define_item {
    id = "slamfire_shotgun",
    copy_from = "slamfire_shotgun",
    name = ccb.content.text("slam-fire pipe shotgun"),
    description = ccb.content.text("A crude shotgun, composed of two thick steel pipes, an end cap, and a nail.  The lack of sights make this weapon only useful at point-blank range."),
    variants = {},
    gun = { ammunition = { "ammo_shot" } },
}

ccb.content.define_item {
    id = "slamfire_shotgun_d",
    copy_from = "slamfire_shotgun_d",
    name = ccb.content.text("double slam-fire pipe shotgun"),
    description = ccb.content.text("A crude shotgun, composed of four thick steel pipes, two end caps, and two nails.  The lack of sights make this weapon only useful at point-blank range."),
    variants = {},
    gun = { ammunition = { "ammo_shot" } },
}

ccb.content.define_item {
    id = "small_shotgun",
    copy_from = "m26_mass_standalone",
    name = ccb.content.text("compact shotgun"),
    description = ccb.content.text("Small shotgun, assembled from underbarrel shotgun modification and a pistol grip.  Not the best weapon, but has a really small size and weight."),
    variants = {},
    gun = { ammunition = { "ammo_shot" } },
}
