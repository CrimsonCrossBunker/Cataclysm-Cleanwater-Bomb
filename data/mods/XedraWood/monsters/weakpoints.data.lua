local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Gives you a higher chance of hitting the arm if the enemy is grabbing you.
-- until we can represent chopping off legs, this is a good way to handle a similar effect.  Can mainly only be done with swinging/slashing weaponry.
-- If a zombie is downed, it's way easier to get a headshot.
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_zombie_body",
    points = {
        {
            id = "arm",
            name = ccb.content.text("the arm"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 4, melee = 1 },
            attack_coverage = { point = 0.75 },
            damage_multiplier = { all = 0.5 },
            effects = {
                {
                    effect = "staggered",
                    chance = 20,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 0, 3 },
                },
                {
                    effect = "staggered",
                    chance = 40,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 4, 100 },
                },
            },
            coverage = 8,
        },
        {
            id = "part_grabbing",
            name = ccb.content.text("the arm"),
            critical_multiplier = { all = 0.75 },
            damage_multiplier = { all = 0.5 },
            effects = {
                {
                    effect = "staggered",
                    chance = 30,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 0, 3 },
                },
                {
                    effect = "staggered",
                    chance = 50,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 4, 100 },
                },
            },
            when = predicates.has_effect("interlocutor", "grabbing"),
            coverage = 8,
        },
        {
            id = "leg",
            name = ccb.content.text("the leg"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { point = 0.75 },
            damage_multiplier = { all = 0.5 },
            effects = {
                {
                    effect = "downed",
                    chance = 10,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 0, 3 },
                },
                {
                    effect = "downed",
                    chance = 20,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 4, 7 },
                },
                {
                    effect = "downed",
                    chance = 40,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 8, 100 },
                },
            },
            coverage = 15,
        },
        {
            id = "leg_mangled",
            name = ccb.content.text("the leg"),
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { point = 0.1 },
            damage_multiplier = { all = 0.5 },
            effects = {
                {
                    effect = "downed",
                    chance = 40,
                    permanent = true,
                    message = ccb.content.text("The %s is knocked down, and doesn't look like it can get back up!"),
                    damage_percent = { 3, 6 },
                },
                {
                    effect = "downed",
                    chance = 80,
                    permanent = true,
                    message = ccb.content.text("The %s is knocked down, and doesn't look like it can get back up!"),
                    damage_percent = { 7, 100 },
                },
            },
            coverage = 10,
        },
        {
            id = "head",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 8,
            critical_multiplier = { all = 2 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 1, ranged = 5 },
            attack_coverage = { melee = 2 },
            damage_multiplier = { all = 10 },
            effects = {
                {
                    effect = "stunned",
                    duration = { 1, 2 },
                    chance = 5,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "stunned",
                    duration = { 1, 2 },
                    chance = 25,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 50 },
                },
                {
                    effect = "stunned",
                    duration = { 1, 2 },
                    chance = 45,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 51, 100 },
                },
            },
        },
        {
            id = "eye",
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 2.5 },
            difficulty = { ranged = 8, melee = 6 },
            attack_coverage = { broad = 0.5 },
            damage_multiplier = { all = 10 },
            effects = {
                {
                    effect = "blind",
                    duration = { 1, 2 },
                    chance = 40,
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
        },
        {
            id = "head_coup",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 25,
            critical_multiplier = { all = 2 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { ranged = 5 },
            attack_coverage = { melee = 2 },
            damage_multiplier = { all = 15 },
            effects = {
                {
                    effect = "stunned",
                    duration = { 1, 2 },
                    chance = 5,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "stunned",
                    duration = { 1, 2 },
                    chance = 25,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 50 },
                },
                {
                    effect = "stunned",
                    duration = { 1, 2 },
                    chance = 45,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 51, 100 },
                },
            },
            when = predicates.has_effect("interlocutor", "downed"),
        },
    },
}

-- Generic dino body, no special armor, weaknesses, everything in hitting range of a normal human
ccb.content.define_weakpoint_set {
    id = "wps_dinosaur_body",
    points = {
        {
            name = ccb.content.text("the head"),
            head = true,
            armor_multiplier = { physical = 0.75 },
            critical_multiplier = { all = 1.1 },
            difficulty = { melee = 1, ranged = 3 },
            attack_coverage = { ranged = 0.75 },
            coverage = 3,
            effects = {
                {
                    effect = "stunned",
                    duration = { 1, 2 },
                    chance = 5,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "stunned",
                    duration = { 1, 2 },
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
            critical_multiplier = { all = 1.1 },
            difficulty = { melee = 1, ranged = 1 },
            attack_coverage = { ranged = 0.75 },
            coverage = 3,
            id = "the belly",
        },
        {
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            attack_coverage = { ranged = 0.5 },
            difficulty = { point = 4, broad = 6 },
            effects = {
                {
                    effect = "blind",
                    duration = { 1, 2 },
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
            name = ccb.content.text("the leg"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 2, melee = 1 },
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
            id = "the leg",
        },
    },
}
