local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_medievalpole_highround",
    name = ccb.content.text("High Round Strike"),
    messages = {
        ccb.content.text("You swing high and strike at %s"),
        ccb.content.text("<npcname> swings high and strikes %s"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    forbidden_buffs_all = { "buff_medievalpole_onmove" },
    reach_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_medievalpole_feint",
    name = ccb.content.text("High Round Feint"),
    messages = {
        ccb.content.text("You fake a high round strike at %s"),
        ccb.content.text("<npcname> feints at %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}

ccb.content.define_technique {
    id = "tec_medievalpole_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you push away"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they push away"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}
