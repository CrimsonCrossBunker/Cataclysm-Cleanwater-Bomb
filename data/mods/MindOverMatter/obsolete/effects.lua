local ccb = require("ccb")

-- Remove after 0.J
ccb.content.add(ccb.content.EffectType {
    id = "effect_vitakin_slow_bleeding_01",
    name = ccb.content.text("Coagulation"),
    description = ccb.content.text("You bleed less than normal."),
    remove_message = ccb.content.text("For just a moment, you feel your blood rushing through your veins."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_vitakin_slow_bleeding_01_0"))

ccb.content.add(ccb.content.EffectType {
    id = "effect_vitakin_slow_bleeding_02",
    name = ccb.content.text("Coagulation"),
    description = ccb.content.text("You bleed much less than normal."),
    remove_message = ccb.content.text("For just a moment, you feel your blood rushing through your veins."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_vitakin_slow_bleeding_02_0"))

ccb.content.add(ccb.content.EffectType {
    id = "effect_vitakin_slow_bleeding_03",
    name = ccb.content.text("Coagulation"),
    description = ccb.content.text("You bleed much less than normal and sometimes not at all."),
    remove_message = ccb.content.text("For just a moment, you feel your blood rushing through your veins."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :blocks_effect("bleed")
    :enchantment("INLINE_ENCH_effect_vitakin_slow_bleeding_03_0"))
