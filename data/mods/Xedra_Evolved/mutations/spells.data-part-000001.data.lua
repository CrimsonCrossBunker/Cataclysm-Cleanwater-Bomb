local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vampire_map_real",
    name = ccb.content.text_without_extraction("Commune with children of the night Real Spell"),
    description = ccb.content.text_without_extraction("This is the spell that actually fires when you cast Commune with Children of the Night.  It's a bug if you have it."),
    valid_targets = { "none" },
    message = ccb.content.text("The secrets of the living earth are revealed to you."),
    flags = { "NO_HANDS", "SILENT" },
    effect = "map",
    shape = "blast",
    max_level = 1,
    min_aoe = { handler = "scaled_vampire_map_real_min_aoe", fallback = 7.0 },
}
