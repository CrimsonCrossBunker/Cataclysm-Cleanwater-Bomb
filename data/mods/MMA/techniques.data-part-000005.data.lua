local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_pokken_sweep",
    name = ccb.content.text("Low Sweep"),
    messages = {
        ccb.content.text("You use Low Sweep on %s"),
        ccb.content.text("<npcname> uses Low Sweep on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    down_dur = 1,
    attack_vectors = { "vector_foot_toes", "vector_avian_talons", "vector_hoof_kick", "vector_shin" },
    when = "allow_mma_tec_pokken_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size incapable of flight"),
}

ccb.content.define_technique {
    id = "mma_tec_setting_sun_stun",
    name = ccb.content.text("Hydra Slaying Strike"),
    messages = {
        ccb.content.text("You interrupt %s with a perfectly aimed strike"),
        ccb.content.text("<npcname> interrupt %s with a perfectly aimed strike"),
    },
    skills = { { id = "unarmed", level = 4 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "mma_tec_setting_sun_throw",
    name = ccb.content.text("Mighty Throw"),
    messages = {
        ccb.content.text("You toss %s aside with a Mighty Throw"),
        ccb.content.text("<npcname> tosses %s with a Mighty Throw"),
    },
    skills = { { id = "unarmed", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    required_buffs_all = { "mma_buff_setting_sun_onpause" },
    down_dur = 2,
    knockback_dist = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.33 },
        { stat = "damage", damage_type = "cut", scale = 1.33 },
        { stat = "damage", damage_type = "stab", scale = 1.33 },
    },
    attack_vectors = { "vector_grasp" },
    when = "allow_mma_tec_setting_sun_throw",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "mma_tec_setting_sun_throw_crit",
    name = ccb.content.text("Ballista Throw"),
    messages = {
        ccb.content.text("You spin and hurl %s away with a Ballista Throw"),
        ccb.content.text("<npcname> spins and hurls %s away with a Ballista Throw"),
    },
    skills = { { id = "unarmed", level = 5 } },
    melee_allowed = true,
    unarmed_allowed = true,
    required_buffs_all = { "mma_buff_setting_sun_onpause" },
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 4,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_grasp" },
    when = "allow_mma_tec_setting_sun_throw",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}
