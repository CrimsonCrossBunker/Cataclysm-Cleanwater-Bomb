local ccb = require("ccb")

ccb.content.define_spell {
    id = "teleport_reality_tear",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    name = "[Ψ]Reality Tear",
    description = "Make your own contribution to the Cataclysm by opening a rift in reality, allowing all manners of netherium creatures access to Earth.  The rift is temporary…hopefully.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DAMAGE", "NO_PROJECTILE" },
    valid_targets = { "self" },
    base_energy_cost = 10000,
    final_energy_cost = 5000,
    energy_increment = -250,
    difficulty = 10,
    max_level = { handler = "w16b_sp_stat_mindovermatter_f3b23418fec0", fallback = 0 },
    base_casting_time = 250,
    final_casting_time = 100,
    casting_time_increment = -10,
    impact_handler = "w16b_sp_imp_mindovermatter_1a6a1143400e",
}
