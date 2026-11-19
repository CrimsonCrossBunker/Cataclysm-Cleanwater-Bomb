local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_tiger_palm",
    name = ccb.content.text("Tiger Palm"),
    messages = {
        ccb.content.text("You land a heavy tiger palm on %s"),
        ccb.content.text("<npcname> lands a heavy tiger palm on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.0 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 1.0 },
    },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_palm" },
}
