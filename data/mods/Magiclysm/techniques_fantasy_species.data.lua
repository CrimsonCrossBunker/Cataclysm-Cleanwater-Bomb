local ccb = require("ccb")

ccb.content.define_technique {
    id = "tech_wing_slap",
    name = ccb.content.text("Wing Slap"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You slap %s with your wings"),
        ccb.content.text("<npcname> slaps %s with their wings"),
    },
    description = ccb.content.text("A slap of the wings."),
    attack_vectors = { "vector_ravenfolk_wing_slap" },
    flat_bonuses = { { stat = "movecost", scale = 20 } },
}

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

ccb.content.define_technique {
    id = "FANGS_BITE_GOBLIN_CRIT",
    name = ccb.content.text("Critical Goblin Bite"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You deliver a wicked bite to %s"),
        ccb.content.text("<npcname> delivers a wicked bite to %s"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 4.4 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.24 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 1 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "FANGS_BITE_LIZARDFOLK",
    name = ccb.content.text("Lizardfolk Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("Bite someone with a lizardfolk's naturally-sharp teeth."),
    unarmed_allowed = true,
    weighting = -1,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "LIZARDFOLK_BITE_CRIT",
    name = ccb.content.text("Lizardfolk Bite"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You viciously tear into %s"),
        ccb.content.text("<npcname> viciously tears %s"),
    },
    unarmed_allowed = true,
    weighting = 1,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 4.4 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.24 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 1 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_fangs_bite_goblin",
}
