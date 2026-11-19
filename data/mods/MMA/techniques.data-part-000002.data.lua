local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_iron_heart_wide",
    name = ccb.content.text("Steel Wind"),
    messages = {
        ccb.content.text("You cleave through %s and those nearby like a steel wind"),
        ccb.content.text("<npcname> cleaves through %s and those nearby like a steel wind"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_wide_crit",
    name = ccb.content.text("Scything Blade"),
    messages = {
        ccb.content.text("You cleanly reap through %s and those nearby"),
        ccb.content.text("<npcname> cleanly reap through %s and those nearby"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    aoe = "wide",
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
}

-- No translation on wiki.  It's a Somersault Kick.
ccb.content.define_technique {
    id = "mma_tec_panzer_somersault",
    name = ccb.content.text("Kumai Sharinraku"),
    messages = {
        ccb.content.text("You jump and somersault kick %s"),
        ccb.content.text("<npcname> jump and somersault kick %s"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_null", "vector_foot_heel" },
}
