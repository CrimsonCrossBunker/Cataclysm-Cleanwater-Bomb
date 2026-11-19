local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eshaper_impalement_moves",
    name = ccb.content.text_without_extraction("Impalement Moves Removing"),
    description = ccb.content.text_without_extraction("Delete some random amount of moves from monster.  You can see it only in debug mode."),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "SILENT", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "mod_moves",
    shape = "blast",
    max_level = 20,
    min_aoe = 1,
    max_aoe = 7,
    aoe_increment = 0.3,
    min_damage = -1000,
    max_damage = -1,
}
