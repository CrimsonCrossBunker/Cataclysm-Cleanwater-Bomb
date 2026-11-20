local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "wps_mi-go",
    points = {
        {
            id = "arm",
            name = ccb.content.text("the arm"),
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
            id = "leg",
            name = ccb.content.text("the leg"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 4, melee = 3 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "staggered",
                    chance = 10,
                    message = ccb.content.text("The %s is tripped off-balance!"),
                    damage_percent = { 15, 30 },
                },
                {
                    effect = "staggered",
                    chance = 20,
                    message = ccb.content.text("The %s is tripped off-balance!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 15,
        },
        {
            id = "wing",
            name = ccb.content.text("the wing"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 4, melee = 3 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "staggered",
                    chance = 15,
                    message = ccb.content.text("The %s is pushed off-balance!"),
                    damage_percent = { 20, 40 },
                },
                {
                    effect = "staggered",
                    chance = 25,
                    message = ccb.content.text("The %s is pushed off-balance!"),
                    damage_percent = { 51, 100 },
                },
            },
            coverage = 2,
        },
        {
            id = "head",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 5,
            critical_multiplier = { all = 1.1 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { ranged = 5, melee = 4 },
            effects = {
                {
                    effect = "stunned",
                    duration = { "1 seconds", "1 seconds" },
                    chance = 5,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 5, 10 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "1 seconds" },
                    chance = 25,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 50 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "1 seconds" },
                    chance = 45,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 51, 100 },
                },
            },
        },
    },
}
