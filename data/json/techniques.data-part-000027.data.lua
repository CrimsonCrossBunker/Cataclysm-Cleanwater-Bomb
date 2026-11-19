local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_eskrima_stun",
    name = ccb.content.text("Stunning Strike"),
    messages = {
        ccb.content.text("You deliver a stunning strike to %s"),
        ccb.content.text("<npcname> delivers a stunning strike to %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_eskrima_low",
    name = ccb.content.text("Low Strike"),
    messages = {
        ccb.content.text("Your weapon becomes a blur as you ground %s"),
        ccb.content.text("<npcname>'s weapon becomes a blur as they ground %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    down_dur = 1,
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
