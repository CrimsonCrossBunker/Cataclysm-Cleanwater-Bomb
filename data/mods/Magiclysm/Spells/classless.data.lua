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
