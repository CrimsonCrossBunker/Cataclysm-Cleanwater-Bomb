local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_kickboxing_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_krav_maga_rapid",
    messages = { ccb.content.text("You jab at %s"), ccb.content.text("<npcname> jabs at %s") },
    name = ccb.content.text("Jab"),
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_null", "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_krav_maga_disarm_simple",
    messages = {
        ccb.content.text("You quickly slap and disarm %s"),
        ccb.content.text("<npcname> quickly slaps and disarms %s"),
    },
    name = ccb.content.text("Disarming Slap"),
    skills = { { id = "unarmed", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.9 } },
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The weapon of %s has been forced out of their hands!"),
        },
    },
    attack_vectors = { "vector_null", "vector_grasp" },
}
