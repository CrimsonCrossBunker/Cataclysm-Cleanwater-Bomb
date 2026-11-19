local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sp_mana_siphon",
    name = ccb.content.text_without_extraction("Mana Siphon"),
    description = ccb.content.text_without_extraction("This is the spell portion of the mana siphon series of mutations.  If you have this spell you probably debugged it in."),
    valid_targets = { "self" },
    min_damage = 5,
    damage_increment = 5.0,
    max_damage = 180,
    max_level = 35,
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    flags = { "SILENT", "NO_LEGS", "NO_HANDS" },
}
