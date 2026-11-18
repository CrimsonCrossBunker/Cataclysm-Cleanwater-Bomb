local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "xe_str",
    name = ccb.content.text("Enormous power"),
    description = ccb.content.text("Your muscles scream with force."),
    apply_message = ccb.content.text("Unleash the power."),
    remove_message = ccb.content.text("The power fades away."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_xe_str_0"))

content.add(content.EffectType {
    id = "xe_int",
    name = ccb.content.text("The Knowledge"),
    description = ccb.content.text("You know for sure - right now you are the smartest human on this side of the planet."),
    apply_message = ccb.content.text("With some effort you can outsmart reality."),
    remove_message = ccb.content.text("You feel yourself much less smarter than before."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_xe_int_0"))

content.add(content.EffectType {
    id = "xe_sight_elec",
    name = ccb.content.text("Sparks"),
    description = ccb.content.text("You feel sparks dancing in your eyes."),
    apply_message = ccb.content.text("Tiny electrical joints jump in your cornea."),
    remove_message = ccb.content.text("The sparks in your eyes are finally gone."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("ELECTRIC_VISION"))

content.add(content.EffectType {
    id = "xaea_electric_emit",
    name = ccb.content.text("Shocker"),
    description = ccb.content.text("Your body emits enough energy to power some small city."),
    apply_message = ccb.content.text("Shocking clouds fly everywhere!"),
    remove_message = ccb.content.text("Electric clouds are gone."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_xaea_electric_emit_0"))

content.add(content.EffectType {
    id = "xe_motion_vision",
    name = ccb.content.text("Extra Senses"),
    description = ccb.content.text("Somehow you can feel any motion around with your spine."),
    apply_message = ccb.content.text("You feel unusual sensation in your spine."),
    remove_message = ccb.content.text("The sensation in your spine is gone."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_xe_motion_vision_0"))

content.add(content.EffectType {
    id = "effect_wants_to_talk",
    name = ccb.content.text("Seeming to want to talk to you"),
    description = ccb.content.text("This person wants to talk with you."),
})

content.add(content.EffectType {
    id = "effect_vampire_torpor",
    name = ccb.content.text("Torpor"),
    description = ccb.content.text("Thanks to your torpor you are healing and recovering quickly"),
    rating = "good",
}
    :flag("DEAF")
    :flag("BLIND")
    :enchantment("INLINE_ENCH_effect_vampire_torpor_0")
    :enchantment("INLINE_ENCH_effect_vampire_torpor_1")
    :vitamin("human_blood_vitamin", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 480 },
    }))

content.add(content.EffectType {
    id = "feed_from_recently",
    name = ccb.content.text("Gave you blood"),
    description = ccb.content.text("This person won't accept to let you drink more of their blood for a while."),
    maximum_duration_turns = 8640000,
})

content.add(content.EffectType {
    id = "about_to_kill_best_friend",
    maximum_duration_turns = 5,
})
