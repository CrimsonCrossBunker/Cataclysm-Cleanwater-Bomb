local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "homullus_civilization_translocate_attune_real",
    name = ccb.content.text_without_extraction("All Roads Lead to Rome Attunement Real"),
    description = ccb.content.text_without_extraction("The actual All Roads Lead to Rome attunement spell.  It's a bug if you have it."),
    teachable = false,
    valid_targets = { "ground" },
    spell_class = "HOMULLUS",
    skill = "deduction",
    flags = { "VERBAL", "SOMATIC", "NO_FAIL" },
    difficulty = 1,
    max_level = 1,
    effect = "ter_transform",
    effect_data = "ter_homullus_translocate_location_attune",
    shape = "blast",
    min_range = 1,
}
