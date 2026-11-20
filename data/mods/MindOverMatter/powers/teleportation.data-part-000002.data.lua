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
