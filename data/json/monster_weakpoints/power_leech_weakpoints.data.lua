local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "wps_power_leech",
    points = {
        {
            id = "frond",
            name = ccb.content.text("the frond"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 4, melee = 3 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "staggered",
                    chance = 15,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 10, 30 },
                },
                {
                    effect = "staggered",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 6,
        },
        {
            id = "rhizome",
            name = ccb.content.text("the rhizome"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "downed",
                    chance = 5,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 10, 30 },
                },
                {
                    effect = "downed",
                    chance = 15,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 31, 50 },
                },
                {
                    effect = "downed",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 51, 100 },
                },
            },
            coverage = 15,
        },
        {
            id = "crown",
            name = ccb.content.text("the crown"),
            head = true,
            coverage = 5,
            critical_multiplier = { all = 1.1 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 2, ranged = 5 },
            effects = {
                {
                    effect = "stunned",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 5,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 25,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 50 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 45,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 51, 100 },
                },
            },
        },
    },
}
