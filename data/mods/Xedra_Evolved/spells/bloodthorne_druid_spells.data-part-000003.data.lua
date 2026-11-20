local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bloodthorne_druid_aura_of_vines_retaliate",
    name = ccb.content.text_without_extraction("Entanglement of Vines Retaliation"),
    description = ccb.content.text_without_extraction("Hits targets when you have Entanglement of Vines active.  You shouldn't see this."),
    message = "",
    valid_targets = { "hostile" },
    flags = { "SILENT", "RANDOM_DAMAGE" },
    magic_type = "xedra_bloodthorne_sorcery",
    skill = "deduction",
    spell_class = "BLOODTHORNE_SORCERY",
    effect = "attack",
    effect_data = "bleed",
    shape = "blast",
    damage_type = "cut",
    min_damage = 5,
    max_damage = 25,
    min_range = 2,
    max_range = 2,
}
