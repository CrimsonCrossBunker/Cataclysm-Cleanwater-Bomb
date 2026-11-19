local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_knife_finisher",
    name = ccb.content.text("Slaying Strike"),
    required_char_flags_all = { "MELEE_PERK_KNIFE_FINISHER" },
    weapon_categories = { "KNIVES", "SHIVS" },
    melee_allowed = true,
    crit_ok = true,
    weighting = 1,
    flat_bonuses = { { stat = "hit", scale = 5.0 } },
    messages = {
        ccb.content.text("You viciously wound %s"),
        ccb.content.text("<npcname> viciously wounds %s"),
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_perk_knife_finisher",
    condition_description = ccb.content.text("* Requires <info>tempo(3)</info> to trigger."),
}

ccb.content.define_technique {
    id = "tec_perk_duelist_combo",
    name = ccb.content.text("Compound strike"),
    required_char_flags_all = { "MELEE_PERK_DUELIST_COMBO" },
    melee_allowed = true,
    crit_ok = true,
    unarmed_allowed = true,
    weighting = 100,
    mult_bonuses = {
        { stat = "hit", scale = 5.0 },
        { stat = "movecost", scale = 0.3 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 2.25 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 2.25 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 2.25 },
        { stat = "damage", damage_type = "bash", scale = 1.55 },
        { stat = "damage", damage_type = "cut", scale = 1.55 },
        { stat = "damage", damage_type = "stab", scale = 1.55 },
    },
    messages = {
        ccb.content.text("You cleanly transition from your last attack into a powerful finishing strike against %s"),
        ccb.content.text("<npcname> cleanly transitions their last attack into a powerful finishing strike against %s"),
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_perk_duelist_combo",
    condition_description = ccb.content.text("* Can only trigger on the attack that achieves <info>tempo(3)</info>.  The attacked target must be the same as the previous two attacks."),
}
