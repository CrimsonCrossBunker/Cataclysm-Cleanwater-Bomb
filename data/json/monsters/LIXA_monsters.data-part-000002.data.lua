local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "LIXA_spread_light",
    name = ccb.content.text_without_extraction("Spread Light"),
    description = ccb.content.text_without_extraction("Splashes congealed light along the ground in a cone."),
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
    field = "fd_congealed_light",
    field_chance = 2,
    min_field_intensity = 2,
    max_field_intensity = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "LIXA_photonic_death",
    name = ccb.content.text_without_extraction("Photonic Death"),
    description = ccb.content.text_without_extraction("Puddle o' light."),
    valid_targets = { "ground", "self", "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    effect_data = "LIXA_illuminated",
    field = "fd_congealed_light",
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 1,
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "LIXA_spawn_copy",
    name = ccb.content.text_without_extraction("Summon Eigenspectre Copy"),
    description = ccb.content.text_without_extraction("Ripping off the hounds of Tindalos!"),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 3,
    base_casting_time = 100,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_eigenspectre_3_echo",
}
