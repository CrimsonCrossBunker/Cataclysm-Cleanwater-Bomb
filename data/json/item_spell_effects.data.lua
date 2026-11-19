local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dragon_inflatable",
    name = ccb.content.text_without_extraction("Inflatable Dragon"),
    description = ccb.content.text_without_extraction("Creates a short-lived inflatable."),
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_halloween_dragon",
    shape = "blast",
    max_level = 1,
    base_casting_time = 10,
    min_range = 10,
    max_range = 10,
    min_damage = 1,
    max_damage = 1,
    min_aoe = 1,
    max_aoe = 1,
    min_duration = 40000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ghost_inflatable",
    name = ccb.content.text_without_extraction("Inflatable Ghost"),
    description = ccb.content.text_without_extraction("Creates a short-lived inflatable."),
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_halloween_ghost",
    shape = "blast",
    max_level = 1,
    base_casting_time = 10,
    min_range = 10,
    max_range = 10,
    min_damage = 1,
    max_damage = 1,
    min_aoe = 1,
    max_aoe = 1,
    min_duration = 40000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fog_machine",
    name = ccb.content.text_without_extraction("Fog Ex Machina"),
    description = ccb.content.text_without_extraction("You see fog bubbling out of the device."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "ally", "hostile", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    min_aoe = 30,
    max_aoe = 60,
    aoe_increment = 1.4,
    min_range = 6,
    max_range = 6,
    field = "fd_fog",
    min_field_intensity = 0,
    max_field_intensity = 4,
    field_intensity_increment = 0.5,
    min_duration = 18000,
    max_duration = 18000,
    damage_type = "cold",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "debug_kill_spell",
    name = ccb.content.text_without_extraction("Debug Kill Creature"),
    description = ccb.content.text_without_extraction("Deal damage equal to 100% of monster's HP."),
    valid_targets = { "self", "ally", "hostile", "ground" },
    min_damage = 100,
    max_damage = 100,
    min_range = 100,
    max_range = 100,
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    flags = { "SILENT", "PERCENTAGE_DAMAGE", "NO_FAIL" },
}
