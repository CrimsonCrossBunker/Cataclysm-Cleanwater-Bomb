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

ccb.content.define_spell {
    id = "will_o_wisp_draining_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("Will o the Wisp draining attack"),
    description = ccb.content.text_without_extraction("The will o the Wisp life-draining attack."),
    flags = { "NO_LEGS", "SILENT", "NO_PROJECTILE", "SPLIT_DAMAGE" },
    valid_targets = { "hostile", "ally", "ground" },
    min_range = 3,
    impact_handler = "w16b_sp_imp_magiclysm_a462961d419e",
}

ccb.content.define_spell {
    id = "rust_monster_detect_metal_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("rust monster detect metal"),
    description = ccb.content.text_without_extraction("Rust monster detecting metal.  It's a bug if you have it."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    valid_targets = { "ally", "hostile", "self" },
    min_aoe = 5,
    max_aoe = 5,
    impact_handler = "w16b_sp_imp_magiclysm_5332ae20b626",
}
