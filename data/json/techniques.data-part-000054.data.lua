local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_snake_swift",
    name = ccb.content.text("Snake Snap"),
    messages = { ccb.content.text("You swiftly jab %s"), ccb.content.text("<npcname> swiftly jabs %s") },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 0.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "per", scale = 0.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "per", scale = 0.5 },
    },
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_snake_feint",
    name = ccb.content.text("Snake Slide"),
    messages = {
        ccb.content.text("You make serpentine hand motions at %s"),
        ccb.content.text("<npcname> makes serpentine hand motions at %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_snake_break",
    name = ccb.content.text("Snake Slither"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you slither free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they slither free"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}
