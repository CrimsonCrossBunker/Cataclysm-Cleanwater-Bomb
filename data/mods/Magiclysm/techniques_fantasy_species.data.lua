local ccb = require("ccb")

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
