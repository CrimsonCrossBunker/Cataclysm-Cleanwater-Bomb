local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_biojutsu_disarm",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You effortlessly disarm and stun %s"),
        ccb.content.text("<npcname> effortlessly disarms and stuns %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    weighting = 2,
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The weapon of %s has been forced out of their hands!"),
        },
    },
    stun_dur = 1,
    attack_vectors = { "vector_grasp" },
}

ccb.content.define_technique {
    id = "tec_biojutsu_strike_melee",
    name = ccb.content.text("Measured Strike (melee)"),
    messages = {
        ccb.content.text("You make an efficient strike against %s"),
        ccb.content.text("<npcname> makes an efficient strike against %s"),
    },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_biojutsu_strike_unarmed",
    name = ccb.content.text("Measured Strike (unarmed)"),
    messages = {
        ccb.content.text("You make an efficient strike against %s"),
        ccb.content.text("<npcname> makes an efficient strike against %s"),
    },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_biojutsu_impale",
    name = ccb.content.text("Biojutsu Impale"),
    messages = {
        ccb.content.text("You brutally impale %s with your weapon"),
        ccb.content.text("<npcname> brutally impales %s with their weapon"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_tec = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    stun_dur = 1,
    attack_vectors = { "vector_null" },
}
