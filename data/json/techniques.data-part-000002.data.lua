local ccb = require("ccb")

ccb.content.define_technique {
    id = "RAPID",
    name = ccb.content.text("Rapid Strike"),
    manual_activation = true,
    melee_allowed = true,
    skills = { { id = "melee", level = 2 } },
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    messages = { ccb.content.text("You quickly strike %s"), ccb.content.text("<npcname> quickly strikes %s") },
    description = ccb.content.text("50% moves, 66% damage, min 2 melee"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "MOUNTED_CHARGE",
    name = ccb.content.text("Mounted Charge"),
    description = ccb.content.text("Charge forward while mounted and strike the first creature in your path."),
    manual_activation = true,
    cooldown = "10 s",
    melee_allowed = true,
    messages = { ccb.content.text("You charge into %s"), ccb.content.text("<npcname> charges into %s") },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "VORPAL",
    name = ccb.content.text("Vorpal Strike"),
    melee_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "cut", scale = 99 } },
    crit_tec = true,
    weighting = -250,
    messages = {
        ccb.content.text("Snicker-snack!  You slice through %s like a hot knife through butter"),
        ccb.content.text("Snicker-snack!  <npcname> slices through %s like a hot knife through butter"),
    },
    description = ccb.content.text("Cut damage multiply by 99, crit only"),
    attack_vectors = { "vector_null" },
}
