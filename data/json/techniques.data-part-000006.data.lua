local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_bojutsu_rollingstrike",
    name = ccb.content.text("Rolling Strike"),
    messages = {
        ccb.content.text("Using your rolling staff you quickly strike %s"),
        ccb.content.text("Using their rolling staff <npcname> quickly strikes %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    required_buffs_all = { "buff_bojutsu_onmove" },
    weighting = 2,
    crit_ok = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_bojutsu_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}

ccb.content.define_technique {
    id = "tec_bojutsu_disarm",
    name = ccb.content.text("Hooking Disarm"),
    messages = {
        ccb.content.text("You're able to disarm %s by hooking their weapon"),
        ccb.content.text("<npcname> hooks %s's weapon and casts it away"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_ok = true,
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
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_barbaran_impale",
    name = ccb.content.text("Impaling Estocada"),
    messages = {
        ccb.content.text("You thrust your weapon through %s"),
        ccb.content.text("<npcname> thrusts their weapon through %s"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    weapon_categories = { "GREAT_SWORDS" },
    aoe = "impale",
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
        { stat = "movecost", scale = 1.2 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_barbaran_disarm",
    name = ccb.content.text("Swift Atajo"),
    messages = {
        ccb.content.text("You jab a quick blow at %s's grip"),
        ccb.content.text("<npcname> jabs a quick blow at %s's grip"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The hand of %s is forced open!"),
        },
    },
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_boxing_cross",
    name = ccb.content.text("Cross"),
    messages = {
        ccb.content.text("You throw a heavy cross at %s"),
        ccb.content.text("<npcname> throws a cross at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}
