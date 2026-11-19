local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "monster_heal_spell",
    name = ccb.content.text_without_extraction("Heal Self Monster "),
    description = ccb.content.text_without_extraction("A spell for a monster to heal themselves.  How DARE they!"),
    valid_targets = { "self" },
    flags = { "SILENT", "RANDOM_DAMAGE" },
    effect = "attack",
    shape = "blast",
    max_level = 50,
    min_damage = -1,
    max_damage = -50,
    damage_increment = -1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "migo_fleshwarper_blood_poison_spell",
    name = ccb.content.text_without_extraction("Blood Poison Monster"),
    description = ccb.content.text_without_extraction("Projects a spray of acrid blood and gore all around the monster while also doing damage."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "RANDOM_DAMAGE", "RANDOM_DURATION", "RANDOM_AOE", "SPLIT_DAMAGE" },
    effect = "attack",
    effect_data = "badpoison",
    shape = "blast",
    max_level = 20,
    min_damage = 1,
    max_damage = 10,
    damage_type = "poison",
    min_aoe = 2,
    max_aoe = 6,
    min_range = 1,
    max_range = 1,
    min_duration = 200,
    max_duration = 3000,
    field = "fd_blood",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 3,
    field_intensity_increment = 0.1,
}
