local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_demon_spider_speed",
    name = ccb.content.text("Flaming Speed"),
    description = ccb.content.text("Your speed is boosted enormously thanks to drinking those flames."),
    rating = "good",
    maximum_duration_turns = 30,
    show_in_info = true,
}
    :removes_effect("magic_slowed")
    :enchantment("INLINE_ENCH_effect_demon_spider_speed_0"))

content.add(content.EffectType {
    id = "effect_demon_spider_venom",
    name = ccb.content.text("Burning Venom"),
    description = ccb.content.text("Your veins are on fire."),
    rating = "bad",
    maximum_duration_turns = 43200,
    show_in_info = true,
}
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_trait("POISRESIST")
    :enchantment("INLINE_ENCH_effect_demon_spider_venom_0")
    :enchantment("INLINE_ENCH_effect_demon_spider_venom_1")
    :modifier("pain", "amount", { base = 2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 30 })
    :modifier("pain", "maximum_value", { base = 40 }))

content.add(content.EffectType {
    id = "effect_feral_animist_guardian_spirit",
    name = ccb.content.text("Guardian Spirit"),
    description = ccb.content.text("A spirit warns you that attacks are coming."),
    rating = "good",
    maximum_duration_turns = 43200,
    show_in_info = true,
}
    :modifier("dodge", "amount", { base = 3 }))

content.add(content.EffectType {
    id = "effect_feral_animist_inner_voice",
    name = ccb.content.text("Inner Voice"),
    description = ccb.content.text("You can talk with your soul."),
    rating = "good",
    maximum_duration_turns = 43200,
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_migo_nether_shield_monster",
    name = ccb.content.text("Nether Shell"),
    description = ccb.content.text("You are surrounded by a shield that blocks nether damage, and also a bit of bullet damage."),
    rating = "good",
    maximum_duration_turns = 43200,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_migo_nether_shield_monster_0")
    :modifier("dodge", "amount", { base = 1 }))

content.add(content.EffectType {
    id = "effect_migo_fleshwarper_block_healing",
    name = ccb.content.text("Writhing Flesh"),
    description = ccb.content.text("Your flesh twitches and wriggles unnaturally."),
    apply_message = ccb.content.text("Your flesh twitches and wriggles!"),
    remove_message = ccb.content.text("Your flesh finally settles down."),
    rating = "bad",
    maximum_duration_turns = 604800,
    show_in_info = true,
}
    :flag("BLOCK_SUPERNATURAL_HEALING")
    :enchantment("INLINE_ENCH_effect_migo_fleshwarper_block_healing_0"))

content.add(content.EffectType {
    id = "effect_migo_enhance_flesh_monster",
    name = ccb.content.text("Enhance Flesh"),
    description = ccb.content.text("Your speed and physical damage resistance are enhanced."),
    rating = "good",
    maximum_duration_turns = 43200,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_migo_enhance_flesh_monster_0")
    :enchantment("INLINE_ENCH_effect_migo_enhance_flesh_monster_1"))
