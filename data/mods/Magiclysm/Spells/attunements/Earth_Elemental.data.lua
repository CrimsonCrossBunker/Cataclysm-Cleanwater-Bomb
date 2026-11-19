local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "rock_blast_push",
    name = ccb.content.text_without_extraction("Rock Blast Push"),
    description = ccb.content.text_without_extraction("The push portion of the rock blast spell."),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "NO_EXPLOSION_SFX" },
    effect = "directed_push",
    shape = "blast",
    max_level = 35,
    min_damage = 1,
    max_damage = 3,
    damage_increment = 0.1,
}
