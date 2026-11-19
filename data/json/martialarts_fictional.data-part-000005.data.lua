local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_venom_snake_tail",
    name = ccb.content.text("Viper Tail"),
    messages = {
        ccb.content.text("You beat %s down with a powerful Viper Tail"),
        ccb.content.text("<npcname> beats %s down with a powerful Viper Tail"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    weighting = 2,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    attack_vectors = { "vector_punch" },
    when = "allow_tec_venom_snake_tail",
    condition_description = ccb.content.text("Requires a stunned target"),
}

ccb.content.define_technique {
    id = "tec_venom_snake_strike",
    name = ccb.content.text("Viper Strike"),
    messages = {
        ccb.content.text("You devastate %s with a spectacular Viper Strike"),
        ccb.content.text("<npcname> devastates %s with a spectacular Viper Strike"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    weighting = 2,
    crit_tec = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_punch" },
    when = "allow_tec_venom_snake_tail",
    condition_description = ccb.content.text("Requires a stunned target"),
}
