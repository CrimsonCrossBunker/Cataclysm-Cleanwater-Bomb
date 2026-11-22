local ccb = require("ccb")

ccb.content.define_spell {
    id = "magus_stop_attack_shield",
    name = ccb.content.text("Mageshield"),
    description = ccb.content.text("A simple but powerful spell, Mageshield will render the caster immune to any single attack.  It is indiscriminate: whether hit by an anti-tank missile or the caster stubbing their toe, it will absorb all energy of the attack and then fade."),
    valid_targets = { "self" },
    spell_class = "MAGUS",
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    effect = "attack",
    effect_data = "effect_magus_mageshield",
    shape = "blast",
    difficulty = 2,
    max_level = 20,
    min_duration = 180000,
    max_duration = 1380000,
    duration_increment = 60000,
    magic_type = "magiclysm_conjuration_magic",
    base_energy_cost = 200,
    base_casting_time = 1500,
}

ccb.content.define_spell {
    id = "magus_teleport_mark",
    components = "spell_components_magus_mark",
    shape = "blast",
    spell_class = "MAGUS",
    magic_type = "magiclysm_conveyance_magic",
    name = "Magus's Mark",
    description = "Mark a particular patch of ground to allow you to return to it later.",
    flags = { "CONVEYANCE_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    base_energy_cost = 2000,
    difficulty = 5,
    max_level = 10,
    base_casting_time = 90000,
    impact_handler = "w16b_sp_imp_magiclysm_3a359415f5f5",
    extra_spells = {
        { spell = "eoc_conveyance_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "magus_word_of_recall",
    components = "spell_components_word_of_recall",
    shape = "blast",
    spell_class = "MAGUS",
    magic_type = "magiclysm_conveyance_magic",
    name = "Word of Recall",
    description = "Immediately return to the place you marked with Magus's Mark, no matter how far away it is.",
    flags = { "CONVEYANCE_SPELL", "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    base_energy_cost = 400,
    difficulty = 8,
    max_level = 15,
    base_casting_time = 100,
    impact_handler = "w16b_sp_imp_magiclysm_fb8e81f41fe7",
    extra_spells = {
        { spell = "eoc_conveyance_setup", self = true },
    },
}
