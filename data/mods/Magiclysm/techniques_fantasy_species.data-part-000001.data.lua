local ccb = require("ccb")

ccb.content.define_technique {
    id = "FANGS_BITE_GOBLIN",
    name = ccb.content.text("Goblin Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("Bite someone with goblin's naturally-sharp teeth."),
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_fangs_bite_goblin",
}

ccb.content.define_technique {
    id = "FANGS_BITE_GOBLIN_GRAB",
    name = ccb.content.text("Goblin Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("Bite someone with a goblin's naturally-sharp teeth."),
    unarmed_allowed = true,
    weighting = 1,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_fangs_bite_goblin_grab",
}
