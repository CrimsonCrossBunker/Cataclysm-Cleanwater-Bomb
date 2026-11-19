local ccb = require("ccb")

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_taekwondo_strong",
    name = ccb.content.text("Spinning Back Kick"),
    messages = {
        ccb.content.text("You spin and back-kick %s, right in the center of gravity"),
        ccb.content.text("<npcname> spins and back-kicks %s, right in the center of gravity"),
    },
    skills = { { id = "unarmed", level = 5 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 2,
    mult_bonuses = {
        { stat = "movecost", scale = 1.5 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_foot_heel" },
    when = "allow_tec_taekwondo_strong",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

ccb.content.define_technique {
    id = "tec_taekwondo_push",
    name = ccb.content.text("Side Kick"),
    messages = {
        ccb.content.text("You turn slightly and side-kick %s"),
        ccb.content.text("<npcname> turns slightly and side-kicks %s"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
    knockback_dist = 1,
    attack_vectors = { "vector_foot_sole" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_taekwondo_sweep",
    name = ccb.content.text("Sweep Kick"),
    messages = {
        ccb.content.text("You crouch low and sweep-kick %s"),
        ccb.content.text("<npcname> crouches low and sweep-kicks %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_ok = true,
    down_dur = 1,
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
        "vector_shin",
    },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
