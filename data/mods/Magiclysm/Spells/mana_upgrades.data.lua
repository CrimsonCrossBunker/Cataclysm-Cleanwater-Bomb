local ccb = require("ccb")

ccb.content.define_spell {
    id = "mana_upgrade_efficiency_01",
    components = "spell_components_mana_upgrade_efficiency_01",
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    name = "First Circle: Lesser Mana Efficiency",
    description = "Perform a magical ritual to increase the efficiency by which your body processes mana, granting you the Lesser Mana Efficiency trait.  The ritual must end when the sun is in the sky and you are at least one story above the ground.\n\nThe chance of the ritual's success depends in your spell level and Spellcraft skill.",
    flags = { "CHANNELING_SPELL", "VERBAL", "SOMATIC", "CONCENTRATE" },
    valid_targets = { "self" },
    base_energy_cost = 800,
    difficulty = 6,
    max_level = 15,
    base_casting_time = 2520000,
    impact_handler = "w16b_sp_imp_magiclysm_115163fc645e",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "mana_upgrade_efficiency_02",
    components = "spell_components_mana_upgrade_efficiency_02",
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    name = "Second Circle: Mana Efficiency",
    description = "Perform a magical ritual to increase the efficiency by which your body processes mana, granting you the Mana Efficiency trait.  You must already have the Lesser Mana Efficiency trait for the spell to take full effect.  The ritual must end within one hour of noon and you are at least four stories above the ground.\n\nThe chance of the ritual's success depends in your spell level and Spellcraft skill.",
    flags = { "CHANNELING_SPELL", "VERBAL", "SOMATIC", "CONCENTRATE" },
    valid_targets = { "self" },
    base_energy_cost = 1400,
    difficulty = 9,
    max_level = 15,
    base_casting_time = 3960000,
    impact_handler = "w16b_sp_imp_magiclysm_f47539edc48c",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "mana_upgrade_regeneration_01",
    components = "spell_components_mana_upgrade_regeneration_01",
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    name = "First Circle: Lesser Mana Regeneration",
    description = "Perform a magical ritual to increase the speed by which your body restores its mana, granting you the Lesser Mana Regeneration trait.  The ritual must be performed while standing in a river or a stream.\n\nThe chance of the ritual's success depends in your spell level and Spellcraft skill.",
    flags = { "CHANNELING_SPELL", "VERBAL", "SOMATIC", "CONCENTRATE" },
    valid_targets = { "self" },
    base_energy_cost = 800,
    difficulty = 6,
    max_level = 15,
    base_casting_time = 2520000,
    impact_handler = "w16b_sp_imp_magiclysm_b8c0c041d5a9",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "mana_upgrade_regeneration_02",
    components = "spell_components_mana_upgrade_regeneration_02",
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    name = "Second Circle: Mana Regeneration",
    description = "Perform a magical ritual to increase the speed by which your body restores its mana, granting you the Mana Regeneration trait.  You must already have the Lesser Mana Regeneration trait for the spell to take full effect.  The ritual must be performed while standing in a river.\n\nThe chance of the ritual's success depends in your spell level and Spellcraft skill.",
    flags = { "CHANNELING_SPELL", "VERBAL", "SOMATIC", "CONCENTRATE" },
    valid_targets = { "self" },
    base_energy_cost = 1400,
    difficulty = 9,
    max_level = 15,
    base_casting_time = 3960000,
    impact_handler = "w16b_sp_imp_magiclysm_ca9c8980eba4",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "mana_upgrade_sensitivity_01",
    components = "spell_components_mana_upgrade_sensitivity_01",
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    name = "First Circle: Lesser Mana Sensitivity",
    description = "Perform a magical ritual to increase the sensitivity that your body has to mana, granting you the Lesser Mana Sensitivity trait.  The ritual must take place in a natural location away (at least 4 OM tiles) from buildings, roads, or other evidence of civilization.\n\nThe chance of the ritual's success depends in your spell level and Spellcraft skill.",
    flags = { "CHANNELING_SPELL", "VERBAL", "SOMATIC", "CONCENTRATE" },
    valid_targets = { "self" },
    base_energy_cost = 800,
    difficulty = 6,
    max_level = 15,
    base_casting_time = 2520000,
    impact_handler = "w16b_sp_imp_magiclysm_4b7875944bd3",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "mana_upgrade_sensitivity_02",
    components = "spell_components_mana_upgrade_sensitivity_02",
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    name = "Second Circle: Mana Sensitivity",
    description = "Perform a magical ritual to increase the sensitivity that your body has to mana, granting you the Mana Sensitivity trait.  You must already have the Lesser Mana Sensitivity trait for the spell to take full effect.  The ritual must take place in a natural location far away (at least 15 OM tiles) from buildings, roads, or other evidence of civilization.\n\nThe chance of the ritual's success depends in your spell level and Spellcraft skill.",
    flags = { "CHANNELING_SPELL", "VERBAL", "SOMATIC", "CONCENTRATE" },
    valid_targets = { "self" },
    base_energy_cost = 1400,
    difficulty = 9,
    max_level = 15,
    base_casting_time = 3960000,
    impact_handler = "w16b_sp_imp_magiclysm_7d4446fcdea5",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}
