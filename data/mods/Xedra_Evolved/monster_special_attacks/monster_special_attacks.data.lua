local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_ratking",
    name = ccb.content.text_without_extraction("Rat King Death"),
    description = ccb.content.text_without_extraction("Rat king dies."),
    valid_targets = { "hostile", "ally" },
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    effect = "remove_effect",
    effect_data = "rat",
    min_range = 48,
    max_range = 48,
    extra_spells = { { spell = "ratking_summon_rats", self = true } },
}
