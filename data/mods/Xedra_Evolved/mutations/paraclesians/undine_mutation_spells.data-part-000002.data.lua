local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "undine_acid_resist_ally_thorns",
    name = ccb.content.text_without_extraction("Caustic Cloak Thorns Spell"),
    description = ccb.content.text_without_extraction("The thorns effect from Caustic Cloak.  It's a bug if you have it directly."),
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "RANDOM_DAMAGE" },
    min_damage = 2,
    max_damage = 10,
    valid_targets = { "hostile" },
    damage_type = "acid",
    min_range = 1,
    max_range = 1,
}
