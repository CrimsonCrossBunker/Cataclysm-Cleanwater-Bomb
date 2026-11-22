local ccb = require("ccb")

ccb.content.define_spell {
    id = "animist_magic_fissile",
    name = ccb.content.text("Magic Fissile"),
    description = ccb.content.text("I cast Magic… Fissile?  At the darkness?"),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "VERBAL", "SOMATIC", "RANDOM_DAMAGE", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
    extra_spells = {
        { spell = "animist_radiation_bolt", self = false },
        { spell = "eoc_evocation_setup", self = true },
    },
    min_damage = { handler = "scaled_animist_magic_fissile_min_damage", fallback = 0.0 },
    max_damage = { handler = "scaled_animist_magic_fissile_max_damage", fallback = 3.0 },
    damage_type = "necrotic",
    min_range = 8,
    range_increment = 0.8,
    max_range = 20,
    base_energy_cost = 50,
    spell_class = "ANIMIST",
    difficulty = 1,
    max_level = 15,
    base_casting_time = 100,
    magic_type = "magiclysm_evocation_magic",
    shape = "blast",
    effect = "attack",
}

ccb.content.define_spell {
    id = "animist_slow_food_rotting_spell",
    components = "spell_components_slow_food_rotting",
    shape = "blast",
    spell_class = "ANIMIST",
    magic_type = "magiclysm_enhancement_magic",
    name = "Abjure Spirits of Rot",
    description = "Placing a warding on food or drink, preventing the spirits of decay from nesting within it.  The mage may affect as much food or drink as they can carry.  The principles by which this spell functions were not discovered until the 20th century, but some animists maintain that radiation is frightening to decay spirits.",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    base_energy_cost = 550,
    difficulty = 5,
    max_level = 15,
    base_casting_time = 90000,
    impact_handler = "w16b_sp_imp_magiclysm_3a6825a92341",
    extra_spells = {
        { spell = "eoc_enhancement_setup", self = true },
    },
}
