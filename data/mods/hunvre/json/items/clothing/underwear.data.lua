local ccb = require("ccb")

-- To make more underwear copy-from this then just add the specific armor definition, name, description and proportional weight and volume.
ccb.content.define_item {
    id = "abstract_underwear",
    copy_from = "abstract_garment_advanced_variants",
    name = ccb.content.plural_text("abstract underwear", "abstract underwear"),
    description = ccb.content.text("Abstract underwear.  If you see this it's a bug, please report."),
    symbol = "[",
    color = "blue",
    looks_like = "shorts",
    materials = { "lycra" },
    mass = "100 g",
    volume = "100 ml",
    survival_price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = { warmth = 5, thickness = 0.1 },
}

ccb.content.define_item {
    id = "boxers",
    copy_from = "abstract_underwear",
    name = ccb.content.plural_text("boxers", "boxers"),
    description = ccb.content.text("Loose men underwear covering most of the thighs."),
    armor = {
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                coverage = 40,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "boxer_briefs",
    copy_from = "boxers",
    name = ccb.content.plural_text("boxer briefs", "boxer briefs"),
    description = ccb.content.text("Men underwear covering most of the thighs."),
    armor = {},
}

ccb.content.define_item {
    id = "trunks",
    copy_from = "abstract_underwear",
    name = ccb.content.plural_text("trunks", "trunks"),
    description = ccb.content.text("Men underwear with a square shape cut."),
    armor = {
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                coverage = 20,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.8, volume = 0.8 } },
}

ccb.content.define_item {
    id = "briefs",
    copy_from = "abstract_underwear",
    name = ccb.content.plural_text("briefs", "briefs"),
    description = ccb.content.text("Men underwear covering the hips with a high leg cut."),
    armor = {
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.6, volume = 0.6 } },
}

ccb.content.define_item {
    id = "thong",
    copy_from = "abstract_underwear",
    name = ccb.content.plural_text("thong", "thong"),
    description = ccb.content.text("Minimal underwear covering the groin and a little bit of the rear."),
    armor = {
        portions = {
            {
                coverage = 60,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.4, volume = 0.4 } },
}

ccb.content.define_item {
    id = "boyshorts",
    copy_from = "abstract_underwear",
    name = ccb.content.plural_text("boy shorts", "boy shorts"),
    description = ccb.content.text("Women underwear with a small rectangular shape cut."),
    armor = {
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                coverage = 10,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.8, volume = 0.8 } },
}

ccb.content.define_item {
    id = "bikini_panties",
    copy_from = "abstract_underwear",
    name = ccb.content.plural_text("bikini panties", "bikini panties"),
    description = ccb.content.text("Women underwear with a low-rise and high leg cut."),
    armor = {
        portions = {
            {
                coverage = 80,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.6, volume = 0.6 } },
}

ccb.content.define_item {
    id = "high_briefs",
    copy_from = "abstract_underwear",
    name = ccb.content.plural_text("high briefs", "high briefs"),
    description = ccb.content.text("Women underwear that leaves the thighs exposed while reaching the waist."),
    armor = {
        portions = {
            { coverage = 10, covers = { "torso" }, subparts = { "torso_lower" } },
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.8, volume = 0.8 } },
}

ccb.content.define_item {
    id = "bra",
    copy_from = "abstract_garment_advanced_variants",
    name = ccb.content.text("bra"),
    description = ccb.content.text("Women underwear providing support for the breasts."),
    symbol = "[",
    color = "blue",
    looks_like = "tank_top",
    materials = { "lycra" },
    mass = "50 g",
    volume = "50 ml",
    survival_price = "50 cent",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = { { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 40 } },
    },
}

ccb.content.define_item {
    id = "sports_bra",
    copy_from = "bra",
    name = ccb.content.text("sports bra"),
    description = ccb.content.text("Women underwear intended for physical activity, providing additional support for the breasts."),
    armor = { portions = { { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 80 } } },
    inheritance = { scale = { mass = 2, volume = 2 } },
}
