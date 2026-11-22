local ccb = require("ccb")

ccb.content.define_spell {
    id = "silent_one_detect_psionic_activity_aggressive",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Silent One Detect Psi Aggressive"),
    description = ccb.content.text_without_extraction("Silent One's detecting of psionic activity when it's already angry.  It's a bug if you have it."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    valid_targets = { "ally", "hostile", "self" },
    min_aoe = 15,
    max_aoe = 15,
    impact_handler = "w16b_sp_imp_mindovermatter_ec7662648390",
}
