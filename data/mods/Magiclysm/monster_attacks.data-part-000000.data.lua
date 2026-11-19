local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teravolt_explosion",
    name = ccb.content.text_without_extraction("Teravolt Explosion"),
    description = ccb.content.text_without_extraction("Create a giant explosion with spark field.  You can see it only in debug mode."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "RANDOM_AOE", "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    min_damage = 40,
    max_damage = 80,
    min_aoe = 3,
    max_aoe = 6,
    damage_type = "electric",
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 7,
    field_intensity_variance = 1,
    field_chance = 1,
    sound_description = ccb.content.text("a crackle"),
    message = "",
}
