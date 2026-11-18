local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_leg_l_fake_blocker",
    name = "",
    description = "",
}
    :blocks_effect("bite")
    :blocks_effect("poison")
    :blocks_effect("badpoison")
    :blocks_effect("paralyzepoison")
    :blocks_effect("frostbite")
    :blocks_effect("paincysts")
    :blocks_effect("spores")
    :blocks_effect("venom_dmg")
    :blocks_effect("venom_pain")
    :blocks_effect("venom_weaken"))

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_leg_r_fake_blocker",
    name = "",
    description = "",
}
    :blocks_effect("bite")
    :blocks_effect("poison")
    :blocks_effect("badpoison")
    :blocks_effect("paralyzepoison")
    :blocks_effect("frostbite")
    :blocks_effect("paincysts")
    :blocks_effect("spores")
    :blocks_effect("venom_dmg")
    :blocks_effect("venom_pain")
    :blocks_effect("venom_weaken"))

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_arm_l_fake_blocker",
    name = "",
    description = "",
}
    :blocks_effect("bite")
    :blocks_effect("poison")
    :blocks_effect("badpoison")
    :blocks_effect("paralyzepoison")
    :blocks_effect("frostbite")
    :blocks_effect("paincysts")
    :blocks_effect("spores")
    :blocks_effect("shakes")
    :blocks_effect("venom_dmg")
    :blocks_effect("venom_pain")
    :blocks_effect("venom_weaken"))

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_arm_r_fake_blocker",
    name = "",
    description = "",
}
    :blocks_effect("bite")
    :blocks_effect("poison")
    :blocks_effect("badpoison")
    :blocks_effect("paralyzepoison")
    :blocks_effect("frostbite")
    :blocks_effect("paincysts")
    :blocks_effect("spores")
    :blocks_effect("shakes")
    :blocks_effect("venom_dmg")
    :blocks_effect("venom_pain")
    :blocks_effect("venom_weaken"))
