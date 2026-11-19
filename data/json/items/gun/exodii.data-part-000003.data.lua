local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_plasma_fan",
    name = ccb.content.text_without_extraction("Plasma fan"),
    description = ccb.content.text_without_extraction("Your weapon releases a searing fan of plasma."),
    effect = "attack",
    shape = "cone",
    field = "fd_plasma",
    min_field_intensity = 1,
    max_field_intensity = 3,
    valid_targets = { "hostile", "ally", "ground" },
    flags = { "LOUD", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE", "IGNITE_FLAMMABLE", "IGNORE_WALLS", "SPLIT_DAMAGE" },
    min_damage = 20,
    max_damage = 30,
    min_bash_scaling = 6,
    max_bash_scaling = 6,
    min_aoe = 15,
    max_aoe = 15,
    min_range = 10,
    max_range = 10,
    difficulty = 1,
    sound_description = ccb.content.text("fzzzt"),
    damage_type = "heat",
}
