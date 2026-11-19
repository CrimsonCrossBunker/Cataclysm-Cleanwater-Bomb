local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_conjure_memories",
    name = ccb.content.text_without_extraction("Life Flashing"),
    description = ccb.content.text_without_extraction("Brings back memories."),
    copy_from = "base_portal",
    max_range = 3,
    effect_data = "EOC_conjure_memories",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "guilt_attack",
    name = ccb.content.text_without_extraction("Guilt Attack"),
    description = ccb.content.text_without_extraction("Makes things heavier."),
    copy_from = "base_portal",
    effect_data = "EOC_guilt_attack",
}
