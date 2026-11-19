local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bloodthorne_druid_stop_bleeding_spell_thornlash",
    name = ccb.content.text_without_extraction("Thorn-sealed Wound Vampire Lash"),
    description = ccb.content.text_without_extraction("Hits nearby vampires and their servants when you close your wounds.  You shouldn't see this."),
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
    min_duration = 6000,
    max_duration = 36000,
    min_aoe = 1,
    targeted_species = { "VAMPIRE", "RENFIELD" },
}
