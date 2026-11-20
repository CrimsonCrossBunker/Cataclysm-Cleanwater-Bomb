local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "magiclysm_generic_magic",
    energy_source = "MANA",
    cannot_cast_flags = "NO_SPELLCASTING",
    cannot_cast_message = ccb.content.text("You can't cast any of the spells you know!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_evocation_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_EVOCATION_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_evocation_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_channeling_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_CHANNELING_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_channeling_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_conjuration_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_SUMMONING_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_summoning_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_enhancement_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_ENHANCEMENT_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_enhancement_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_enervation_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_ENERVATION_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_enervation_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_conveyance_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_CONVEYANCE_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_conveyance_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_restoration_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_RESTORATION_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_restoration_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}

ccb.content.define_magic_type {
    id = "magiclysm_transformation_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING", "NO_CASTING_TRANSFORMATION_SPELLS" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "magiclysm_spell_failure_transformation_formula",
    cannot_cast_message = ccb.content.text("You can't cast that spell right now!"),
}
