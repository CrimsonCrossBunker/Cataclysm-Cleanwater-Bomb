local ccb = require("ccb")

-- Missile Blow.
ccb.content.define_technique {
    id = "mma_tec_panzer_rapid",
    name = ccb.content.text("Geschoss Schlag"),
    messages = {
        ccb.content.text("You launch a supersonic punch at %s"),
        ccb.content.text("<npcname> launches a supersonic punch at %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "mma_tec_pokken_kick",
    name = ccb.content.text("Mega Kick"),
    messages = {
        ccb.content.text("You use Mega Kick on %s"),
        ccb.content.text("<npcname> uses Mega Kick on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 2.0 },
        { stat = "damage", damage_type = "cut", scale = 2.0 },
        { stat = "damage", damage_type = "stab", scale = 2.0 },
    },
    attack_vectors = { "vector_foot_sole" },
}

ccb.content.define_technique {
    id = "mma_tec_pokken_lariat",
    name = ccb.content.text("Darkest Lariat"),
    messages = {
        ccb.content.text("You use Darkest Lariat on %s"),
        ccb.content.text("<npcname> uses Darkest Lariat on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 1.5 },
    },
    attack_vectors = { "vector_arm" },
}

ccb.content.define_technique {
    id = "mma_tec_pokken_strike",
    name = ccb.content.text("Smart Strike"),
    messages = {
        ccb.content.text("You use Smart Strike on %s"),
        ccb.content.text("<npcname> uses Smart Strike on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = { { stat = "hit", scale = 5.0 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_headbutt",
        "vector_shoulder",
    },
}
