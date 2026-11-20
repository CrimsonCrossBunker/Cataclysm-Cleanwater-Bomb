local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Gives you a higher chance of hitting the arm if the enemy is grabbing you.
ccb.content.define_weakpoint_set {
    id = "wps_combat_cyborg",
    points = {
        {
            id = "small_gap",
            name = ccb.content.text("a small gap in the armored plates"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            armor_multiplier = { all = 0.25 },
        },
        {
            id = "weak_joint",
            name = ccb.content.text("a joint in the armored plates"),
            coverage = 8,
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.25 },
            armor_multiplier = { all = 0.5 },
        },
        {
            id = "hard_point",
            name = ccb.content.text("a particularly thick patch of armor"),
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
            id = "cyborg_leg",
            name = ccb.content.text("the cybernetic leg"),
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
        {
            id = "motive_power",
            name = ccb.content.text("the motive power box"),
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
                    chance = 15,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 50 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 25,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 51, 100 },
                },
            },
        },
        {
            id = "vid_eye_aperture",
            name = ccb.content.text("the video aperture"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 8, melee = 6 },
            attack_coverage = { broad = 0.5 },
            effects = {
                {
                    effect = "blind",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 40,
                    message = ccb.content.text("The %s is blinded!"),
                    damage_percent = { 1, 25 },
                },
                {
                    effect = "blind",
                    permanent = true,
                    chance = 30,
                    message = ccb.content.text("Sparks fly from the aperture!"),
                    damage_percent = { 26, 100 },
                },
            },
        },
    },
}
