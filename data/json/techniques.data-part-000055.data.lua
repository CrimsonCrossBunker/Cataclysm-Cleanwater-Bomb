local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_snake_precise",
    name = ccb.content.text("Snake Strike"),
    messages = {
        ccb.content.text("You lash out at %s with a vicious Snake Strike"),
        ccb.content.text("<npcname> lashes out at %s with a vicious Snake Strike"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_snake_onpause" },
    crit_tec = true,
    stun_dur = 1,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "per", scale = 1.0 },
    },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_sojutsu_shove",
    name = ccb.content.text("Shove"),
    messages = { ccb.content.text("You shove %s back"), ccb.content.text("<npcname> shoves %s back") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    knockback_dist = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_sojutsu_trip",
    name = ccb.content.text("Trip"),
    messages = { ccb.content.text("You deftly trip %s"), ccb.content.text("<npcname> deftly trips %s") },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    reach_ok = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
