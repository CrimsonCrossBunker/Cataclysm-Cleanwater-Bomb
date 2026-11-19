local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_eskrima_round",
    name = ccb.content.text("Round Strike"),
    messages = { ccb.content.text("You round strike %s"), ccb.content.text("<npcname> round strikes %s") },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.6 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_eskrima_fan",
    name = ccb.content.text("Fan Strike"),
    messages = { ccb.content.text("You fan strike %s"), ccb.content.text("<npcname> fan strikes %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.75 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_eskrima_snap",
    name = ccb.content.text("Snap Strike"),
    messages = { ccb.content.text("You snap out at %s"), ccb.content.text("<npcname> snaps quickly at %s") },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_eskrima_combination",
    name = ccb.content.text("Combination Strike"),
    messages = {
        ccb.content.text("You combination strike %s"),
        ccb.content.text("<npcname> combination strikes %s"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    required_buffs_all = { "buff_eskrima_oncrit" },
    crit_tec = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.8 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
}
