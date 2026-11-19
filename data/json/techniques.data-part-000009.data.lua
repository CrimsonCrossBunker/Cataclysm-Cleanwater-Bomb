local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_capoeira_feint",
    name = ccb.content.text("Feint"),
    messages = { ccb.content.text("You fake a kick at %s"), ccb.content.text("<npcname> fakes a kick at %s") },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_capoeira_pushkick",
    name = ccb.content.text("Push Kick"),
    messages = { ccb.content.text("You push kick %s"), ccb.content.text("<npcname> push kicks %s") },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_foot_sole" },
}

ccb.content.define_technique {
    id = "tec_capoeira_circlekick",
    name = ccb.content.text("Circle Kick"),
    messages = { ccb.content.text("You circle kick %s"), ccb.content.text("<npcname> circle kicks %s") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_foot_sole" },
}
