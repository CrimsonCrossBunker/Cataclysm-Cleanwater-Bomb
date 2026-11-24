local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    required_char_flags_all = { "MELEE_PERK_FEINT" },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}

ccb.content.define_technique {
    id = "tec_perk_stagger_strike",
    name = ccb.content.text("Staggering Strike"),
    weapon_damage = { { type = "bash", minimum = 12 } },
    melee_allowed = true,
    crit_ok = true,
    stun_dur = 3,
    weighting = 1,
    required_char_flags_all = { "MELEE_PERK_STAGGER_STRIKE" },
    messages = {
        ccb.content.text("You deliver a stunning strike to %s"),
        ccb.content.text("<npcname> delivers a stunning strike to %s"),
    },
    description = ccb.content.text("Stun for 1 turn"),
    attack_vectors = { "vector_null" },
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    when = "allow_tec_perk_stagger_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar or smaller</info> size."),
}

ccb.content.define_technique {
    id = "tec_perk_fore",
    name = ccb.content.text("Brutal Swing"),
    required_char_flags_all = { "MELEE_PERK_FORE" },
    weapon_damage = { { type = "bash", minimum = 15 } },
    melee_allowed = true,
    crit_ok = true,
    knockback_dist = 3,
    weighting = -4,
    messages = {
        ccb.content.text("You send %s reeling with a brutal strike"),
        ccb.content.text("<npcname> sends %s reeling"),
    },
    description = ccb.content.text("Three tile knockback"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_perk_fore_stunned",
    name = ccb.content.text("Brutal Swing (Stunned target)"),
    required_char_flags_all = { "MELEE_PERK_FORE" },
    weapon_damage = { { type = "bash", minimum = 15 } },
    melee_allowed = true,
    crit_ok = true,
    knockback_dist = 3,
    weighting = 100,
    messages = {
        ccb.content.text("You send %s reeling with a brutal strike"),
        ccb.content.text("<npcname> sends %s reeling"),
    },
    description = ccb.content.text("Three tile knockback"),
    attack_vectors = { "vector_null" },
    when = "allow_tec_perk_fore_stunned",
}

ccb.content.define_technique {
    id = "tec_perk_shoulder_tackle",
    name = ccb.content.text("Shoulder tackle"),
    messages = {
        ccb.content.text("You ground %s with a shoulder bash"),
        ccb.content.text("<npcname> drops %s with a shoulder bash"),
    },
    required_char_flags_all = { "MELEE_PERK_TACKLE" },
    required_buffs_any = { "buff_perk_momentum" },
    weighting = 100,
    crit_ok = true,
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 0.8 },
    },
    down_dur = 2,
    attack_vectors = { "vector_shoulder" },
    on_apply = "perk_clear_momentum",
    when = "allow_perk_shoulder_tackle",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size incapable of flight.  Requires <info>momentum(3)</info> or higher to trigger."),
}

ccb.content.define_technique {
    id = "tec_perk_vulgar_opening",
    name = ccb.content.text("Vulgar Opening"),
    messages = {
        ccb.content.text("You cleave into %s with a mighty strike"),
        ccb.content.text("<npcname> cleaves into %s with a powerful blow"),
    },
    required_char_flags_all = { "MELEE_PERK_JUST_HIT_IT" },
    melee_allowed = true,
    crit_ok = true,
    weapon_categories = {
        "GREAT_AXES",
        "GREAT_SWORDS",
        "GREAT_HAMMERS",
        "AXE",
        "MEDIUM-SWORDS",
        "LONG_SWORDS",
        "MACES",
        "AXES",
        "FLAILS",
    },
    weighting = 100,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 2.25 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 2.25 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 2.25 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_perk_vulgar_opening",
}

ccb.content.define_technique {
    id = "tec_perk_coiling_strike",
    name = ccb.content.text("Coiling strike"),
    weapon_categories = { "QUARTERSTAVES", "SPEARS", "POLEARMS" },
    required_buffs_any = { "buff_perk_momentum" },
    melee_allowed = true,
    reach_tec = true,
    required_char_flags_all = { "MELEE_PERK_COILING_STRIKE" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "per", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scaling_stat = "per", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scaling_stat = "per", scale = 0.5 },
    },
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.25 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    messages = {
        ccb.content.text("You quickly stab %s with a sideways thrust"),
        ccb.content.text("<npcname> stabs %s with a quick thrust"),
    },
    description = ccb.content.text("A quick reach attack that scales heavily with perception."),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_perk_make_way",
    name = ccb.content.text("Make Way"),
    required_char_flags_all = { "MELEE_PERK_MAKE_WAY" },
    weapon_categories = { "QUARTERSTAVES", "SPEARS", "POLEARMS" },
    melee_allowed = true,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.25 },
        { stat = "damage", damage_type = "stab", scale = 0.01 },
    },
    messages = {
        ccb.content.text("You swing through %s and everything nearby with an overhead attack"),
        ccb.content.text("<npcname> swings at %s and everything nearby with an overhead attack"),
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_make_way_applied",
    when = "allow_perk_make_way",
}

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

ccb.content.define_technique {
    id = "tec_perk_poise_parry",
    name = ccb.content.text("Perfect Parry"),
    required_char_flags_all = { "MELEE_PERK_POISE_PARRY" },
    melee_allowed = true,
    block_counter = true,
    weighting = 10000,
    mult_bonuses = {
        { stat = "movecost", scale = 0.1 },
        { stat = "damage", damage_type = "bash", scale = 0.02 },
        { stat = "damage", damage_type = "cut", scale = 0.02 },
        { stat = "damage", damage_type = "stab", scale = 0.02 },
    },
    description = ccb.content.text("A quick stunning counter-attack that triggers on blocks or parries."),
    messages = {
        ccb.content.text("You throw %s off balance with a perfect parry"),
        ccb.content.text("<npcname> throws %s off balance with a parry"),
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_stagger_attacker",
    when = "allow_perk_poise_parry",
    condition_description = ccb.content.text("* Requires a full <info>stance meter</info> to trigger on a successful block or parry"),
}
