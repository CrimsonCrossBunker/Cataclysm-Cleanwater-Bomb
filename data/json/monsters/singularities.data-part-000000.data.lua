local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "LTNT_attract_nearby",
    name = ccb.content.text_without_extraction("Visual Sundering"),
    description = ccb.content.text_without_extraction("The fact a shadow can make such an awful, loud sound makes your head want to split in two."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "hostile" },
    shape = "blast",
    min_accuracy = 20,
    max_accuracy = 20,
    min_range = 30,
    max_range = 30,
    max_level = 1,
    min_damage = 120,
    max_damage = 120,
    effect = "noise",
}
