local ccb = require("ccb")

ccb.content.define_spell {
    id = "rust_monster_increase_aggression",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Rust monster increase aggression"),
    description = ccb.content.text_without_extraction("Makes a hostile rust monster hostile again if you come back with more metal.  It's a bug if you have it."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "HIDDEN_SPELL" },
    valid_targets = { "self", "hostile", "ally" },
    targeted_monsters = { "mon_rust_monster" },
    min_range = 10,
    max_range = 10,
    difficulty = 8,
    max_level = 30,
    impact_handler = "w16b_sp_imp_magiclysm_c7c41b231122",
}
