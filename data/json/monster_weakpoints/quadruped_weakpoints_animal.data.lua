local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "wps_animal_quadruped",
    points = {
        {
            name = ccb.content.text("the head"),
            id = "head",
            head = true,
            armor_multiplier = { physical = 0.75 },
            critical_multiplier = { all = 1.1 },
            difficulty = { melee = 2, ranged = 4 },
            damage_multiplier = { physical = 1.1 },
            attack_coverage = { ranged = 0.75 },
            coverage = 3,
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
            name = ccb.content.text("the chest"),
            id = "chest",
            armor_multiplier = { bash = 2 },
            difficulty = { melee = 2, ranged = 1 },
            damage_multiplier = { stab = 1.25, bullet = 1.33 },
            coverage = 18,
        },
        {
            name = ccb.content.text("the chest"),
            id = "heart",
            armor_multiplier = { bullet = 2.5, cut = 1.5, stab = 2, bash = 0 },
            difficulty = { ranged = 4 },
            damage_multiplier = { physical = 2 },
            attack_coverage = { melee = 0 },
            coverage = 0.3,
            effects = {
                { effect = "bleed", intensity = { 25, 40 }, permanent = true, damage_percent = { 1, 100 } },
            },
        },
        {
            name = ccb.content.text("the leg"),
            id = "leg",
            difficulty = { melee = 1, ranged = 2 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "staggered",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 10, 25 },
                },
                {
                    effect = "downed",
                    chance = 33,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 26, 100 },
                },
            },
            coverage = 16,
        },
    },
}
