local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_electrokinetic_speed_boost_npc",
    name = ccb.content.text("Neuro-Accelerated"),
    description = ccb.content.text("Your nervous system is enhanced."),
    apply_message = "",
    remove_message = ccb.content.text("Your reactions return to baseline."),
    rating = "good",
    maximum_duration_turns = 600,
}
    :removes_effect("effect_electrokinetic_pain_immune")
    :enchantment("INLINE_ENCH_effect_electrokinetic_speed_boost_npc_0"))

content.add(content.EffectType {
    id = "asked_to_vitakinetic_heal",
    name = "Asked to heal",
    description = "You were asked if you wanted your illness healed and you said no.",
})
