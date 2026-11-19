local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_crane_precise",
    name = ccb.content.text("Crane Kick"),
    messages = { ccb.content.text("You leap and kick %s"), ccb.content.text("<npcname> leaps and kicks %s") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_crane_ondodge" },
    crit_ok = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
