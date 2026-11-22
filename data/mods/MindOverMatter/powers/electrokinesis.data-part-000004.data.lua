local ccb = require("ccb")

ccb.content.define_spell {
    id = "electrokinetic_lightning_aura",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "ELECTROKINETIC",
    magic_type = "mom_psionics",
    name = "[Ψ]Galvanic Aura (C)",
    description = "Charge the air around you with power, unleashing blasts at anyone nearby.  This power does not discriminate between friend and foe.  It will also protect you from electricity while active.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>",
    message = "The air around you hums with power.",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = { handler = "w16b_sp_stat_mindovermatter_f8023f6085f2", fallback = 0 },
    max_duration = { handler = "w16b_sp_stat_mindovermatter_956f497e5fe4", fallback = 0 },
    base_energy_cost = { handler = "w16b_sp_stat_mindovermatter_4bd37d7a502d", fallback = 0 },
    difficulty = 8,
    max_level = { handler = "w16b_sp_stat_mindovermatter_b0d940c3d35d", fallback = 0 },
    base_casting_time = { handler = "w16b_sp_stat_mindovermatter_f5253b1dd765", fallback = 0 },
    impact_handler = "w16b_sp_imp_mindovermatter_4b3ceb7ba1bd",
}
