local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_weakpoint_set {
    id = "wps_natural_armor",
    points = {
        {
            id = "gap",
            name = ccb.content.text("a small gap in the thick hide"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            armor_multiplier = { all = 0.25 },
        },
        {
            id = "joint",
            name = ccb.content.text("a soft fold in the thick hide"),
            coverage = 10,
            difficulty = { melee = 3, ranged = 5 },
            attack_coverage = { point = 0.75 },
            armor_multiplier = { all = 0.5 },
        },
        {
            id = "hard_hide",
            name = ccb.content.text("a particularly thick patch of hide"),
            good = false,
            armor_multiplier = { all = 1.25 },
            critical_multiplier = { all = 0.75 },
            attack_coverage = { melee = 0.75 },
            coverage = 3,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_bone_armor",
    points = {
        {
            id = "gap",
            name = ccb.content.text("a small gap in the bony plates"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            armor_multiplier = { all = 0.25 },
        },
        {
            id = "joint",
            name = ccb.content.text("a joint in the bony plates"),
            coverage = 10,
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.25 },
            armor_multiplier = { all = 0.5 },
        },
        {
            id = "hard_point",
            name = ccb.content.text("a particularly thick patch of bone"),
            good = false,
            armor_multiplier = { all = 1.25 },
            critical_multiplier = { all = 0.75 },
            attack_coverage = { melee = 0.75 },
            coverage = 3,
        },
    },
}

-- Similar to wps_bone_armor for rust plated and rust shelled zombies.
ccb.content.define_weakpoint_set {
    id = "wps_metal_shell_armor",
    points = {
        {
            id = "gap",
            name = ccb.content.text("a small fissure between the metal plates"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { broad = 0.5 },
            armor_multiplier = { all = 0.35 },
        },
        {
            id = "joint",
            name = ccb.content.text("an exposed joint unprotected by the metal plates"),
            coverage = 10,
            difficulty = { melee = 3, ranged = 7 },
            attack_coverage = { ranged = 0.25 },
            armor_multiplier = { all = 0.15 },
        },
        {
            id = "hard_point",
            name = ccb.content.text("a strong, rigid chunk of metal"),
            good = false,
            armor_multiplier = { all = 1.4 },
            critical_multiplier = { all = 0.75 },
            attack_coverage = { melee = 0.75 },
            coverage = 3,
        },
    },
}

-- only pair of eyes
-- ["make the game properly track (maybe as an effect?) amount of working eyes", "so you may be able to hit first eye, and then another one (or both in one buck shot)", "probably require weakpoint being able to increase intensity of existing effects"]
ccb.content.define_weakpoint_set {
    id = "wps_eyes",
    points = {
        {
            id = "eye",
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            attack_coverage = { ranged = 0.5 },
            difficulty = { melee = 10, ranged = 10 },
            effects = {
                {
                    effect = "blind",
                    duration = { "1 seconds", "3 seconds" },
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

-- Let's assume that larger-than-tiny eyes are mildly more resistant to damage.
ccb.content.define_weakpoint_set {
    id = "wps_eyes_big",
    points = {
        {
            id = "eye",
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0.2 },
            coverage = 2,
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 7, melee = 5 },
            attack_coverage = { broad = 0.5 },
            effects = {
                {
                    effect = "blind",
                    duration = { "1 seconds", "2 seconds" },
                    message = ccb.content.text("The %s is blinded!"),
                    damage_percent = { 1, 40 },
                },
                {
                    effect = "blind",
                    permanent = true,
                    chance = 20,
                    message = ccb.content.text("The %s's eyes are obliterated!"),
                    damage_percent = { 41, 100 },
                },
            },
        },
    },
}

-- For creatures that bleed and breath, so animals, humanoids and some initial, generic zombie types.
-- small chance to penetrate both lungs in one shot
-- since both heart and lungs are generally close to each other, you can hit both in the same attack
-- rest of internal organs, that would make monster die, but not as fast; liver and similar
ccb.content.define_weakpoint_set {
    id = "wps_vital_organs",
    points = {
        {
            name = ccb.content.text("the head"),
            id = "brain",
            armor_multiplier = { physical = 0.45 },
            difficulty = { melee = 4, ranged = 7 },
            damage_multiplier = { physical = 2 },
            attack_coverage = { melee = 0 },
            coverage = 0.5,
            head = true,
            effects = {
                {
                    death_chance = 100,
                    message = ccb.content.text("With a clean attack to the head, %s drops dead like a puppet with strings cut."),
                },
            },
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
            name = ccb.content.text("the chest"),
            id = "lungs",
            armor_multiplier = { physical = 0.45 },
            difficulty = { ranged = 4 },
            damage_multiplier = { physical = 2 },
            attack_coverage = { melee = 0 },
            coverage = 4,
            effects = {
                { effect = "lung_collapse", intensity = 1, permanent = true, damage_percent = { 1, 100 } },
                {
                    effect = "lung_collapse",
                    chance = 15,
                    intensity = 2,
                    permanent = true,
                    damage_percent = { 1, 100 },
                },
            },
        },
        {
            name = ccb.content.text("the chest"),
            id = "lungs_second_time",
            armor_multiplier = { physical = 0.45 },
            difficulty = { ranged = 4 },
            damage_multiplier = { physical = 2 },
            attack_coverage = { melee = 0 },
            coverage = 2,
            when = predicates.has_effect("interlocutor", "lung_collapse"),
            effects = {
                {
                    effect = "lung_collapse",
                    chance = 15,
                    intensity = 2,
                    permanent = true,
                    damage_percent = { 1, 100 },
                },
            },
        },
        {
            name = ccb.content.text("the chest"),
            id = "heart_and_lungs",
            armor_multiplier = { bullet = 2.5, cut = 1.5, stab = 2, bash = 0 },
            difficulty = { ranged = 4 },
            damage_multiplier = { physical = 2 },
            attack_coverage = { melee = 0 },
            coverage = 0.1,
            effects = {
                { effect = "bleed", intensity = { 25, 40 }, permanent = true, damage_percent = { 1, 100 } },
                { effect = "lung_collapse", intensity = 1, permanent = true, damage_percent = { 1, 100 } },
            },
        },
        {
            name = ccb.content.text("the vitals"),
            id = "vitals",
            armor_multiplier = { physical = 0.45 },
            difficulty = { ranged = 4 },
            damage_multiplier = { physical = 2 },
            attack_coverage = { melee = 0 },
            coverage = 3,
            effects = {
                {
                    effect = "bleed",
                    intensity = { 10, 22 },
                    permanent = true,
                    message = ccb.content.text("The %s is shot in the vitals!"),
                    damage_percent = { 1, 100 },
                },
            },
        },
    },
}
