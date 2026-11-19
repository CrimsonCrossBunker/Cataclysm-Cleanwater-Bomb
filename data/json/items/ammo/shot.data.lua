local ccb = require("ccb")

ccb.content.define_item {
    id = "reloaded_shot_bird",
    copy_from = "shot_bird",
    name = ccb.content.plural_text("12 gauge birdshot, reloaded", "12 gauge birdshot, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
            shot_damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_dragon",
    copy_from = "shot_dragon",
    name = ccb.content.plural_text("12 gauge dragon's breath, reloaded", "12 gauge dragon's breath, reloaded"),
    description = ccb.content.text("A shotgun shell filled with magnesium pellets or shards, used mostly as a distress flare or pyrotechnics tool.  When the round is fired, high-temperature sparks and flames shoot out of the barrel.  While looking very impressive, they present more of a fire hazard than an effective tool for lighting up hostiles.  This one was made in somebody's garage.  Are you sure you want to shoot this?"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
            shot_damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_00",
    copy_from = "shot_00",
    name = ccb.content.plural_text("12 gauge buckshot, reloaded", "12 gauge buckshot, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
            shot_damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_flechette",
    copy_from = "shot_flechette",
    name = ccb.content.plural_text("12 gauge flechette, reloaded", "12 gauge flechettes, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
            shot_damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_shot_slug",
    copy_from = "shot_slug",
    name = ccb.content.plural_text("12 gauge slug, reloaded", "12 gauge slugs, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_bird",
    copy_from = "shot_bird",
    name = ccb.content.plural_text("12 gauge birdshot, black powder", "12 gauge birdshot, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
            shot_damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_dragon",
    copy_from = "shot_dragon",
    name = ccb.content.plural_text("12 gauge dragon's breath, black powder", "12 gauge dragon's breath, black powder"),
    description = ccb.content.text("A shotgun shell filled with magnesium pellets or shards, used mostly as a distress flare or pyrotechnics tool.  When the round is fired, high-temperature sparks and flames shoot out of the barrel.  While looking very impressive, they present more of a fire hazard than an effective tool for lighting up hostiles.  This one was made in somebody's garage.  Are you sure you want to shoot this?"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
            shot_damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_00",
    copy_from = "shot_00",
    name = ccb.content.plural_text("12 gauge buckshot, black powder", "12 gauge buckshot, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
            shot_damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_flechette",
    copy_from = "shot_flechette",
    name = ccb.content.plural_text("12 gauge flechette, black powder", "12 gauge flechettes, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
            shot_damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_slug",
    copy_from = "shot_slug",
    name = ccb.content.plural_text("12 gauge slug, black powder", "12 gauge slugs, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "shotshell_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("base shotshell"),
    mass = "47 g",
    volume = "18 ml",
    length = "57 mm",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "plastic", "lead", "powder" },
    symbol = "=",
    color = "red",
    ammunition = { count = 1, type = "shot", casing = "shot_hull" },
}

ccb.content.define_item {
    id = "shot_00",
    copy_from = "shotshell_abstract",
    name = ccb.content.plural_text("12 gauge buckshot", "12 gauge buckshot"),
    mass = "43 g",
    description = ccb.content.text("A 12 gauge shotgun shell, filled with 9 pellets of 00 buck.  A very common and versatile round, they're useful for both self defense and for hunting.  The spread of the shot doesn't just increase your chances to have a projectile hit, it also causes a much larger wound, greatly increasing lethality.  It does struggle with range, and against body armor."),
    ascii_picture = "shot_00",
    price = "25 cent",
    survival_price = "40 cent",
    ammunition = {
        range = 18,
        damage = { type = "bullet", amount = 60 },
        shot_damage = { type = "bullet", amount = 15 },
        projectile_count = 9,
        shot_spread = 300,
        recoil = 2500,
        loudness = 160,
        effects = { "COOKOFF", "SHOT" },
    },
}

ccb.content.define_item {
    id = "shot_beanbag",
    copy_from = "shotshell_abstract",
    name = ccb.content.text("12 gauge beanbag"),
    description = ccb.content.text("A beanbag round for shotguns.  Designated 'less-lethal' and intended to disable, but remember that 'less-lethal' does not mean 'non-lethal'."),
    ascii_picture = "shot_beanbag",
    mass = "57 g",
    price = "50 cent",
    survival_price = "20 cent",
    ammunition = {
        range = 10,
        count = 1,
        damage = { type = "bullet", amount = 5 },
        recoil = 1000,
        loudness = 100,
        effects = { "BEANBAG", "COOKOFF", "NOGIB" },
    },
}

ccb.content.define_item {
    id = "shot_bird",
    copy_from = "shotshell_abstract",
    name = ccb.content.plural_text("12 gauge birdshot", "12 gauge birdshot"),
    mass = "38 g",
    description = ccb.content.text("Weak shotgun ammunition, filled with tiny pellets and a low powder charge.  Used often for shooting clays or birds, they're a very common commercial round.  Their effectiveness against human targets are quite limited outside of very close ranges, serving more to hurt than kill."),
    ascii_picture = "shot_bird",
    price = "5 cent",
    survival_price = "20 cent",
    ammunition = {
        projectile_count = 100,
        shot_spread = 300,
        range = 18,
        shot_damage = { type = "bullet", amount = 0.2 },
        damage = { type = "bullet", amount = 50 },
        recoil = 1500,
        loudness = 128,
        effects = { "COOKOFF", "SHOT", "NOGIB" },
    },
}

ccb.content.define_item {
    id = "shot_dragon",
    copy_from = "shot_bird",
    name = ccb.content.plural_text("12 gauge dragon's breath", "12 gauge dragon's breath"),
    description = ccb.content.text("A shotgun shell filled with magnesium pellets or shards, used mostly as a distress flare or pyrotechnics tool.  When the round is fired, high-temperature sparks and flames shoot out of the barrel.  While looking very impressive, they present more of a fire hazard than an effective tool for lighting up hostiles."),
    ascii_picture = "shot_dragon",
    price = "50 cent",
    survival_price = "5 cent",
    inheritance = {
        add = { projectile_effects = { "INCENDIARY", "PYROTECHNIC_DISPLAY" } },
        scale = { range = 0.5 },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "shot_flechette",
    copy_from = "shot_00",
    name = ccb.content.text("12 gauge flechette"),
    description = ccb.content.text("A shotgun shell filled with tiny steel darts.  While looking quite dangerous, their actual effectiveness is questionable.  Despite being finned, they have a tendency to tumble mid-air, leading to greater spread and reduced damage."),
    ascii_picture = "shot_flechette",
    price = "1 USD",
    survival_price = "50 cent",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    ammunition = {
        projectile_count = 19,
        shot_spread = 500,
        range = 18,
        shot_damage = { type = "bullet", amount = 8 },
        damage = { type = "bullet", amount = 39 },
    },
}

ccb.content.define_item {
    id = "shot_scrap",
    copy_from = "shot_00",
    name = ccb.content.plural_text("12 gauge scrap shot, reloaded", "12 gauge scrap shot, reloaded"),
    description = ccb.content.text("A shotgun shell filled with whatever scrap metal was lying around.  More damaging than birdshot, but fairly inaccurate."),
    ascii_picture = "shot_scrap",
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.4, shot_spread = 1.2, damage = { type = "bullet", amount = 0.6 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_shot_scrap",
    copy_from = "shot_scrap",
    name = ccb.content.plural_text("12 gauge scrap shot, black powder", "12 gauge scrap shot, black powder"),
    description = ccb.content.text("A shotgun shell filled with black gunpowder and whatever scrap metal was lying around.  The logical conclusion of ammunition bootlegging.  It'll kill zombies just fine, but your gun will suffer for it."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = { price = 0.6, damage = { type = "bullet", amount = 0.8 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "shot_slug",
    copy_from = "shotshell_abstract",
    name = ccb.content.text("12 gauge slug"),
    description = ccb.content.text("A 12 gauge slug.  Unlike birdshot or buckshot, slugs are a single large projectile fired from a shotgun.  They're mostly used for hunting bigger game, or for longer range shots where typical buck may spread out more.  Not as lethal as buckshot in certain ranges, but much more accurate and with a longer range, and is more effective against armor."),
    ascii_picture = "shot_slug",
    price = "4 USD",
    survival_price = "4 USD",
    ammunition = {
        range = 24,
        dispersion = 100,
        damage = {
            type = "bullet",
            amount = 50,
            penetration = 6,
            barrels = {
                { length = "13 mm", amount = 8 },
                { length = "14 mm", amount = 9 },
                { length = "16 mm", amount = 10 },
                { length = "17 mm", amount = 11 },
                { length = "19 mm", amount = 12 },
                { length = "20 mm", amount = 13 },
                { length = "22 mm", amount = 14 },
                { length = "24 mm", amount = 15 },
                { length = "26 mm", amount = 16 },
                { length = "28 mm", amount = 17 },
                { length = "31 mm", amount = 18 },
                { length = "33 mm", amount = 19 },
                { length = "36 mm", amount = 20 },
                { length = "39 mm", amount = 21 },
                { length = "43 mm", amount = 22 },
                { length = "46 mm", amount = 23 },
                { length = "51 mm", amount = 24 },
                { length = "55 mm", amount = 25 },
                { length = "60 mm", amount = 26 },
                { length = "65 mm", amount = 27 },
                { length = "71 mm", amount = 28 },
                { length = "77 mm", amount = 29 },
                { length = "84 mm", amount = 30 },
                { length = "91 mm", amount = 31 },
                { length = "99 mm", amount = 32 },
                { length = "108 mm", amount = 33 },
                { length = "118 mm", amount = 34 },
                { length = "128 mm", amount = 35 },
                { length = "140 mm", amount = 36 },
                { length = "152 mm", amount = 37 },
                { length = "166 mm", amount = 38 },
                { length = "180 mm", amount = 39 },
                { length = "196 mm", amount = 40 },
                { length = "214 mm", amount = 41 },
                { length = "233 mm", amount = 42 },
                { length = "253 mm", amount = 43 },
                { length = "276 mm", amount = 44 },
                { length = "300 mm", amount = 45 },
                { length = "327 mm", amount = 46 },
                { length = "356 mm", amount = 47 },
                { length = "388 mm", amount = 48 },
                { length = "422 mm", amount = 49 },
                { length = "460 mm", amount = 50 },
                { length = "500 mm", amount = 51 },
                { length = "545 mm", amount = 52 },
                { length = "593 mm", amount = 53 },
                { length = "646 mm", amount = 54 },
                { length = "703 mm", amount = 55 },
                { length = "766 mm", amount = 56 },
                { length = "834 mm", amount = 57 },
                { length = "908 mm", amount = 58 },
                { length = "989 mm", amount = 59 },
                { length = "1077 mm", amount = 60 },
                { length = "1173 mm", amount = 61 },
                { length = "1277 mm", amount = 62 },
                { length = "1391 mm", amount = 63 },
                { length = "1514 mm", amount = 64 },
                { length = "1649 mm", amount = 65 },
                { length = "1796 mm", amount = 66 },
                { length = "1955 mm", amount = 67 },
            },
        },
        recoil = 3500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "wax_slug",
    copy_from = "shot_slug",
    name = ccb.content.text("wax slug"),
    description = ccb.content.text("A round of 12 gauge birdshot that has had the crimp opened, and wax poured into the shot to mimic the performance of a proper slug."),
    inheritance = {
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.75, survival_price = 0.75, damage = { type = "bullet", amount = 0.75 } },
    },
    ammunition = { range = 16, dispersion = 350, recoil = 1500 },
}
