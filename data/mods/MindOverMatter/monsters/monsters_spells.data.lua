local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vitakinetic_health_down",
    name = ccb.content.text_without_extraction("[Ψ]Draining Touch Monster"),
    description = ccb.content.text_without_extraction("Drain Target's Health Mod.  It's a bug if you have it."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "SILENT", "TOUCH_REQUIRED", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_vitakinetic_health_down",
    damage_type = "psi_enervation_damage",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 1,
    min_damage = 1,
    max_damage = 1,
    min_duration = 1080000,
    base_casting_time = 50,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vitakinetic_healing_down",
    name = ccb.content.text_without_extraction("[Ψ]Draining Touch 2 Monster"),
    description = ccb.content.text_without_extraction("Drain Target's Health Mod and reduce healing.  It's a bug if you have it."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "SILENT", "TOUCH_REQUIRED", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_vitakinetic_healing_down",
    damage_type = "psi_enervation_damage",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 1,
    min_damage = 1,
    max_damage = 1,
    min_duration = 1620000,
    base_casting_time = 50,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vitakinetic_regeneration_monster",
    name = ccb.content.text_without_extraction("[Ψ]Feral Vitakinetic healing"),
    description = ccb.content.text_without_extraction("Buffs regeneration for a feral vitakinetic.  It's a bug if you have it, and anyway it wouldn't work on you."),
    valid_targets = { "self" },
    flags = { "PSIONIC", "SILENT", "TOUCH_REQUIRED", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "effect_feral_regeneration",
    shape = "blast",
    min_duration = 200,
    max_duration = 600,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_feral_vitakin3_degenerating_touch",
    name = ccb.content.text_without_extraction("[Ψ]Degenerating Touch Self From Monster"),
    description = ccb.content.text_without_extraction("You are degenerating.  RIP."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    spell_class = "VITAKINETIC",
    skill = "metaphysics",
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "RANDOM_DAMAGE",
        "NO_LEGS",
        "SPLIT_DAMAGE",
        "RANDOM_DURATION",
        "NO_EXPLOSION_SFX",
    },
    effect = "attack",
    effect_data = "effect_vita_degenerating_touch",
    damage_type = "biological",
    shape = "blast",
    min_dot = 4,
    max_dot = 10,
    min_duration = 1500,
    max_duration = 6500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_feral_vitakin3_degenerating_touch_monster",
    name = ccb.content.text_without_extraction("[Ψ]Degenerating Touch Self From Monster to Monster"),
    description = ccb.content.text_without_extraction("You are degenerating.  RIP."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    spell_class = "VITAKINETIC",
    skill = "metaphysics",
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "RANDOM_DAMAGE",
        "RANDOM_DURATION",
        "NO_EXPLOSION_SFX",
    },
    effect = "attack",
    effect_data = "effect_vita_degenerating_touch",
    damage_type = "biological",
    shape = "blast",
    min_dot = 1,
    max_dot = 4,
    min_duration = 1500,
    max_duration = 6500,
}

-- NO_I18N
ccb.content.define_spell {
    id = "hidebehind_apply_mindsight",
    name = ccb.content.text_without_extraction("Hidebehind apply mindsight"),
    description = ccb.content.text("Add the effect to give the hidebehind mindsight."),
    flags = {
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "MUST_HAVE_CLASS_TO_LEARN",
        "HIDDEN_SPELL",
    },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "eff_mind_seeing_bonus_20",
    shape = "blast",
    min_range = 0,
    max_range = 0,
    min_duration = 900000,
    max_duration = 900000,
}

-- NO_I18N
ccb.content.define_spell {
    id = "eater_apply_mindsight",
    name = ccb.content.text_without_extraction("Eater apply mindsight"),
    description = ccb.content.text("Add the effect to give the eater mindsight."),
    flags = {
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "MUST_HAVE_CLASS_TO_LEARN",
        "HIDDEN_SPELL",
    },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "eff_mind_seeing_bonus_30",
    shape = "blast",
    min_range = 0,
    max_range = 0,
    min_duration = 900000,
    max_duration = 900000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "small_psi_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Psi Raptors"),
    description = ccb.content.text_without_extraction("Summons a few zombiespawn psi raptors."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX", "SPAWN_GROUP" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "GROUP_SPAWN_PSI_RAPTOR",
}
