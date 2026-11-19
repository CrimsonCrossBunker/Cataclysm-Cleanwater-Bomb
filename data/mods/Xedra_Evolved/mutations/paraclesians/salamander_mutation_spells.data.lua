local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_explosion_and_heal_spell_self_heal",
    name = ccb.content.text_without_extraction("The Phoenix's Last Cry Healing Effect"),
    description = ccb.content.text_without_extraction("The healing effect of The Phoenix's Last Cry.  It's a bug if you have it directly."),
    valid_targets = { "self" },
    teachable = false,
    spell_class = "SALAMANDER",
    flags = { "SILENT", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "effect_salamander_phoenix_healing",
    shape = "blast",
    min_duration = 1440000,
    max_duration = 2880000,
}
