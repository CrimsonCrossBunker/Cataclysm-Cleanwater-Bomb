local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_taekwondo_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
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
    id = "tec_taekwondo_feint",
    name = ccb.content.text("Feint"),
    messages = { ccb.content.text("You fake a kick at %s"), ccb.content.text("<npcname> fakes a kick at %s") },
    skills = { { id = "unarmed", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_taichi_disarm",
    name = ccb.content.text("Disarm"),
    messages = { ccb.content.text("You gently disarm %s"), ccb.content.text("<npcname> gently disarms %s") },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
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
    attack_vectors = { "vector_grasp" },
}
