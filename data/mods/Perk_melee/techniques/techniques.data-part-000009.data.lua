local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_duelist_lunge",
    name = ccb.content.text("Lunge"),
    weapon_categories = { "FENCING_WEAPONRY", "LONG_THRUSTING_SWORDS" },
    melee_allowed = true,
    crit_ok = true,
    reach_tec = true,
    weighting = 100,
    required_char_flags_all = { "MELEE_PERK_DUELIST_LUNGE" },
    mult_bonuses = {
        { stat = "movecost", scale = 0.8 },
        { stat = "damage", damage_type = "bash", scale = 0.25 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    messages = {
        ccb.content.text("You step and stab the %s with an elegant motion"),
        ccb.content.text("<npcname> steps closer to %s and stabs them with a quick motion"),
    },
    description = ccb.content.text("A quick reach attack that scales heavily with perception."),
    attack_vectors = { "vector_null" },
    on_apply = "perk_duelist_lunge",
}

ccb.content.define_technique {
    id = "tec_perk_knife_counter_dodge",
    name = ccb.content.text("Knife Counter"),
    required_char_flags_all = { "MELEE_PERK_KNIFE_COUNTER_DODGE" },
    weapon_categories = { "KNIVES", "SHIVS" },
    melee_allowed = true,
    crit_ok = true,
    dodge_counter = true,
    weighting = 100,
    mult_bonuses = {
        { stat = "movecost", scale = 0.1 },
        { stat = "damage", damage_type = "bash", scale = 0.02 },
        { stat = "damage", damage_type = "cut", scale = 0.2 },
        { stat = "damage", damage_type = "stab", scale = 0.2 },
    },
    messages = {
        ccb.content.text("You slash at  %s as you dodge"),
        ccb.content.text("<npcname> slashes at %s as they dodge"),
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_retreat_on_dodge",
}
