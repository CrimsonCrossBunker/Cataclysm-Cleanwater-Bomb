local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_reflection_attack",
    name = ccb.content.text_without_extraction("Reflection Action"),
    description = ccb.content.text_without_extraction("Teleports and harms monsters."),
    copy_from = "base_portal",
    min_range = 15,
    max_range = 15,
    effect_data = "EOC_mon_reflection_attack",
}
