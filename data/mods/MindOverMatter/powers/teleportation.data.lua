local ccb = require("ccb")

ccb.content.define_spell {
    id = "teleport_reality_tear_temporary",
    copy_from = "teleport_reality_tear",
    magic_type = "mom_psionics",
    valid_targets = { "ground" },
    effect = "attack",
    shape = "blast",
    min_range = { handler = "scale_teleport_reality_tear_temporary_min_range", fallback = 0.0 },
    max_range = 80,
    field = "fd_tear_in_reality_temporary",
    field_chance = 1,
    min_field_intensity = 2,
    max_field_intensity = 2,
}

ccb.content.define_spell {
    id = "teleport_reality_tear_permanent",
    copy_from = "teleport_reality_tear",
    magic_type = "mom_psionics",
    valid_targets = { "ground" },
    effect = "attack",
    shape = "blast",
    min_range = { handler = "scale_teleport_reality_tear_temporary_min_range", fallback = 0.0 },
    max_range = 80,
    field = "fd_fatigue",
    field_chance = 1,
    min_field_intensity = 3,
    max_field_intensity = 3,
}

ccb.content.define_spell {
    id = "teleport_blink",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    name = "[Ψ]Blink",
    description = "Step briefly into the void between dimensions and emerge at a random nearby location.\n\nThe power <color_red>will fail</color> if the volume of your carried gear is too great.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    base_energy_cost = 900,
    final_energy_cost = 350,
    energy_increment = -55,
    difficulty = 1,
    max_level = { handler = "w16b_sp_stat_mindovermatter_f3b23418fec0", fallback = 0 },
    base_casting_time = 50,
    final_casting_time = 5,
    casting_time_increment = -3.5,
    impact_handler = "w16b_sp_imp_mindovermatter_439c8b4415e1",
}
