local ccb = require("ccb")

-- Adds up to 39 ranged and 34 melee coverage.
ccb.content.define_weakpoint_set {
    id = "afs_wps_robot",
    points = {
        {
            id = "power_plant",
            name = ccb.content.text("the main power plant"),
            coverage = 1,
            difficulty = { melee = 10, ranged = 5 },
            attack_coverage = { melee = 0 },
            armor_multiplier = { all = 1.5 },
            effects = {
                {
                    death_chance = 100,
                    message = ccb.content.text("The %s power plants sparks and smokes."),
                    chance = 100,
                    damage_percent = { 1, 100 },
                },
            },
        },
        {
            id = "cpu",
            name = ccb.content.text("the AI core"),
            coverage = 1,
            difficulty = { melee = 10, ranged = 5 },
            attack_coverage = { melee = 0 },
            armor_multiplier = { all = 2 },
            effects = {
                {
                    death_chance = 100,
                    message = ccb.content.text("The %s processor is completely destroyed!"),
                    chance = 100,
                    damage_percent = { 1, 100 },
                },
            },
        },
        {
            id = "governor",
            name = ccb.content.text("the motive governor"),
            coverage = 1,
            difficulty = { melee = 10, ranged = 5 },
            attack_coverage = { melee = 0 },
            armor_multiplier = { all = 2 },
            effects = {
                {
                    effect = "downed",
                    duration = { "5 seconds", "10 seconds" },
                    message = ccb.content.text("The %s stumbles."),
                    damage_percent = { 1, 2 },
                },
                {
                    effect = "effect_robot_immobilized",
                    permanent = true,
                    duration = 86400,
                    chance = 100,
                    message = ccb.content.text("The %s collapses to the ground as its limbs fail!"),
                    damage_percent = { 2, 100 },
                },
            },
        },
        {
            id = "main_sensor",
            name = ccb.content.text("the main sensory array"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 7 },
            attack_coverage = { melee = 2 },
            armor_multiplier = { all = 0.1 },
            effects = {
                {
                    effect = "blind",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 40,
                    message = ccb.content.text("The %s is blinded!"),
                    damage_percent = { 1, 1 },
                },
                {
                    effect = "blind",
                    permanent = true,
                    duration = 86400,
                    chance = 100,
                    message = ccb.content.text("The %s sensor mount is completely destroyed!"),
                    damage_percent = { 1, 100 },
                },
            },
        },
        {
            id = "weak_point",
            name = ccb.content.text("a lightly armored segment"),
            coverage = 20,
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.05 },
            armor_multiplier = { all = 1 },
        },
        {
            id = "heavy_armor",
            name = ccb.content.text("a segment of sloped armor"),
            good = false,
            armor_multiplier = { all = 3 },
            attack_coverage = { melee = 0.15 },
            coverage = 30,
        },
    },
}
