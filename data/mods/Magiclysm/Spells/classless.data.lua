local ccb = require("ccb")

-- This spell does not have a corresponding Dabbler hobby because it's literally useless on its own.
ccb.content.define_spell {
    id = "classless_restore_crystal_mana",
    name = ccb.content.text("Mana Extraction"),
    description = ccb.content.text("Return crystallized mana into raw mana and absorb it, restoring some of your mana.  The process is slow and not very efficient, but it's easier to transport than mana potions."),
    message = ccb.content.text("You slowly crush the crystallized mana and as it flares into a burst of light, absorb the now-free mana."),
    valid_targets = { "self" },
    flags = { "RESTORATION_SPELL", "CONCENTRATE", "SOMATIC", "NO_LEGS", "RANDOM_DAMAGE" },
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    components = "spell_components_restore_crystal_mana",
    difficulty = 3,
    max_level = 10,
    min_damage = { handler = "scaled_classless_restore_crystal_mana_min_damage", fallback = 50.0 },
    max_damage = { handler = "scaled_classless_restore_crystal_mana_max_damage", fallback = 150.0 },
    magic_type = "magiclysm_restoration_magic",
    extra_spells = { { spell = "eoc_restoration_setup", self = true } },
    base_energy_cost = 0,
    base_casting_time = 12000,
}

ccb.content.define_spell {
    id = "crystallize_mana",
    shape = "blast",
    spell_class = "NONE",
    magic_type = "magiclysm_channeling_magic",
    name = "Crystallize Mana",
    description = "Crystallizes mana into solid form.",
    flags = { "CHANNELING_SPELL", "NO_LEGS", "CONCENTRATE" },
    valid_targets = { "self" },
    min_damage = 1,
    max_damage = 1,
    duration_increment = 1,
    base_energy_cost = 1000,
    final_energy_cost = 1000,
    difficulty = 3,
    base_casting_time = 600000,
    final_casting_time = 600000,
    impact_handler = "w16b_sp_imp_magiclysm_a248dc9ec300",
    extra_spells = {
        { spell = "mana_fatigue" },
        { spell = "eoc_channeling_setup", self = true },
    },
}
