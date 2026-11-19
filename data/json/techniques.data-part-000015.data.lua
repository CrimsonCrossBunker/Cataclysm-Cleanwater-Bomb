local ccb = require("ccb")

-- Things of similar size in both directions that keep their heads high
ccb.content.define_technique {
    id = "tec_boxing_upper",
    name = ccb.content.text("Uppercut"),
    messages = { ccb.content.text("You uppercut %s"), ccb.content.text("<npcname> uppercuts %s") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_boxing_upper",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar</info> size"),
}
