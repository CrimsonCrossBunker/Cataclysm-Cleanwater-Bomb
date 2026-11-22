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

ccb.content.define_spell {
    id = "earthshaper_granite_aegis",
    shape = "blast",
    spell_class = "EARTHSHAPER",
    magic_type = "magiclysm_conjuration_magic",
    name = "Granite Aegis",
    description = "In an extremity of danger, summon a hollow shell of rock around yourself.  It lasts only a few moments, but sometimes that's all you need.  You must be standing on the living earth to invoke it.",
    flags = { "CONJURATION_SPELL", "SOMATIC", "VERBAL" },
    valid_targets = { "self" },
    base_energy_cost = 750,
    difficulty = 9,
    max_level = 10,
    base_casting_time = 150,
    final_casting_time = 100,
    casting_time_increment = -5,
    impact_handler = "w16b_sp_imp_magiclysm_5e3c72c0037e",
    extra_spells = {
        { spell = "eoc_summon_setup", self = true },
    },
}
