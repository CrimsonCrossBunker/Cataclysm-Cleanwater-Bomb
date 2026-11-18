local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_mom_artifact_speed_boost",
    name = ccb.content.text("Preternatural Speed"),
    description = ccb.content.text("You are moving much faster than anything nearby."),
    apply_message = "",
    remove_message = ccb.content.text("The world speeds up again."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_speed_boost_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_physical_boost",
    name = ccb.content.text("Enhanced Prowess"),
    description = ccb.content.text("Your physical abilities are enhanced."),
    apply_message = "",
    remove_message = ccb.content.text("Your prowess fades away."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_physical_boost_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_increase_pain",
    name = ccb.content.text("Sensitive"),
    description = ccb.content.text("Your skin prickles."),
    apply_message = "",
    remove_message = ccb.content.text("The prickling sensation of your skin disappears."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_increase_pain_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_movement_exertion",
    name = ccb.content.text("Fatigue"),
    description = ccb.content.text("Moving seems to take more effort than usual."),
    apply_message = "",
    remove_message = ccb.content.text("Movement becomes slightly easier."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_movement_exertion_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_hardened_skin",
    name = ccb.content.text("Hardened Skin"),
    description = ccb.content.text("Your skin is more resilient."),
    apply_message = "",
    remove_message = ccb.content.text("The slight itching and waxiness in your skin fades away."),
    rating = "good",
}
    :flag("TOUGH_FEET")
    :blocks_effect("bleed")
    :blocks_effect("hypovolemia")
    :blocks_effect("dermatik")
    :enchantment("INLINE_ENCH_effect_mom_artifact_hardened_skin_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_perception_boost",
    name = ccb.content.text("Enhanced Perception"),
    description = ccb.content.text("Your senses are enhanced."),
    apply_message = ccb.content.text("All your senses suddenly sharpen."),
    remove_message = ccb.content.text("Your enhanced senses fade away."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_perception_boost_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_lightning_immune",
    name = "",
    description = "",
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_lightning_immune_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_electrical_zap_attack",
    name = ccb.content.text("Horripilation"),
    description = ccb.content.text("Your hair is standing on end."),
    apply_message = ccb.content.text("Your hair stands on end."),
    remove_message = ccb.content.text("Your skin crackles as lightning discharges into your target!"),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_electrical_zap_attack_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_illumination_on_self",
    name = "",
    description = "",
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_illumination_on_self_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_lambent_illumination",
    name = ccb.content.text("Illuminated"),
    description = ccb.content.text("You are glowing."),
    rating = "bad",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_lambent_illumination_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_burning_cloak",
    name = ccb.content.text("Burning Air"),
    description = ccb.content.text("The air around you is superheated."),
    apply_message = "",
    remove_message = ccb.content.text("The air around you loses its heat."),
    rating = "good",
}
    :removes_effect("effect_pyrokinetic_aura_damage")
    :enchantment("INLINE_ENCH_effect_mom_artifact_burning_cloak_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_levitation",
    name = ccb.content.text("Levitation"),
    description = ccb.content.text("You are floating in defiance of gravity."),
    apply_message = "",
    remove_message = ccb.content.text("Your feet touch the ground once again."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 50,
    intensity_duration_turns = 5,
}
    :decay_message(ccb.content.text("You are sinking despite your best efforts."), "bad")
    :decay_message(ccb.content.text("You wobble briefly downward before recovering."), "bad")
    :flag("LEVITATION")
    :flag("CLIMB_FLYING")
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

-- This exists so you only actually get the artifact mind sight when wielding the artifact
content.add(content.EffectType {
    id = "effect_mom_artifact_mind_sight_container",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_mind_sight_container_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_mind_sight",
    name = ccb.content.text("Mind Sight"),
    description = ccb.content.text("You can sense nearby minds."),
    apply_message = "",
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_mind_sight_0"))

-- This exists so you only actually get the artifact telepathic shield when wielding the artifact
content.add(content.EffectType {
    id = "effect_mom_artifact_telepathic_shield_container",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_telepathic_shield_container_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_telepathic_shield",
    name = ccb.content.text("Telepathic Shield Sight"),
    description = ccb.content.text("Your mind is a guarded fortress."),
    apply_message = "",
    rating = "good",
}
    :flag("TEEPSHIELD"))

content.add(content.EffectType {
    id = "effect_mom_artifact_slow",
    name = ccb.content.text("Stutterstepping"),
    description = ccb.content.text("Your steps aren't taking you as far as your eyes tell you they should."),
    apply_message = ccb.content.text("The air ripples and you stumble."),
    remove_message = ccb.content.text("Your eyes and your legs agree with each other again."),
    rating = "bad",
    maximum_duration_turns = 18000,
    show_in_info = true,
}
    :immune_character_flag("DIMENSIONAL_ANCHOR")
    :immune_character_flag("TELESTOP")
    :immune_character_flag("TELEPORT_IMMUNE")
    :enchantment("INLINE_ENCH_effect_mom_artifact_slow_0"))

content.add(content.EffectType {
    id = "effect_mom_artifact_regeneration",
    name = ccb.content.text("Tingling Skin"),
    description = ccb.content.text("Your entire body is tingling slightly."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_mom_artifact_regeneration_0"))
