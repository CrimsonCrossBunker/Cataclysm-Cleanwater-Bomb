local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "cleansingflame_hermes_burn",
    name = ccb.content.text_without_extraction("Hermes Reborn Fire"),
    description = ccb.content.text_without_extraction("Give some frost damage for Hermes Reborn spell.  Subspell; you aren't allowed to see it except in debug mode."),
    valid_targets = { "self" },
    max_level = 35,
    flags = { "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    min_damage = 8,
    max_damage = 20,
    min_range = 1,
    max_range = 1,
    damage_type = "cold",
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.06,
    spell_class = "CLEANSING_FLAME",
}
