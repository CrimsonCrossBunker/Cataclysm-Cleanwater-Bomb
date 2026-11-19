local ccb = require("ccb")

ccb.content.define_item {
    id = "shot_buck",
    copy_from = "shot_00",
    name = ccb.content.plural_text("shotshell, buckshot", "shotshells, buckshot"),
    ammunition = { type = "ammo_shot" },
}

ccb.content.define_item {
    id = "shot_bean",
    copy_from = "shot_buck",
    name = ccb.content.plural_text("shotshell, beanbag", "shotshells, beanbag"),
    description = ccb.content.text("A beanbag round for shotguns, not deadly but designed to disable."),
    inheritance = {
        add = { projectile_effects = { "BEANBAG", "NOGIB" } },
        scale = {
            price = 0.5,
            survival_price = 0.5,
            count = 0.5,
            recoil = 0.4,
            loudness = 0.6,
            damage = { type = "bullet", amount = 0.1 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "shot_fowl",
    copy_from = "shot_buck",
    name = ccb.content.plural_text("shotshell, birdshot", "shotshells, birdshot"),
    description = ccb.content.text("A shotshell filled with numerous small pellets.  Designed for hunting birds and other small game, its applications in combat are very limited."),
    survival_price = "24 USD",
    inheritance = {
        add = { projectile_effects = { "NOGIB" } },
        scale = { price = 0.2, recoil = 0.6, loudness = 0.8, damage = { type = "bullet", amount = 0.3 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "shot_foster",
    copy_from = "shot_buck",
    name = ccb.content.plural_text("shotshell, slug", "shotshells, slug"),
    description = ccb.content.text("A shotshell with a single projectile, shaped somewhat like a shuttlecock.  Slugs are used with shotguns to give them extra range, allowing them to stand in for a rifle.  Extremely damaging but rather inaccurate."),
    inheritance = {
        remove = { projectile_effects = { "SHOT" } },
        scale = { price = 1.4, survival_price = 1.4, recoil = 1.4 },
        offset = { range = 12, damage = { type = "bullet", penetration = 6 } },
    },
    ammunition = { dispersion = 100 },
}

ccb.content.define_item {
    id = "shot_pyro",
    copy_from = "shot_buck",
    name = ccb.content.plural_text("shotshell, pyrotechnical", "shotshells, pyrotechnical"),
    description = ccb.content.text("A novelty shotgun shell filled with a simple pyrotechnical charge.  The payload is light and won't wound very well, but the flash and sparks will certainly be impressive, in addition to being an extreme fire hazard."),
    inheritance = {
        add = { projectile_effects = { "INCENDIARY", "PYROTECHNIC_DISPLAY", "STREAM_TINY", "NOGIB" } },
        scale = {
            price = 2,
            survival_price = 2,
            recoil = 0.6,
            loudness = 0.8,
            dispersion = 1.2,
            range = 0.5,
            damage = { type = "bullet", amount = 0.2 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_junk",
    copy_from = "shot_buck",
    name = ccb.content.plural_text("shotshell, junk", "shotshells, junk"),
    description = ccb.content.text("A shotgun shell filled with whatever was lying around.  They are more damaging than birdshot, but fairly inaccurate."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.4, dispersion = 1.2, damage = { type = "bullet", amount = 0.6 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_buck",
    copy_from = "shot_buck",
    name = ccb.content.plural_text("shotshell, buckshot (reloaded)", "shotshells, buckshot (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_fowl",
    copy_from = "shot_fowl",
    name = ccb.content.plural_text("shotshell, birdshot (reloaded)", "shotshells, birdshot (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_foster",
    copy_from = "shot_foster",
    name = ccb.content.plural_text("shotshell, slug (reloaded)", "shotshells, slug (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_pyro",
    copy_from = "shot_pyro",
    name = ccb.content.plural_text("shotshell, pyrotechnical (reloaded)", "shotshells, pyrotechnical (reloaded)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- intentionally reload only because flechette shot is not available commercially or used by the military
ccb.content.define_item {
    id = "reloaded_shot_dart",
    copy_from = "reloaded_shot_flechette",
    name = ccb.content.plural_text("shotshell, flechette (reloaded)", "shotshells, flechette (reloaded)"),
    description = ccb.content.text("A shotgun shell filled with tiny steel darts, definitely not a factory loading.  Flechettes won't pattern as well as normal shot, and they'll likely do less damage.  However, they may fare better against armor than other shotgun loads."),
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_buck",
    copy_from = "shot_buck",
    name = ccb.content.plural_text("shotshell, buckshot (black powder)", "shotshells, buckshot (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = { price = 0.6, dispersion = 1.2, damage = { type = "bullet", amount = 0.8 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_fowl",
    copy_from = "shot_fowl",
    name = ccb.content.plural_text("shotshell, birdshot (black powder)", "shotshells, birdshot (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = { price = 0.6, dispersion = 1.2, damage = { type = "bullet", amount = 0.8 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_foster",
    copy_from = "shot_foster",
    name = ccb.content.plural_text("shotshell, slug (black powder)", "shotshells, slug (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = { price = 0.6, dispersion = 1.2, damage = { type = "bullet", amount = 0.8 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_pyro",
    copy_from = "shot_pyro",
    name = ccb.content.plural_text("shotshell, pyrotechnical (black powder)", "shotshells, pyrotechnical (black powder)"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = { price = 0.6, dispersion = 1.2, damage = { type = "bullet", amount = 0.8 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_dart",
    copy_from = "reloaded_shot_dart",
    name = ccb.content.plural_text("shotshell, flechette (black powder)", "shotshells, flechette (black powder)"),
    inheritance = {
        add = { projectile_effects = { "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = { price = 0.86, dispersion = 1.09, damage = { type = "bullet", amount = 0.88 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_junk",
    copy_from = "reloaded_shot_junk",
    name = ccb.content.plural_text("shotshell, junk (black powder)", "shotshells, junk (black powder)"),
    inheritance = {
        add = { projectile_effects = { "MUZZLE_SMOKE" } },
        scale = { price = 0.6, damage = { type = "bullet", amount = 0.8 } },
    },
    ammunition = {},
}
