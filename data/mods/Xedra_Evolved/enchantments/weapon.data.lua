local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_weak_healing",
    name = ccb.content.text_without_extraction("Weak healing"),
    description = ccb.content.text_without_extraction("Heal 1 HP.  Used in various enchantments.  You can see it only in debug."),
    valid_targets = { "self" },
    min_damage = -1,
    max_damage = -1,
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
}
