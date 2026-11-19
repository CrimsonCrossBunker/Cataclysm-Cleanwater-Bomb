local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "life_drain_stamina",
    name = ccb.content.text_without_extraction("Life Drain Stamina"),
    description = ccb.content.text_without_extraction("Gives you a bit of stamina.  Subspell; you aren't allowed to see it except in debug mode."),
    effect = "recover_energy",
    effect_data = "STAMINA",
    flags = { "RESTORATION_SPELL" },
    valid_targets = { "self" },
    shape = "blast",
    min_damage = 500,
    max_damage = 2500,
    damage_increment = 60,
    max_level = 35,
    energy_source = "NONE",
}
