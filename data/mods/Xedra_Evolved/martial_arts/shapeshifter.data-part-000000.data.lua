local ccb = require("ccb")

ccb.content.define_technique {
    id = "CLAWS_SHAPESHIFTER",
    name = ccb.content.text("Claw Slash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slash at %s with your claws"),
        ccb.content.text("<npcname> slashes at %s with their claws"),
    },
    unarmed_allowed = true,
    weighting = 3,
    reach_ok = false,
    attack_vectors = { "vector_punch" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "CLAWS_SHAPESHIFTER_RENDING",
    name = ccb.content.text("Claw Rending Slash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slash %s, tearing open bleeding wounds"),
        ccb.content.text("<npcname> slashes %s, tearing open bleeding wounds"),
    },
    unarmed_allowed = true,
    weighting = 0,
    crit_ok = true,
    reach_ok = false,
    attack_vectors = { "vector_punch" },
    effects = {
        {
            id = "bleed",
            chance = 100,
            duration_turns = 600,
            on_damage = true,
            message = ccb.content.text("%s is bleeding!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}
