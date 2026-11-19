local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "absence_capture_attack",
    name = ccb.content.text_without_extraction("Absence Capture Attack"),
    description = ccb.content.text_without_extraction("Traps you with nothing."),
    copy_from = "base_portal",
    min_range = 12,
    max_range = 12,
    effect_data = "EOC_absence_capture_attack",
}
