local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_capoeira_sweepkick",
    name = ccb.content.text("Sweep Kick"),
    messages = { ccb.content.text("You sweep kick %s"), ccb.content.text("<npcname> sweep kicks %s") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_capoeira_onmove" },
    weighting = 2,
    down_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
    when = "allow_tec_brawl_trip",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar</info> size"),
}

ccb.content.define_technique {
    id = "tec_capoeira_spinkick",
    name = ccb.content.text("Spin Kick"),
    messages = { ccb.content.text("You spin kick %s"), ccb.content.text("<npcname> spin kicks %s") },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_capoeira_onmove" },
    weighting = 2,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_foot_sole" },
    when = "allow_tec_capoeira_spinkick",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar or smaller</info> size"),
}
