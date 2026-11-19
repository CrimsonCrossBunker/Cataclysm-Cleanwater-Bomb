local ccb = require("ccb")

ccb.content.define_spell {
    id = "earthshaper_harden_earth",
    name = ccb.content.text("Harden Earth"),
    description = ccb.content.text("Compress dirt together so it becomes as hard as rock.  A great way to turn makeshift barricades into a fortress."),
    valid_targets = { "hostile", "ally", "ground", "self" },
    flags = { "TRANSFORMATION_SPELL", "SOMATIC", "VERBAL" },
    spell_class = "EARTHSHAPER",
    difficulty = 4,
    max_level = 20,
    effect = "ter_transform",
    effect_data = "ter_earthshaper_harden_earth",
    extra_spells = { { spell = "eoc_transformation_setup", self = true } },
    shape = "line",
    min_range = 2,
    max_range = 20,
    range_increment = 1,
    magic_type = "magiclysm_transformation_magic",
    base_energy_cost = 200,
    base_casting_time = 1500,
}
