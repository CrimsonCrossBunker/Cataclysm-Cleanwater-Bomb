local ccb = require("ccb")
local content = ccb.content

-- mutations/mutations.json
content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_EYEBULGE_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_bulging", ""))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_GASTROPOD_FOOT_1",
    native_modifier_order = true,
}
    :value("FOOTSTEP_NOISE", { multiply = -0.75 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_ARM_FEATHERS_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :bodypart_change("", "arm_l")
    :bodypart_change("", "arm_r")
    :bodypart_change("arm_feathers_l", "")
    :bodypart_change("arm_feathers_r", ""))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_WINGS_BIRD_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :bodypart_change("", "arm_l")
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("", "hand_l")
    :bodypart_change("arm_wing_bird_l", "")
    :bodypart_change("arm_wing_bird_r", ""))
