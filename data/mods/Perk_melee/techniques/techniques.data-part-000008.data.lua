local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_staff_kick",
    name = ccb.content.text("Fulcrum Kick"),
    required_char_flags_all = { "MELEE_PERK_STAFF_KICK" },
    weapon_categories = { "QUARTERSTAVES", "SPEARS", "POLEARMS" },
    weighting = -2,
    knockback_dist = 2,
    crit_ok = true,
    melee_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.015 },
        { stat = "damage", damage_type = "stab", scale = 0.01 },
    },
    messages = {
        ccb.content.text("You use your polearm as a springboard to kick %s"),
        ccb.content.text("<npcname> kicks %s"),
    },
    attack_vectors = { "vector_foot_heel" },
    when = "allow_mma_tec_pokken_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size incapable of flight."),
}

ccb.content.define_technique {
    id = "tec_perk_estocada",
    name = ccb.content.text("Estocada"),
    required_char_flags_all = { "MELEE_PERK_ESTOCADA" },
    messages = {
        ccb.content.text("You thrust your weapon into %s"),
        ccb.content.text("<npcname> thrusts their weapon into %s"),
    },
    melee_allowed = true,
    weighting = 10,
    weapon_categories = {
        "QUARTERSTAVES",
        "LONG_SWORDS",
        "MEDIUM-SWORDS",
        "LONG_THRUSTING_SWORDS",
        "FENCING_WEAPONRY",
    },
    mult_bonuses = {
        { stat = "damage", damage_type = "stab", scale = 1.1 },
        { stat = "movecost", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_perk_estocada",
    condition_description = ccb.content.text("* Requires <info>momentum(1)</info> to trigger."),
}
