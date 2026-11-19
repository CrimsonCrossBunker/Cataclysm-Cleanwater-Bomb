local ccb = require("ccb")

-- Similar size
ccb.content.define_technique {
    id = "tec_brawl_power",
    name = ccb.content.text("Power Hit"),
    messages = { ccb.content.text("You send %s reeling"), ccb.content.text("<npcname> sends %s reeling") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    knockback_dist = 1,
    stun_dur = 1,
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_brawl_power",
    condition_description = ccb.content.text("* Only works on a <info>non-downed and non-stunned</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_brawl_trip",
    name = ccb.content.text("Trip"),
    messages = { ccb.content.text("You trip %s"), ccb.content.text("<npcname> trips %s") },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    down_dur = 1,
    attack_vectors = { "vector_shin" },
    when = "allow_tec_brawl_trip",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar</info> size"),
}
