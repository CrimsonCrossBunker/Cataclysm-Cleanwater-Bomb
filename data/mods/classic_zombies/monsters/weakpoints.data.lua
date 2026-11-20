local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Gives you a higher chance of hitting the arm if the enemy is grabbing you.
-- until we can represent chopping off legs, this is a good way to handle a similar effect.  Can mainly only be done with swinging/slashing weaponry.
-- If a zombie is downed, it's way easier to get a headshot.
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_body",
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
            critical_multiplier = { all = 2.5 },
            difficulty = { ranged = 8, melee = 6 },
            attack_coverage = { broad = 0.5 },
            damage_multiplier = { all = 10 },
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
            when = predicates.has_effect("interlocutor", "downed"),
        },
        {
            id = "brain",
            name = ccb.content.text("the brain"),
            head = true,
            coverage = 2,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            effects = {
                {
                    effect = "staggered",
                    death_chance = 100,
                    chance = 100,
                    message = ccb.content.text("The %s collapses in a heap!"),
                    damage_percent = { 7, 100 },
                },
            },
        },
        {
            id = "brain_coup",
            name = ccb.content.text("the brain"),
            head = true,
            coverage = 8,
            difficulty = { melee = 3, ranged = 4 },
            attack_coverage = { broad = 0.5 },
            when = predicates.has_effect("interlocutor", "downed"),
            effects = {
                {
                    effect = "staggered",
                    death_chance = 100,
                    chance = 100,
                    message = ccb.content.text("The %s collapses in a heap!"),
                    damage_percent = { 7, 100 },
                },
            },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_head_big",
    points = {
        {
            id = "head",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 12,
            critical_multiplier = { all = 2 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 1, ranged = 5 },
            attack_coverage = { melee = 2 },
            damage_multiplier = { all = 10 },
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
            critical_multiplier = { all = 2.5 },
            difficulty = { ranged = 7, melee = 5 },
            attack_coverage = { broad = 0.5 },
            damage_multiplier = { all = 10 },
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
        {
            id = "brain",
            name = ccb.content.text("the brain"),
            head = true,
            coverage = 3,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            effects = {
                {
                    effect = "staggered",
                    death_chance = 100,
                    chance = 100,
                    message = ccb.content.text("The %s collapses in a heap!"),
                    damage_percent = { 7, 100 },
                },
            },
        },
        {
            id = "brain_coup",
            name = ccb.content.text("the brain"),
            head = true,
            coverage = 10,
            difficulty = { melee = 3, ranged = 4 },
            attack_coverage = { broad = 0.5 },
            when = predicates.has_effect("interlocutor", "downed"),
            effects = {
                {
                    effect = "staggered",
                    death_chance = 100,
                    chance = 100,
                    message = ccb.content.text("The %s collapses in a heap!"),
                    damage_percent = { 7, 100 },
                },
            },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_head_small",
    points = {
        {
            id = "head",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 6,
            critical_multiplier = { all = 2 },
            armor_multiplier = { physical = 0.75 },
            difficulty = { melee = 1, ranged = 6 },
            attack_coverage = { melee = 2 },
            damage_multiplier = { all = 10 },
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
            critical_multiplier = { all = 2.5 },
            difficulty = { ranged = 10, melee = 8 },
            attack_coverage = { broad = 0.5 },
            damage_multiplier = { all = 10 },
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
        {
            id = "brain",
            name = ccb.content.text("the brain"),
            head = true,
            coverage = 1,
            difficulty = { melee = 6, ranged = 9 },
            attack_coverage = { broad = 0.5 },
            effects = {
                {
                    effect = "staggered",
                    death_chance = 100,
                    chance = 100,
                    message = ccb.content.text("The %s collapses in a heap!"),
                    damage_percent = { 7, 100 },
                },
            },
        },
        {
            id = "brain_coup",
            name = ccb.content.text("the brain"),
            head = true,
            coverage = 5,
            difficulty = { melee = 4, ranged = 7 },
            attack_coverage = { broad = 0.5 },
            when = predicates.has_effect("interlocutor", "downed"),
            effects = {
                {
                    effect = "staggered",
                    death_chance = 100,
                    chance = 100,
                    message = ccb.content.text("The %s collapses in a heap!"),
                    damage_percent = { 7, 100 },
                },
            },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_turnout_gear",
    points = {
        {
            id = "tear",
            name = ccb.content.text("a tear in its turnout gear"),
            armor_multiplier = { physical = 0.5, acid = 0.5 },
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { broad = 0.65 },
            effects = {
                {
                    effect = "staggered",
                    chance = 20,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 1, 3 },
                },
                {
                    effect = "staggered",
                    chance = 40,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 4, 100 },
                },
            },
            coverage = 5,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_body_armor",
    points = {
        {
            id = "stomach_armour",
            name = ccb.content.text("a gap in the armor"),
            armor_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
            attack_coverage = { broad = 0.5 },
            difficulty = { ranged = 4, melee = 1 },
            damage_multiplier = { all = 0.5 },
            coverage = 4,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_humanoid_light_armor",
    points = {
        {
            id = "stomach_armour",
            name = ccb.content.text("a gap in the armor"),
            armor_multiplier = { physical = 0.25 },
            attack_coverage = { broad = 0.75 },
            difficulty = { ranged = 3, melee = 1 },
            coverage = 4,
            damage_multiplier = { all = 0.5 },
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
            armor_multiplier = { physical = 1.5 },
            critical_multiplier = { all = 0.5 },
            attack_coverage = { melee = 0.75 },
            damage_multiplier = { all = 10 },
            coverage = 4,
        },
        {
            id = "head",
            name = ccb.content.text("the face"),
            head = true,
            armor_multiplier = { physical = 0 },
            critical_multiplier = { all = 2 },
            difficulty = { melee = 2, ranged = 7 },
            damage_multiplier = { all = 10 },
            attack_coverage = { melee = 2 },
            coverage = 6,
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
            critical_multiplier = { all = 2.5 },
            damage_multiplier = { all = 10 },
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
            damage_multiplier = { all = 5 },
            coverage = 1,
        },
    },
}

-- the hard part of the helmet is actually the opposite of a weakpoint.
-- If a zombie is downed, it's way easier to get a headshot.  The armor still applies though.
ccb.content.define_weakpoint_set {
    id = "wps_humanoid_full_helmet",
    points = {
        {
            id = "helmet",
            name = ccb.content.text("the helmet"),
            armor_multiplier = { physical = 1.5 },
            critical_multiplier = { all = 0.5 },
            damage_multiplier = { all = 10 },
            attack_coverage = { melee = 0.75 },
            coverage = 4,
        },
        {
            id = "head",
            name = ccb.content.text("the face shield"),
            head = true,
            critical_multiplier = { all = 1.5 },
            difficulty = { melee = 2, ranged = 7 },
            attack_coverage = { melee = 2 },
            damage_multiplier = { all = 10 },
            coverage = 6,
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
            damage_multiplier = { all = 10 },
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
        {
            id = "head_coup",
            name = ccb.content.text("the head"),
            head = true,
            coverage = 25,
            critical_multiplier = { all = 1.5 },
            difficulty = { ranged = 7 },
            attack_coverage = { melee = 2 },
            damage_multiplier = { all = 15 },
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
            when = predicates.has_effect("interlocutor", "downed"),
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
            damage_multiplier = { all = 10 },
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
            damage_multiplier = { all = 0.5 },
            effects = {
                {
                    effect = "downed",
                    chance = 15,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 0, 3 },
                },
                {
                    effect = "downed",
                    chance = 30,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 4, 7 },
                },
                {
                    effect = "downed",
                    chance = 50,
                    message = ccb.content.text("The %s is knocked down!"),
                    damage_percent = { 8, 100 },
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
                    chance = 60,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 4, 100 },
                },
            },
            coverage = 7,
        },
    },
}
