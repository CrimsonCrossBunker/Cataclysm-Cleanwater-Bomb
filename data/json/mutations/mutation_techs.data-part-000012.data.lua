local ccb = require("ccb")

ccb.content.define_technique {
    id = "HOOVES_KICK",
    name = ccb.content.text("Hoof Kick"),
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_AGAINST_LARGE",
    name = ccb.content.text("Hoof Kick"),
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_against_large",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_NATURAL",
    name = ccb.content.text("Hoof Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    weighting = 2,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    knockback_dist = 1,
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_natural",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_NATURAL_AGAINST_LARGE",
    name = ccb.content.text("Hoof Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    weighting = 2,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_natural_against_large",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_CRIT",
    name = ccb.content.text("Critical Hoof Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your hooves, knocking them down."),
        ccb.content.text("<npcname> kick %s with their hooves, knocking them down."),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 1,
    attack_vectors = { "vector_hoof_kick" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_crit",
}

ccb.content.define_technique {
    id = "TOE_TALONS_KICK",
    name = ccb.content.text("Toe Talons Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your taloned feet"),
        ccb.content.text("<npcname> kicks %s with their taloned feet"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_foot_toes", "vector_foot_sole", "vector_foot_heel" },
    effects = {
        {
            id = "bleed",
            chance = 35,
            duration_turns = 60,
            on_damage = true,
            message = ccb.content.text("Your kick opens up bleeding gashes on %s!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "TOE_TALONS_KICK_NATURAL",
    name = ccb.content.text("Toe Talons Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your taloned feet"),
        ccb.content.text("<npcname> kicks %s with their taloned feet"),
    },
    unarmed_allowed = true,
    weighting = -1,
    reach_ok = false,
    attack_vectors = { "vector_foot_toes", "vector_foot_sole", "vector_foot_heel" },
    effects = {
        {
            id = "bleed",
            chance = 35,
            duration_turns = 60,
            on_damage = true,
            message = ccb.content.text("Your kick opens up bleeding gashes on %s!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick_natural",
}
