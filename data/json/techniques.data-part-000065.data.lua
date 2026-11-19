local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_wingchun_punch_knockback",
    name = ccb.content.text("Straight Punch (Knockback)"),
    messages = {
        ccb.content.text("You force %s back with a straight horizontal punch"),
        ccb.content.text("<npcname> forces %s back with a straight horizontal punch"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_wingchun_onpause" },
    weighting = 2,
    knockback_dist = 1,
    knockback_follow = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_wingchun_hook",
    name = ccb.content.text("L-hook"),
    messages = {
        ccb.content.text("You deliver a solid L-hook to %s"),
        ccb.content.text("<npcname> delivers a solid L-hook to %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 1,
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
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_wingchun_hook_knockback",
    name = ccb.content.text("L-hook (Knockback)"),
    messages = {
        ccb.content.text("You knock %s back with a solid L-hook"),
        ccb.content.text("<npcname> knocks %s back with a solid L-hook"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_wingchun_onpause" },
    weighting = 2,
    crit_tec = true,
    down_dur = 1,
    knockback_dist = 1,
    knockback_follow = true,
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
    when = "allow_tec_wingchun_hook_knockback",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets grabbing you"),
}
