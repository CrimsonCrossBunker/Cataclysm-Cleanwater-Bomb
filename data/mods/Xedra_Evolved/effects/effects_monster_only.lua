local ccb = require("ccb")
local content = ccb.content

-- No enchantment to actually increase monsters' damage so we have to use this as a condition for an attack
content.add(content.EffectType {
    id = "effect_vampire_monster_strength",
    name = ccb.content.text("Vigor Mortis"),
    description = "",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_vampire_monster_agility",
    name = ccb.content.text("Flow Like Blood"),
    description = "",
    show_in_info = true,
}
    :modifier("dodge", "amount", { base = 3 })
    :modifier("hit", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_vampire_monster_resilience",
    name = ccb.content.text("Sanguine Resilience"),
    description = "",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_vampire_monster_resilience_0"))

content.add(content.EffectType {
    id = "effect_vampire_monster_speed",
    name = ccb.content.text("Blood-Driven Speed"),
    description = "",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_vampire_monster_speed_0"))

content.add(content.EffectType {
    id = "effect_werewolf_lunar_renewal_monster",
    name = ccb.content.text("Gift of Lunar Renewal"),
    description = "",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_werewolf_red_handed_rage_monster",
    name = ccb.content.text("Red-Handed Rage"),
    description = "",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_monster_viridian_cuirass",
    name = ccb.content.text("Viridian Cuirass"),
    description = "",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_viridian_cuirass_0")
    :enchantment("INLINE_ENCH_effect_monster_viridian_cuirass_1"))

content.add(content.EffectType {
    id = "effect_monster_swirl_of_autumn_leaves",
    name = ccb.content.text("Swirl of Autumn Leaves"),
    description = "",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_swirl_of_autumn_leaves_0"))

content.add(content.EffectType {
    id = "effect_monster_a_fire_in_the_blood",
    name = ccb.content.text("A Fire in the Blood"),
    description = "",
    show_in_info = true,
}
    :modifier("dodge", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_xe_feral_dreamer_dream_dagger",
    name = ccb.content.text("Dream Dagger"),
    description = "",
    show_in_info = true,
})
