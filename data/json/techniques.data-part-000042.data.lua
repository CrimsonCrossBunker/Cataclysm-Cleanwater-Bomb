local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_leopard_rapid",
    name = ccb.content.text("Leopard Swipe"),
    messages = {
        ccb.content.text("You quickly swipe at %s"),
        ccb.content.text("<npcname> quickly swipes at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_leopard_claw",
    name = ccb.content.text("Leopard Claw"),
    messages = {
        ccb.content.text("You savagely claw at %s"),
        ccb.content.text("<npcname> savagely claws at %s"),
    },
    unarmed_allowed = true,
    crit_tec = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.8 },
        { stat = "damage", damage_type = "bash", scale = 1.3 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}
