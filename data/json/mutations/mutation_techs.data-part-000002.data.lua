local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_RODENT_BITE",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A rodent bite."),
    attack_vectors = { "vector_rodent_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_rodent_bite",
}

ccb.content.define_technique {
    id = "TECH_RABBIT_BITE",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = -2,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A rabbit bite."),
    attack_vectors = { "vector_rabbit_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_rodent_bite",
}

ccb.content.define_technique {
    id = "TECH_RABBIT_BITE_GRABBED",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A rabbit bite."),
    attack_vectors = { "vector_rabbit_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_rabbit_bite_grabbed",
}

ccb.content.define_technique {
    id = "TECH_BIRD_PECK",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = -2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_bird_peck",
}

-- More likely to peck if you have wings
ccb.content.define_technique {
    id = "TECH_BIRD_PECK_IF_WINGS",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = 2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_bird_peck_if_wings",
}

ccb.content.define_technique {
    id = "TECH_BIRD_PECK_GRABBED",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_bird_peck_grabbed",
}
