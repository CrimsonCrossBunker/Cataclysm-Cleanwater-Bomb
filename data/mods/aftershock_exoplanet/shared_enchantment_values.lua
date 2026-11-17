local ccb = require("ccb")
local content = ccb.content

-- effects_esper.json
ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_danger_sense_0_value_0_add", function(ctx)
    return math.max((3 + ((ctx.spell_levels["afs_precog_danger_sense"] * 0.5) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))), 25)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_precog_danger_sense_0",
    native_modifier_order = true,
}
    :value("MOTION_ALARM", { add_handler = "shared_enchantment_inline_ench_effect_afs_precog_danger_sense_0_value_0_add", load_skills = {  }, load_spell_levels = { "afs_precog_danger_sense" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_ranged_enhance_0_value_0_add", function(ctx)
    return (1 + ((ctx.spell_levels["afs_precog_ranged_enhance"] * 0.25) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_ranged_enhance_0_value_1_multiply", function(ctx)
    return math.max(((ctx.spell_levels["afs_precog_ranged_enhance"] * (-0.025)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)), (-0.6))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_precog_ranged_enhance_0",
    native_modifier_order = true,
}
    :value("RANGE", { add_handler = "shared_enchantment_inline_ench_effect_afs_precog_ranged_enhance_0_value_0_add", load_skills = {  }, load_spell_levels = { "afs_precog_ranged_enhance" } })
    :value("WEAPON_DISPERSION", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_precog_ranged_enhance_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "afs_precog_ranged_enhance" } })
    :value("MOVE_COST", { multiply = 0.1 })
    :value("DODGE_CHANCE", { add = -3 }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_craft_bonus_0_value_1_multiply", function(ctx)
    return (0.04 + ((ctx.spell_levels["afs_precog_craft_bonus"] * 0.01) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_precog_craft_bonus_0",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = 3 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_precog_craft_bonus_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "afs_precog_craft_bonus" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_dodge_bonus_0_value_0_add", function(ctx)
    return math.min((0.25 + ((ctx.spell_levels["afs_precog_dodge_bonus"] * 0.015) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))), 0.7)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_dodge_bonus_0_value_1_add", function(ctx)
    return math.min(((ctx.spell_levels["afs_precog_dodge_bonus"] * 0.5) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)), 10)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_precog_dodge_bonus_0",
    native_modifier_order = true,
}
    :value("RANGE_DODGE", { add_handler = "shared_enchantment_inline_ench_effect_afs_precog_dodge_bonus_0_value_0_add", load_skills = {  }, load_spell_levels = { "afs_precog_dodge_bonus" } })
    :value("DODGE_CHANCE", { add_handler = "shared_enchantment_inline_ench_effect_afs_precog_dodge_bonus_0_value_1_add", load_skills = {  }, load_spell_levels = { "afs_precog_dodge_bonus" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_melee_enhance_0_value_0_add", function(ctx)
    return (1 + ((ctx.spell_levels["afs_precog_ranged_enhance"] * 0.25) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_melee_enhance_0_value_1_add", function(ctx)
    return (1 + ((ctx.spell_levels["afs_precog_ranged_enhance"] * 0.25) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_precog_melee_enhance_0_value_2_add", function(ctx)
    return (0.1 + ((ctx.spell_levels["afs_precog_ranged_enhance"] * 0.05) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_precog_melee_enhance_0",
    native_modifier_order = true,
}
    :value("MELEE_TO_HIT", { add_handler = "shared_enchantment_inline_ench_effect_afs_precog_melee_enhance_0_value_0_add", load_skills = {  }, load_spell_levels = { "afs_precog_ranged_enhance" } })
    :value("DODGE_CHANCE", { add_handler = "shared_enchantment_inline_ench_effect_afs_precog_melee_enhance_0_value_1_add", load_skills = {  }, load_spell_levels = { "afs_precog_ranged_enhance" } })
    :value("MELEE_DAMAGE", { add_handler = "shared_enchantment_inline_ench_effect_afs_precog_melee_enhance_0_value_2_add", load_skills = {  }, load_spell_levels = { "afs_precog_ranged_enhance" } })
    :value("FREE_DODGES", { add = 1 })
    :value("BONUS_DODGE", { add = 1 }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_value_0_multiply", function(ctx)
    return math.max(((ctx.spell_levels["afs_telekinetic_momentum"] * (-0.005)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)), (-0.15))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_value_1_multiply", function(ctx)
    return ((ctx.spell_levels["afs_telekinetic_momentum"] * (-0.01)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_0_multiply", function(ctx)
    return ((ctx.spell_levels["afs_telekinetic_momentum"] * (-0.01)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_1_multiply", function(ctx)
    return ((ctx.spell_levels["afs_telekinetic_momentum"] * (-0.005)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_2_multiply", function(ctx)
    return ((ctx.spell_levels["afs_telekinetic_momentum"] * (-0.005)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_3_multiply", function(ctx)
    return ((ctx.spell_levels["afs_telekinetic_momentum"] * (-0.02)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_telekinetic_momentum_0",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "afs_telekinetic_momentum" } })
    :value("ATTACK_SPEED", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "afs_telekinetic_momentum" } })
    :incoming_damage("bash", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_0_multiply", load_skills = {  }, load_spell_levels = { "afs_telekinetic_momentum" } })
    :incoming_damage("stab", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_1_multiply", load_skills = {  }, load_spell_levels = { "afs_telekinetic_momentum" } })
    :incoming_damage("cut", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_2_multiply", load_skills = {  }, load_spell_levels = { "afs_telekinetic_momentum" } })
    :incoming_damage("bullet", { multiply_handler = "shared_enchantment_inline_ench_effect_afs_telekinetic_momentum_0_incoming_damage_3_multiply", load_skills = {  }, load_spell_levels = { "afs_telekinetic_momentum" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telepathic_suggestion_0_value_0_add", function(ctx)
    return (((ctx.spell_levels["afs_telepathic_suggestion"] * 2.5) + 3) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telepathic_suggestion_0_value_1_add", function(ctx)
    return (((ctx.spell_levels["afs_telepathic_suggestion"] * 2.5) + 3) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_afs_telepathic_suggestion_0_value_2_add", function(ctx)
    return (((ctx.spell_levels["afs_telepathic_suggestion"] * 2.5) + 3) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_telepathic_suggestion_0",
    native_modifier_order = true,
}
    :value("SOCIAL_INTIMIDATE", { add_handler = "shared_enchantment_inline_ench_effect_afs_telepathic_suggestion_0_value_0_add", load_skills = {  }, load_spell_levels = { "afs_telepathic_suggestion" } })
    :value("SOCIAL_LIE", { add_handler = "shared_enchantment_inline_ench_effect_afs_telepathic_suggestion_0_value_1_add", load_skills = {  }, load_spell_levels = { "afs_telepathic_suggestion" } })
    :value("SOCIAL_PERSUADE", { add_handler = "shared_enchantment_inline_ench_effect_afs_telepathic_suggestion_0_value_2_add", load_skills = {  }, load_spell_levels = { "afs_telepathic_suggestion" } }))
