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
