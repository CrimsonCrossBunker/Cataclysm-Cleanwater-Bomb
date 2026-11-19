local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_sojutsu_jab",
    name = ccb.content.text("Jab"),
    messages = { ccb.content.text("You quickly strike %s"), ccb.content.text("<npcname> quickly strikes %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    reach_tec = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_sojutsu_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a thrust at %s"),
        ccb.content.text("<npcname> fakes a thrust at %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_taekwondo_disarm",
    name = ccb.content.text("Snatch Weapon"),
    messages = {
        ccb.content.text("You snatch %s's weapon"),
        ccb.content.text("<npcname> snatches %s's weapon"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    weighting = 2,
    take_weapon = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 0.5 } },
    attack_vectors = { "vector_grasp" },
}
