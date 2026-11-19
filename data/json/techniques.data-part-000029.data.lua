local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_fencing_riposte",
    name = ccb.content.text("Fencing Riposte"),
    messages = {
        ccb.content.text("You deliver a perfect riposte to %s"),
        ccb.content.text("<npcname> delivers a perfect riposte to %s"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    required_buffs_all = { "buff_fencing_onblock" },
    crit_ok = true,
    weighting = 2,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.66 },
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_medievalpole_counter",
    name = ccb.content.text("Displace and Hook"),
    messages = {
        ccb.content.text("You parry and hook %s down"),
        ccb.content.text("<npcname> parries and hooks %s down"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_all = { "buff_medievalpole_onblock" },
    crit_ok = true,
    weighting = 2,
    down_dur = 2,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
