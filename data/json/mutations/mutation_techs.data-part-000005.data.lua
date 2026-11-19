local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_GASTROPOD_TONGUE",
    name = ccb.content.text("Tongue Stab"),
    crit_ok = true,
    unarmed_allowed = true,
    reach_ok = true,
    messages = {
        ccb.content.text("You stab %s with your sharp tongue"),
        ccb.content.text("<npcname> stabs %s with their sharp tongue"),
    },
    description = ccb.content.text("A stabbing attack with your gastropod tongue."),
    attack_vectors = { "vector_gastropod_tongue" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.25 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "TECH_SLIME_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You punch %s"), ccb.content.text("<npcname> punch %s") },
    description = ccb.content.text("A basic gooey punch"),
    attack_vectors = { "vector_slime_punch" },
}

-- This is just base punch for crabs
ccb.content.define_technique {
    id = "TECH_CRAB_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You snip %s with your pincer"),
        ccb.content.text("<npcname> snips %s with their pincer"),
    },
    description = ccb.content.text("A basic crustacean punch"),
    attack_vectors = { "vector_crab_pincer" },
}
