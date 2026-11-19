local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_centipede_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you skitter free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they skitter free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_centipede_rapid",
    name = ccb.content.text("Centipede Strike"),
    messages = { ccb.content.text("You swiftly hit %s"), ccb.content.text("<npcname> swiftly hits %s") },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_punch" },
}
