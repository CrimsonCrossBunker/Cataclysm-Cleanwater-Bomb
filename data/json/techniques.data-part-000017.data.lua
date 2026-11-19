local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_karate_rapid",
    name = ccb.content.text("Backfist Strike"),
    messages = {
        ccb.content.text("You quickly strike %s with the back of your fist"),
        ccb.content.text("<npcname> quickly strikes %s with the back of their fist"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_backhand" },
}

ccb.content.define_technique {
    id = "tec_karate_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_karate_staff",
    name = ccb.content.text("Staff Strike"),
    messages = {
        ccb.content.text("You strike %s with your staff"),
        ccb.content.text("<npcname> strikes %s with their staff"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    weapon_categories = { "QUARTERSTAVES" },
    mult_bonuses = { { stat = "movecost", scale = 0.9 } },
    attack_vectors = { "vector_null" },
}
