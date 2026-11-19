local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "impossible_shape_attack",
    name = ccb.content.text_without_extraction("Impossible Shape Attack"),
    description = ccb.content.text_without_extraction("Hurts you mentally."),
    copy_from = "base_portal",
    min_range = 50,
    max_range = 50,
    effect_data = "EOC_impossible_shape_attack",
}
