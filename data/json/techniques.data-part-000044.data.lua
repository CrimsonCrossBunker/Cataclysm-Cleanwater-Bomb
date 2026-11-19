local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_swordsmanship_lethal",
    name = ccb.content.text("Lethal Strike"),
    messages = {
        ccb.content.text("You drive the point of your blade into %s"),
        ccb.content.text("<npcname> drives their blade into %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    required_buffs_all = { "buff_swordsmanship_onpause" },
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 1.5 },
    },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_swordsmanship_feint",
    name = ccb.content.text("Flow Drills"),
    messages = {
        ccb.content.text("With practiced movements, you transition from a failed strike into another strike"),
        ccb.content.text("With practiced movements, <npcname> transitions from a failed strike into another strike"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_muay_thai_rapid",
    name = ccb.content.text("Jab"),
    messages = { ccb.content.text("You quickly jab %s"), ccb.content.text("<npcname> quickly jabs at %s") },
    skills = { { id = "unarmed", level = 1 } },
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
    id = "tec_muay_thai_cross",
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

ccb.content.define_technique {
    id = "tec_muay_thai_elbow",
    name = ccb.content.text("Elbow Strike"),
    messages = {
        ccb.content.text("You slam your elbow into %s"),
        ccb.content.text("<npcname> slams their elbow into %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    crit_tec = true,
    flat_bonuses = { { stat = "damage", damage_type = "cut", scale = 2 } },
    mult_bonuses = { { stat = "movecost", scale = 0.66 } },
    attack_vectors = { "vector_elbow" },
}

ccb.content.define_technique {
    id = "tec_muay_thai_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = {
        "vector_shin",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}
