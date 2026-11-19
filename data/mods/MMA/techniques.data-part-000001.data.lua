local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_iron_heart_execute",
    name = ccb.content.text("Finishing Move"),
    messages = {
        ccb.content.text("You finish off %s with a powerful slash"),
        ccb.content.text("<npcname> finishes off %s with a powerful slash"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_stun",
    name = ccb.content.text("Dazing Strike"),
    messages = { ccb.content.text("You harshly stun %s"), ccb.content.text("<npcname> harshly stuns %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
