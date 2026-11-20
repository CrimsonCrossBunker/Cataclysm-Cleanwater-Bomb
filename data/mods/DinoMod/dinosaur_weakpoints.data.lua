local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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

-- Adult sauropod body, no special armor, far above where a normal human can harm it unless downed
ccb.content.define_weakpoint_set {
    id = "wps_sauropod_body",
    points = {
        {
            name = ccb.content.text("the head"),
            head = true,
            armor_multiplier = { physical = 0.75 },
            critical_multiplier = { all = 1.1 },
            difficulty = { melee = 5, ranged = 5 },
            attack_coverage = { ranged = 0.75 },
            coverage = 3,
            when = predicates.has_effect("interlocutor", "downed"),
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
            when = predicates.has_effect("interlocutor", "downed"),
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
    },
}

-- Adult sauropod leg, no special armor, must be badly hurt or destroyed to expose the rest of the dino
ccb.content.define_weakpoint_set {
    id = "wps_sauropod_leg",
    points = {
        {
            name = ccb.content.text("the leg"),
            critical_multiplier = { all = 0.5 },
            difficulty = { ranged = 4, melee = 2 },
            effects = {
                {
                    effect = "downed",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 50, 100 },
                },
            },
            coverage = 8,
            id = "the leg",
        },
        {
            name = ccb.content.text("the foot"),
            difficulty = { ranged = 2, melee = 1 },
            armor_multiplier = { all = 2 },
            critical_multiplier = { all = 0.1 },
            attack_coverage = { melee = 0.1 },
            effects = {
                {
                    effect = "staggered",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 20, 50 },
                },
            },
            coverage = 1,
            id = "the foot",
        },
        {
            name = ccb.content.text("the knee"),
            critical_multiplier = { all = 1.1 },
            difficulty = { ranged = 6 },
            attack_coverage = { ranged = 2 },
            effects = {
                {
                    effect = "staggered",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 20, 50 },
                },
                {
                    effect = "downed",
                    chance = 33,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 50, 100 },
                },
            },
            coverage = 1,
            id = "the knee",
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_lg_theropod_body",
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

ccb.content.define_weakpoint_set {
    id = "wps_ankylosaurid_body",
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

ccb.content.define_weakpoint_set {
    id = "wps_lg_ceratopsian_body",
    points = {
        {
            name = ccb.content.text("the head"),
            head = true,
            armor_multiplier = { physical = 2 },
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

ccb.content.define_weakpoint_set {
    id = "wps_pterosaur_body",
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

ccb.content.define_weakpoint_set {
    id = "wps_mosasaur_body",
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
            name = ccb.content.text("the fin"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 2, melee = 1 },
            attack_coverage = { point = 0.75 },
            coverage = 8,
            id = "the fin",
        },
    },
}
