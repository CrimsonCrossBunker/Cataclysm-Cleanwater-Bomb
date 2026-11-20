local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_flame_punch_spell_push",
    name = ccb.content.text_without_extraction("Blazing Blow Push"),
    description = ccb.content.text_without_extraction("This is the push effect of the Blazing Blow spell.  It's a bug if you have it directly."),
    message = "",
    skill = "deduction",
    valid_targets = { "ally", "hostile", "item", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    effect = "directed_push",
    shape = "blast",
    max_level = 15,
    min_damage = 1,
    max_damage = 3,
    min_range = 1,
    max_range = 1,
}
