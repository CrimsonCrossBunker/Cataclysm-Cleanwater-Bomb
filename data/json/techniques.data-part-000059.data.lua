local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_taichi_palm",
    name = ccb.content.text("Palm Strike"),
    messages = { ccb.content.text("You palm strike %s"), ccb.content.text("<npcname> palm strikes %s") },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_tai_chi_onpause" },
    knockback_dist = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_palm" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_taichi_counter",
    name = ccb.content.text("Grasp the Sparrow's Tail"),
    messages = {
        ccb.content.text("You divert %s's attack and lead them to the ground"),
        ccb.content.text("<npcname> diverts %s's attack and leads them to the ground"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_tai_chi_onblock" },
    crit_ok = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_taichi_precise",
    name = ccb.content.text("Double Palm Strike"),
    messages = {
        ccb.content.text("Your double-handed palm strikes %s"),
        ccb.content.text("<npcname>'s double-handed palm strikes %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    required_buffs_all = { "buff_tai_chi_onpause" },
    knockback_dist = 1,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 2.0 },
        { stat = "damage", damage_type = "cut", scale = 2.0 },
        { stat = "damage", damage_type = "stab", scale = 2.0 },
    },
    attack_vectors = { "vector_palm" },
    when = "allow_tec_taichi_precise",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
