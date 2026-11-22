local ccb = require("ccb")

ccb.content.define_spell {
    id = "teleport_phase_real",
    copy_from = "teleport_phase",
    valid_targets = { "ground" },
    magic_type = "mom_psionics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "TARGET_TELEPORT", "IGNORE_WALLS" },
    effect = "short_range_teleport",
    shape = "blast",
    min_range = { handler = "scale_teleport_phase_real_min_range", fallback = 2.0 },
    max_range = 4,
}

ccb.content.define_spell {
    id = "teleport_phase",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    name = "[Ψ]Phase",
    description = "By stepping for a moment into the void between dimensions, you can bypass a wall or walk from the ground to the roof of a house.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    base_energy_cost = 2500,
    final_energy_cost = 1250,
    energy_increment = -65,
    difficulty = 2,
    max_level = { handler = "w16b_sp_stat_mindovermatter_f3b23418fec0", fallback = 0 },
    base_casting_time = 65,
    final_casting_time = 15,
    casting_time_increment = -3,
    impact_handler = "w16b_sp_imp_mindovermatter_0169e4f2dffd",
}
