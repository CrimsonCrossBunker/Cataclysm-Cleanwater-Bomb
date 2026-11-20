local ccb = require("ccb")

-- Well that's too edgy now, need to replace it.
ccb.content.define_spell {
    id = "cleansingflame_hermes_heal",
    spell_class = "CLEANSING_FLAME",
    name = ccb.content.text("Hermes Reborn"),
    description = ccb.content.text("In the sea without lees\nStandeth the bird of Hermes\nEating his wings variable\nAnd maketh himself yet full stable"),
    valid_targets = { "self" },
    effect = "attack",
    shape = "blast",
    base_casting_time = 350,
    base_energy_cost = 800,
    magic_type = "magiclysm_restoration_magic",
    difficulty = 10,
    min_damage = { handler = "scaled_cleansingflame_hermes_heal_min_damage", fallback = -8.0 },
    max_damage = { handler = "scaled_cleansingflame_hermes_heal_max_damage", fallback = -15.0 },
    max_level = 35,
    extra_spells = {
        { spell = "cleansingflame_hermes_burn" },
        { spell = "pain_split" },
        { spell = "eoc_restoration_setup", self = true },
    },
    flags = { "RESTORATION_SPELL", "RANDOM_DAMAGE", "SOMATIC", "VERBAL", "CONCENTRATE", "LOUD" },
}
