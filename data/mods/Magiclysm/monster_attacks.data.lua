local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electric_turret_line",
    name = ccb.content.text_without_extraction("Lightning Line Attack"),
    description = ccb.content.text_without_extraction("Line heat attack for stormcaller's thunder pillar."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_AOE", "SPLIT_DAMAGE" },
    min_damage = 55,
    max_damage = 105,
    min_range = 5,
    max_range = 12,
    min_aoe = 15,
    max_aoe = 35,
    field = "fd_electricity",
    min_field_intensity = 2,
    max_field_intensity = 5,
    field_chance = 1,
    damage_type = "heat",
    sound_description = ccb.content.text("a crackle"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electric_turret_blast",
    name = ccb.content.text_without_extraction("Lightning Blast Attack"),
    description = ccb.content.text_without_extraction("Blast electric attack for stormcaller's thunder pillar."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_AOE", "SPLIT_DAMAGE" },
    min_damage = 40,
    max_damage = 65,
    min_range = 10,
    max_range = 25,
    min_aoe = 2,
    max_aoe = 6,
    field = "fd_electricity",
    min_field_intensity = 2,
    max_field_intensity = 5,
    field_chance = 2,
    damage_type = "electric",
    sound_description = ccb.content.text("a crackle"),
}
