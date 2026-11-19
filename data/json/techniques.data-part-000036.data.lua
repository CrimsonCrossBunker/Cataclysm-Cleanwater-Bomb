local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_kickboxing_rapid",
    name = ccb.content.text("Jab"),
    messages = { ccb.content.text("You quickly jab %s"), ccb.content.text("<npcname> quickly jabs at %s") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_kickboxing_cross",
    name = ccb.content.text("Cross"),
    messages = {
        ccb.content.text("You throw a heavy cross at %s"),
        ccb.content.text("<npcname> throws a cross at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}
