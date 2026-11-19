local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "VAMPIRE_ANATHEMA_SETUP",
    name = ccb.content.text_without_extraction("Anathema Setup"),
    description = ccb.content.text_without_extraction("This gives the protective effect to the Anathema when it spawns, as monsters cannot spawn with enchantments as of writting this."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "NO_FAIL", "NO_LEGS", "NO_HANDS" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_anathema_resilience",
    spell_class = "NONE",
    energy_source = "NONE",
    max_level = 1,
    min_duration = 3000000,
    max_duration = 3000000,
}
