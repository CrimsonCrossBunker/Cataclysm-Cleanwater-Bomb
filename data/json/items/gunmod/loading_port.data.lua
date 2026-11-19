local ccb = require("ccb")

ccb.content.define_item {
    id = "arredondo_chute",
    name = ccb.content.plural_text("speedloader chute", "speedloader chutes"),
    description = ccb.content.text("A metal ramp that can be installed near a shotgun's feeding port to index speedloader tubes.  Need modification before attaching."),
    mass = "135 g",
    volume = "149 ml",
    integral_volume = "149 ml",
    price = "157 USD",
    survival_price = "2 USD 50 cent",
    materials = { "aluminum" },
    symbol = ":",
    color = "green",
    gunmod = {
        install_time = "8 m",
        location = ccb.content.text("loading port"),
        targets = {
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
        },
        compatible_ammo = { "shot" },
    },
    minimum_skills = { { id = "weapon", count = 2 }, { id = "mechanics", count = 1 } },
}

ccb.content.define_item {
    id = "arredondo_chute_benelli_sa",
    name = ccb.content.plural_text("speedloader chute, 4-round waterfowl shotgun", "speedloader chute, 4-round waterfowl shotguns"),
    description = ccb.content.text("A metal ramp that is installed near a shotgun's feeding port to index speedloader tubes.  This one is for 4-round waterfowl shotgun."),
    copy_from = "arredondo_chute",
    gunmod = {
        targets = { ccb.content.text("benelli_sa", "gun_type_type") },
        added_pockets = {
            {
                kind = "MAGAZINE",
                rigid = true,
                ammunition = { shot = 4 },
                allowed_speedloaders = { "shot_speedloader6", "shot_speedloader8" },
            },
        },
    },
}

-- Will be fixed in future PR
ccb.content.define_item {
    id = "arredondo_chute_remington_870_breacher",
    name = ccb.content.plural_text("speedloader chute, 4-round breaching shotgun", "speedloader chute, 4-round breaching shotguns"),
    description = ccb.content.text("A metal ramp that is installed near a shotgun's feeding port to index speedloader tubes.  This one is for 4-round breaching shotgun."),
    copy_from = "arredondo_chute",
    gunmod = {
        targets = {},
        added_pockets = {
            {
                kind = "MAGAZINE",
                rigid = true,
                ammunition = { shot = 4 },
                allowed_speedloaders = { "shot_speedloader6", "shot_speedloader8" },
            },
        },
    },
}

ccb.content.define_item {
    id = "arredondo_chute_remington_870",
    name = ccb.content.plural_text("speedloader chute, 5-round hunting shotgun", "speedloader chute, 5-round hunting shotguns"),
    description = ccb.content.text("A metal ramp that is installed near a shotgun's feeding port to index speedloader tubes.  This one is for 5-round hunting shotgun."),
    copy_from = "arredondo_chute",
    gunmod = {
        targets = { ccb.content.text("remington_870", "gun_type_type") },
        added_pockets = {
            {
                kind = "MAGAZINE",
                rigid = true,
                ammunition = { shot = 5 },
                allowed_speedloaders = { "shot_speedloader6", "shot_speedloader8" },
            },
        },
    },
}

ccb.content.define_item {
    id = "arredondo_chute_mossberg_500",
    name = ccb.content.plural_text("speedloader chute, 6-round combat shotgun", "speedloader chute, 6-round combat shotguns"),
    description = ccb.content.text("A metal ramp that is installed near a shotgun's feeding port to index speedloader tubes.  This one is for 6-round combat shotgun."),
    copy_from = "arredondo_chute",
    gunmod = {
        targets = { ccb.content.text("mossberg_500", "gun_type_type") },
        added_pockets = {
            {
                kind = "MAGAZINE",
                rigid = true,
                ammunition = { shot = 6 },
                allowed_speedloaders = { "shot_speedloader6", "shot_speedloader8" },
            },
        },
    },
}

ccb.content.define_item {
    id = "arredondo_chute_mossberg_930",
    name = ccb.content.plural_text("speedloader chute, 8-round auto-loading shotgun", "speedloader chute, 8-round auto-loading shotguns"),
    description = ccb.content.text("A metal ramp that is installed near a shotgun's feeding port to index speedloader tubes.  This one is for 8-round auto-loading shotgun."),
    copy_from = "arredondo_chute",
    gunmod = {
        targets = { ccb.content.text("mossberg_930", "gun_type_type") },
        added_pockets = {
            {
                kind = "MAGAZINE",
                rigid = true,
                ammunition = { shot = 8 },
                allowed_speedloaders = { "shot_speedloader6", "shot_speedloader8" },
            },
        },
    },
}

ccb.content.define_item {
    id = "arredondo_chute_mossberg_590",
    name = ccb.content.plural_text("speedloader chute, 9-round combat shotgun", "speedloader chute, 9-round combat shotguns"),
    description = ccb.content.text("A metal ramp that is installed near a shotgun's feeding port to index speedloader tubes.  This one is for 9-round combat shotgun."),
    copy_from = "arredondo_chute",
    gunmod = {
        targets = { ccb.content.text("mossberg_590", "gun_type_type") },
        added_pockets = {
            {
                kind = "MAGAZINE",
                rigid = true,
                ammunition = { shot = 9 },
                allowed_speedloaders = { "shot_speedloader6", "shot_speedloader8" },
            },
        },
    },
}
