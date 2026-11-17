local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("inline_enchantment_effects_absorbed_electric", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["absorbed_electric"]
end)

ccb.runtime.handler("inline_enchantment_effects_absorbed_acidic", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["absorbed_acidic"]
end)

ccb.runtime.handler("inline_enchantment_learning_serum_main_1", function(ctx)
    local inputs = ctx.character_inputs
    return (not (inputs.worn_flags["SUN_GLASSES"]) and
        (inputs.environment.outside and
        inputs.environment.daylight))
end)

ccb.runtime.handler("inline_enchantment_not_daylight", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.environment.daylight)
end)

ccb.runtime.handler("inline_enchantment_super_soldier_serum_main_1", function(ctx)
    local inputs = ctx.character_inputs
    return not ((inputs.traits["SLOWHEALER"] or
        inputs.traits["SLOWHEALER2"] or
        inputs.traits["SLOWHEALER3"]))
end)

ccb.runtime.handler("inline_enchantment_traits_slowhealer", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["SLOWHEALER"]
end)

ccb.runtime.handler("inline_enchantment_traits_slowhealer2", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["SLOWHEALER2"]
end)

ccb.runtime.handler("inline_enchantment_traits_slowhealer3", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["SLOWHEALER3"]
end)

ccb.runtime.handler("inline_enchantment_not_effects_effect_tindalos_ignore_cancel", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.effects["effect_tindalos_ignore_cancel"])
end)

ccb.runtime.handler("inline_enchantment_divable", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.divable
end)

ccb.runtime.handler("inline_enchantment_not_armed", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.armed)
end)

ccb.runtime.handler("inline_enchantment_not_traits_arm_bionic_basic_right", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["ARM_BIONIC_BASIC_RIGHT"])
end)

ccb.runtime.handler("inline_enchantment_not_traits_arm_bionic_basic_left", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["ARM_BIONIC_BASIC_LEFT"])
end)

ccb.runtime.handler("inline_enchantment_legs_bat_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.move_mode == "crouch" and
        not ((inputs.armed and not inputs.wielded_flags.NO_UNWIELD)) and
        inputs.traits["WINGS_BAT"])
end)

ccb.runtime.handler("inline_enchantment_legs_bat_1", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.move_mode == "run" and
        not ((inputs.armed and not inputs.wielded_flags.NO_UNWIELD)) and
        inputs.traits["WINGS_BAT"])
end)

ccb.runtime.handler("inline_enchantment_not_traits_bionic_leg_basic_left", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["BIONIC_LEG_BASIC_LEFT"])
end)

ccb.runtime.handler("inline_enchantment_not_traits_bionic_leg_basic_right", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["BIONIC_LEG_BASIC_RIGHT"])
end)

ccb.runtime.handler("inline_enchantment_animal_feet_1", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.move_mode == "crouch" and
        not ((inputs.armed and not inputs.wielded_flags.NO_UNWIELD)) and
        inputs.character_flags["QUADRUPED_CROUCH"])
end)

-- data/json/effects.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_grown_of_fuse_1",
    condition_handler = "inline_enchantment_effects_absorbed_electric",
    load_character_inputs = { effects = { "absorbed_electric" } },
}
    :incoming_damage("electric", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_grown_of_fuse_2",
    condition_handler = "inline_enchantment_effects_absorbed_acidic",
    load_character_inputs = { effects = { "absorbed_acidic" } },
}
    :incoming_damage("acid", { multiply = -1 }))

-- data/json/effects_on_condition/medicine_eocs/learning_serum_eoc.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_learning_serum_main_1",
    condition_handler = "inline_enchantment_learning_serum_main_1",
    load_character_inputs = { environment = { daylight = true, outside = true }, worn_flags = { "SUN_GLASSES" } },
}
    :effect("learning_serum_light_pain", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_learning_serum_crash_1",
    condition_handler = "inline_enchantment_learning_serum_main_1",
    load_character_inputs = { environment = { daylight = true, outside = true }, worn_flags = { "SUN_GLASSES" } },
}
    :effect("learning_serum_light_pain", 1))

-- data/json/effects_on_condition/medicine_eocs/night_operations_serum.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_night_ops_serum_main_2",
    condition_handler = "inline_enchantment_not_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("OVERMAP_SIGHT", { add = 6 }))

