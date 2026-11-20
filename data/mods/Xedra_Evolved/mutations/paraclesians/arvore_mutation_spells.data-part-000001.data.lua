local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_arvore_thorns_mut_counter",
    name = ccb.content.text_without_extraction("Arvore Thorns Damage"),
    description = ccb.content.text_without_extraction("Sometimes, when an enemy punches your thorns, they hurt themselves."),
    valid_targets = { "ally", "hostile" },
    skill = "gramarye",
    effect = "attack",
    shape = "blast",
    min_damage = 1,
    max_damage = 8,
    min_range = 1,
    damage_type = "stab",
    flags = { "RANDOM_DAMAGE" },
}
