local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_forest_traverse_the_wilds",
    name = ccb.content.text("Weald-Walking"),
    description = ccb.content.text("Nature is speeding your passage."),
    remove_message = ccb.content.text("Nature no longer speeds your movements."),
    rating = "good",
    maximum_duration_turns = 57600,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_forest_traverse_the_wilds_0")
    :enchantment("INLINE_ENCH_effect_forest_traverse_the_wilds_1"))

-- hidden effect, a tracker for the chirurgeon's attacks
content.add(content.EffectType {
    id = "effect_mon_xw_chirurgeon_tracker",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_mon_xw_chirurgeon_sleeper",
    name = "",
    description = "",
    rating = "good",
}
    :flag("INVISIBLE")
    :flag("DEAF")
    :enchantment("INLINE_ENCH_effect_mon_xw_chirurgeon_sleeper_0"))

content.add(content.EffectType {
    id = "effect_pattern_tattoo_meditation",
    name = "",
    description = "",
    rating = "good",
}
    :flag("BLIND"))

content.add(content.EffectType {
    id = "effect_flames_tattoo_one",
    name = "",
    description = "",
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_mountain_tattoo_three",
    name = "",
    description = "",
    rating = "good",
}
    :removes_effect("stunned")
    :removes_effect("downed")
    :removes_effect("dazed"))

content.add(content.EffectType {
    id = "effect_triffid_entangled",
    name = ccb.content.text("Vegetative Grasp"),
    description = ccb.content.text("Roots and vines entangle your foes."),
    apply_message = ccb.content.text("Roots and vines burst from the ground and entangle you!"),
    remove_message = ccb.content.text("The roots and vines wither up and die."),
    maximum_intensity = 4,
    intensity_add_value = 1,
    show_in_info = true,
}
    :flag("EFFECT_IMPEDING")
    :modifier("speed", "amount", { base = -20, per_intensity = -5 }))

content.add(content.EffectType {
    id = "effect_triffid_speed_boost",
    name = ccb.content.text("Vegetal Speed"),
    description = ccb.content.text("Make you faster, and allow to hold this state for a while."),
    apply_message = ccb.content.text("You feel your legs can work much better than before"),
    remove_message = ccb.content.text("Your speed slows down."),
    rating = "good",
}
    :modifier("speed", "amount", { base = 40 })
    :modifier("stamina", "minimum", { base = 20 }))
