local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_BIRD_WOODPECKER_PECK",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = -2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_woodpecker_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -2.5 },
        { stat = "movecost", scaling_stat = "dex", scale = -1 },
    },
}

ccb.content.define_technique {
    id = "TECH_BIRD_WOODPECKER_PECK_IF_WINGS",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = 2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_woodpecker_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -2.5 },
        { stat = "movecost", scaling_stat = "dex", scale = -1 },
    },
}
