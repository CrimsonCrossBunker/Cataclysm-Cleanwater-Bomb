local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_muay_thai_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you break the clinch"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break the clinch"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_ninjutsu_swift",
    name = ccb.content.text("Swift Strike (normal)"),
    messages = { ccb.content.text("You swiftly strike %s"), ccb.content.text("<npcname> swiftly strikes %s") },
    skills = { { id = "melee", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_elbow",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
        "vector_shin",
    },
}

ccb.content.define_technique {
    id = "tec_ninjutsu_swift_crit",
    name = ccb.content.text("Swift Strike (crit)"),
    messages = { ccb.content.text("You swiftly strike %s"), ccb.content.text("<npcname> swiftly strikes %s") },
    skills = { { id = "melee", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_ninjutsu_onattack" },
    crit_tec = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_elbow",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
        "vector_shin",
    },
}

ccb.content.define_technique {
    id = "tec_ninjutsu_precise",
    name = ccb.content.text("Assassinate"),
    messages = {
        ccb.content.text("You attempt to slay %s in a single stroke"),
        ccb.content.text("<npcname> attempts to slay %s in a single stroke"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    forbidden_buffs_all = { "buff_ninjutsu_onattack" },
    crit_tec = true,
    weighting = 3,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.3 },
        { stat = "damage", damage_type = "cut", scale = 1.3 },
        { stat = "damage", damage_type = "stab", scale = 1.3 },
    },
    attack_vectors = { "vector_null" },
}
