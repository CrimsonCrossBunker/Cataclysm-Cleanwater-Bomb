local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_scenario_heart_of_fire_awake_attunement_gain",
    name = ccb.content.text("Heart of Fire"),
    description = ccb.content.text("The flames in your heart have kindled, fueling a connection to the Nether.  Your Nether Attunement will not reduce with time."),
    rating = "neutral",
}
    :vitamin("vitamin_psionic_drain", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 300 },
    }))

content.add(content.EffectType {
    id = "effect_scenario_heart_of_fire_asleep_attunement_gain",
    name = ccb.content.text("Heart of Cinders"),
    description = ccb.content.text("The flames in your heart smolder, maintaining your connection to the Nether.  Your Nether Attunement will reduce with time, but more slowly."),
    rating = "neutral",
}
    :vitamin("vitamin_psionic_drain", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 700 },
    }))

-- Hidden, used as a tracker
content.add(content.EffectType {
    id = "effect_scenario_heart_of_fire_channeled_power_protector",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_scenario_heart_of_fire_need_to_channel",
    name = ccb.content.text("Let the Fire Burn"),
    description = ccb.content.text("The power twists inside you.  Let it out.  Let the flames rise."),
    apply_message = ccb.content.text("A fire burns within you."),
    rating = "bad",
    maximum_intensity = 10,
    intensity_add_value = 1,
}
    :enchantment("INLINE_ENCH_effect_scenario_heart_of_fire_need_to_channel_0")
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 10, per_intensity = -1 })
    :modifier("health", "tick", { base = 60 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 10, per_intensity = -1 })
    :modifier("pain", "maximum_value", { base = 20, per_intensity = 5 })
    :modifier("pain", "tick", { base = 60 }))

content.add(content.EffectType {
    id = "effect_scenario_heart_of_fire_damage",
    name = ccb.content.text("Inner Blaze"),
    description = ccb.content.text("You feel far too warm."),
    apply_message = "",
    rating = "bad",
    maximum_intensity = 5,
    intensity_add_value = 1,
}
    :name(ccb.content.text("Inner Blaze"))
    :name(ccb.content.text("Inner Inferno"))
    :name(ccb.content.text("Inner Inferno"))
    :description(ccb.content.text("You feel far, far too warm."))
    :description(ccb.content.text("You are burning up!"))
    :description(ccb.content.text("You are burning up!"))
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 20, per_intensity = -2 })
    :modifier("hurt", "tick", { base = 300, per_intensity = -20 }))
