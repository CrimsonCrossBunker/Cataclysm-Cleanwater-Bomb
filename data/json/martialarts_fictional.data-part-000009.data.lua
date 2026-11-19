local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_centipede_bite",
    name = ccb.content.text("Centipede Bite"),
    messages = {
        ccb.content.text("You palm strike %s with a painful Centipede Bite"),
        ccb.content.text("<npcname> palm strikes %s with a painful Centipede Bite"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = { "vector_palm" },
    when = "allow_tec_biojutsu_takedown",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target"),
}
