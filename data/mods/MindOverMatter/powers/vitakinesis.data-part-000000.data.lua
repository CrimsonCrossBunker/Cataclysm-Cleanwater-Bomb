local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_stop_bleeding_01",
    name = ccb.content.text_without_extraction("[Ψ]Staunch Wound #1"),
    description = ccb.content.text_without_extraction("The first of the Staunch Wound spells.  This summons a low-power bandage--it's a bug if you have it."),
    valid_targets = { "self" },
    skill = "metaphysics",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    effect_data = "vita_bandage_01",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_duration = 200,
    max_duration = 200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_stop_bleeding_02",
    name = ccb.content.text_without_extraction("[Ψ]Staunch Wound #2"),
    description = ccb.content.text_without_extraction("The first of the Staunch Wound spells.  This summons a medium-power bandage--it's a bug if you have it."),
    valid_targets = { "self" },
    skill = "metaphysics",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    effect_data = "vita_bandages_02",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_duration = 200,
    max_duration = 200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_stop_bleeding_03",
    name = ccb.content.text_without_extraction("[Ψ]Staunch Wound #3"),
    description = ccb.content.text_without_extraction("The first of the Staunch Wound spells.  This summons a high-power bandage--it's a bug if you have it."),
    valid_targets = { "self" },
    skill = "metaphysics",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    effect_data = "vita_bandages_03",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_duration = 200,
    max_duration = 200,
}
