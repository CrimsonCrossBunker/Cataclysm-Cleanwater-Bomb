local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "psi_blind",
    name = ccb.content.text("Blind"),
    description = ccb.content.text("Range of Sight: 0.  You cannot see anything."),
    apply_message = ccb.content.text("You're blinded!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("BLIND")
    :immune_character_flag("TEEPSHIELD")
    :removes_effect("glare")
    :removes_effect("snow_glare")
    :removes_effect("darkness")
    :limb_score("vision", { multiplier = 0.0 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.2 }))

-- Separate id to change the apply message.
content.upsert_effect_type(content.EffectType {
    id = "psi_dazed",
    name = ccb.content.text("Dazed"),
    description = ccb.content.text("You're visibly shaken up, and are having a hard time focusing on what's going on around you."),
    apply_message = ccb.content.text("A roar fills your mind and you stagger!"),
    rating = "bad",
    maximum_intensity = 10,
    maximum_duration_turns = 600,
    intensity_add_value = 2,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("TEEPSHIELD")
    :modifier("speed", "amount", { per_intensity = -3 })
    :limb_score("balance", { multiplier = 0.5 })
    :limb_score("reaction", { multiplier = 0.35 })
    :limb_score("vision", { multiplier = 0.75 }))

-- Separate id to change the apply message.
content.upsert_effect_type(content.EffectType {
    id = "psi_dazed_zap",
    name = ccb.content.text("Dazed"),
    description = ccb.content.text("You're visibly shaken up, and are having a hard time focusing on what's going on around you."),
    apply_message = ccb.content.text("Your body twitches under the electrical assault!"),
    rating = "bad",
    maximum_intensity = 10,
    maximum_duration_turns = 600,
    intensity_add_value = 2,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("ELECTRIC_IMMUNE")
    :immune_character_flag("ELECTRIC")
    :immune_character_flag("ELECTRIC_FIELD")
    :modifier("speed", "amount", { per_intensity = -3 })
    :limb_score("balance", { multiplier = 0.5 })
    :limb_score("reaction", { multiplier = 0.35 })
    :limb_score("vision", { multiplier = 0.75 }))

content.upsert_effect_type(content.EffectType {
    id = "psi_deaf",
    name = ccb.content.text("Deaf"),
    description = ccb.content.text("You can't hear anything and your head aches from all the noise.  You can't converse with NPCs."),
    apply_message = ccb.content.text("Your ears ring!"),
    remove_message = ccb.content.text("You can hear again!"),
    rating = "bad",
    maximum_intensity = 3,
    intensity_duration_turns = 300,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("TEEPSHIELD")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 10 })
    :modifier("pain", "chance_numerator", { base = 250 })
    :modifier("pain", "chance_denominator", { base = 1000 })
    :limb_score("reaction", { multiplier = 0.5 }))

-- VISION_RANGE enchant is a proxy for perception, which monsters do not have
content.upsert_effect_type(content.EffectType {
    id = "effect_monster_heightened_reflex_enhanced",
    name = ccb.content.text("Heightened Reflexes"),
    description = ccb.content.text("You are enhancing your speed and senses."),
    show_in_info = true,
}
    :removes_effect("blind")
    :removes_effect("deaf")
    :enchantment("INLINE_ENCH_effect_monster_heightened_reflex_enhanced_0"))

content.upsert_effect_type(content.EffectType {
    id = "effect_radiation_aura",
    name = ccb.content.text("Eerie Glow"),
    description = ccb.content.text("Your skin tingles."),
    apply_message = "",
    remove_message = "",
    rating = "bad",
}
    :immune_character_flag("RAD_PROOF")
    :immune_character_flag("NO_RADIATION")
    :modifier("radiation", "amount", { base = 2 })
    :modifier("radiation", "minimum", { base = 3, resisted_base = 1 }))

content.upsert_effect_type(content.EffectType {
    id = "effect_photokinetic_illuminate_enemy",
    name = ccb.content.text("Illuminated"),
    description = ccb.content.text("You are glowing slightly."),
    apply_message = ccb.content.text("A faint glow springs up around you!"),
    remove_message = ccb.content.text("The faint glow around you fades away."),
    rating = "bad",
    maximum_duration_turns = 300,
}
    :enchantment("INLINE_ENCH_effect_photokinetic_illuminate_enemy_0")
    :modifier("dodge", "amount", { base = -1 }))

-- Separate ID to allow telepaths and telepathy-immune monsters to defend against it.
content.upsert_effect_type(content.EffectType {
    id = "psi_stunned",
    name = ccb.content.text("Stunned"),
    description = ccb.content.text("Your mind is reeling."),
    apply_message = ccb.content.text("You're stunned!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("DISABLE_FLIGHT")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_SPELLCASTING")
    :flag("NO_PSIONICS")
    :immune_character_flag("TEEPSHIELD")
    :immune_character_flag("TEEP_IMMUNE")
    :limb_score("balance", { multiplier = 0.2 })
    :limb_score("reaction", { multiplier = 0.0 }))
