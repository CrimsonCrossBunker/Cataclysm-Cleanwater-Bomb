local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hit_and_run",
    name = ccb.content.text_without_extraction("Running Away"),
    description = ccb.content.text_without_extraction("Causes monster to run away for 5 turns."),
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    effect = "attack",
    shape = "blast",
    effect_data = "run",
    min_duration = 500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dermatik_emergence",
    name = ccb.content.text_without_extraction("Dermatik Emergence"),
    description = ccb.content.text_without_extraction("The incubating dermatik larvae flee their host."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    base_casting_time = 20,
    min_range = 1,
    max_range = 5,
    min_damage = 1,
    max_damage = 3,
    damage_type = "stab",
    min_aoe = 2,
    max_aoe = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_dermatik_larva",
    extra_spells = { { spell = "frog_mother_hurt_self", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_juv_dermatik_wingmolt_spell",
    name = ccb.content.text_without_extraction("Attempt to molt wings"),
    description = ccb.content.text_without_extraction("redbull-gives you wings!"),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "NO_PROJECTILE" },
    effect = "targeted_polymorph",
    effect_data = "mon_dermatik_juvenile",
    shape = "blast",
    spell_class = "NONE",
    base_casting_time = 50,
    difficulty = 0,
    max_level = 1,
    min_damage = 9999,
    max_damage = 9999,
    damage_type = "pure",
    min_range = 30,
    max_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mutant_frenzy",
    name = ccb.content.text_without_extraction("Mutant Frenzy"),
    description = ccb.content.text_without_extraction("Speeds up allied mutants in a radius."),
    valid_targets = { "ally" },
    targeted_monsters = {
        "mon_mutant_antler",
        "mon_mutant_arthropod",
        "mon_mutant_camouflaged",
        "mon_mutant_mollusk",
        "mon_mutant_experimental",
        "mon_mutant_evolved",
    },
    effect = "attack",
    shape = "blast",
    effect_data = "frenzy",
    max_level = 1,
    min_range = 10,
    max_range = 10,
    min_aoe = 8,
    max_aoe = 12,
    min_damage = 0,
    max_damage = 0,
    min_duration = 9000,
    max_duration = 9000,
    base_casting_time = 200,
    flags = { "RANDOM_AOE", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spread_sludge",
    name = ccb.content.text_without_extraction("Spread Sludge"),
    description = ccb.content.text_without_extraction("Splatters sludge along the ground in a cone."),
    valid_targets = { "hostile", "ground" },
    max_level = 1,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    min_aoe = 45,
    max_aoe = 45,
    base_casting_time = 75,
    min_range = 4,
    max_range = 4,
    effect = "attack",
    shape = "cone",
    field = "fd_sludge",
    field_chance = 2,
    min_field_intensity = 2,
    max_field_intensity = 2,
}
