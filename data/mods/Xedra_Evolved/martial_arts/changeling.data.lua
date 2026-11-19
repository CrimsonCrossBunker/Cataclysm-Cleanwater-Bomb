local ccb = require("ccb")

ccb.content.define_technique {
    id = "CHANGELING_RIASTRAD_KNOCKBACK",
    name = ccb.content.text("Ríastrad Knockback"),
    melee_allowed = true,
    unarmed_allowed = true,
    crit_ok = true,
    messages = {
        ccb.content.text("You smash %s with a brutal strike, knocking them to the ground"),
        ccb.content.text("<npcname> smashes %swith a brutal strike, knocking them to the ground"),
    },
    weighting = -2,
    reach_ok = false,
    attack_vectors = { "vector_null" },
    knockback_dist = 1,
    knockback_spread = 1,
    knockback_follow = true,
    down_dur = 2,
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_changeling_riastrad_knockback",
    condition_description = ccb.content.text("Needs X"),
}

ccb.content.define_technique {
    id = "CHANGELING_RIASTRAD_STUN",
    name = ccb.content.text("Ríastrad Stun"),
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    weighting = -2,
    messages = {
        ccb.content.text("You strike a mighty blow at %s"),
        ccb.content.text("<npcname> strikes a mighty blow at %s"),
    },
    stun_dur = 2,
    attack_vectors = { "vector_null" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tec_precise",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned humanoid</info> target of <info>similar or smaller</info> size"),
}
