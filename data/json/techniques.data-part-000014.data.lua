local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_fencing_feint",
    messages = {
        ccb.content.text("You steady your weapon and fake a thrust at %s"),
        ccb.content.text("<npcname> steadies their weapon and fakes a thrust at %s"),
    },
    name = ccb.content.text("Feint"),
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_fencing_lunge",
    name = ccb.content.text("Fencing Lunge"),
    messages = { ccb.content.text("You lunge at %s"), ccb.content.text("<npcname> lunges at %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_ok = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_fencing_compound1",
    name = ccb.content.text("Compound Attack (Remise)"),
    messages = {
        ccb.content.text("Your feint leads to a compound attack against %s"),
        ccb.content.text("<npcname>'s feint leads to a compound attack against %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    required_buffs_all = { "buff_fencing_onmiss" },
    weighting = 4,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_fencing_compound2",
    name = ccb.content.text("Compound Attack (Counter Time)"),
    messages = {
        ccb.content.text("Your feint leads to a compound attack against %s"),
        ccb.content.text("<npcname>'s feint leads to a compound attack against %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_all = { "buff_fencing_onpause" },
    weighting = 4,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
}
