local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_execution_sword",
    name = ccb.content.text("Execution (Great Sword)"),
    messages = {
        ccb.content.text("You deliver a rapid strike to the %s before cleaving them in two with a powerful blow"),
        ccb.content.text("<npcname> cleaves %s in two with a powerful blow"),
    },
    required_char_flags_all = { "MELEE_PERK_EXECUTION" },
    melee_allowed = true,
    crit_ok = true,
    weapon_categories = { "GREAT_SWORDS" },
    weighting = 10000,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scale = 1000 },
        { stat = "arpen", damage_type = "cut", scale = 1000 },
        { stat = "arpen", damage_type = "stab", scale = 1000 },
    },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 12.0 },
        { stat = "damage", damage_type = "cut", scale = 12.0 },
        { stat = "damage", damage_type = "stab", scale = 12.0 },
        { stat = "movecost", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_execution_applied",
    when = "allow_perk_execution",
}

ccb.content.define_technique {
    id = "tec_perk_execution_hammer",
    name = ccb.content.text("Execution (Great Hammer)"),
    messages = {
        ccb.content.text("You knock the %s to the ground before delivering a crushing blow"),
        ccb.content.text("<npcname> knocks down and crushes %s with a powerful blow"),
    },
    required_char_flags_all = { "MELEE_PERK_EXECUTION" },
    melee_allowed = true,
    crit_ok = true,
    weapon_categories = { "GREAT_HAMMERS" },
    weighting = 10000,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scale = 1000 },
        { stat = "arpen", damage_type = "cut", scale = 1000 },
        { stat = "arpen", damage_type = "stab", scale = 1000 },
    },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 12.0 },
        { stat = "damage", damage_type = "cut", scale = 12.0 },
        { stat = "damage", damage_type = "stab", scale = 12.0 },
        { stat = "movecost", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_execution_applied",
    when = "allow_perk_execution",
}

ccb.content.define_technique {
    id = "tec_perk_execution_axe",
    name = ccb.content.text("Execution (Great Axe)"),
    messages = {
        ccb.content.text("You cleave the %s asunder with a furious slash"),
        ccb.content.text("<npcname> cleaves into %s with a powerful blow"),
    },
    required_char_flags_all = { "MELEE_PERK_EXECUTION" },
    melee_allowed = true,
    crit_ok = true,
    weapon_categories = { "GREAT_AXES" },
    weighting = 10000,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scale = 1000 },
        { stat = "arpen", damage_type = "cut", scale = 1000 },
        { stat = "arpen", damage_type = "stab", scale = 1000 },
    },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 12.0 },
        { stat = "damage", damage_type = "cut", scale = 12.0 },
        { stat = "damage", damage_type = "stab", scale = 12.0 },
        { stat = "movecost", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_execution_applied",
    when = "allow_perk_execution",
}
