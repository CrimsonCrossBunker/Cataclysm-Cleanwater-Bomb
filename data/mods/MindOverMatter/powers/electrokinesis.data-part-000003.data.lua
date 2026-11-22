local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electro_spawn_robot_interface",
    name = ccb.content.text_without_extraction("[Ψ]Create Robotic Interface"),
    description = ccb.content.text_without_extraction("Creates a tool used to hack robots.  It's a bug if you have it."),
    valid_targets = { "self" },
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX", "PERMANENT" },
    effect = "spawn_item",
    effect_data = "electro_robot_interface",
    shape = "blast",
    min_duration = 0,
    max_duration = 0,
}

ccb.content.define_spell {
    id = "electrokinetic_robot_interface",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "ELECTROKINETIC",
    magic_type = "mom_psionics",
    name = "[Ψ]Robotic Interface",
    description = "Use your powers to remotely interface with a robot's internal circuitry, allowing you to hack it if you have the skill.",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    base_energy_cost = 8000,
    final_energy_cost = 5000,
    energy_increment = -125,
    difficulty = 8,
    max_level = { handler = "w16b_sp_stat_mindovermatter_b0d940c3d35d", fallback = 0 },
    base_casting_time = 75,
    final_casting_time = 30,
    casting_time_increment = -2.5,
    impact_handler = "w16b_sp_imp_mindovermatter_754748e8f927",
}
