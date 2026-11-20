local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "stormshaper_heart_of_hurricane_throw",
    name = ccb.content.text_without_extraction("Heart of the Hurricane Throw"),
    description = ccb.content.text_without_extraction("This is the spell that throws your target back.  It's a bug if you have it directly."),
    message = ccb.content.text("The winds lash out and hurl <npcname> away!"),
    valid_targets = { "ally", "hostile", "item", "ground" },
    spell_class = "STORMSHAPER",
    flags = { "ENHANCEMENT_SPELL", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    effect = "directed_push",
    shape = "blast",
    min_damage = 1,
    max_damage = { handler = "scaled_stormshaper_heart_of_hurricane_throw_max_damage", fallback = 1.0 },
    min_range = 1,
}
