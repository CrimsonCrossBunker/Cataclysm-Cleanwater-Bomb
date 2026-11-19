local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_leopard_precise",
    name = ccb.content.text("Leopard Fist"),
    messages = {
        ccb.content.text("You strike out at %s with your Leopard Fist"),
        ccb.content.text("<npcname> strikes out at %s with a Leopard Fist"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
