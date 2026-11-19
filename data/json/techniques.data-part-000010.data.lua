local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_aikido_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you smoothly break free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they smoothly break free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_bojutsu_thrust",
    name = ccb.content.text("Front Thrust"),
    messages = { ccb.content.text("You thrust at %s"), ccb.content.text("<npcname> thrusts at %s") },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = { "vector_null" },
}
