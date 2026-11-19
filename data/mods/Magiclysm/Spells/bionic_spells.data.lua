local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bio_ley_energy_blaster_spell",
    name = ccb.content.text_without_extraction("Levinbolt Projector Targeting"),
    description = ccb.content.text_without_extraction("Blast someone with magical energy just like in anime."),
    message = ccb.content.text("You unleash a levinbolt."),
    valid_targets = { "ally", "hostile", "ground" },
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_FAIL" },
    spell_class = "NONE",
    effect = "attack",
    shape = "line",
    damage_type = "nether",
    min_damage = 25,
    max_damage = 60,
    min_range = 8,
    max_range = 8,
    field = "fd_laser",
    magic_type = "magiclysm_generic_magic",
    base_casting_time = 25,
    base_energy_cost = 75,
    min_field_intensity = 2,
    max_field_intensity = 2,
    field_chance = 1,
}
