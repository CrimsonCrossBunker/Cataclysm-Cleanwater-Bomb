local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_dreamsmith_time_trap_freeze_spawn_trap",
    name = ccb.content.text_without_extraction("Time Freeze - Spawn Trap"),
    description = ccb.content.text_without_extraction("Spawns the trap after it is used.  Having this spell is a bug."),
    teachable = false,
    valid_targets = { "ground" },
    skill = "deduction",
    flags = { "NO_FAIL", "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "PERMANENT_ALL_LEVELS" },
    difficulty = 0,
    max_level = 1,
    effect = "spawn_item",
    effect_data = "xedra_dreamsmith_time_trap",
    shape = "blast",
    min_range = 1,
    max_range = 1,
    energy_source = "NONE",
    base_energy_cost = 0,
    base_casting_time = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_unique_weapon_sword_onhit_blind",
    name = ccb.content.text_without_extraction("Sidereal Eclipse blind"),
    description = ccb.content.text_without_extraction("Targets you hit are blinded."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "blind",
    min_duration = 200,
    max_duration = 600,
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_blind_flash",
    name = ccb.content.text_without_extraction("Flash fruit"),
    description = ccb.content.text_without_extraction("Produces the fruit's flash effect when eaten.  You're not supposed to see this, the same way your foes aren't supposed to see after you ate that fruit near them."),
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    affected_bodyparts = { "eyes" },
    valid_targets = { "self", "ground" },
    min_aoe = 7,
    max_aoe = 7,
    min_range = 1,
    max_range = 1,
    min_duration = 2000,
    max_duration = 2500,
    spell_class = "NONE",
    flags = { "SILENT", "NO_FAIL", "NO_LEGS", "NO_PROJECTILE" },
    difficulty = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_heat_blasts",
    name = ccb.content.text_without_extraction("Fruit blast"),
    description = ccb.content.text_without_extraction("Cast heat beams in random directions."),
    valid_targets = { "self" },
    flags = { "WONDER" },
    effect = "attack",
    shape = "blast",
    message = ccb.content.text("Fiery needles emerge from your body and surge towards anything vaguely hostile."),
    min_damage = 25,
    max_damage = 25,
    min_range = 0,
    max_range = 0,
    extra_spells = { { spell = "goblin_fruit_heat_blast" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_heat_blast",
    name = ccb.content.text_without_extraction("Heat beam"),
    description = ccb.content.text_without_extraction("Uncontrolled heat blast."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_TARGET", "RANDOM_DAMAGE", "SILENT" },
    effect = "attack",
    shape = "blast",
    message = "",
    min_damage = 10,
    max_damage = 20,
    damage_type = "heat",
    min_range = 7,
    max_range = 7,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_map_reveal",
    name = ccb.content.text_without_extraction("Goblin fruit map reveal"),
    description = ccb.content.text_without_extraction("Reveal map when you eat a goblin fruit.  You must not see this."),
    teachable = false,
    valid_targets = { "none" },
    spell_class = "NONE",
    flags = { "NO_HANDS", "NO_FAIL", "SILENT", "NO_LEGS" },
    difficulty = 0,
    max_level = 0,
    effect = "map",
    shape = "blast",
    min_aoe = 15,
    max_aoe = 15,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bezoar_vomit",
    name = ccb.content.text_without_extraction("Bezoar Vomit"),
    valid_targets = { "self" },
    description = ccb.content.text_without_extraction("Vomits when you consume a second bezoar."),
    flags = { "SILENT" },
    effect = "vomit",
    shape = "blast",
}
