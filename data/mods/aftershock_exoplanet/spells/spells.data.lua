local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_fusion_fan",
    name = ccb.content.text_without_extraction("Plasma fan"),
    description = ccb.content.text_without_extraction("Your weapon releases a searing fan of plasma."),
    effect = "attack",
    shape = "cone",
    field = "fd_rad_glimmer",
    min_field_intensity = 3,
    max_field_intensity = 9,
    valid_targets = { "hostile", "ally", "ground" },
    flags = { "LOUD", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE", "IGNORE_WALLS", "SPLIT_DAMAGE" },
    min_damage = 15,
    max_damage = 15,
    min_bash_scaling = 1,
    max_bash_scaling = 4,
    min_aoe = 15,
    max_aoe = 15,
    min_range = 10,
    max_range = 10,
    difficulty = 1,
    sound_description = ccb.content.text("fzzzt"),
    damage_type = "afs_plasma",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_vahagn",
    name = ccb.content.text_without_extraction("Vahagn Targeting"),
    description = ccb.content.text_without_extraction("Targets foes in a 120° cone around the original target.  Queues firing."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT" },
    effect_data = "smart_targeted",
    min_damage = 0,
    max_damage = 0,
    min_bash_scaling = 1,
    max_bash_scaling = 4,
    min_aoe = 60,
    max_aoe = 60,
    min_range = 45,
    max_range = 45,
    difficulty = 1,
    sound_description = ccb.content.text("fzzzt"),
    damage_type = "afs_plasma",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_electric_chain",
    name = ccb.content.text_without_extraction("Superconductive Arc"),
    description = ccb.content.text_without_extraction("Your  weapon arcs electricity to a nearby target."),
    effect = "attack",
    shape = "line",
    valid_targets = { "hostile", "ground" },
    flags = { "SOMATIC", "NO_LEGS", "RANDOM_TARGET", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    min_damage = 15,
    max_damage = 15,
    min_range = 15,
    max_range = 15,
    extra_spells = { { spell = "spell_electric_chain_2" } },
    difficulty = 1,
    sound_description = ccb.content.text("a crackle"),
    damage_type = "electric",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_electric_chain_2",
    name = ccb.content.text_without_extraction("Superconductive Arc II"),
    description = ccb.content.text_without_extraction("Your bionic weapon arcs electricity to a nearby target."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "ally", "hostile", "ground" },
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_CRITTER", "NO_EXPLOSION_SFX", "NO_PROJECTILE" },
    min_damage = 10,
    max_damage = 15,
    extra_spells = { { spell = "spell_electric_chain_3" } },
    min_range = 4,
    max_range = 4,
    min_aoe = 2,
    max_aoe = 2,
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 1,
    field_chance = 5,
    damage_type = "electric",
    sound_description = ccb.content.text("a crackle"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_electric_chain_3",
    name = ccb.content.text_without_extraction("Superconductive Arc III"),
    description = ccb.content.text_without_extraction("Your bionic weapon arcs electricity to a nearby target."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "ally", "hostile", "ground" },
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_CRITTER", "NO_EXPLOSION_SFX", "NO_PROJECTILE" },
    min_damage = 10,
    max_damage = 15,
    min_range = 4,
    max_range = 4,
    min_aoe = 2,
    max_aoe = 2,
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 1,
    field_chance = 5,
    damage_type = "electric",
    sound_description = ccb.content.text("a crackle"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bio_blade_electric_arc",
    name = ccb.content.text_without_extraction("Superconductive Arc"),
    description = ccb.content.text_without_extraction("Your bionic weapon arcs electricity to a nearby target."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally", "self" },
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_DAMAGE", "RANDOM_AOE" },
    max_level = 1,
    min_damage = 5,
    max_damage = 15,
    min_range = 1,
    max_range = 1,
    extra_spells = { { spell = "bio_blade_electric_arc_2" } },
    difficulty = 1,
    sound_description = ccb.content.text("a crackle"),
    damage_type = "electric",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bio_blade_electric_arc_2",
    name = ccb.content.text_without_extraction("Superconductive Arc"),
    description = ccb.content.text_without_extraction("Your bionic weapon arcs electricity to a nearby target."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally", "self" },
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_DAMAGE", "RANDOM_AOE" },
    max_level = 1,
    min_damage = 5,
    max_damage = 15,
    min_range = 1,
    max_range = 1,
    difficulty = 1,
    sound_description = ccb.content.text("a crackle"),
    damage_type = "electric",
}

-- NO_I18N
-- Used for heat retention cream not castable
-- NO_I18N
ccb.content.define_spell {
    id = "cream_greater_prot_cold",
    name = ccb.content.text_without_extraction("Heat Retention Cream Xtreme"),
    description = ccb.content.text_without_extraction("You rub the thick cream all over your body in preparation for unbearable cold."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS" },
    effect = "spawn_item",
    effect_data = "cold_res_cream_greater",
    shape = "blast",
    max_level = 0,
    min_damage = 0,
    max_damage = 0,
    damage_increment = 0,
    damage_type = "biological",
    difficulty = 0,
    spell_class = "NONE",
    base_casting_time = 6000,
    base_energy_cost = 2,
    min_duration = 720000,
    max_duration = 720000,
}

-- NO_I18N
-- Used for CBM not castable
-- NO_I18N
ccb.content.define_spell {
    id = "protection_from_cold",
    name = ccb.content.text_without_extraction("Emergency Insulation"),
    description = ccb.content.text_without_extraction("You feel a jolt through your body as energy pulses through the wires in your flesh."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_PROJECTILE" },
    effect = "attack",
    effect_data = "afs_cold_protect",
    shape = "blast",
    max_level = 0,
    spell_class = "NONE",
    base_casting_time = 1,
    min_duration = 1000,
    max_duration = 1000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "cryo_blast",
    name = ccb.content.text_without_extraction("Cryokinetic Blast"),
    description = ccb.content.text_without_extraction("You blast a cone of frigid air toward the target."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "ally", "hostile", "ground" },
    flags = { "SILENT", "VERBAL", "NO_FAIL", "NO_LEGS", "NO_HANDS", "SPLIT_DAMAGE" },
    max_level = 20,
    min_damage = 24,
    max_damage = 68,
    damage_increment = 1.2,
    min_aoe = 30,
    max_aoe = 60,
    aoe_increment = 1.4,
    min_range = 6,
    max_range = 20,
    range_increment = 1.0,
    base_casting_time = 200,
    base_energy_cost = 350,
    energy_source = "MANA",
    difficulty = 4,
    field = "fd_cold_air2",
    min_field_intensity = 0,
    max_field_intensity = 4,
    field_intensity_increment = 0.5,
    damage_type = "cold",
}

ccb.content.define_spell {
    id = "afs_motion_sensor_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("motion sensor spell"),
    description = ccb.content.text_without_extraction("EOCs the victim."),
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "hostile", "ally" },
    min_range = 0,
    min_aoe = 1,
    max_aoe = 1,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_fcbf2b2f725b",
}
