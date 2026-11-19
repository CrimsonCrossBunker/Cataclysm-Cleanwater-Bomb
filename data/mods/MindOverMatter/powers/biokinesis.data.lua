local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokin_hurricane_blows_2",
    name = ccb.content.text_without_extraction("[Ψ]Hurricane Blows 2"),
    description = ccb.content.text_without_extraction("Makes sure the extra effects of Hurricane Blows last through the power's duration.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_biokin_hurricane_blows_2",
    shape = "blast",
    min_duration = 200,
    max_duration = 200,
}
