local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_biojutsu_wide",
    name = ccb.content.text("Biojutsu Cleave"),
    messages = {
        ccb.content.text("You quickly cleave through %s and those nearby"),
        ccb.content.text("<npcname> quickly cleaves through %s and those nearby"),
    },
    skills = { { id = "melee", level = 5 } },
    weapon_categories = { "BIONIC_WEAPONRY" },
    melee_allowed = true,
    weighting = 2,
    crit_tec = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_lizard_rapid",
    name = ccb.content.text("Lizard Strike"),
    messages = {
        ccb.content.text("You spearhand strike %s"),
        ccb.content.text("<npcname> spearhand strikes %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_lizard_tail",
    name = ccb.content.text("Lizard Tail"),
    messages = { ccb.content.text("You leap and kick %s"), ccb.content.text("<npcname> leaps and kicks %s") },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_lizard_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you outmaneuver it"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they outmaneuver it"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_lizard_walldive",
    name = ccb.content.text("Lizard Wall Dive"),
    messages = {
        ccb.content.text("You push off a nearby wall and strike down at %s"),
        ccb.content.text("<npcname> pushes off a nearby wall and strikes down at %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    wall_adjacent = true,
    stun_dur = 2,
    knockback_dist = 1,
    knockback_spread = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.5 } },
    attack_vectors = { "vector_shoulder" },
}

ccb.content.define_technique {
    id = "tec_venom_snake_feint",
    name = ccb.content.text("Viper Hiss"),
    messages = {
        ccb.content.text("You hiss threateningly at %s"),
        ccb.content.text("<npcname> hisses threateningly at %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_venom_snake_rapid",
    name = ccb.content.text("Viper Fist"),
    messages = { ccb.content.text("You quickly chop %s"), ccb.content.text("<npcname> quickly chops %s") },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_wrist" },
}

ccb.content.define_technique {
    id = "tec_venom_snake_bite",
    name = ccb.content.text("Viper Bite"),
    messages = {
        ccb.content.text("You lash out at %s with a Viper Bite"),
        ccb.content.text("<npcname> lashes out at %s with a Viper Bite"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 2,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_punch" },
}
