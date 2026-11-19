local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_tiger_wide",
    name = ccb.content.text("Tiger Rampage"),
    messages = {
        ccb.content.text("You slash wildly at %s and those nearby"),
        ccb.content.text("<npcname> slashes wildly at %s and those nearby"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    weighting = 3,
    aoe = "wide",
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_wingchun_punch",
    name = ccb.content.text("Straight Punch"),
    messages = {
        ccb.content.text("You deliver a straight vertical punch to %s"),
        ccb.content.text("<npcname> delivers a straight vertical punch to %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}
