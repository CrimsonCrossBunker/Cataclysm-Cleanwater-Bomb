local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_scorpion_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = { "vector_foot_heel" },
}

ccb.content.define_technique {
    id = "tec_scorpion_brutal",
    name = ccb.content.text("Stinger Kick"),
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 2,
    knockback_dist = 3,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    messages = {
        ccb.content.text("Your Stinger Kick sends %s flying"),
        ccb.content.text("<npcname>'s Stinger Kick sends %s flying"),
    },
    attack_vectors = { "vector_foot_sole" },
}

ccb.content.define_technique {
    id = "tec_scorpion_precise",
    name = ccb.content.text("Pincer Fist"),
    messages = {
        ccb.content.text("You stun %s with your Pincer Fist"),
        ccb.content.text("<npcname> jabs %s with a Pincer Fist"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_scorpion_onmove" },
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_toad_cross",
    name = ccb.content.text("Toad Smack"),
    messages = {
        ccb.content.text("You give %s a hardy smack"),
        ccb.content.text("<npcname> gives %s a hardy smack"),
    },
    skills = { { id = "unarmed", level = 4 } },
    crit_ok = true,
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_toad_crit",
    name = ccb.content.text("Toad Slam"),
    messages = {
        ccb.content.text("You meet %s head-on with a stunning slam"),
        ccb.content.text("<npcname> meet %s head-on with a stunning slam"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = { "vector_arm" },
}
