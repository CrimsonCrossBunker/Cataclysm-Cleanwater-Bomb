local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biomantic_pain_caused_light",
    name = ccb.content.text_without_extraction("Cause minor pain"),
    description = ccb.content.text_without_extraction("Causes a small amount of pain when certain spells are used."),
    valid_targets = { "self" },
    effect = "recover_energy",
    effect_data = "PAIN",
    shape = "blast",
    flags = { "SILENT", "RANDOM_DAMAGE" },
    spell_class = "BIOMANCER",
    min_damage = -1,
    max_damage = -4,
}
