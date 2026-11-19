local ccb = require("ccb")

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_boxing_counter",
    name = ccb.content.text("Cross Counter"),
    messages = {
        ccb.content.text("You cross-counter %s"),
        ccb.content.text("<npcname> throws a perfect counter at %s"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_boxing_ondodge" },
    weighting = 2,
    crit_tec = true,
    knockback_dist = 1,
    knockback_spread = 1,
    stun_dur = 1,
    down_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
