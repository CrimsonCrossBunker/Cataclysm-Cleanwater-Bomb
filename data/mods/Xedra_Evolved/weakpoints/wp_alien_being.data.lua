local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Gives you a higher chance of hitting the arm if the enemy is grabbing you.
ccb.content.define_weakpoint_set {
    id = "wps_alien_biology",
    points = {
        {
            id = "vital_gap",
            name = ccb.content.text("this small gap leads to something vital"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            armor_multiplier = { all = 0.25 },
        },
        {
            id = "alien_joint",
            name = ccb.content.text("where a limb derives motion from"),
            coverage = 8,
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.25 },
            armor_multiplier = { all = 0.5 },
        },
        {
            id = "hard_point",
            name = ccb.content.text("a particularly strong part of the body"),
            armor_multiplier = { all = 1.25 },
            critical_multiplier = { all = 0.75 },
            attack_coverage = { melee = 0.75 },
            coverage = 12,
        },
        {
            id = "grasping_appendage",
            name = ccb.content.text("the arm"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 4, melee = 1 },
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
            coverage = 8,
        },
        {
            id = "part_grasping_appendage",
            name = ccb.content.text("the grasping appendage"),
            critical_multiplier = { all = 0.75 },
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
            when = predicates.has_effect("interlocutor", "grabbing"),
            coverage = 8,
        },
        {
            id = "alien_leg",
            name = ccb.content.text("the leg"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "downed",
                    chance = 3,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 10, 30 },
                },
                {
                    effect = "downed",
                    chance = 8,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 31, 50 },
                },
                {
                    effect = "downed",
                    chance = 16,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 51, 100 },
                },
            },
            coverage = 15,
        },
    },
}
