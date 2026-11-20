local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "wps_slime",
    points = {
        {
            id = "body",
            name = ccb.content.text("the body"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 4, melee = 3 },
            attack_coverage = { point = 0.75 },
            coverage = 6,
        },
        {
            id = "insensitive_spot",
            name = ccb.content.text("a spot with virtually nothing to damage"),
            good = false,
            armor_multiplier = { all = 1.25 },
            critical_multiplier = { all = 0.75 },
            attack_coverage = { melee = 0.75 },
            coverage = 3,
        },
        {
            id = "pseudopod",
            name = ccb.content.text("a pseudopod reaching out to strike you when you deftly counter strike it"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 7, melee = 5 },
            attack_coverage = { point = 0.75 },
            coverage = 5,
        },
    },
}
