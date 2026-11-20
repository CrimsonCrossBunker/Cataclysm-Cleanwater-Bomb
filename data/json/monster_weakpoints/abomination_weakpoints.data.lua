local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_weakpoint_set {
    id = "wps_amalgamation_base",
    points = {
        {
            id = "leg",
            name = ccb.content.text("a leg"),
            difficulty = { melee = 3, ranged = 3 },
            damage_multiplier = { all = 0.66 },
            critical_multiplier = { all = 0.66 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "staggered",
                    chance = 5,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 10, 30 },
                },
                {
                    effect = "staggered",
                    chance = 15,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 30, 100 },
                },
            },
            coverage = 10,
        },
        {
            id = "leg_joint",
            name = ccb.content.text("a joint"),
            damage_multiplier = { all = 0.66 },
            critical_multiplier = { all = 0.66 },
            armor_multiplier = { all = 0.5 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "staggered",
                    chance = 25,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 5, 20 },
                },
                {
                    effect = "staggered",
                    chance = 40,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 21, 100 },
                },
                {
                    effect = "maimed_leg",
                    chance = 10,
                    duration = { "5 seconds", "25 seconds" },
                    message = ccb.content.text("The %s's leg falls limp!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "maimed_leg",
                    chance = 25,
                    duration = { "15 seconds", "50 seconds" },
                    message = ccb.content.text("The %s's leg falls limp!"),
                    damage_percent = { 11, 30 },
                },
                {
                    effect = "maimed_leg",
                    chance = 25,
                    duration = 86400,
                    message = ccb.content.text("The %s's leg is disabled!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 2,
        },
        {
            id = "head",
            name = ccb.content.text("the head"),
            head = true,
            damage_multiplier = { all = 1.1 },
            critical_multiplier = { all = 1.1 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 3, ranged = 5 },
            coverage = 3,
        },
        {
            id = "eye",
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0.4 },
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 8, melee = 6 },
            effects = {
                {
                    effect = "blind",
                    duration = 86400,
                    chance = 20,
                    message = ccb.content.text("The %s's eyes are obliterated!"),
                    damage_percent = { 35, 100 },
                },
            },
            coverage = 2,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_amalgamation_acid",
    points = {
        {
            id = "acid_gland",
            name = ccb.content.text("the acid gland"),
            armor_multiplier = { physical = 0.5 },
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 5, melee = 5 },
            effects = {
                {
                    effect = "maimed_acid_gland",
                    chance = 15,
                    duration = { "1 seconds", "10 seconds" },
                    message = ccb.content.text("The %s's acid glands are maimed!"),
                    damage_percent = { 1, 15 },
                },
                {
                    effect = "maimed_acid_gland",
                    chance = 33,
                    duration = { "5 seconds", "25 seconds" },
                    message = ccb.content.text("The %s's acid glands are maimed!"),
                    damage_percent = { 16, 30 },
                },
                {
                    effect = "maimed_acid_gland",
                    chance = 50,
                    duration = 86400,
                    message = ccb.content.text("The %s's acid glands are destroyed!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 7,
        },
        {
            id = "proboscis",
            name = ccb.content.text("the proboscis"),
            head = true,
            damage_multiplier = { all = 0.5 },
            critical_multiplier = { all = 0.5 },
            difficulty = { ranged = 5, melee = 3 },
            effects = {
                {
                    effect = "maimed_mandible",
                    chance = 25,
                    duration = { "1 seconds", "10 seconds" },
                    message = ccb.content.text("The %s's proboscis is maimed!"),
                    damage_percent = { 1, 15 },
                },
                {
                    effect = "maimed_mandible",
                    chance = 50,
                    duration = { "5 seconds", "25 seconds" },
                    message = ccb.content.text("The %s's proboscis is maimed!"),
                    damage_percent = { 16, 30 },
                },
                {
                    effect = "maimed_mandible",
                    chance = 50,
                    duration = 86400,
                    message = ccb.content.text("The %s's proboscis is destroyed!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 5,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_amalgamation_armor",
    points = {
        {
            id = "armor_thin",
            name = ccb.content.text("a thin part of its armor"),
            armor_multiplier = { all = 0.5 },
            critical_multiplier = { all = 1.25 },
            attack_coverage = { point = 1.5 },
            difficulty = { ranged = 6, melee = 6 },
            coverage = 15,
        },
        {
            id = "armor_thick",
            name = ccb.content.text("a thick part of its armor"),
            good = false,
            armor_multiplier = { all = 2.0 },
            critical_multiplier = { all = 0.75 },
            attack_coverage = { cut = 1.5 },
            coverage = 20,
            effects = {
                {
                    effect = "maimed_armor",
                    chance = 15,
                    duration = 86400,
                    message = ccb.content.text("The %s's armor cracks!"),
                    damage_percent = { 10, 30 },
                },
                {
                    effect = "maimed_armor",
                    chance = 50,
                    duration = 86400,
                    message = ccb.content.text("The %s's armor cracks!"),
                    damage_percent = { 31, 100 },
                },
            },
        },
        {
            id = "armor_cracked",
            name = ccb.content.text("a crack in the armor"),
            armor_multiplier = { all = 0.33 },
            critical_multiplier = { all = 1.2 },
            coverage = 15,
            attack_coverage = { cut = 1.5 },
            when = predicates.has_effect("interlocutor", "maimed_armor"),
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_amalgamation_electric",
    points = {
        {
            id = "capacitor",
            name = ccb.content.text("the glowing organ"),
            armor_multiplier = { physical = 0.5 },
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 3, melee = 3 },
            effects = {
                {
                    effect = "maimed_capacitor",
                    chance = 25,
                    duration = { "1 seconds", "10 seconds" },
                    message = ccb.content.text("Sparks fly from the %s!"),
                    damage_percent = { 1, 15 },
                },
                {
                    effect = "maimed_acid_gland",
                    chance = 50,
                    duration = { "5 seconds", "25 seconds" },
                    message = ccb.content.text("Sparks fly from the %s!"),
                    damage_percent = { 16, 30 },
                },
                {
                    effect = "maimed_acid_gland",
                    chance = 50,
                    duration = 86400,
                    message = ccb.content.text("The %s's glowing organ sputters out!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 10,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_amalgamation_mandible",
    points = {
        {
            id = "mandible",
            name = ccb.content.text("the mandibles"),
            head = true,
            difficulty = { ranged = 5, melee = 3 },
            effects = {
                {
                    effect = "maimed_mandible",
                    chance = 25,
                    duration = { "1 seconds", "10 seconds" },
                    message = ccb.content.text("The %s's mandibles are maimed!"),
                    damage_percent = { 1, 15 },
                },
                {
                    effect = "maimed_mandible",
                    chance = 50,
                    duration = { "5 seconds", "25 seconds" },
                    message = ccb.content.text("The %s's mandibles are maimed!"),
                    damage_percent = { 16, 30 },
                },
                {
                    effect = "maimed_mandible",
                    chance = 50,
                    duration = 86400,
                    message = ccb.content.text("The %s's mandibles are destroyed!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 5,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_amalgamation_tail",
    points = {
        {
            id = "tail",
            name = ccb.content.text("the tail"),
            armor_multiplier = { physical = 0.7 },
            damage_multiplier = { all = 0.7 },
            critical_multiplier = { all = 0.7 },
            effects = {
                {
                    effect = "maimed_tail",
                    chance = 25,
                    duration = { "15 seconds", "30 seconds" },
                    message = ccb.content.text("The %s's tail is maimed!"),
                    damage_percent = { 0, 24 },
                },
                {
                    effect = "maimed_tail",
                    chance = 50,
                    duration = 86400,
                    message = ccb.content.text("The %s's tail is disabled!"),
                    damage_percent = { 25, 100 },
                },
            },
            coverage = 15,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_amalgamation_wing",
    points = {
        {
            id = "wing",
            name = ccb.content.text("the wings"),
            armor_multiplier = { physical = 0.2 },
            damage_multiplier = { all = 0.5 },
            critical_multiplier = { all = 0.5 },
            effects = {
                {
                    effect = "maimed_wings",
                    chance = 25,
                    duration = { "15 seconds", "30 seconds" },
                    message = ccb.content.text("The %s's wings are maimed!"),
                    damage_percent = { 0, 24 },
                },
                {
                    effect = "maimed_wings",
                    chance = 50,
                    duration = 86400,
                    message = ccb.content.text("The %s's wings are disabled!"),
                    damage_percent = { 25, 100 },
                },
            },
            coverage = 8,
        },
    },
}