-- data/json/effects_on_condition/medicine_eocs/super_soldier_serum_eoc.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_super_soldier_serum_main_1",
    condition_handler = "inline_enchantment_super_soldier_serum_main_1",
    load_character_inputs = { traits = { "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3" } },
}
    :value("REGEN_HP", { multiply = -0.9 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_super_soldier_serum_main_2",
    condition_handler = "inline_enchantment_traits_slowhealer",
    load_character_inputs = { traits = { "SLOWHEALER" } },
}
    :value("REGEN_HP", { multiply = -0.65 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_super_soldier_serum_main_3",
    condition_handler = "inline_enchantment_traits_slowhealer2",
    load_character_inputs = { traits = { "SLOWHEALER2" } },
}
    :value("REGEN_HP", { multiply = -0.23 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_super_soldier_serum_main_4",
    condition_handler = "inline_enchantment_traits_slowhealer3",
    load_character_inputs = { traits = { "SLOWHEALER3" } },
}
    :value("REGEN_HP", { multiply = -0.05 }))

-- data/json/items/relics/highland_censer.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_golden_incense_effect_0",
    condition_handler = "inline_enchantment_not_effects_effect_tindalos_ignore_cancel",
    load_character_inputs = { effects = { "effect_tindalos_ignore_cancel" } },
}
    :mutation("TINDALOS_IGNORE"))

-- data/json/mutations/mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_INTERSTICE_VISION_0",
    condition_handler = "inline_enchantment_not_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("OVERMAP_SIGHT", { add = 15 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_WATERSLEEPER_0",
    condition_handler = "inline_enchantment_divable",
    load_character_inputs = { environment = { divable = true } },
}
    :value("SLEEPY", { add = 40 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_NIGHT_RAIDER_0",
    condition_handler = "inline_enchantment_not_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("FOOTSTEP_NOISE", { multiply = -0.5 })
    :value("ATTACK_NOISE", { multiply = -0.2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_THORNS_0",
    condition_handler = "inline_enchantment_not_armed",
    load_character_inputs = { armed = true },
}
    :melee_damage("stab", { add = 2 }))

-- data/json/mutations/mutations_limbs.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_CRUSTACEAN_CLAW_0",
    condition_handler = "inline_enchantment_not_traits_arm_bionic_basic_right",
    load_character_inputs = { traits = { "ARM_BIONIC_BASIC_RIGHT" } },
}
    :bodypart_change("", "hand_r")
    :bodypart_change("crustacean_pincer_r", ""))

content.add(content.Enchantment {
    id = "INLINE_ENCH_WINGS_BAT_0",
    condition_handler = "inline_enchantment_not_traits_arm_bionic_basic_left",
    load_character_inputs = { traits = { "ARM_BIONIC_BASIC_LEFT" } },
}
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("arm_wing_bat_l", ""))

content.add(content.Enchantment {
    id = "INLINE_ENCH_WINGS_BAT_1",
    condition_handler = "inline_enchantment_not_traits_arm_bionic_basic_right",
    load_character_inputs = { traits = { "ARM_BIONIC_BASIC_RIGHT" } },
}
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("arm_wing_bat_r", ""))

content.add(content.Enchantment {
    id = "INLINE_ENCH_LEGS_BAT_0",
    condition_handler = "inline_enchantment_legs_bat_0",
    load_character_inputs = { armed = true, move_mode = true, traits = { "WINGS_BAT" }, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.58 })
    :value("FOOTSTEP_NOISE", { multiply = 0 })
    :effect("natural_stance", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_LEGS_BAT_1",
    condition_handler = "inline_enchantment_legs_bat_1",
    load_character_inputs = { armed = true, move_mode = true, traits = { "WINGS_BAT" }, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.2 })
    :value("FOOTSTEP_NOISE", { multiply = -0.6 })
    :effect("natural_stance", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_RABBIT_FEET_2",
    condition_handler = "inline_enchantment_not_traits_bionic_leg_basic_left",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_LEFT" } },
}
    :bodypart_change("", "foot_l")
    :bodypart_change("animal_paw_rabbit_l", ""))

content.add(content.Enchantment {
    id = "INLINE_ENCH_RABBIT_FEET_3",
    condition_handler = "inline_enchantment_not_traits_bionic_leg_basic_right",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_RIGHT" } },
}
    :bodypart_change("", "foot_r")
    :bodypart_change("animal_paw_rabbit_r", ""))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ANIMAL_FEET_1",
    condition_handler = "inline_enchantment_animal_feet_1",
    load_character_inputs = { armed = true, character_flags = { "QUADRUPED_CROUCH" }, move_mode = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.35 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ANIMAL_FEET_3",
    condition_handler = "inline_enchantment_not_traits_bionic_leg_basic_left",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_LEFT" } },
}
    :bodypart_change("", "foot_l")
    :bodypart_change("animal_paw_l", ""))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ANIMAL_FEET_4",
    condition_handler = "inline_enchantment_not_traits_bionic_leg_basic_right",
    load_character_inputs = { traits = { "BIONIC_LEG_BASIC_RIGHT" } },
}
    :bodypart_change("", "foot_r")
    :bodypart_change("animal_paw_r", ""))

-- data/json/mutations/mutations_skin.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_CHITIN2_0",
    condition_handler = "inline_enchantment_not_armed",
    load_character_inputs = { armed = true },
}
    :melee_damage("bash", { add = 2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_CHITIN3_0",
    condition_handler = "inline_enchantment_not_armed",
    load_character_inputs = { armed = true },
}
    :melee_damage("bash", { add = 4 }))
