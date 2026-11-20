local ccb = require("ccb")

ccb.content.define_spell {
    id = "earthshaper_map_real",
    name = ccb.content.text("Reading the Earthbones Real Spell"),
    description = ccb.content.text("This is the spell that actually fires when you cast Reading the Earthbones.  It's a bug if you have it."),
    valid_targets = { "none" },
    message = ccb.content.text("The secrets of the living earth are revealed to you."),
    flags = { "NO_HANDS", "SILENT" },
    effect = "map",
    shape = "blast",
    max_level = 1,
    min_aoe = { handler = "scaled_earthshaper_map_real_min_aoe", fallback = 7.0 },
}
