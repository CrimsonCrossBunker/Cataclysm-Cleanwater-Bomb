local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_weakpoint_set {
    id = "wps_bird_body",
    points = {
        {
            name = ccb.content.text("the head"),
            head = true,
            armor_multiplier = { physical = 0.75 },
            critical_multiplier = { all = 1.1 },
            difficulty = { melee = 2, ranged = 2 },
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
                    damage_percent = { 11, 100 },
                },
            },
            id = "the head",
        },
        {
            name = ccb.content.text("the belly"),
            armor_multiplier = { physical = 0.5 },
            critical_multiplier = { all = 1.2 },
            difficulty = { melee = 4, ranged = 1 },
            attack_coverage = { ranged = 0.75 },
            coverage = 3,
            when = predicates.has_effect("interlocutor", "downed"),
            id = "the belly",
        },
        {
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            attack_coverage = { ranged = 0.5 },
            difficulty = { point = 10, broad = 10 },
            effects = {
                {
                    effect = "blind",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 25,
                    message = ccb.content.text("The %s is blinded!"),
                    damage_percent = { 1, 25 },
                },
                {
                    effect = "blind",
                    permanent = true,
                    chance = 30,
                    message = ccb.content.text("The %s's eyes are obliterated!"),
                    damage_percent = { 26, 100 },
                },
            },
            id = "the eye",
        },
        {
            name = ccb.content.text("the wing"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 1, melee = 2 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "downed",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 15, 100 },
                },
            },
            coverage = 8,
            id = "the wing",
        },
    },
}
