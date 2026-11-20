local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Gives you a higher chance of hitting the arm if the enemy is grabbing you.
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_body",
    points = {
        {
            id = "arm",
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
            id = "part_grabbing",
            name = ccb.content.text("the arm"),
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
            id = "leg",
            name = ccb.content.text("the leg"),
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
            id = "head",
            name = ccb.content.text("the head"),
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

-- overrides weakpoints of the same id from wps_humanoid_body
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_head_big",
    points = {
        {
            id = "head",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 6,
            critical_multiplier = { all = 1.1 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 3, ranged = 5 },
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
            id = "eye",
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 7, melee = 5 },
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
                    message = ccb.content.text("The %s's eyes are obliterated!"),
                    damage_percent = { 26, 100 },
                },
            },
        },
    },
}

-- overrides weakpoints of the same id from wps_humanoid_body
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_head_small",
    points = {
        {
            id = "head",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 3,
            critical_multiplier = { all = 1.1 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 3, ranged = 6 },
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
            id = "eye",
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 10, melee = 8 },
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
                    message = ccb.content.text("The %s's eyes are obliterated!"),
                    damage_percent = { 26, 100 },
                },
            },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_turnout_gear",
    points = {
        {
            id = "arm",
            name = ccb.content.text("a tear in its turnout gear"),
            armor_multiplier = { physical = 0.5, acid = 0.5 },
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { broad = 0.65 },
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
            coverage = 5,
        },
        {
            id = "leg",
            name = ccb.content.text("a tear in its turnout gear"),
            armor_multiplier = { physical = 0.5, acid = 0.5 },
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { broad = 0.55 },
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
            coverage = 5,
        },
    },
}

-- Note that most bullet hits on an armour plate probably shatter it, but not all of them shatter it enough to matter for future attacks.
-- Note that most bullet hits on an armour plate probably shatter it, but not all of them shatter it enough to matter for future attacks.
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_body_armor",
    points = {
        {
            id = "arm",
            name = ccb.content.text("the arm"),
            armor_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
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
            id = "armpit",
            name = ccb.content.text("the armpit"),
            armor_multiplier = { bullet = 0.3, cut = 0.3, stab = 0.15, bash = 0.15 },
            difficulty = { all = 5 },
            attack_coverage = { ranged = 0.1 },
            coverage = 1,
        },
        {
            id = "armour_plate_bullet",
            name = ccb.content.text("the body armor"),
            good = false,
            armor_multiplier = { cut = 1.5, stab = 1.5, bash = 1.5 },
            attack_coverage = { ranged = 0.8, melee = 0 },
            when = predicates.negate(predicates.has_effect("interlocutor", "shattered")),
            effects = {
                {
                    effect = "shattered",
                    chance = 25,
                    message = ccb.content.text("The %s's armor is shattered!"),
                    damage_percent = { 1, 10 },
                    permanent = true,
                },
                {
                    effect = "shattered",
                    chance = 50,
                    message = ccb.content.text("The %s's armor is shattered!"),
                    damage_percent = { 11, 30 },
                    permanent = true,
                },
                {
                    effect = "shattered",
                    chance = 75,
                    message = ccb.content.text("The %s's armor is shattered!"),
                    damage_percent = { 31, 200 },
                    permanent = true,
                },
            },
            coverage = 50,
        },
        {
            id = "armour_plate_melee",
            name = ccb.content.text("the body armor"),
            good = false,
            armor_multiplier = { cut = 1.3, stab = 1.15, bash = 1.15 },
            attack_coverage = { ranged = 0, melee = 0.8 },
            when = predicates.negate(predicates.has_effect("interlocutor", "shattered")),
            effects = {
                {
                    effect = "shattered",
                    chance = 15,
                    message = ccb.content.text("The armor is shattered!"),
                    damage_percent = { 5, 20 },
                    permanent = true,
                },
                {
                    effect = "shattered",
                    chance = 40,
                    message = ccb.content.text("The armor is shattered!"),
                    damage_percent = { 21, 40 },
                    permanent = true,
                },
                {
                    effect = "shattered",
                    chance = 60,
                    message = ccb.content.text("The armor is shattered!"),
                    damage_percent = { 41, 200 },
                    permanent = true,
                },
            },
            coverage = 50,
        },
        {
            id = "armour_shattered",
            name = ccb.content.text("the shattered armor plating"),
            armor_multiplier = { all = 0.25 },
            difficulty = { broad = 3, point = 2 },
            attack_coverage = { ranged = 0.8 },
            coverage = 40,
            when = predicates.has_effect("interlocutor", "shattered"),
        },
        {
            id = "side_armour",
            name = ccb.content.text("the weak armor on the side"),
            armor_multiplier = { bullet = 0.3, cut = 0.3, stab = 0.15, bash = 0.15 },
            difficulty = { broad = 4, point = 1 },
            attack_coverage = { ranged = 0.65 },
            coverage = 4,
        },
        {
            id = "stomach_armour",
            name = ccb.content.text("a gap in the stomach armor"),
            armor_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
            attack_coverage = { broad = 0.5 },
            difficulty = { ranged = 4, melee = 1 },
            coverage = 4,
        },
        {
            id = "leg",
            name = ccb.content.text("an unarmored part of the leg"),
            armor_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
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
            coverage = 8,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_light_armor",
    points = {
        {
            id = "arm",
            name = ccb.content.text("the arm"),
            armor_multiplier = { physical = 0.25 },
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
            id = "side_armour",
            name = ccb.content.text("the weak armor on the side"),
            armor_multiplier = { physical = 0.15 },
            difficulty = { broad = 2, point = 1 },
            attack_coverage = { ranged = 0.65 },
            coverage = 4,
        },
        {
            id = "stomach_armour",
            name = ccb.content.text("a gap in the stomach armor"),
            armor_multiplier = { physical = 0.25 },
            attack_coverage = { broad = 0.75 },
            difficulty = { ranged = 3, melee = 1 },
            coverage = 4,
        },
        {
            id = "leg",
            name = ccb.content.text("an unarmored part of the leg"),
            armor_multiplier = { physical = 0.25 },
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 3, melee = 1 },
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
            coverage = 12,
        },
    },
}

