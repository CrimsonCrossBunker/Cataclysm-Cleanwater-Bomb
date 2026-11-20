local ccb = require("ccb")

ccb.content.define_spell {
    id = "recover_bionic_power",
    name = ccb.content.text("Manatricity"),
    description = ccb.content.text("You have found a way to convert your mana into power you can use for your bionics."),
    valid_targets = { "self" },
    flags = { "RESTORATION_SPELL", "RANDOM_DAMAGE", "NO_LEGS", "NO_HANDS", "SOMATIC", "VERBAL", "SILENT" },
    extra_spells = { { spell = "eoc_restoration_setup", self = true } },
    min_damage = { handler = "scaled_recover_bionic_power_min_damage", fallback = 125.0 },
    max_damage = { handler = "scaled_recover_bionic_power_max_damage", fallback = 300.0 },
    base_energy_cost = 550,
    max_level = 25,
    spell_class = "TECHNOMANCER",
    effect = "recover_energy",
    effect_data = "BIONIC",
    shape = "blast",
    magic_type = "magiclysm_restoration_magic",
    difficulty = 6,
    base_casting_time = 1000,
}
