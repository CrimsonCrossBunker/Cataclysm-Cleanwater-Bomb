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
