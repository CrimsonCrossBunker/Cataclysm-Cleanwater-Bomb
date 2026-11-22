local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokin_summon_thermogenesis_1",
    name = ccb.content.text_without_extraction("[Ψ]Thermogenesis #1"),
    description = ccb.content.text_without_extraction("The spell to summon a thermogenesis node.  It's a bug if you have it directly."),
    valid_targets = { "ground" },
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_pyrokin_hotair_1",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_range = 3,
    min_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_min_duration", fallback = 0.0 },
    max_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_max_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokin_summon_thermogenesis_2",
    name = ccb.content.text_without_extraction("[Ψ]Thermogenesis #2"),
    description = ccb.content.text_without_extraction("The spell to summon a thermogenesis node.  It's a bug if you have it directly."),
    valid_targets = { "ground" },
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_pyrokin_hotair_2",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_range = 3,
    min_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_min_duration", fallback = 0.0 },
    max_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_max_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokin_summon_thermogenesis_3",
    name = ccb.content.text_without_extraction("[Ψ]Thermogenesis #3"),
    description = ccb.content.text_without_extraction("The spell to summon a thermogenesis node.  It's a bug if you have it directly."),
    valid_targets = { "ground" },
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_pyrokin_hotair_3",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_range = 3,
    min_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_min_duration", fallback = 0.0 },
    max_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_max_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokin_summon_thermogenesis_4",
    name = ccb.content.text_without_extraction("[Ψ]Thermogenesis #4"),
    description = ccb.content.text_without_extraction("The spell to summon a thermogenesis node.  It's a bug if you have it directly."),
    valid_targets = { "ground" },
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_pyrokin_hotair_4",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_range = 3,
    min_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_min_duration", fallback = 0.0 },
    max_duration = { handler = "scale_pyrokin_summon_thermogenesis_1_max_duration", fallback = 0.0 },
}

ccb.content.define_spell {
    id = "pyrokinetic_lance",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "PYROKINETIC",
    magic_type = "mom_psionics",
    name = "[Ψ]Incandescent Lance (C)",
    description = "Concentrate heat into a thin, searing beam capable of cutting through solid metal or welding it together.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>.  It is <color_red>canceled by engaging in combat</color>.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = { handler = "w16b_sp_stat_mindovermatter_86195536794f", fallback = 0 },
    max_duration = { handler = "w16b_sp_stat_mindovermatter_e413d9c8f888", fallback = 0 },
    base_energy_cost = { handler = "w16b_sp_stat_mindovermatter_131774c430aa", fallback = 0 },
    difficulty = 5,
    max_level = { handler = "w16b_sp_stat_mindovermatter_073c19652ad6", fallback = 0 },
    base_casting_time = { handler = "w16b_sp_stat_mindovermatter_35d5714b83fb", fallback = 0 },
    impact_handler = "w16b_sp_imp_mindovermatter_14c34afd6c09",
}

ccb.content.define_spell {
    id = "pyrokinetic_thermogenesis",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "PYROKINETIC",
    magic_type = "mom_psionics",
    name = "[Ψ]Thermogenesis",
    description = "Heat the air nearby and maintain it, taking off the chill or turning winter to warm summer.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = { handler = "w16b_sp_stat_mindovermatter_9eca71a925df", fallback = 0 },
    max_duration = { handler = "w16b_sp_stat_mindovermatter_4e0931358362", fallback = 0 },
    base_energy_cost = 8000,
    final_energy_cost = 4000,
    energy_increment = -200,
    difficulty = 6,
    max_level = { handler = "w16b_sp_stat_mindovermatter_073c19652ad6", fallback = 0 },
    base_casting_time = 1500,
    final_casting_time = 1200,
    casting_time_increment = -10,
    impact_handler = "w16b_sp_imp_mindovermatter_50f60fe07cb7",
}
