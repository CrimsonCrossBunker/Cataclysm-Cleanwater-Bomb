local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "cd_delight_strength_enhancement",
    name = ccb.content.text("Strength Enhancement"),
    description = ccb.content.text("Your strength has been enhanced.  Each intensity level increases strength by 10%."),
    rating = "good",
    maximum_intensity = 10,
    show_in_info = true,
    show_intensity = true,
}
    :enchantment("INLINE_ENCH_cd_delight_strength_enhancement_0"))

content.add(content.EffectType {
    id = "cd_delight_dexterity_enhancement",
    name = ccb.content.text("Dexterity Enhancement"),
    description = ccb.content.text("Your dexterity has been enhanced.  Each intensity level increases dexterity by 10%."),
    rating = "good",
    maximum_intensity = 10,
    show_in_info = true,
    show_intensity = true,
}
    :enchantment("INLINE_ENCH_cd_delight_dexterity_enhancement_0"))

content.add(content.EffectType {
    id = "cd_delight_perception_enhancement",
    name = ccb.content.text("Perception Enhancement"),
    description = ccb.content.text("Your perception has been enhanced.  Each intensity level increases perception by 10%."),
    rating = "good",
    maximum_intensity = 10,
    show_in_info = true,
    show_intensity = true,
}
    :enchantment("INLINE_ENCH_cd_delight_perception_enhancement_0"))

content.add(content.EffectType {
    id = "cd_delight_intelligence_enhancement",
    name = ccb.content.text("Intelligence Enhancement"),
    description = ccb.content.text("Your intelligence has been enhanced.  Each intensity level increases intelligence by 10%."),
    rating = "good",
    maximum_intensity = 10,
    show_in_info = true,
    show_intensity = true,
}
    :enchantment("INLINE_ENCH_cd_delight_intelligence_enhancement_0"))

content.add(content.EffectType {
    id = "cd_delight_detoxification",
    name = ccb.content.text("Detoxification"),
    description = ccb.content.text("You are flushing mutant toxins from your body.  Each intensity level reduces toxin by 15 points every 15 minutes."),
    rating = "good",
    maximum_intensity = 20,
    show_in_info = true,
    show_intensity = true,
})

content.add(content.EffectType {
    id = "cd_delight_focus_regen",
    name = ccb.content.text("Focus Regeneration"),
    description = ccb.content.text("Your mind is highly focused, and your focus regeneration speed is increased.  Each intensity level improves focus regeneration by 10%."),
    rating = "good",
    maximum_intensity = 10,
    show_in_info = true,
    show_intensity = true,
}
    :enchantment("INLINE_ENCH_cd_delight_focus_regen_0"))

content.add(content.EffectType {
    id = "cd_delight_satiety",
    name = ccb.content.text("Satiety"),
    description = ccb.content.text("You feel deeply satisfied, and your body's vitality is recovering quickly.  Each intensity level increases stamina regeneration by 10%."),
    rating = "good",
    maximum_intensity = 10,
    show_in_info = true,
    show_intensity = true,
}
    :enchantment("INLINE_ENCH_cd_delight_satiety_0"))

content.add(content.EffectType {
    id = "cd_delight_nourishment",
    name = ccb.content.text("Nourishment"),
    description = ccb.content.text("A soothing vitality flows through your body, accelerating healing of wounds and fatigue.  Each intensity level increases HP regeneration by 10%."),
    rating = "good",
    maximum_intensity = 10,
    show_in_info = true,
    show_intensity = true,
}
    :enchantment("INLINE_ENCH_cd_delight_nourishment_0"))
