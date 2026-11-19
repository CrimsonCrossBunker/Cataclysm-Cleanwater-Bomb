local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "arvore_seed_bearer_real",
    name = ccb.content.text_without_extraction("Seed Bearer Real"),
    description = ccb.content.text_without_extraction("The actual spell that calls forth seeds.  It's a bug if you have it."),
    skill = "deduction",
    flags = { "SPAWN_GROUP", "PERMANENT" },
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "farming_seeds",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
}
