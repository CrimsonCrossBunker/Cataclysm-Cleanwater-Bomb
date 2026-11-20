local ccb = require("ccb")

ccb.content.define_spell {
    id = "light_healing",
    name = ccb.content.text("Knit the Rent Flesh"),
    description = ccb.content.text("Cause the target's wounds to writhe, the flesh to crawl back together, and their injuries to heal.  Disturbing, and painful, but effective."),
    valid_targets = { "self", "ally" },
    min_damage = { handler = "scaled_light_healing_min_damage", fallback = -1.0 },
    max_damage = { handler = "scaled_light_healing_max_damage", fallback = -4.0 },
    max_level = 15,
    min_range = 0,
    max_range = 4,
    range_increment = 0.75,
    effect = "attack",
    shape = "blast",
    base_casting_time = 300,
    base_energy_cost = 800,
    extra_spells = {
        { spell = "eoc_restoration_setup", self = true },
        { spell = "biomantic_pain_caused_light", self = true },
    },
    flags = { "RESTORATION_SPELL", "RANDOM_DAMAGE", "SOMATIC", "VERBAL", "NO_PROJECTILE" },
    spell_class = "BIOMANCER",
    difficulty = 2,
    magic_type = "magiclysm_restoration_magic",
}
