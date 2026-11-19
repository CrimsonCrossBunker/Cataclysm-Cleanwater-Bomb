local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_wingchun_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("Your attack misses %s but you don't let up"),
        ccb.content.text("<npcname>'s attack misses %s but they don't let up"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_zuiquan_feint",
    name = ccb.content.text("Drunken Feint"),
    messages = {
        ccb.content.text("You stumble and leer at %s"),
        ccb.content.text("<npcname> stumbles and leers at %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_zuiquan_fist",
    name = ccb.content.text("Drunk Fist"),
    messages = {
        ccb.content.text("You lurch, and your wild swing hits %s"),
        ccb.content.text("<npcname> lurches, and hits %s"),
    },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_zuiquan_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you stumble away"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they stumble away"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_zuiquan_spin",
    name = ccb.content.text("Whirling Strikes"),
    messages = {
        ccb.content.text("You spin, hitting %s and everyone around you"),
        ccb.content.text("<npcname> spins, hitting %s and everyone around them"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    aoe = "spin",
    mult_bonuses = {
        { stat = "movecost", scale = 1.5 },
        { stat = "damage", damage_type = "bash", scale = 1.3 },
        { stat = "damage", damage_type = "cut", scale = 1.3 },
        { stat = "damage", damage_type = "stab", scale = 1.3 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "RAPID_TEST",
    name = ccb.content.text("Rapid Strike Test"),
    melee_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    messages = { ccb.content.text("You quickly strike %s"), ccb.content.text("<npcname> quickly strikes %s") },
    description = ccb.content.text("50% moves, 66% damage"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_debug_slow",
    name = ccb.content.text("slow strike"),
    unarmed_allowed = true,
    skills = { { id = "unarmed", level = 3 } },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 3.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.1 },
    },
    flat_bonuses = {
        { stat = "movecost", scale = 100 },
        { stat = "movecost", scaling_stat = "str", scale = 10 },
    },
    messages = { ccb.content.text("You slowly strike %s"), ccb.content.text("<npcname> slowly strikes %s") },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_debug_arpen",
    name = ccb.content.text("phasing strike"),
    unarmed_allowed = true,
    melee_allowed = true,
    skills = { { id = "melee", level = 3 } },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.2 },
        { stat = "damage", damage_type = "cut", scale = 0.2 },
        { stat = "damage", damage_type = "stab", scale = 0.2 },
        { stat = "movecost", scale = 0.3 },
    },
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scale = 10 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 1 },
    },
    crit_tec = true,
    messages = { ccb.content.text("You phase-strike %s"), ccb.content.text("<npcname> phase-strikes %s") },
    attack_vectors = { "vector_null", "vector_punch" },
}
