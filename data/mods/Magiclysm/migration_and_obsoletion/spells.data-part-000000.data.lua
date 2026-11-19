local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pertifying_touch_moves",
    name = ccb.content.text_without_extraction("Petrifying Touch Moves Removing"),
    description = ccb.content.text_without_extraction("Delete some amount of moves from monster, and inflict DoT.  You can see it only in debug mode."),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "SILENT", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    effect = "mod_moves",
    shape = "blast",
    min_damage = -1000,
    max_damage = -1,
    damage_increment = 50,
    min_dot = 0,
    max_dot = 10,
    dot_increment = 0.5,
    max_level = 20,
}
