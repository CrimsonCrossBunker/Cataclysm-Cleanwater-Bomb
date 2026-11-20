local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sylph_reveal_overmap_spell_real",
    name = ccb.content.text_without_extraction("Like a Bird on the Wing Real Spell"),
    description = ccb.content.text_without_extraction("This is the spell that actually fires when you cast Like a Bird on the Wing.  It's a bug if you have it."),
    valid_targets = { "none" },
    message = "",
    flags = { "NO_HANDS", "SILENT" },
    effect = "map",
    shape = "blast",
    max_level = 1,
    min_aoe = { handler = "scaled_sylph_reveal_overmap_spell_real_min_aoe", fallback = 10.0 },
}
