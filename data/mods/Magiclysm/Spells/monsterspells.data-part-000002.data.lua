local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "rust_monster_polymorph_to_hostile",
    name = ccb.content.text_without_extraction("[Ψ]Rust monster polymorph"),
    description = ccb.content.text_without_extraction("Rust monster polymorphing to hostile.  It's a bug if you have it."),
    message = "",
    valid_targets = { "self", "hostile", "ally" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "HIDDEN_SPELL" },
    difficulty = 8,
    max_level = 30,
    effect = "targeted_polymorph",
    effect_data = "mon_rust_monster_aggressive",
    shape = "blast",
    min_damage = 500,
    max_damage = 500,
    min_range = 10,
    max_range = 10,
    targeted_monsters = { "mon_rust_monster" },
}
