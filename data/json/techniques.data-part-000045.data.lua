local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_muay_thai_push",
    name = ccb.content.text("Push Kick"),
    messages = {
        ccb.content.text("You shove %s back with a front kick"),
        ccb.content.text("<npcname> shoves %s back with a front kick"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    knockback_dist = 1,
    attack_vectors = { "vector_foot_sole" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_muay_thai_knee",
    name = ccb.content.text("Knee Strike"),
    messages = {
        ccb.content.text("You drive your knee into %s"),
        ccb.content.text("<npcname> drives their knee into %s"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.35 } },
    attack_vectors = { "vector_knee" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
