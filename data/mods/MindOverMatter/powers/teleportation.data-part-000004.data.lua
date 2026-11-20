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
