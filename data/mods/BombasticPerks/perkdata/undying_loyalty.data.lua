local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "perk_undying_loyalty_spell",
    name = ccb.content.text_without_extraction("Undying Loyalty Spell"),
    description = ccb.content.text_without_extraction("The spell to activate the Undying Loyalty effect.  It's a bug if you have it."),
    valid_targets = { "ally" },
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_perk_undying_loyalty",
    shape = "blast",
    difficulty = 1,
    min_duration = 6000,
    max_duration = 6000,
    min_aoe = 15,
    max_aoe = 15,
}
