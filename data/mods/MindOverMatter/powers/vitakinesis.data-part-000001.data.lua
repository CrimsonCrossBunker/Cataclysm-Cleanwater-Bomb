local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_stop_infection_01",
    name = ccb.content.text_without_extraction("[Ψ]Allay Infection #1"),
    description = ccb.content.text_without_extraction("The first of the Allay Infection spells.  This summons a low-power disinfectant/antibiotic--it's a bug if you have it."),
    valid_targets = { "self" },
    teachable = false,
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    effect_data = "vita_disinfectant_01",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_duration = 200,
    max_duration = 200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_stop_infection_02",
    name = ccb.content.text_without_extraction("[Ψ]Allay Infection #2"),
    description = ccb.content.text_without_extraction("The second of the Allay Infection spells.  This summons a medium-power disinfectant/antibiotic--it's a bug if you have it."),
    valid_targets = { "self" },
    teachable = false,
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    effect_data = "vita_disinfectant_02",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_duration = 200,
    max_duration = 200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_stop_infection_03",
    name = ccb.content.text_without_extraction("[Ψ]Allay Infection #3"),
    description = ccb.content.text_without_extraction("The third of the Allay Infection spells.  This summons a high-power disinfectant/antibiotic--it's a bug if you have it."),
    valid_targets = { "self" },
    teachable = false,
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    effect_data = "vita_disinfectant_03",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_duration = 200,
    max_duration = 200,
}
