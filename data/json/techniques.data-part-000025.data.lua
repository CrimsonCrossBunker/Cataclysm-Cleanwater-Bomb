local ccb = require("ccb")

ccb.content.define_technique {
    id = "niten_timing_attack",
    name = ccb.content.text("In-One Timing"),
    messages = {
        ccb.content.text("You strike at %s's weak spot"),
        ccb.content.text("<npcname> strikes at %s's weak spot"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    required_buffs_all = { "buff_niten_ondodge" },
    crit_ok = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "niten_feint",
    name = ccb.content.text("Feint"),
    messages = { ccb.content.text("You feint at %s"), ccb.content.text("<npcname> feints at %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}

ccb.content.define_technique {
    id = "tec_pankration_cross",
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
