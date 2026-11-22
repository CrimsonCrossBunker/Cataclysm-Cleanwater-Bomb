local ccb = require("ccb")

ccb.content.define_spell {
    id = "earthshaper_sleep_in_earth",
    shape = "blast",
    spell_class = "EARTHSHAPER",
    magic_type = "magiclysm_enhancement_magic",
    name = "Stone Slumber",
    description = "When standing on earth or stone, sink into the ground.  While submerged, you will heal faster, sleep will be more restorative, and you will not need to eat or drink.  Cast this spell again to return to the surface.",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "SOMATIC", "VERBAL" },
    valid_targets = { "self" },
    base_energy_cost = { handler = "w16b_sp_stat_magiclysm_d681c41866f4", fallback = 0 },
    difficulty = 8,
    max_level = 20,
    base_casting_time = { handler = "w16b_sp_stat_magiclysm_a7a2677dd087", fallback = 0 },
    impact_handler = "w16b_sp_imp_magiclysm_c016ea9ae3ac",
    extra_spells = {
        { spell = "eoc_enhancement_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "earthshaper_repair_metal_stone",
    components = "spell_components_repair_metal_stone",
    shape = "blast",
    spell_class = "EARTHSHAPER",
    magic_type = "magiclysm_channeling_magic",
    name = "Fault-Mending Chant",
    description = "While holding an item made of natural metal or stone, mold it with your hands, work to repairing any flaws and restoring its condition.  Note that some items may still not be repaired.",
    flags = { "CHANNELING_SPELL", "CONCENTRATE", "VERBAL", "NO_HANDS" },
    valid_targets = { "self" },
    base_energy_cost = 600,
    difficulty = 4,
    max_level = 20,
    base_casting_time = 360000,
    final_casting_time = 90000,
    casting_time_increment = -13500,
    impact_handler = "w16b_sp_imp_magiclysm_5329e1c89f2f",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "earthshaper_diggable_teleport",
    shape = "blast",
    spell_class = "EARTHSHAPER",
    magic_type = "magiclysm_conveyance_magic",
    name = "Earth Gate",
    description = "While standing on natural earth, sink into it and emerge from any other patch of natural earth within the spell's range.",
    message = "",
    teachable = false,
    flags = { "CONVEYANCE_SPELL", "VERBAL", "SOMATIC", "SILENT" },
    valid_targets = { "self" },
    base_energy_cost = 650,
    difficulty = 8,
    max_level = 20,
    base_casting_time = 250,
    impact_handler = "w16b_sp_imp_magiclysm_d9a8eaa65ddb",
    extra_spells = {
        { spell = "eoc_conveyance_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "earthshaper_remove_corpses",
    shape = "blast",
    spell_class = "EARTHSHAPER",
    magic_type = "magiclysm_channeling_magic",
    name = "The Last Embrace",
    description = "A truly ancient spell, its use attested in funeral rites from prehistoric times, The Last Embrace causes all bodies within its area of effect to sink within the living earth, coming to rest in a natural tomb.  It only works on earth or stone.",
    teachable = false,
    flags = { "CHANNELING_SPELL", "SOMATIC", "LOUD", "NO_PROJECTILE" },
    valid_targets = { "self" },
    base_energy_cost = 150,
    final_energy_cost = 50,
    energy_increment = -7,
    difficulty = 4,
    max_level = 15,
    base_casting_time = 1200,
    impact_handler = "w16b_sp_imp_magiclysm_cddc5164f6d7",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}
