local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eat_dreamdross_ingot_mana",
    name = ccb.content.text_without_extraction("Eat dreamdross ingots mana"),
    description = ccb.content.text_without_extraction("Restore some mana when you consume a whole dreamdross ingot."),
    teachable = false,
    valid_targets = { "self" },
    min_damage = 5000,
    max_damage = 5000,
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
}
