local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shapeshifter_remove_pain_spell",
    name = ccb.content.text_without_extraction("Shapeshifter reduce pain spell"),
    description = ccb.content.text_without_extraction("This reduces pain for shapeshifters as their wounds regenerate.  You should never see it."),
    valid_targets = { "self" },
    min_damage = 1,
    max_damage = 1,
    effect = "recover_energy",
    effect_data = "PAIN",
    shape = "blast",
    energy_source = "STAMINA",
    flags = { "SILENT", "PAIN_NORESIST" },
}
