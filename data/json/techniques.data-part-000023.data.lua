local ccb = require("ccb")

-- TODO: differentiate the stun from the damage, though 1.5x flat is excessive
ccb.content.define_technique {
    id = "tec_crane_strike",
    name = ccb.content.text("Crane Strike"),
    messages = {
        ccb.content.text("You hand-peck and strike %s"),
        ccb.content.text("<npcname> hand-pecks and strikes %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_crane_ondodge" },
    crit_ok = true,
    stun_dur = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_wrist" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
