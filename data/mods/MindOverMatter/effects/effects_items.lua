local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "instability_remover",
    name = ccb.content.text("Morphic Reinforcement"),
    description = ccb.content.text("You're not exactly sure what morphic reinforcement means, but it definitely itches like crazy."),
    apply_message = ccb.content.text("Your entire body itches terribly!"),
    remove_message = ccb.content.text("The itching finally fades away."),
    rating = "mixed",
    maximum_duration_turns = 86400,
}
    :enchantment("INLINE_ENCH_instability_remover_0")
    :modifier("speed", "amount", { base = -10 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("health_modifier", "minimum", { base = -1 })
    :modifier("health_modifier", "chance_numerator", { base = 1 })
    :modifier("health_modifier", "chance_denominator", { base = 5 })
    :modifier("health_modifier", "tick", { base = 3600 })
    :vitamin("mutagen", {
        rates = { { minimum = -1, maximum = -1 } },
        tick_turns = { 120 },
    }))

-- Hidden effect to set off an EoC
content.add(content.EffectType {
    id = "effect_noetic_resilience_trigger",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "force_field_generated",
    name = ccb.content.text("Rippling Air"),
    description = ccb.content.text("The air around you is wavering strangely."),
    apply_message = ccb.content.text("The world takes on a slightly bent look, as though you're a straw inserted into a glass of water."),
    remove_message = ccb.content.text("The world snaps back into focus."),
    rating = "good",
    maximum_duration_turns = 60,
}
    :enchantment("INLINE_ENCH_force_field_generated_0"))

-- Blank to create uncertainty
content.add(content.EffectType {
    id = "effect_psyshield_protection",
    name = "",
    description = "",
}
    :flag("PSYSHIELD_PROTECT")
    :removes_effect("psi_blind")
    :removes_effect("psi_deaf")
    :removes_effect("effect_telepathic_primal_terror")
    :removes_effect("psi_dazed"))

-- Blank to hide effect
content.add(content.EffectType {
    id = "effect_shield_belt_telekin_protection",
    name = "",
    description = "",
}
    :flag("TELEKIN_SHIELD"))

-- Blank to hide effect
content.add(content.EffectType {
    id = "effect_suppression_belt_fire_protection",
    name = "",
    description = "",
}
    :flag("HEAT_IMMUNE"))

content.add(content.EffectType {
    id = "effect_black_nether_water_disease",
    name = ccb.content.text("Unearthly Cold"),
    description = ccb.content.text("You are chilled from the inside out."),
    apply_message = ccb.content.text("A numbing cold spreads out from your stomach to your whole body."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_black_nether_water_disease_0")
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 300 })
    :modifier("vomiting", "chance_numerator", { base = 600 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 2 })
    :modifier("health", "tick", { base = 60 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("sleepiness", "maximum", { base = 2 })
    :modifier("sleepiness", "chance_numerator", { base = 4 })
    :modifier("sleepiness", "tick", { base = 60 })
    :modifier("sleepiness", "maximum_value", { base = 700 }))

content.add(content.EffectType {
    id = "effect_mom_cascade_stone",
    name = ccb.content.text("Energy Locus"),
    description = ccb.content.text("You are overflowing with a torrent of Nether power."),
    remove_message = ccb.content.text("The torrent of Nether power finally ceases."),
    rating = "good",
})

-- Hidden effect to set off an EoC
content.add(content.EffectType {
    id = "effect_black_nether_water_nightmares",
    name = "",
    description = "",
})

-- Hidden effect, lets you fall one story
content.add(content.EffectType {
    id = "effect_mom_fall_one_story",
    name = "",
    description = "",
}
    :flag("ONE_STORY_FALL"))
