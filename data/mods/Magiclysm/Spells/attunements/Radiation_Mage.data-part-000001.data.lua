local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shortwave_2",
    name = ccb.content.text_without_extraction("Shortwave 2"),
    description = ccb.content.text_without_extraction("Cook nearby monsters (and yourself to an extent)."),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "SOMATIC", "MUST_HAVE_CLASS_TO_LEARN", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    damage_type = "heat",
    min_damage = { handler = "scaled_shortwave_2_min_damage", fallback = 26.0 },
    max_damage = { handler = "scaled_shortwave_2_max_damage", fallback = 51.0 },
    min_range = 3,
    max_range = 3,
    min_aoe = 3,
    max_aoe = 3,
    max_level = 35,
}
