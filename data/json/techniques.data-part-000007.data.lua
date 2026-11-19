local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_boxing_rapid",
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
