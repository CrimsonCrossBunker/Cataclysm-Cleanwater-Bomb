local ccb = require("ccb")

-- NO_I18N
ccb.content.define_spell {
    id = "gain_mana_leech_shackle",
    name = ccb.content.text("MANA_LEECH_START"),
    description = ccb.content.text_without_extraction("Workaround that gives the mana-leech shackle on game start.  You're not supposed to see this.  Delete it when EOCs can spawn items as equipped."),
    valid_targets = { "self" },
    flags = { "PERMANENT_ALL_LEVELS", "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    shape = "blast",
    effect_data = "mana_leech_shackle",
    min_damage = 1,
    max_damage = 1,
}

-- NO_I18N
ccb.content.define_spell {
    id = "gain_mana_leech_shackle_unlocked",
    name = ccb.content.text("MANA_LEECH_START"),
    description = ccb.content.text_without_extraction("Workaround that ensures that the inert mana-leech shackle is worn when it is made inert.  You're not supposed to see this.  Delete it when EOCs can spawn items as equipped."),
    valid_targets = { "self" },
    flags = { "PERMANENT_ALL_LEVELS", "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    shape = "blast",
    effect_data = "mana_leech_shackle_unlocked",
    min_damage = 1,
    max_damage = 1,
}
