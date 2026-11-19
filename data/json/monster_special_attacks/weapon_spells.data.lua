local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mi-go_slaver_beam",
    name = ccb.content.text_without_extraction("Mi-go Slaver Beam"),
    description = ccb.content.text_without_extraction("Mi-go slaver beams cause pain, lower stamina, and give a short-lasting daze effect.  Starts very short range, increases rapidly with level."),
    valid_targets = { "hostile" },
    flags = { "SILENT" },
    shape = "blast",
    effect = "attack",
    effect_data = "dazed",
    extra_spells = {
        { spell = "pain_damage_mi-go_slaver_beam" },
        { spell = "stamina_damage_mi-go_slaver_beam" },
    },
    base_casting_time = 100,
    max_level = 5,
    min_range = 1,
    max_range = 25,
    range_increment = 5.0,
    min_duration = 100,
    max_duration = 1000,
    duration_increment = 200,
}

-- NO_I18N
-- NO_I18N
-- Listed as a recover energy effect with a negative modifier that decreases with each level of the spell, which makes it cause damage instead.
ccb.content.define_spell {
    id = "stamina_damage_mi-go_slaver_beam",
    name = ccb.content.text_without_extraction("Tired"),
    description = ccb.content.text_without_extraction("Decreases stamina.  Designed for mi-go slaver beam."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = -500,
    max_damage = -5500,
    damage_increment = -500.0,
    max_level = 10,
    shape = "blast",
    effect = "recover_energy",
    effect_data = "STAMINA",
}

-- NO_I18N
-- NO_I18N
-- Listed as a recover energy effect with a negative modifier that decreases with each level of the spell, which makes it cause damage instead.
ccb.content.define_spell {
    id = "pain_damage_mi-go_slaver_beam",
    name = ccb.content.text_without_extraction("Pain"),
    description = ccb.content.text_without_extraction("Increases pain.  Designed for mi-go slaver beam."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = -8,
    max_damage = -148,
    damage_increment = -14.0,
    max_level = 10,
    shape = "blast",
    effect = "recover_energy",
    effect_data = "PAIN",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "exodii_weapon_pod",
    name = ccb.content.text_without_extraction("Exodii Multipurpose Weapon Pod"),
    description = ccb.content.text_without_extraction("Randomly selects one of several weapons."),
    valid_targets = { "hostile", "ground" },
    flags = { "NO_EXPLOSION_SFX", "WONDER" },
    effect = "attack",
    shape = "blast",
    base_casting_time = 200,
    min_range = 1,
    max_range = 5,
    max_level = 2,
    min_damage = 1,
    max_damage = 1,
    extra_spells = {
        { spell = "weaponpod_electric_blast" },
        { spell = "weaponpod_heat_gun" },
        { spell = "weaponpod_saw" },
        { spell = "weaponpod_saw" },
        { spell = "weaponpod_saw" },
        { spell = "weaponpod_saw" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "weaponpod_electric_blast",
    name = ccb.content.text_without_extraction("Electric Arc Burst"),
    description = ccb.content.text_without_extraction("The machine emits an explosion of arcing electricity."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    max_level = 3,
    min_damage = 20,
    max_damage = 60,
    damage_increment = 20.0,
    min_range = 5,
    max_range = 7,
    range_increment = 1,
    min_aoe = 10,
    max_aoe = 30,
    aoe_increment = 10.0,
    base_casting_time = 200,
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 1,
    field_chance = 1,
    sound_description = ccb.content.text("a loud crack"),
    damage_type = "electric",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "weaponpod_heat_gun",
    name = ccb.content.text_without_extraction("Combat Heat Gun"),
    description = ccb.content.text_without_extraction("The machine emits a blast of searing heat."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "IGNITE_FLAMMABLE", "SPLIT_DAMAGE" },
    max_level = 3,
    min_damage = 20,
    max_damage = 60,
    damage_increment = 20.0,
    min_range = 3,
    max_range = 5,
    range_increment = 1,
    min_aoe = 20,
    max_aoe = 60,
    aoe_increment = 20.0,
    base_casting_time = 200,
    sound_description = ccb.content.text("a whoosh"),
    damage_type = "heat",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "weaponpod_saw",
    name = ccb.content.text_without_extraction("Combat Saw Arm"),
    description = ccb.content.text_without_extraction("The machine lashes out with a spinning sawblade on some kind of extension arm."),
    effect = "attack",
    shape = "line",
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile", "ground" },
    max_level = 3,
    min_damage = 40,
    max_damage = 80,
    damage_increment = 20.0,
    min_range = 1,
    max_range = 2,
    range_increment = 1,
    base_casting_time = 200,
    sound_description = ccb.content.text("a whir"),
    min_pierce = 3,
    max_pierce = 5,
    pierce_increment = 1,
    damage_type = "stab",
}
