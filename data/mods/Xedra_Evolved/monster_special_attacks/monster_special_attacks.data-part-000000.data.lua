local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xe_light_healing",
    name = ccb.content.text_without_extraction("Cure Light Wounds"),
    description = ccb.content.text_without_extraction("Heals a little bit of damage on the target."),
    valid_targets = { "self" },
    min_damage = -5,
    max_damage = -20,
    damage_increment = -1.0,
    max_level = 15,
    min_range = 0,
    max_range = 4,
    range_increment = 0.75,
    effect = "attack",
    shape = "blast",
    base_casting_time = 300,
    base_energy_cost = 800,
    flags = { "SOMATIC", "VERBAL", "NO_PROJECTILE" },
    spell_class = "NONE",
    difficulty = 2,
    energy_source = "NONE",
}
