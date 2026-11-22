local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "silent_one_polymorph_to_hostile",
    name = ccb.content.text_without_extraction("[Ψ]Silent One polymorph"),
    description = ccb.content.text_without_extraction("Silent One' polymorphing to hostile.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    difficulty = 8,
    max_level = 30,
    effect = "targeted_polymorph",
    effect_data = "mon_nether_silent_one_aggressive",
    shape = "blast",
    min_damage = 500,
    max_damage = 500,
    targeted_monsters = { "mon_nether_silent_one_passive" },
}

ccb.content.define_spell {
    id = "silent_one_drain_monster",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Silent One Draining attack"),
    description = ccb.content.text_without_extraction("Silent One's draining attack.  It's a bug if you have it."),
    message = "",
    flags = { "NO_EXPLOSION_SFX", "SILENT" },
    valid_targets = { "hostile" },
    min_range = 15,
    max_range = 15,
    impact_handler = "w16b_sp_imp_mindovermatter_cab969960e4d",
}

ccb.content.define_spell {
    id = "silent_one_detect_psionic_activity",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Silent One Detect Psi"),
    description = ccb.content.text_without_extraction("Silent One's detecting of psionic activity.  It's a bug if you have it."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    valid_targets = { "ally", "hostile", "self" },
    min_aoe = 45,
    max_aoe = 45,
    impact_handler = "w16b_sp_imp_mindovermatter_d8745b22534f",
}
