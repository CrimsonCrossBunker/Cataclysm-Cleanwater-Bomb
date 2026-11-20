local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- if animal is downed,  hitting the head should be way easier too!
-- this should be limited to downed animals and present opport. to hit vitals.  hitting belly per se is easier though, esp. with melee
-- downed eye variant.  easier to hit with melee, but ranged unchanged
-- standing animal, eyes are nigh impossible to hit (with non point weapons.  actually, reach weapons, but not possible here, so point it is)
-- legs are the easiest target, but usually also hardy.
ccb.content.define_weakpoint_set {
    id = "wps_megafauna_body",
    points = {
        {
            id = "head_normal",
            name = ccb.content.text("the head"),
            head = true,
            armor_multiplier = { physical = 0.75 },
            damage_multiplier = { all = 1.25 },
            critical_multiplier = { all = 1.25 },
            difficulty = { all = 4 },
            attack_coverage = { ranged = 1.2, stab = 1.5 },
            coverage = 3,
            effects = {
                {
                    effect = "stunned",
                    duration = { "1 seconds", "3 seconds" },
                    chance = 7,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "3 seconds" },
                    chance = 18,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 100 },
                },
                {
                    effect = "dazed",
                    duration = { "1 seconds", "3 seconds" },
                    chance = 10,
                    message = ccb.content.text("The %s is dazed!"),
                    damage_percent = { 10, 100 },
                },
            },
        },
        {
            id = "head_down",
            name = ccb.content.text("the downed %s head"),
            head = true,
            armor_multiplier = { physical = 0.75 },
            damage_multiplier = { all = 1.25 },
            critical_multiplier = { all = 1.25 },
            difficulty = { all = 2 },
            attack_coverage = { ranged = 0.3 },
            coverage = 10,
            when = predicates.has_effect("interlocutor", "downed"),
            effects = {
                {
                    effect = "stunned",
                    duration = { "1 seconds", "3 seconds" },
                    chance = 7,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 1, 10 },
                },
                {
                    effect = "stunned",
                    duration = { "1 seconds", "3 seconds" },
                    chance = 18,
                    message = ccb.content.text("The %s is stunned!"),
                    damage_percent = { 11, 100 },
                },
                {
                    effect = "dazed",
                    duration = { "1 seconds", "3 seconds" },
                    chance = 10,
                    message = ccb.content.text("The %s is dazed!"),
                    damage_percent = { 10, 100 },
                },
            },
        },
        {
            name = ccb.content.text("the belly"),
            armor_multiplier = { physical = 0.5 },
            critical_multiplier = { all = 1.2 },
            difficulty = { melee = 2, ranged = 4 },
            attack_coverage = { ranged = 0.5 },
            coverage = 25,
            when = predicates.has_effect("interlocutor", "downed"),
            effects = {
                {
                    effect = "nausea",
                    permanent = true,
                    chance = 10,
                    message = ccb.content.text("You have ripped the %1$s bowels!  The %1$s is retching."),
                    damage_percent = { 5, 25 },
                },
                {
                    effect = "winded",
                    permanent = true,
                    chance = 10,
                    message = ccb.content.text("You have punctured the %1$s lungs!  The %1$s has trouble breathing."),
                    damage_percent = { 5, 25 },
                },
            },
            id = "the belly",
        },
        {
            name = ccb.content.text("the downed %s eyes"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            attack_coverage = { ranged = 0.5 },
            difficulty = { ranged = 4, melee = 3 },
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
            id = "the downed %s eyes",
        },
        {
            name = ccb.content.text("the eyes"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            critical_multiplier = { all = 1.25 },
            attack_coverage = { ranged = 0.5 },
            difficulty = { ranged = 6, melee = 10 },
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
            id = "the eyes",
        },
        {
            name = ccb.content.text("the leg"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 2, melee = 1 },
            attack_coverage = { point = 0.75 },
            coverage = 8,
            effects = {
                {
                    effect = "staggered",
                    chance = 25,
                    duration = { "1 seconds", "2 seconds" },
                    message = ccb.content.text("The %s is staggered!"),
                    damage_percent = { 10, 100 },
                },
                {
                    effect = "maimed_leg",
                    chance = 14,
                    permanent = true,
                    message = ccb.content.text("You maim one of the %s legs!"),
                    damage_percent = { 10, 100 },
                },
                {
                    effect = "downed",
                    chance = 20,
                    message = ccb.content.text("The %s is knocked down, leaving its vitals unprotected!"),
                    damage_percent = { 20, 100 },
                },
            },
            id = "the leg",
        },
    },
}
