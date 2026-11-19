local ccb = require("ccb")

-- Scaling on these three is 75% of normal
ccb.content.define_technique {
    id = "TAIL_THICK_BASH",
    name = ccb.content.text("Thick Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You thwack %s with your tail"),
        ccb.content.text("<npcname> thwacks %s with their tail"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_tail_thick" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "TAIL_THICK_BASH_NATURAL",
    name = ccb.content.text("Thick Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You thwack %s with your tail"),
        ccb.content.text("<npcname> thwacks %s with their tail"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_tail_thick" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick_natural",
}

ccb.content.define_technique {
    id = "TAIL_THICK_BASH_CRIT",
    name = ccb.content.text("Thick Tail Bash Crit"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slam %s with your tail"),
        ccb.content.text("<npcname> slams %s with their tail"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_tail_thick" },
    knockback_dist = 1,
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tail_thick_bash_crit",
}

ccb.content.define_technique {
    id = "TAIL_THICK_BASH_CRIT_VS_STUMBLE",
    name = ccb.content.text("Thick Tail Bash Crit"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slam %s with your tail and knock them down"),
        ccb.content.text("<npcname> slams %s with their tail and knock them down"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_tail_thick" },
    knockback_dist = 1,
    down_dur = 2,
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tail_thick_bash_crit_vs_stumble",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
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
    when = "allow_hooves_kick",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH_VS_LARGE",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_against_large",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH_NATURAL",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
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
    id = "TAIL_CLUB_BASH_NATURAL_VS_LARGE",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_natural_against_large",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH_CRIT",
    name = ccb.content.text("Critical Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You brutally smash %s with your club tail"),
        ccb.content.text("<npcname> brutally smashes %s with their club tail"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 1,
    attack_vectors = { "vector_tail_club" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.5 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_crit",
}
