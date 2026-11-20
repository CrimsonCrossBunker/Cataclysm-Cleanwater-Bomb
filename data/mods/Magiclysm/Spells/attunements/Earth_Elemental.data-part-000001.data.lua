local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "quake_transform",
    name = ccb.content.text_without_extraction("Quake Transform"),
    description = ccb.content.text_without_extraction("Causes rubble to be spawned occasionally."),
    valid_targets = { "hostile", "ground" },
    flags = { "EVOCATION_SPELL", "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    effect = "ter_transform",
    effect_data = "quake_transform",
    shape = "blast",
    min_damage = 30,
    max_damage = 200,
    damage_increment = 5,
    min_aoe = 0,
    max_aoe = 35,
    aoe_increment = 1,
    max_level = 35,
}
