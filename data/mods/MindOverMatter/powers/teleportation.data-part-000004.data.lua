local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_01",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex 01"),
    description = ccb.content.text_without_extraction("Version 1 of the spacial vortex, with 2 pulls in."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = {
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_02",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex 02"),
    description = ccb.content.text_without_extraction("Version 2 of the spacial vortex, with 3 pulls in."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = {
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_03",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex 03"),
    description = ccb.content.text_without_extraction("Version 3 of the spacial vortex, with 4 pulls in."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = {
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_04",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex 04"),
    description = ccb.content.text_without_extraction("Version 4 of the spacial vortex, with 5 pulls in."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = {
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_05",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex 05"),
    description = ccb.content.text_without_extraction("Version 5 of the spacial vortex, with 6 pulls in."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = {
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_06",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex 06"),
    description = ccb.content.text_without_extraction("Version 6 of the spacial vortex, with 7 pulls in."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = {
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_07",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex 07"),
    description = ccb.content.text_without_extraction("Version 7 of the spacial vortex, with 8 pulls in."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = {
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
        { spell = "teleport_collapse_pull", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_collapse_pull",
    name = ccb.content.text_without_extraction("[Ψ]Spacial Vortex Real"),
    description = ccb.content.text_without_extraction("The actual spacial vortex that pulls in monsters.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "area_pull",
    shape = "blast",
    min_range = { handler = "scale_teleport_collapse_01_min_range", fallback = 0.0 },
    max_range = 80,
    min_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_teleport_collapse_01_min_aoe", fallback = 0.0 },
}

ccb.content.define_spell {
    id = "teleport_displacement",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    name = "[Ψ]Displacement",
    description = "With a touch, you can send your target through the void to re-emerge somewhere nearby, further away from you.  Targets that are <color_yellow>too large</color> cannot be displaced.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "TOUCH_REQUIRED", "NO_LEGS", "NO_EXPLOSION_SFX" },
    valid_targets = { "ally", "hostile" },
    ignored_species = { "PSI_NULL" },
    min_range = 1,
    base_energy_cost = 4000,
    final_energy_cost = 1750,
    energy_increment = -65,
    difficulty = 4,
    max_level = { handler = "w16b_sp_stat_mindovermatter_f3b23418fec0", fallback = 0 },
    base_casting_time = 95,
    final_casting_time = 25,
    casting_time_increment = -4,
    impact_handler = "w16b_sp_imp_mindovermatter_c688e5792376",
}

ccb.content.define_spell {
    id = "teleport_reactive_displacement",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    name = "[Ψ]Reactive Displacement (C)",
    description = "Maintain a field of unstable space around you, allowing you to effortlessly teleport enemies that strike you further away.  Unfortunately, their attacks will still hurt you as normal.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>.",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = { handler = "w16b_sp_stat_mindovermatter_77a117a85919", fallback = 0 },
    max_duration = { handler = "w16b_sp_stat_mindovermatter_9de8067b1aff", fallback = 0 },
    base_energy_cost = { handler = "w16b_sp_stat_mindovermatter_457d62e42aae", fallback = 0 },
    difficulty = 5,
    max_level = { handler = "w16b_sp_stat_mindovermatter_f3b23418fec0", fallback = 0 },
    base_casting_time = { handler = "w16b_sp_stat_mindovermatter_83e99fcbfdc1", fallback = 0 },
    impact_handler = "w16b_sp_imp_mindovermatter_3fb483008824",
}

ccb.content.define_spell {
    id = "teleport_reactive_displacement_teleport",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    name = ccb.content.text_without_extraction("[Ψ]Reactive Displacement (C) - Teleport"),
    description = ccb.content.text_without_extraction("The actual teleport effect of reactive displacement.  Having this spell is a bug."),
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    valid_targets = { "ally", "hostile" },
    ignored_species = { "PSI_NULL" },
    energy_source = "NONE",
    min_damage = 1,
    max_damage = 1,
    min_range = 1,
    difficulty = 0,
    max_level = 0,
    impact_handler = "w16b_sp_imp_mindovermatter_c688e5792376",
}

ccb.content.define_spell {
    id = "teleport_collapse",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    name = "[Ψ]Spacial Vortex",
    description = "Affect the fabric of space, changing relative distance around a point so that everything moving within finds themselves moving towards it.",
    message = "The air around your enemies shimmers as their forward motion carries them rapidly towards each other.",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    ignored_species = { "PSI_NULL" },
    base_energy_cost = 5500,
    final_energy_cost = 3000,
    energy_increment = -75,
    difficulty = 5,
    max_level = { handler = "w16b_sp_stat_mindovermatter_f3b23418fec0", fallback = 0 },
    base_casting_time = 80,
    final_casting_time = 45,
    casting_time_increment = -2,
    impact_handler = "w16b_sp_imp_mindovermatter_607e87675641",
}
