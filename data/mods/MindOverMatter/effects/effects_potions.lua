local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_matrix_potion_headblind",
    name = ccb.content.text("Drank Matrix Elixir"),
    description = ccb.content.text("You're suffering the effects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 54000,
    maximum_intensity = 1,
}
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 20 })
    :modifier("health", "tick", { base = 200 })
    :modifier("vomiting", "chance_numerator", { base = 100 })
    :modifier("vomiting", "tick", { base = 180 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

-- Hidden effect
content.add(content.EffectType {
    id = "effect_matrix_potion_nether_boost",
    name = "",
    description = "",
}
    :vitamin("vitamin_psionic_drain", {
        rates = { { minimum = 1, maximum = 2 } },
        tick_turns = { 300 },
    }))

content.add(content.EffectType {
    id = "effect_biokin_potion",
    name = ccb.content.text("Pink Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and are replaced with a gnawing weakness."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("BLEED_IMMUNE")
    :flag("STEADY")
    :enchantment("INLINE_ENCH_effect_biokin_potion_0")
    :modifier("strength", "amount", { base = 4 })
    :modifier("dexterity", "amount", { base = 4 })
    :modifier("speed", "amount", { base = 25 }))

content.add(content.EffectType {
    id = "effect_biokin_potion_comedown",
    name = ccb.content.text("Pink Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :enchantment("INLINE_ENCH_effect_biokin_potion_comedown_0")
    :modifier("strength", "amount", { base = -6 })
    :modifier("dexterity", "amount", { base = -6 })
    :modifier("speed", "amount", { base = -40 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

content.add(content.EffectType {
    id = "effect_clair_potion",
    name = ccb.content.text("Gray Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and darkness creeps in at the edges of your vision."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("SEESLEEP")
    :flag("SAFECRACK_NO_TOOL")
    :flag("IMMUNE_HEARING_DAMAGE")
    :enchantment("enchant_clair_potion")
    :modifier("perception", "amount", { base = 4 }))

content.add(content.EffectType {
    id = "effect_clair_potion_comedown",
    name = ccb.content.text("Gray Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :flag("HYPEROPIC")
    :flag("MYOPIC")
    :modifier("perception", "amount", { base = -6 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

content.add(content.EffectType {
    id = "effect_electrokin_potion",
    name = ccb.content.text("Cyan Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and your muscles twitch."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("EMP_IMMUNE")
    :enchantment("enchant_electrokin_potion")
    :modifier("dexterity", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_electrokin_potion_comedown",
    name = ccb.content.text("Cyan Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

content.add(content.EffectType {
    id = "effect_photokin_potion",
    name = ccb.content.text("Golden Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and your vision warps."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("GLARE_RESIST")
    :enchantment("enchant_photokin_potion_rads")
    :enchantment("enchant_photokin_potion_hide")
    :modifier("radiation", "minimum", { base = -1 })
    :modifier("radiation", "chance_numerator", { base = 30 })
    :modifier("radiation", "tick", { base = 60 }))

content.add(content.EffectType {
    id = "effect_photokin_potion_comedown",
    name = ccb.content.text("Golden Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :enchantment("enchant_photokin_potion_unhide")
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

content.add(content.EffectType {
    id = "effect_pyrokin_potion",
    name = ccb.content.text("Red Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and are replaced with a burning heat."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("HEATSINK")
    :flag("BARKY")
    :enchantment("enchant_pyrokin_potion")
    :modifier("speed", "amount", { base = 10 }))

content.add(content.EffectType {
    id = "effect_pyrokin_potion_comedown",
    name = ccb.content.text("Red Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :flag("COLDBLOOD")
    :enchantment("INLINE_ENCH_effect_pyrokin_potion_comedown_0")
    :modifier("pain", "chance_denominator", { base = 200 })
    :modifier("pain", "chance_numerator", { base = 2, resisted_base = 1 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10, resisted_base = 5 }))

content.add(content.EffectType {
    id = "effect_telekin_potion",
    name = ccb.content.text("Yellow Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and you suddenly feel like something is pressing down on you."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("DOWNED_RECOVERY")
    :enchantment("INLINE_ENCH_effect_telekin_potion_0")
    :modifier("strength", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_telekin_potion_comedown",
    name = ccb.content.text("Yellow Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :enchantment("INLINE_ENCH_effect_telekin_potion_comedown_0")
    :modifier("strength", "amount", { base = -2 })
    :modifier("speed", "amount", { base = -25 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

-- When I get around to modifying dialogue to account for telepaths, I need to make sure to account for this too
content.add(content.EffectType {
    id = "effect_telepath_potion",
    name = ccb.content.text("White Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and it gets hard to think straight."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("TEEPSHIELD")
    :enchantment("INLINE_ENCH_effect_telepath_potion_0"))

content.add(content.EffectType {
    id = "effect_telepath_potion_comedown",
    name = ccb.content.text("White Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :enchantment("INLINE_ENCH_effect_telepath_potion_comedown_0")
    :modifier("intelligence", "amount", { base = -4 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

content.add(content.EffectType {
    id = "effect_teleport_potion",
    name = ccb.content.text("Blue Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and you suddenly feel stretched, like something unseen is pulling at you."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("FEATHER_FALL")
    :enchantment("enchant_teleport_potion"))

content.add(content.EffectType {
    id = "effect_vitakin_potion",
    name = ccb.content.text("Green Elixir"),
    description = ccb.content.text("You drank the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's effects fade and you stagger as you suddenly feel faint."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
}
    :flag("MEND_ALL")
    :flag("PARAIMMUNE")
    :flag("NO_DISEASE")
    :flag("INFECTION_IMMUNE")
    :enchantment("INLINE_ENCH_effect_vitakin_potion_0")
    :modifier("healing", "amount", { base = 4 }))

content.add(content.EffectType {
    id = "effect_vitakin_potion_comedown",
    name = ccb.content.text("Green Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :modifier("healing", "amount", { base = 0.3 })
    :modifier("vomiting", "chance_numerator", { base = 100 })
    :modifier("vomiting", "tick", { base = 180 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))

content.add(content.EffectType {
    id = "effect_noetic_resilience",
    name = ccb.content.text("Noetic Resilience"),
    description = ccb.content.text("You are fortified against too strong a connection with the Nether."),
    apply_message = "",
    remove_message = ccb.content.text("Your protection against too much connection to the Nether fades away."),
    rating = "good",
    maximum_duration_turns = 108000,
    maximum_intensity = 1,
})

content.add(content.EffectType {
    id = "effect_noetic_resilience_comedown",
    name = ccb.content.text("Noetically Fragile"),
    description = ccb.content.text("Your psionic capacity, and physical stamina, are reduced by the aftereffects of the noetic resilience treatment."),
    apply_message = ccb.content.text("You feel a sudden weakness in your body."),
    remove_message = ccb.content.text("You feel your strength and ability to channel your powers finally return to normal."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 150 })
    :modifier("stamina", "amount", { base = -2500 })
    :modifier("stamina", "minimum", { base = -250 })
    :modifier("stamina", "chance_numerator", { base = 30 }))

content.add(content.EffectType {
    id = "effect_teleport_potion_comedown",
    name = ccb.content.text("Blue Elixir Aftereffects"),
    description = ccb.content.text("You're suffering the aftereffects of drinking the concentrated matrix crystal concoction."),
    apply_message = "",
    remove_message = ccb.content.text("The concoction's aftereffects finally wear off."),
    rating = "bad",
    maximum_duration_turns = 198000,
    maximum_intensity = 1,
}
    :removes_optional_effect("DIMENSIONAL_ANCHOR")
    :enchantment("enchant_teleport_potion_comedown")
    :modifier("speed", "amount", { base = -15 })
    :modifier("pain", "chance_denominator", { base = 200 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "tick", { base = 200 }))
