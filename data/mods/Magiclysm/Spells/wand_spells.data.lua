local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "magic_missile_wand",
    name = ccb.content.text_without_extraction("Magic Missile for wands"),
    description = ccb.content.text_without_extraction("The wand casts Magic Missile.  It's a bug if you have this."),
    valid_targets = { "hostile" },
    flags = { "VERBAL", "SOMATIC", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
    base_casting_time = 100,
    min_damage = 1,
    damage_increment = 1.5,
    damage_type = "nether",
    max_damage = 20,
    min_range = 8,
    range_increment = 0.8,
    max_range = 20,
    max_level = 15,
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fireball_wand",
    name = ccb.content.text_without_extraction("Fireball for wands"),
    description = ccb.content.text_without_extraction("The wand casts fireball.  It's a bug if you have this."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "self", "ally", "hostile", "ground" },
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "IGNITE_FLAMMABLE", "SPLIT_DAMAGE" },
    base_casting_time = 100,
    max_level = 20,
    min_damage = 24,
    max_damage = 68,
    damage_increment = 2.2,
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.1,
    min_range = 6,
    max_range = 20,
    range_increment = 1.0,
    damage_type = "heat",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "magus_mana_beam_wand",
    name = ccb.content.text_without_extraction("Mana Beam for wands"),
    description = ccb.content.text_without_extraction("The wand casts Mana Beam.  It's a bug if you have this."),
    valid_targets = { "hostile", "ground" },
    flags = { "VERBAL", "SOMATIC", "NO_LEGS", "LOUD", "SPLIT_DAMAGE" },
    base_casting_time = 100,
    effect = "attack",
    shape = "line",
    max_level = 20,
    min_damage = 15,
    max_damage = 60,
    damage_increment = 3,
    damage_type = "nether",
    min_aoe = 1,
    max_aoe = 1,
    min_range = 5,
    max_range = 20,
    range_increment = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "point_flare_wand",
    name = ccb.content.text_without_extraction("Point Flare for wands"),
    description = ccb.content.text_without_extraction("The wand casts Point Flare.  It's a bug if you have this."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "SOMATIC", "LOUD", "NO_PROJECTILE" },
    base_casting_time = 100,
    effect = "attack",
    shape = "blast",
    damage_type = "heat",
    min_damage = 16,
    damage_increment = 4.0,
    max_damage = 80,
    min_range = 3,
    range_increment = 0.5,
    max_range = 11,
    base_energy_cost = 75,
    max_level = 16,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hoary_blast_wand",
    name = ccb.content.text_without_extraction("Hoary Blast for wands"),
    description = ccb.content.text_without_extraction("The wand casts Hoary Blast.  It's a bug if you have this."),
    effect = "attack",
    effect_data = "cold",
    shape = "blast",
    valid_targets = { "self", "ally", "hostile", "ground" },
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "SPLIT_DAMAGE" },
    base_casting_time = 100,
    max_level = 20,
    min_damage = 24,
    max_damage = 68,
    damage_increment = 2.2,
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.1,
    min_range = 6,
    max_range = 20,
    range_increment = 1.0,
    damage_type = "cold",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "cone_cold_wand",
    name = ccb.content.text_without_extraction("Cone of Cold for wands"),
    description = ccb.content.text_without_extraction("The wand casts Cone of Cold.  It's a bug if you have this."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "ally", "hostile", "ground" },
    flags = { "SOMATIC", "VERBAL", "SPLIT_DAMAGE" },
    base_casting_time = 100,
    max_level = 20,
    min_damage = 24,
    max_damage = 68,
    damage_increment = 2.2,
    min_aoe = 30,
    max_aoe = 60,
    aoe_increment = 1.4,
    min_range = 6,
    max_range = 20,
    range_increment = 1.0,
    field = "fd_cold_air2",
    min_field_intensity = 0,
    max_field_intensity = 4,
    field_intensity_increment = 0.5,
    damage_type = "cold",
}
