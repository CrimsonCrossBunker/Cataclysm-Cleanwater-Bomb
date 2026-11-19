local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pfruit_aura_thorns",
    name = ccb.content.text_without_extraction("Blackberry fruit aura thorns"),
    description = ccb.content.text_without_extraction("Stab a monster that attacked you."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE" },
    shape = "blast",
    effect = "attack",
    damage_type = "stab",
    min_damage = 1,
    max_damage = 4,
    min_range = 1,
    max_range = 1,
}
