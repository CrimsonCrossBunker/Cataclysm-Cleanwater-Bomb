local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "wps_yrax_quadraphract",
    points = {
        {
            id = "crystal",
            name = ccb.content.text("a crystalline facet"),
            coverage = 15,
            difficulty = { melee = 4, ranged = 5 },
            armor_multiplier = { all = 0.1 },
        },
        {
            id = "weak_joint",
            name = ccb.content.text("a lightly armored segment"),
            coverage = 10,
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.05 },
            armor_multiplier = { all = 0.75 },
        },
        {
            id = "heavy_armor",
            name = ccb.content.text("a segment of sloped armor"),
            good = false,
            armor_multiplier = { all = 1 },
            critical_multiplier = { all = 0.1 },
            attack_coverage = { melee = 1.5 },
            coverage = 75,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_yrax_quadraphract_leg",
    points = {
        {
            id = "weak_joint",
            name = ccb.content.text("a lightly armored segment"),
            coverage = 10,
            difficulty = { melee = 3, ranged = 6 },
            attack_coverage = { ranged = 1.5 },
            armor_multiplier = { all = 0.75 },
        },
        {
            id = "weak_point",
            name = ccb.content.text("a weak segment"),
            coverage = 5,
            difficulty = { melee = 6, ranged = 8 },
            attack_coverage = { ranged = 2 },
            armor_multiplier = { all = 0.1 },
        },
        {
            id = "heavy_armor",
            name = ccb.content.text("a segment of sloped armor"),
            good = false,
            armor_multiplier = { all = 5 },
            critical_multiplier = { all = 0.1 },
            attack_coverage = { melee = 0.1 },
            coverage = 75,
        },
    },
}
