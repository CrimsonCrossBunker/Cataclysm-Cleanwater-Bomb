local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A fallback for netherium abominations for use when no specific ones exist (which are none when this comment is written)
ccb.content.define_weakpoint_set {
    id = "wps_netherium_abomination",
    points = {
        {
            id = "vulnerable spot",
            name = ccb.content.text("a spot that's more vulnerable than the rest"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { point = 0.25 },
            armor_multiplier = { all = 0.75 },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_stiltwalker",
    points = {
        {
            id = "chink in the armor",
            name = ccb.content.text("a narrow crack in the armor plating"),
            coverage = 20,
            difficulty = { melee = 4, ranged = 5 },
            attack_coverage = { point = 2 },
            armor_multiplier = { all = 0.01 },
        },
        {
            id = "chink in the armor",
            name = ccb.content.text("a softer spot in its armor plating"),
            coverage = 40,
            difficulty = { melee = 3, ranged = 4 },
            armor_multiplier = { bullet = 0.25, cut = 0.5, stab = 0.25, bash = 0.5 },
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_void_spider",
    points = {
        {
            id = "weak_point",
            name = ccb.content.text("a band of vulnerable flesh."),
            coverage = 20,
            when = predicates.negate(predicates.has_effect("interlocutor", "maimed_armor")),
            difficulty = { melee = 3, ranged = 4 },
            attack_coverage = { ranged = 0.5 },
            armor_multiplier = { all = 0.03 },
            effects = {
                {
                    effect = "maimed_armor",
                    permanent = true,
                    duration = 86400,
                    chance = 2,
                    message = ccb.content.text("Foul vapor starts seeping from the %s body!"),
                    damage_percent = { 1, 5 },
                },
                {
                    effect = "maimed_armor",
                    permanent = true,
                    duration = 86400,
                    chance = 5,
                    message = ccb.content.text("Foul vapor starts seeping from the %s body!"),
                    damage_percent = { 5, 9 },
                },
                {
                    effect = "maimed_armor",
                    permanent = true,
                    duration = 86400,
                    chance = 20,
                    message = ccb.content.text("Foul vapor starts seeping from the %s body!"),
                    damage_percent = { 10, 100 },
                },
            },
        },
        {
            id = "heavy_armor",
            name = ccb.content.text("a segment full of fangs"),
            good = false,
            armor_multiplier = { all = 1.5 },
            attack_coverage = { melee = 0.15 },
            difficulty = { melee = 5, ranged = 8 },
            when = predicates.negate(predicates.any({ predicates.has_effect("interlocutor", "maimed_armor"), predicates.has_effect("interlocutor", "afs_android_crawling") })),
            coverage = 30,
            effects = {
                {
                    effect = "maimed_armor",
                    permanent = true,
                    duration = 86400,
                    chance = 10,
                    message = ccb.content.text("Foul vapor starts seeping from the %s body!"),
                    damage_percent = { 1, 5 },
                },
                {
                    effect = "maimed_armor",
                    permanent = true,
                    duration = 86400,
                    chance = 30,
                    message = ccb.content.text("Foul vapor starts seeping from the %s body!"),
                    damage_percent = { 5, 100 },
                },
            },
        },
        {
            id = "internal_exposed",
            name = ccb.content.text("its exposed internals"),
            armor_multiplier = { all = 0.01 },
            damage_multiplier = { all = 1.5 },
            when = predicates.has_effect("interlocutor", "maimed_armor"),
            coverage = 45,
        },
    },
}

ccb.content.define_weakpoint_set {
    id = "wps_nether_huntsman",
    points = {
        {
            id = "huntsman_arm",
            name = ccb.content.text("appendage"),
            armor_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 5, melee = 2 },
            attack_coverage = { point = 0.75 },
            effects = {
                {
                    effect = "maimed_huntsman_arm",
                    chance = 15,
                    permanent = true,
                    message = ccb.content.text("The %s makes a pained screech as the appendage goes limp!"),
                    damage_percent = { 10, 30 },
                },
                {
                    effect = "maimed_huntsman_arm",
                    chance = 50,
                    permanent = true,
                    message = ccb.content.text("The %s makes a pained screech as the appendage goes limp!"),
                    damage_percent = { 31, 100 },
                },
            },
            coverage = 12,
        },
        {
            id = "huntsman_armor",
            name = ccb.content.text("its porous armor plate"),
            good = false,
            armor_multiplier = { bullet = 2, cut = 1.5, stab = 1.5, bash = 2 },
            attack_coverage = { ranged = 1, melee = 0.4 },
            coverage = 20,
        },
        {
            id = "huntsman_armor_alt",
            name = ccb.content.text("its armored limb"),
            good = false,
            armor_multiplier = { bullet = 1.7, cut = 1.3, stab = 1.3, bash = 1.7 },
            attack_coverage = { ranged = 1, melee = 0.4 },
            coverage = 20,
        },
        {
            id = "huntsman_armor_gap",
            name = ccb.content.text("a vulnerable spot between the armor"),
            good = true,
            critical_multiplier = { all = 1.25 },
            armor_multiplier = { all = 0.5 },
            difficulty = { melee = 3, ranged = 4 },
            coverage = 7,
        },
        {
            id = "eye",
            name = ccb.content.text("the photoreceptors"),
            head = true,
            coverage = 2,
            armor_multiplier = { physical = 0 },
            critical_multiplier = { all = 1.25 },
            difficulty = { ranged = 7, melee = 5 },
            attack_coverage = { broad = 0.8 },
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
                    chance = 70,
                    message = ccb.content.text("The %s's photoreceptors are obliterated!"),
                    damage_percent = { 26, 100 },
                },
            },
        },
    },
}
