local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "wps_triffid",
    points = {
        {
            id = "branch",
            name = ccb.content.text("the branch"),
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
            id = "root",
            name = ccb.content.text("the root"),
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
            id = "flower",
            name = ccb.content.text("the flower"),
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
        {
            id = "gap",
            name = ccb.content.text("a small gap in the bark"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            armor_multiplier = { all = 0.25 },
        },
        {
            id = "joint",
            name = ccb.content.text("a soft fold in the thick bark"),
            coverage = 10,
            difficulty = { melee = 3, ranged = 5 },
            attack_coverage = { point = 0.75 },
            armor_multiplier = { all = 0.5 },
        },
        {
            id = "thick bark",
            name = ccb.content.text("a particularly thick patch of the bark"),
            good = false,
            armor_multiplier = { all = 1.25 },
            critical_multiplier = { all = 0.75 },
            attack_coverage = { melee = 0.75 },
            coverage = 3,
        },
    },
}
