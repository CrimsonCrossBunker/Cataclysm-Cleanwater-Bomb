local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_karate_precise",
    name = ccb.content.text("Knifehand Strike"),
    messages = {
        ccb.content.text("You hit %s with a knifehand strike"),
        ccb.content.text("<npcname> hits %s with a knifehand strike"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_wrist" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
