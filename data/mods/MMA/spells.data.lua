local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "learn_ki_strike",
    name = ccb.content.text_without_extraction("Ki Strike Meditations"),
    description = ccb.content.text_without_extraction("This grants a specific mutation."),
    effect = "mutate",
    shape = "blast",
    effect_data = "KI_STRIKE",
    message = ccb.content.text("You study the meditations until you could do them in your sleep…"),
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}
