local ccb = require("ccb")

ccb.content.define_spell {
    id = "teleport_farstep_real",
    name = ccb.content.text("[Ψ]Farstep"),
    description = ccb.content.text("Skating along the void between dimensions, move to a specific place nearby.\n\nThe power <color_red>will fail</color> if the volume of your carried gear is too great."),
    message = "",
    teachable = false,
    valid_targets = { "ground" },
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_AOE", "TARGET_TELEPORT", "IGNORE_WALLS" },
    difficulty = 6,
    max_level = { handler = "scale_teleport_slow_max_level", fallback = 0 },
    effect = "short_range_teleport",
    shape = "blast",
    min_aoe = 1,
    max_aoe = { handler = "scale_teleport_farstep_real_max_aoe", fallback = 1.0 },
    min_range = { handler = "scale_teleport_farstep_real_min_range", fallback = 0.0 },
    max_range = 80,
}
