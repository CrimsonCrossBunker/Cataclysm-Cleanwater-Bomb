local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "perk_dex_bonus",
    name = "",
    maximum_intensity = 6,
    maximum_duration_turns = 2,
    intensity_add_value = 1,
    intensity_decay_tick = 150,
}
    :name(ccb.content.text("Momentum Dex (1)"))
    :name(ccb.content.text("Momentum Dex (1)"))
    :name(ccb.content.text("Momentum Dex (2)"))
    :name(ccb.content.text("Momentum Dex (2)"))
    :name(ccb.content.text("Momentum Dex (3)"))
    :modifier("dexterity", "amount", { base = 0.5, per_intensity = 0.5 }))

content.add(content.EffectType {
    id = "perk_insight",
    name = ccb.content.text("Insight"),
    description = ccb.content.text("Each stack increases the damage of your weapon's main damage type by 1."),
    maximum_intensity = 200000,
    intensity_add_value = 1,
})

content.add(content.EffectType {
    id = "perk_blind_check",
    maximum_intensity = 15,
    intensity_add_value = 1,
})

content.add(content.EffectType {
    id = "perk_hit_marker",
    name = ccb.content.text("Hit (1)"),
    description = ccb.content.text("Each stack increases the damage of your weapon's main damage type by 1."),
    maximum_duration_turns = 2,
    maximum_intensity = 15,
    intensity_add_value = 1,
    show_in_info = true,
}
    :name(ccb.content.text("Hit (2)"))
    :name(ccb.content.text("Hit (3)"))
    :name(ccb.content.text("Hit (4)"))
    :name(ccb.content.text("Hit (5)"))
    :name(ccb.content.text("Hit (6)"))
    :name(ccb.content.text("Hit (7)"))
    :name(ccb.content.text("Hit (8)"))
    :name(ccb.content.text("Hit (9)"))
    :name(ccb.content.text("Hit (10)")))
