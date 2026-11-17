local ccb = require("ccb")
local content = ccb.content

-- data/json/effects_on_condition/medicine_eocs/learning_serum_eoc.json
ccb.runtime.handler("body_enchantment_active_inline_ench_learning_serum_main_2", function(ctx)
    return (((ctx.character_inputs.nearby_monsters["monsters_1"] + ctx.character_inputs.nearby_characters["characters_1"]) > 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_learning_serum_main_2",
    condition_handler = "body_enchantment_active_inline_ench_learning_serum_main_2",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "not_allies", radius = 35 }
        },
        nearby_monsters = {
            monsters_1 = { attitude = "hostile", radius = 35 }
        }
    },
    native_modifier_order = true,
}
    :every(7, { id = "learning_serum_time_slow_perception_spell" })
    :every(19, { id = "learning_serum_time_slow_perception_spell" }))

ccb.runtime.handler("body_enchantment_active_inline_ench_learning_serum_main_3", function(ctx)
    return (((ctx.character_inputs.nearby_monsters["monsters_1"] + ctx.character_inputs.nearby_characters["characters_1"]) > 0) and
        (ctx.character_inputs.effect_intensities["learning_serum_main"] >= 3))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_learning_serum_main_3",
    condition_handler = "body_enchantment_active_inline_ench_learning_serum_main_3",
    load_character_inputs = {
        effect_intensities = { "learning_serum_main" },
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "not_allies", radius = 35 }
        },
        nearby_monsters = {
            monsters_1 = { attitude = "hostile", radius = 35 }
        }
    },
    native_modifier_order = true,
}
    :every(13, { id = "learning_serum_time_slow_perception_spell" }))

-- data/json/mutations/mutations.json
ccb.runtime.handler("body_enchantment_active_inline_ench_vines2_1", function(ctx)
    return ((ctx.character_inputs.hit_points["vine_limb_upper_r"] > 15) and
        (ctx.character_inputs.hit_points["vine_limb_lower_r"] > 15))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VINES2_1",
    condition_handler = "body_enchantment_active_inline_ench_vines2_1",
    load_character_inputs = { hit_points = { "vine_limb_lower_r", "vine_limb_upper_r" } },
    native_modifier_order = true,
}
    :value("BONUS_BLOCK", { add = 1 }))

ccb.runtime.handler("body_enchantment_active_inline_ench_vines2_2", function(ctx)
    return ((ctx.character_inputs.hit_points["vine_limb_upper_l"] > 15) and
        (ctx.character_inputs.hit_points["vine_limb_lower_l"] > 15))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VINES2_2",
    condition_handler = "body_enchantment_active_inline_ench_vines2_2",
    load_character_inputs = { hit_points = { "vine_limb_lower_l", "vine_limb_upper_l" } },
    native_modifier_order = true,
}
    :value("BONUS_BLOCK", { add = 1 }))

-- data/json/mutations/mutations_limbs.json
ccb.runtime.handler("body_enchantment_active_inline_ench_wings_insect_active_0", function(ctx)
    return ((ctx.character_inputs.hit_points["wing_insect_l"] > 10) and
        (ctx.character_inputs.hit_points["wing_insect_r"] > 10))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WINGS_INSECT_active_0",
    condition_handler = "body_enchantment_active_inline_ench_wings_insect_active_0",
    load_character_inputs = { hit_points = { "wing_insect_l", "wing_insect_r" } },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = -0.25 })
    :effect("effect_insect_wings_muscle_veh_boost", 1))
