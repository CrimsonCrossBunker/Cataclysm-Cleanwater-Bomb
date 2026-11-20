local ccb = require("ccb")

ccb.content.define_spell {
    id = "gaiaschosen_samsara",
    spell_class = "GAIAS_CHOSEN",
    name = ccb.content.text("Samsara"),
    description = ccb.content.text("You tie your ley lines to the world's, renewing your flesh as if reborn."),
    valid_targets = { "self" },
    extra_spells = { { spell = "eoc_restoration_setup", self = true } },
    effect = "attack",
    effect_data = "cureall",
    shape = "blast",
    base_casting_time = 60000,
    base_energy_cost = 800,
    magic_type = "magiclysm_restoration_magic",
    difficulty = 8,
    min_damage = { handler = "scaled_gaiaschosen_samsara_min_damage", fallback = -5.0 },
    max_damage = { handler = "scaled_gaiaschosen_samsara_max_damage", fallback = -12.0 },
    max_level = 40,
    flags = { "RESTORATION_SPELL", "RANDOM_DAMAGE", "SOMATIC", "VERBAL", "CONCENTRATE", "LOUD" },
}
