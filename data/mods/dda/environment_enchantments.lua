local ccb = require("ccb")
local content = ccb.content

local function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

-- data/json/effects.json
ccb.runtime.handler("context_enchantment_inline_ench_nemesis_buff_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.global_variables["Nemesis_iteration"] * 0.01)
end)

ccb.runtime.handler("context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_0_add", function(ctx)
    return (ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1))
end)

ccb.runtime.handler("context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_1_add", function(ctx)
    return (ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1))
end)

ccb.runtime.handler("context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_2_add", function(ctx)
    return (ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1))
end)

ccb.runtime.handler("context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_3_add", function(ctx)
    return (ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_nemesis_buff_0", condition = "ALWAYS",
    load_character_inputs = { global_variables = { "Nemesis_iteration" } },
    native_modifier_order = true,
}
    :value("SPEED", { multiply_handler = "context_enchantment_inline_ench_nemesis_buff_0_value_0_multiply", load_skills = {  } })
    :incoming_damage("bash", { add_handler = "context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_0_add", load_skills = {  } })
    :incoming_damage("stab", { add_handler = "context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_1_add", load_skills = {  } })
    :incoming_damage("cut", { add_handler = "context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_2_add", load_skills = {  } })
    :incoming_damage("bullet", { add_handler = "context_enchantment_inline_ench_nemesis_buff_0_incoming_damage_3_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_hunting_horror_poison_0", function(ctx)
    return (ctx.character_inputs.fine_detail_vision <= 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_hunting_horror_poison_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_hunting_horror_poison_0",
    load_character_inputs = { fine_detail_vision = true },
    native_modifier_order = true,
}
    :effect("effect_hunting_horror_poison_light_sensitive", 1))

-- data/json/effects_on_condition/medicine_eocs/learning_serum_eoc.json
ccb.runtime.handler("context_enchantment_inline_ench_learning_serum_main_0_value_0_add", function(ctx)
    return (3 + math.min(ctx.character_inputs.effect_intensities["learning_serum_main"], 5))
end)

ccb.runtime.handler("context_enchantment_inline_ench_learning_serum_main_0_value_1_add", function(ctx)
    return ((ctx.character_inputs.physiology.focus < 60) and (60 - ctx.character_inputs.physiology.focus) or 0)
end)

ccb.runtime.handler("context_enchantment_inline_ench_learning_serum_main_0_value_2_multiply", function(ctx)
    return (0.5 + math.min((ctx.character_inputs.effect_intensities["learning_serum_main"] * 0.1), 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_learning_serum_main_0",
    load_character_inputs = { effect_intensities = { "learning_serum_main" }, physiology = true },
    native_modifier_order = true,
}
    :value("PERCEPTION", { add_handler = "context_enchantment_inline_ench_learning_serum_main_0_value_0_add", load_skills = {  } })
    :value("LEARNING_FOCUS", { add_handler = "context_enchantment_inline_ench_learning_serum_main_0_value_1_add", load_skills = {  } })
    :value("THEORETICAL_SKILL_CATCHUP_BONUS", { multiply_handler = "context_enchantment_inline_ench_learning_serum_main_0_value_2_multiply", load_skills = {  } })
    :value("READING_SPEED_MULTIPLIER", { multiply = -0.2 })
    :value("SLEEPY", { add = -1000 })
    :value("METABOLISM", { multiply = 0.2 }))

-- data/json/effects_on_condition/medicine_eocs/night_operations_serum.json
ccb.runtime.handler("context_enchantment_active_inline_ench_night_ops_serum_main_1", function(ctx)
    return (ctx.character_inputs.fine_detail_vision >= 4)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_night_ops_serum_main_1",
    condition_handler = "context_enchantment_active_inline_ench_night_ops_serum_main_1",
    load_character_inputs = { fine_detail_vision = true },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", { add = 50 }))

-- data/json/effects_on_condition/medicine_eocs/speed_serum_eoc.json
ccb.runtime.handler("context_enchantment_active_inline_ench_speed_serum_main_1", function(ctx)
    return (ctx.character_inputs.physiology.perceived_pain <= 40)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_speed_serum_main_1",
    condition_handler = "context_enchantment_active_inline_ench_speed_serum_main_1",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("BONUS_BLOCK", { add = 1 })
    :value("BONUS_DODGE", { add = 1 }))

-- data/json/effects_on_condition/medicine_eocs/super_soldier_serum_eoc.json
ccb.runtime.handler("context_enchantment_inline_ench_super_soldier_serum_main_0_value_11_add", function(ctx)
    return clamp(((ctx.character_inputs.physiology.focus - 15) * (-1)), (-200), 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_super_soldier_serum_main_0",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("STRENGTH", { add = 5 })
    :value("DEXTERITY", { add = 5 })
    :value("REGEN_STAMINA", { multiply = 2 })
    :value("PAIN", { multiply = -0.25 })
    :value("METABOLISM", { multiply = 0.4 })
    :value("PAIN_PENALTY_MOD_STR", { multiply = -0.6 })
    :value("PAIN_PENALTY_MOD_DEX", { multiply = -0.6 })
    :value("PAIN_PENALTY_MOD_INT", { multiply = -0.6 })
    :value("PAIN_PENALTY_MOD_PER", { multiply = -0.6 })
    :value("PAIN_PENALTY_MOD_SPEED", { multiply = -0.6 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.5 })
    :value("LEARNING_FOCUS", { add_handler = "context_enchantment_inline_ench_super_soldier_serum_main_0_value_11_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_inline_ench_super_soldier_serum_crash_0_value_7_add", function(ctx)
    return clamp(((ctx.character_inputs.physiology.focus - 15) * (-1)), (-200), 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_super_soldier_serum_crash_0",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { multiply = -0.5 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.5 })
    :value("PAIN_PENALTY_MOD_STR", { multiply = 1 })
    :value("PAIN_PENALTY_MOD_DEX", { multiply = 1 })
    :value("PAIN_PENALTY_MOD_INT", { multiply = 1 })
    :value("PAIN_PENALTY_MOD_PER", { multiply = 1 })
    :value("PAIN_PENALTY_MOD_SPEED", { multiply = 1 })
    :value("LEARNING_FOCUS", { add_handler = "context_enchantment_inline_ench_super_soldier_serum_crash_0_value_7_add", load_skills = {  } }))

-- data/json/mutations/mutations.json
ccb.runtime.handler("context_enchantment_active_inline_ench_eagleeyed_0", function(ctx)
    return ctx.character_inputs.environment.daylight
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_EAGLEEYED_0",
    condition_handler = "context_enchantment_active_inline_ench_eagleeyed_0",
    load_character_inputs = { environment = { daylight = true } },
    native_modifier_order = true,
}
    :value("OVERMAP_SIGHT", { add = 5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_arm_feathers_1", function(ctx)
    return not (ctx.character_inputs.traits["ARM_BIONIC_BASIC_RIGHT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARM_FEATHERS_1",
    condition_handler = "context_enchantment_active_inline_ench_arm_feathers_1",
    load_character_inputs = { traits = { "ARM_BIONIC_BASIC_RIGHT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "arm_r")
    :bodypart_change("arm_feathers_r", ""))

ccb.runtime.handler("context_enchantment_active_inline_ench_dirtsleeper_0", function(ctx)
    return (ctx.character_inputs.environment.position_z < 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DIRTSLEEPER_0",
    condition_handler = "context_enchantment_active_inline_ench_dirtsleeper_0",
    load_character_inputs = { environment = { position_z = true } },
    native_modifier_order = true,
}
    :value("SLEEPY", { add = 20 }))

ccb.runtime.handler("context_enchantment_inline_ench_biolum0_0_value_0_add", function(ctx)
    return ((ctx.character_inputs.physiology.hunger / 10) + math.max(ctx.character_inputs.morale, 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BIOLUM0_0",
    load_character_inputs = { morale = true, physiology = true },
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "context_enchantment_inline_ench_biolum0_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_active_inline_ench_tunnel_fighter_0", function(ctx)
    return (ctx.character_inputs.environment.position_z < 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_TUNNEL_FIGHTER_0",
    condition_handler = "context_enchantment_active_inline_ench_tunnel_fighter_0",
    load_character_inputs = { environment = { position_z = true } },
    native_modifier_order = true,
}
    :value("BONUS_BLOCK", { add = 1 })
    :value("BONUS_DODGE", { add = 1 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_vines3_1", function(ctx)
    return ((ctx.character_inputs.global_variables["vine_limb_upper_r"] > 15) and
        (ctx.character_inputs.global_variables["vine_limb_lower_r"] > 15))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VINES3_1",
    condition_handler = "context_enchantment_active_inline_ench_vines3_1",
    load_character_inputs = { global_variables = { "vine_limb_lower_r", "vine_limb_upper_r" } },
    native_modifier_order = true,
}
    :value("BONUS_BLOCK", { add = 1 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_vines3_2", function(ctx)
    return ((ctx.character_inputs.global_variables["vine_limb_upper_l"] > 15) and
        (ctx.character_inputs.global_variables["vine_limb_lower_l"] > 15))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VINES3_2",
    condition_handler = "context_enchantment_active_inline_ench_vines3_2",
    load_character_inputs = { global_variables = { "vine_limb_lower_l", "vine_limb_upper_l" } },
    native_modifier_order = true,
}
    :value("BONUS_BLOCK", { add = 1 }))

-- data/json/mutations/mutations_limbs.json
ccb.runtime.handler("context_enchantment_active_inline_ench_wings_bird_1", function(ctx)
    return not (ctx.character_inputs.traits["ARM_BIONIC_BASIC_RIGHT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WINGS_BIRD_1",
    condition_handler = "context_enchantment_active_inline_ench_wings_bird_1",
    load_character_inputs = { traits = { "ARM_BIONIC_BASIC_RIGHT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("arm_wing_bird_r", ""))

ccb.runtime.handler("context_enchantment_active_inline_ench_hooves_0", function(ctx)
    return not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_LEFT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOOVES_0",
    condition_handler = "context_enchantment_active_inline_ench_hooves_0",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_LEFT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "foot_l")
    :bodypart_change("hoof_l", ""))

ccb.runtime.handler("context_enchantment_active_inline_ench_hooves_1", function(ctx)
    return not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_RIGHT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOOVES_1",
    condition_handler = "context_enchantment_active_inline_ench_hooves_1",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_RIGHT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "foot_r")
    :bodypart_change("hoof_r", ""))

ccb.runtime.handler("context_enchantment_active_inline_ench_bird_legs_0", function(ctx)
    return not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_LEFT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BIRD_LEGS_0",
    condition_handler = "context_enchantment_active_inline_ench_bird_legs_0",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_LEFT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "foot_l")
    :bodypart_change("avian_talon_l", ""))

ccb.runtime.handler("context_enchantment_active_inline_ench_bird_legs_1", function(ctx)
    return not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_RIGHT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BIRD_LEGS_1",
    condition_handler = "context_enchantment_active_inline_ench_bird_legs_1",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_RIGHT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "foot_r")
    :bodypart_change("avian_talon_r", ""))

ccb.runtime.handler("context_enchantment_active_inline_ench_leg_tentacles_0", function(ctx)
    return not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_LEFT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LEG_TENTACLES_0",
    condition_handler = "context_enchantment_active_inline_ench_leg_tentacles_0",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_LEFT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "foot_l")
    :bodypart_change("", "leg_l")
    :bodypart_change("tentacle_lower_front_l", "")
    :bodypart_change("tentacle_lower_middle_l", "")
    :bodypart_change("tentacle_lower_rear_l", ""))

ccb.runtime.handler("context_enchantment_active_inline_ench_leg_tentacles_1", function(ctx)
    return not (ctx.character_inputs.traits["BIONIC_LEG_BASIC_RIGHT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LEG_TENTACLES_1",
    condition_handler = "context_enchantment_active_inline_ench_leg_tentacles_1",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_RIGHT" } },
    native_modifier_order = true,
}
    :bodypart_change("", "foot_r")
    :bodypart_change("", "leg_r")
    :bodypart_change("tentacle_lower_front_r", "")
    :bodypart_change("tentacle_lower_middle_r", "")
    :bodypart_change("tentacle_lower_rear_r", ""))
