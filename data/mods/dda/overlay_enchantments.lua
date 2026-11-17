local ccb = require("ccb")
local content = ccb.content

-- data/json/mutations/mutations.json
ccb.runtime.handler("overlay_enchantment_active_inline_ench_interstice_resonance_2_0", function(ctx)
    return ctx.character_inputs.environment.dimension == "default"
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_INTERSTICE_RESONANCE_2_0",
    condition_handler = "overlay_enchantment_active_inline_ench_interstice_resonance_2_0",
    load_character_inputs = { environment = { dimension = true } },
    native_modifier_order = true,
}
    :value("ARTIFACT_RESONANCE", { add = 1250 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_INTERSTICE_RESONANCE_3_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("ARTIFACT_RESONANCE", { add = 1250 }))

ccb.runtime.handler("overlay_enchantment_active_inline_ench_arm_feathers_0", function(ctx)
    return not (ctx.character_inputs.traits["ARM_BIONIC_BASIC_LEFT"])
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_ARM_FEATHERS_0",
    condition_handler = "overlay_enchantment_active_inline_ench_arm_feathers_0",
    load_character_inputs = { traits = { "ARM_BIONIC_BASIC_LEFT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "arm_l")
    :bodypart_change("arm_feathers_l", ""))

ccb.runtime.handler("overlay_enchantment_active_inline_ench_gastropod_foot_1", function(ctx)
    return (not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_LEFT"]) and
        not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_RIGHT"]))
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_GASTROPOD_FOOT_1",
    condition_handler = "overlay_enchantment_active_inline_ench_gastropod_foot_1",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_LEFT", "BIONIC_LEG_BASIC_RIGHT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "leg_l")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("", "foot_l")
    :bodypart_change("gastropod_foot", ""))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_EYEBULGE_0",
    native_modifier_order = true,
}
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_bulging", ""))

-- data/json/mutations/mutations_limbs.json
ccb.runtime.handler("overlay_enchantment_active_inline_ench_wings_bird_0", function(ctx)
    return not (ctx.character_inputs.traits["ARM_BIONIC_BASIC_LEFT"])
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_WINGS_BIRD_0",
    condition_handler = "overlay_enchantment_active_inline_ench_wings_bird_0",
    load_character_inputs = { traits = { "ARM_BIONIC_BASIC_LEFT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("arm_wing_bird_l", ""))
