local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_kickboxing_push",
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

-- Things of similar size in both directions that keep their heads high
ccb.content.define_technique {
    id = "tec_kickboxing_upper",
    name = ccb.content.text("Uppercut"),
    messages = { ccb.content.text("You uppercut %s"), ccb.content.text("<npcname> uppercuts %s") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_boxing_upper",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar</info> size"),
}
