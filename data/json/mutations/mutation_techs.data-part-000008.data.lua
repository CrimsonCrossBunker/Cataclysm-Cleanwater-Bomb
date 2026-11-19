local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_PUNCH_WITH_CLAWS",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You claw %s"), ccb.content.text("<npcname> claws %s") },
    description = ccb.content.text("A basic ursine punch, with claws"),
    attack_vectors = { "vector_broad_paw_punch" },
    when = "allow_tech_broad_paw_punch_with_claws",
}

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_CLAW",
    name = ccb.content.text("Smash"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You viciously claw %s"), ccb.content.text("<npcname> viciously claws %s") },
    description = ccb.content.text("A vicious clawed attack."),
    weighting = -2,
    attack_vectors = { "vector_broad_paw_punch" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "unarmed", scale = 0.25 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_broad_paw_punch_with_claws",
}

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_SMASH_KNOCKBACK",
    name = ccb.content.text("Smash"),
    crit_tec = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You smash %s with your paw and send them reeling!"),
        ccb.content.text("<npcname> smashes %s and sends them reeling!"),
    },
    description = ccb.content.text("A vicious smashing attack."),
    weighting = -2,
    attack_vectors = { "vector_broad_paw_punch" },
    knockback_dist = 2,
    down_dur = 2,
    when = "allow_tech_broad_paw_smash_knockback",
}

ccb.content.define_technique {
    id = "TECH_PAW_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You punch %s"), ccb.content.text("<npcname> punches %s") },
    description = ccb.content.text("A basic pawed punch"),
    attack_vectors = { "vector_paw_punch", "vector_paw_rat_punch" },
    when = "allow_tech_broad_paw_punch",
}

ccb.content.define_technique {
    id = "TECH_PAW_PUNCH_WITH_CLAWS",
    name = ccb.content.text("Claw"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You claw %s"), ccb.content.text("<npcname> claw %s") },
    description = ccb.content.text("A basic clawed and pawed punch"),
    attack_vectors = { "vector_paw_punch", "vector_paw_rat_punch" },
    when = "allow_tech_broad_paw_punch_with_claws",
}

ccb.content.define_technique {
    id = "TECH_PAW_CLAW",
    name = ccb.content.text("Claw"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You viciously claw %s"), ccb.content.text("<npcname> viciously claws %s") },
    description = ccb.content.text("A vicious clawed attack."),
    weighting = -2,
    attack_vectors = { "vector_paw_punch", "vector_paw_rat_punch" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "unarmed", scale = 0.25 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_broad_paw_punch_with_claws",
}