-- the hard part of the helmet is actually the opposite of a weakpoint.
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_open_helmet",
    points = {
        {
            id = "helmet",
            name = ccb.content.text("the helmet"),
            good = false,
            armor_multiplier = { physical = 1.5 },
            critical_multiplier = { all = 0.5 },
            attack_coverage = { melee = 0.75 },
            coverage = 3,
        },
        {
            id = "head",
            name = ccb.content.text("the face"),
            head = true,
            armor_multiplier = { physical = 0 },
            critical_multiplier = { all = 1.1 },
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.5 },
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
            id = "eye",
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            attack_coverage = { ranged = 0.5 },
            difficulty = { point = 7, broad = 9 },
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
        },
        {
            id = "neck",
            name = ccb.content.text("the neck"),
            head = true,
            armor_multiplier = { physical = 0.25 },
            difficulty = { melee = 4, ranged = 6 },
            attack_coverage = { broad = 0.5 },
            coverage = 1,
        },
    },
}

-- the hard part of the helmet is actually the opposite of a weakpoint.
-- All right, I'll admit it, I only added this effect so I could make the joke.  What you gonna do about it?
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_full_helmet",
    points = {
        {
            id = "helmet",
            name = ccb.content.text("the helmet"),
            good = false,
            armor_multiplier = { physical = 1.5 },
            critical_multiplier = { all = 0.5 },
            attack_coverage = { melee = 0.75 },
            coverage = 3,
        },
        {
            id = "head",
            name = ccb.content.text("the face shield"),
            head = true,
            critical_multiplier = { all = 1.1 },
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.5 },
            coverage = 3,
            effects = {
                {
                    effect = "stunned",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 1,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 5,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 50 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 10,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 51, 100 },
                },
            },
        },
        {
            id = "eye",
            name = ccb.content.text("the goggles"),
            head = true,
            armor_multiplier = { physical = 1 },
            coverage = 1,
            attack_coverage = { ranged = 0.5 },
            difficulty = { point = 7, broad = 9 },
            effects = {
                {
                    effect = "blind",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 1,
                    message = ccb.content.text("The %s is blinded!  The goggles, they did nothing!"),
                    damage_percent = { 20, 100 },
                },
            },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_gasmask",
    points = {
        {
            id = "eye",
            name = ccb.content.text("the goggles"),
            head = true,
            armor_multiplier = { physical = 1 },
            coverage = 1,
            attack_coverage = { ranged = 0.5 },
            difficulty = { point = 7, broad = 9 },
            effects = {
                {
                    effect = "blind",
                    duration = { "1 seconds", "2 seconds" },
                    chance = 1,
                    message = ccb.content.text("The %s is blinded!  The goggles, they did nothing!"),
                    damage_percent = { 20, 100 },
                },
            },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_child_body",
    points = {
        {
            id = "leg",
            name = ccb.content.text("the leg"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 3, melee = 2 },
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
            coverage = 9,
        },
        {
            id = "arm",
            name = ccb.content.text("the arm"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 3, melee = 1 },
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
            coverage = 7,
        },
    },
}

-- Basically the same as wps_humanoid_body but without the head weakpoints for headless zombies.
-- Gives you a higher chance of hitting the arm if the enemy is grabbing you.
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_body_headless",
    points = {
        {
            id = "arm",
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
            id = "part_grabbing",
            name = ccb.content.text("the arm"),
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
            id = "leg",
            name = ccb.content.text("the leg"),
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
    },
}
