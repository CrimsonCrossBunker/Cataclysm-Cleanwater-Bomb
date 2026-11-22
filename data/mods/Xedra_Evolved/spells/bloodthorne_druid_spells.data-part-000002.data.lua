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

ccb.content.define_spell {
    id = "bloodthorne_druid_regain_blood_spell",
    skill = "deduction",
    shape = "blast",
    spell_class = "BLOODTHORNE_SORCERY",
    magic_type = "xedra_bloodthorne_sorcery",
    name = "Woodblood Restoration",
    description = "While in a forest or on natural foliage, restore your lost blood or that of an ally.",
    message = "",
    flags = { "VERBAL", "SOMATIC", "NO_LEGS" },
    valid_targets = { "self", "ally" },
    min_range = 1,
    base_energy_cost = { handler = "w16b_sp_stat_xedra_evolved_9b3091019ecc", fallback = 0 },
    base_casting_time = 150,
    caster_when = "w16b_sp_cast_xedra_evolved_6248cea5f2ed",
    impact_handler = "w16b_sp_imp_xedra_evolved_513fbe8b0162",
}

ccb.content.define_spell {
    id = "bloodthorne_druid_stop_bleeding_spell",
    skill = "deduction",
    shape = "blast",
    spell_class = "BLOODTHORNE_SORCERY",
    magic_type = "xedra_bloodthorne_sorcery",
    name = "Thorn-sealed Wounds",
    description = "When bleeding, your heartvines can pull the wound closed and stop it.  This is painful, but will prevent further bleeding.  If there are any vampires or their servants nearby, the heartvines will also lash out at them as they pull the wound closed.",
    message = "",
    flags = { "SILENT", "NO_HANDS" },
    valid_targets = { "self" },
    base_energy_cost = { handler = "w16b_sp_stat_xedra_evolved_9fc2405b7014", fallback = 0 },
    base_casting_time = 75,
    caster_when = "w16b_sp_cast_xedra_evolved_955ba9dd7233",
    impact_handler = "w16b_sp_imp_xedra_evolved_96452ec0f2ba",
    extra_spells = {
        {
            spell = "bloodthorne_druid_stop_bleeding_spell_thornlash",
        },
    },
}

ccb.content.define_spell {
    id = "bloodthorne_druid_prevent_vampirism_spell",
    skill = "deduction",
    shape = "blast",
    effect = "attack",
    effect_data = "effect_bloodthorne_druid_prevent_vampirism",
    spell_class = "BLOODTHORNE_SORCERY",
    magic_type = "xedra_bloodthorne_sorcery",
    name = "Sanguinary Sapshield",
    description = "While in a forest, draw on the power of nature to protect yourself from the vampire's insidious curse.  If infected, the shield will activate, purge the curse, and protect you from further curses for a period afterwards.",
    message = "You draw the vitality of nature into yourself and infuse it into your blood.",
    flags = { "VERBAL", "SOMATIC", "NO_LEGS" },
    valid_targets = { "self" },
    min_duration = { handler = "w16b_sp_stat_xedra_evolved_5117735c547b", fallback = 0 },
    max_duration = { handler = "w16b_sp_stat_xedra_evolved_7ceb733a4a7f", fallback = 0 },
    base_energy_cost = { handler = "w16b_sp_stat_xedra_evolved_3474c281ff1d", fallback = 0 },
    base_casting_time = 150,
    caster_when = "w16b_sp_cast_xedra_evolved_ba4614703a94",
}
