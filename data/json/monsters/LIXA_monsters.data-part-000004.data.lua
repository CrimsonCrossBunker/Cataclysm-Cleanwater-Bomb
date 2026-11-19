local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "LIXA_reshuffle_cone",
    name = ccb.content.text_without_extraction("an arc of coordinate reassignment"),
    description = ccb.content.text_without_extraction("Spawns LIXA reshuffle."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    max_level = 5,
    min_damage = 0,
    max_damage = 0,
    min_aoe = 10,
    max_aoe = 15,
    aoe_increment = 1,
    min_range = 8,
    max_range = 16,
    range_increment = 2,
    base_casting_time = 50,
    field = "fd_LIXA_decompression",
    min_field_intensity = 1,
    max_field_intensity = 3,
    field_intensity_increment = 1,
    field_intensity_variance = 1,
    field_chance = 4,
    sound_type = "combat",
    sound_id = "fire_gun",
    sound_variant = "bio_lightning",
    sound_description = ccb.content.text("snapping geometry"),
}
