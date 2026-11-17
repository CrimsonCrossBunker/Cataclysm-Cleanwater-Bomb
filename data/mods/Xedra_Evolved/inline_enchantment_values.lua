local ccb = require("ccb")
local content = ccb.content

local random = ccb.services.random

-- effects/effects.json
ccb.runtime.handler("inline_value_inline_ench_foxfire_imbibed_0_value_0_add", function(ctx)
    return (ctx.character_inputs.effect_intensities["foxfire_imbibed"] * 50)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_foxfire_imbibed_0",
    load_character_inputs = { effect_intensities = { "foxfire_imbibed" } },
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "inline_value_inline_ench_foxfire_imbibed_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_eyegleam_1_value_0_add", function(ctx)
    return (((4 + (ctx.character_inputs.traits["VAMPIRE2"] and 1 or 0)) + (ctx.character_inputs.traits["VAMPIRE3"] and 1 or 0)) + ((ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0) * 2))
end)

ccb.runtime.handler("inline_active_inline_ench_eyegleam_1", function(ctx)
    return not (ctx.character_inputs.environment.daylight)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_eyegleam_1",
    condition_handler = "inline_active_inline_ench_eyegleam_1",
    load_character_inputs = { environment = { daylight = true }, traits = { "VAMPIRE2", "VAMPIRE3", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("OVERMAP_SIGHT", { add_handler = "inline_value_inline_ench_eyegleam_1_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_vampire_stamina_for_blood_cardio_bonus_0_value_0_multiply", function(ctx)
    return (0.15 * ctx.character_inputs.effect_intensities["effect_vampire_stamina_for_blood_cardio_bonus"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampire_stamina_for_blood_cardio_bonus_0",
    load_character_inputs = { effect_intensities = { "effect_vampire_stamina_for_blood_cardio_bonus" } },
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", { multiply_handler = "inline_value_inline_ench_effect_vampire_stamina_for_blood_cardio_bonus_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_vampire_drank_blood_power_boost_0_value_0_add", function(ctx)
    return ((2 + (ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0)) + (ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_vampire_drank_blood_power_boost_0_value_1_add", function(ctx)
    return ((2 + (ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0)) + (ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampire_drank_blood_power_boost_0",
    load_character_inputs = { traits = { "BLOOD_DRINKER", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_effect_vampire_drank_blood_power_boost_0_value_0_add", load_skills = {  } })
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_effect_vampire_drank_blood_power_boost_0_value_1_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_vampire_drank_blood_power_boost_1_value_0_add", function(ctx)
    return ((2 + (ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0)) + (ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_vampire_drank_blood_power_boost_1_value_1_add", function(ctx)
    return ((2 + (ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0)) + (ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0))
end)

ccb.runtime.handler("inline_active_inline_ench_effect_vampire_drank_blood_power_boost_1", function(ctx)
    return ctx.character_inputs.traits["VAMPIRE_BLOOD_TEMPORARY_BOOST_REFINEMENT_MIND_BOOST"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampire_drank_blood_power_boost_1",
    condition_handler = "inline_active_inline_ench_effect_vampire_drank_blood_power_boost_1",
    load_character_inputs = { traits = { "BLOOD_DRINKER", "VAMPIRE4", "VAMPIRE_BLOOD_TEMPORARY_BOOST_REFINEMENT_MIND_BOOST" } },
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add_handler = "inline_value_inline_ench_effect_vampire_drank_blood_power_boost_1_value_0_add", load_skills = {  } })
    :value("PERCEPTION", { add_handler = "inline_value_inline_ench_effect_vampire_drank_blood_power_boost_1_value_1_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_spell_stamina_eff_0_value_0_multiply", function(ctx)
    return (ctx.spell_levels["spell_stamina_wonder"] / 5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_spell_stamina_eff_0",
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { multiply_handler = "inline_value_inline_ench_spell_stamina_eff_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "spell_stamina_wonder" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_dodge_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["spell_dodge"] / 6) + 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_dodge_0",
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "inline_value_inline_ench_effect_dodge_0_value_0_add", load_skills = {  }, load_spell_levels = { "spell_dodge" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_endurance_0_value_0_add", function(ctx)
    return ((-1) * ctx.spell_levels["spell_endurance"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_endurance_0",
    native_modifier_order = true,
}
    :value("ARMOR_ALL", { add_handler = "inline_value_inline_ench_effect_endurance_0_value_0_add", load_skills = {  }, load_spell_levels = { "spell_endurance" } }))

ccb.runtime.handler("inline_value_inline_ench_spell_melee_damage_0_value_0_add", function(ctx)
    return (ctx.spell_levels["spell_melee_damage"] * (-2))
end)

ccb.runtime.handler("inline_value_inline_ench_spell_melee_damage_0_value_1_add", function(ctx)
    return (ctx.spell_levels["spell_melee_damage"] / 10)
end)

ccb.runtime.handler("inline_value_inline_ench_spell_melee_damage_0_value_2_multiply", function(ctx)
    return (ctx.spell_levels["spell_melee_damage"] / 20)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_spell_melee_damage_0",
    native_modifier_order = true,
}
    :value("ATTACK_SPEED", { add_handler = "inline_value_inline_ench_spell_melee_damage_0_value_0_add", load_skills = {  }, load_spell_levels = { "spell_melee_damage" } })
    :value("BONUS_DODGE", { add_handler = "inline_value_inline_ench_spell_melee_damage_0_value_1_add", load_skills = {  }, load_spell_levels = { "spell_melee_damage" } })
    :value("MELEE_DAMAGE", { multiply_handler = "inline_value_inline_ench_spell_melee_damage_0_value_2_multiply", load_skills = {  }, load_spell_levels = { "spell_melee_damage" } }))

ccb.runtime.handler("inline_value_inline_ench_spell_speed_eff_0_value_0_add", function(ctx)
    return (ctx.spell_levels["spell_speed_wonder"] * 5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_spell_speed_eff_0",
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "inline_value_inline_ench_spell_speed_eff_0_value_0_add", load_skills = {  }, load_spell_levels = { "spell_speed_wonder" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_weakening_0_value_0_add", function(ctx)
    return (10 * ctx.spell_levels["spell_weak"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_weakening_0",
    native_modifier_order = true,
}
    :value("ARMOR_ALL", { add_handler = "inline_value_inline_ench_effect_weakening_0_value_0_add", load_skills = {  }, load_spell_levels = { "spell_weak" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_broke_fae_ban_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_max_mana_penalty"] * (-0.04))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_broke_fae_ban_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_max_mana_penalty"] * (-0.1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_broke_fae_ban_0",
    load_character_inputs = { effect_intensities = { "effect_max_mana_penalty" } },
    native_modifier_order = true,
}
    :value("REGEN_MANA", { multiply_handler = "inline_value_inline_ench_effect_broke_fae_ban_0_value_0_multiply", load_skills = {  } })
    :value("MAX_MANA", { multiply_handler = "inline_value_inline_ench_effect_broke_fae_ban_0_value_1_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_skinchanged_penalties_0_value_0_add", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_skinchanged_penalties"] * (-1))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_skinchanged_penalties_0_value_1_add", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_skinchanged_penalties"] * 0.33)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_skinchanged_penalties_0_value_2_multiply", function(ctx)
    return math.max(((ctx.character_inputs.effect_intensities["effect_skinchanged_penalties"] - 3) * 0.8), 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_skinchanged_penalties_0",
    load_character_inputs = { effect_intensities = { "effect_skinchanged_penalties" } },
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add_handler = "inline_value_inline_ench_effect_skinchanged_penalties_0_value_0_add", load_skills = {  } })
    :value("PERCEPTION", { add_handler = "inline_value_inline_ench_effect_skinchanged_penalties_0_value_1_add", load_skills = {  } })
    :value("SKILL_RUST_RESIST", { multiply_handler = "inline_value_inline_ench_effect_skinchanged_penalties_0_value_2_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_0_add", function(ctx)
    return (1 + ((ctx.character_inputs.character_variables["glamoured_changeling_noble_traits"] * 0.08) + (ctx.character_inputs.character_variables["glamoured_deduction_movement_buff"] * 0.25)))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_1_add", function(ctx)
    return (1 + ((ctx.character_inputs.character_variables["glamoured_changeling_noble_traits"] * 0.05) + (ctx.character_inputs.character_variables["glamoured_deduction_movement_buff"] * 0.2)))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_2_add", function(ctx)
    return (1 + ((ctx.character_inputs.character_variables["glamoured_changeling_noble_traits"] * 0.07) + (ctx.character_inputs.character_variables["glamoured_deduction_movement_buff"] * 0.35)))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_3_add", function(ctx)
    return math.min((0.33 + ((ctx.character_inputs.character_variables["glamoured_changeling_noble_traits"] * 0.005) + (ctx.character_inputs.character_variables["glamoured_deduction_movement_buff"] * 0.02))), 0.98)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_4_multiply", function(ctx)
    return ((-0.1) - ((ctx.character_inputs.character_variables["glamoured_changeling_noble_traits"] * 0.0015) - (ctx.character_inputs.character_variables["glamoured_deduction_movement_buff"] * 0.015)))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_5_multiply", function(ctx)
    return ((-0.1) - ((ctx.character_inputs.character_variables["glamoured_changeling_noble_traits"] * 0.0015) - (ctx.character_inputs.character_variables["glamoured_deduction_movement_buff"] * 0.015)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_noble_movement_buffs_ally_0",
    load_character_inputs = { character_variables = { "glamoured_changeling_noble_traits", "glamoured_deduction_movement_buff" } },
    native_modifier_order = true,
}
    :value("DODGE_CHANCE", { add_handler = "inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_0_add", load_skills = {  } })
    :value("BONUS_DODGE", { add_handler = "inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_1_add", load_skills = {  } })
    :value("THROW_STR", { add_handler = "inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_2_add", load_skills = {  } })
    :value("RANGE_DODGE", { add_handler = "inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_3_add", load_skills = {  } })
    :value("MOVE_COST", { multiply_handler = "inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_4_multiply", load_skills = {  } })
    :value("ATTACK_SPEED", { multiply_handler = "inline_value_inline_ench_effect_changeling_noble_movement_buffs_ally_0_value_5_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_no_ruach_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_lilin_no_ruach"] * 0.05)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_no_ruach_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_lilin_no_ruach"] * 0.05)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_no_ruach_0_value_2_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_lilin_no_ruach"] * 0.05)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_no_ruach_0_value_3_multiply", function(ctx)
    return math.max((ctx.character_inputs.effect_intensities["effect_lilin_no_ruach"] * (-0.04)), (-1))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_no_ruach_0_value_4_multiply", function(ctx)
    return math.max((ctx.character_inputs.effect_intensities["effect_lilin_no_ruach"] * (-0.04)), (-0.95))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_no_ruach_0_value_5_multiply", function(ctx)
    return math.max((ctx.character_inputs.effect_intensities["effect_lilin_no_ruach"] * (-0.04)), (-0.95))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_no_ruach_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "effect_lilin_no_ruach" } },
    native_modifier_order = true,
}
    :value("HUNGER", { multiply_handler = "inline_value_inline_ench_effect_lilin_no_ruach_0_value_0_multiply", load_skills = {  } })
    :value("THIRST", { multiply_handler = "inline_value_inline_ench_effect_lilin_no_ruach_0_value_1_multiply", load_skills = {  } })
    :value("SLEEPINESS", { multiply_handler = "inline_value_inline_ench_effect_lilin_no_ruach_0_value_2_multiply", load_skills = {  } })
    :value("REGEN_HP", { multiply_handler = "inline_value_inline_ench_effect_lilin_no_ruach_0_value_3_multiply", load_skills = {  } })
    :value("REGEN_STAMINA", { multiply_handler = "inline_value_inline_ench_effect_lilin_no_ruach_0_value_4_multiply", load_skills = {  } })
    :value("REGEN_MANA", { multiply_handler = "inline_value_inline_ench_effect_lilin_no_ruach_0_value_5_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_attribute_bonuses_0_value_0_add", function(ctx)
    return ((((1 + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_STRENGTH"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_DEXTERITY"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_PERCEPTION"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["THRESH_LILIN"] and 1 or 0) * 2))
end)

ccb.runtime.handler("inline_active_inline_ench_effect_lilin_attribute_bonuses_0", function(ctx)
    return ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_STRENGTH"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_attribute_bonuses_0",
    condition_handler = "inline_active_inline_ench_effect_lilin_attribute_bonuses_0",
    load_character_inputs = { traits = { "LILIN_ATTRIBUTE_BONUSES_DEXTERITY", "LILIN_ATTRIBUTE_BONUSES_PERCEPTION", "LILIN_ATTRIBUTE_BONUSES_STRENGTH", "THRESH_LILIN" } },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_effect_lilin_attribute_bonuses_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_attribute_bonuses_1_value_0_add", function(ctx)
    return ((((1 + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_STRENGTH"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_DEXTERITY"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_PERCEPTION"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["THRESH_LILIN"] and 1 or 0) * 2))
end)

ccb.runtime.handler("inline_active_inline_ench_effect_lilin_attribute_bonuses_1", function(ctx)
    return ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_DEXTERITY"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_attribute_bonuses_1",
    condition_handler = "inline_active_inline_ench_effect_lilin_attribute_bonuses_1",
    load_character_inputs = { traits = { "LILIN_ATTRIBUTE_BONUSES_DEXTERITY", "LILIN_ATTRIBUTE_BONUSES_PERCEPTION", "LILIN_ATTRIBUTE_BONUSES_STRENGTH", "THRESH_LILIN" } },
    native_modifier_order = true,
}
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_effect_lilin_attribute_bonuses_1_value_0_add", load_skills = {  } })
    :value("BONUS_DODGE", { add = 1 }))

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_attribute_bonuses_2_value_0_add", function(ctx)
    return ((((1 + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_STRENGTH"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_DEXTERITY"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_PERCEPTION"] and 1 or 0) * 1)) + ((ctx.character_inputs.traits["THRESH_LILIN"] and 1 or 0) * 2))
end)

ccb.runtime.handler("inline_active_inline_ench_effect_lilin_attribute_bonuses_2", function(ctx)
    return ctx.character_inputs.traits["LILIN_ATTRIBUTE_BONUSES_PERCEPTION"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_attribute_bonuses_2",
    condition_handler = "inline_active_inline_ench_effect_lilin_attribute_bonuses_2",
    load_character_inputs = { traits = { "LILIN_ATTRIBUTE_BONUSES_DEXTERITY", "LILIN_ATTRIBUTE_BONUSES_PERCEPTION", "LILIN_ATTRIBUTE_BONUSES_STRENGTH", "THRESH_LILIN" } },
    native_modifier_order = true,
}
    :value("PERCEPTION", { add_handler = "inline_value_inline_ench_effect_lilin_attribute_bonuses_2_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_speed_boost_0_value_2_add", function(ctx)
    return (2 + ((ctx.character_inputs.traits["THRESH_LILIN"] and 1 or 0) * 2))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_lilin_speed_boost_0_value_3_add", function(ctx)
    return (0.25 + ((ctx.character_inputs.traits["THRESH_LILIN"] and 1 or 0) * 0.25))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_speed_boost_0",
    load_character_inputs = { traits = { "THRESH_LILIN" } },
    native_modifier_order = true,
}
    :value("ATTACK_SPEED", { multiply = -0.66 })
    :value("BONUS_DODGE", { add = 1 })
    :value("DODGE_CHANCE", { add_handler = "inline_value_inline_ench_effect_lilin_speed_boost_0_value_2_add", load_skills = {  } })
    :value("RANGE_DODGE", { add_handler = "inline_value_inline_ench_effect_lilin_speed_boost_0_value_3_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_xedra_chronomancer_destabilizing_strikes_1_value_0_add", function(ctx)
    return (-math.max((1000 - (25 * ctx.spell_levels["xedra_chronomancer_destabilizing_strikes"])), 250))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xedra_chronomancer_destabilizing_strikes_1",
    native_modifier_order = true,
}
    :value("MAX_MANA", { add_handler = "inline_value_inline_ench_effect_xedra_chronomancer_destabilizing_strikes_1_value_0_add", load_skills = {  }, load_spell_levels = { "xedra_chronomancer_destabilizing_strikes" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_xedra_chronomancer_stabilize_timeline_0_value_0_add", function(ctx)
    return (-math.max((500 - (12.5 * ctx.spell_levels["xedra_chronomancer_stabilize_timeline"])), 125))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xedra_chronomancer_stabilize_timeline_0",
    native_modifier_order = true,
}
    :value("MAX_MANA", { add_handler = "inline_value_inline_ench_effect_xedra_chronomancer_stabilize_timeline_0_value_0_add", load_skills = {  }, load_spell_levels = { "xedra_chronomancer_stabilize_timeline" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_xedra_chronomancer_reverse_entropy_0_value_0_add", function(ctx)
    return (-math.max((1000 - (25 * ctx.spell_levels["xedra_chronomancer_reverse_entropy"])), 250))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xedra_chronomancer_reverse_entropy_0",
    native_modifier_order = true,
}
    :value("MAX_MANA", { add_handler = "inline_value_inline_ench_effect_xedra_chronomancer_reverse_entropy_0_value_0_add", load_skills = {  }, load_spell_levels = { "xedra_chronomancer_reverse_entropy" } }))

-- effects/effects_changeling_seasonal_magic.json
ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_protect_from_hot_weather_1_value_0_add", function(ctx)
    return ((10 + (ctx.character_inputs.character_variables["summer_spell_count"] * 2)) + (ctx.character_inputs.character_variables["gramarye_for_spells"] * 4))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_protect_from_hot_weather_1",
    load_character_inputs = { character_variables = { "gramarye_for_spells", "summer_spell_count" } },
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_CHILL", { add_handler = "inline_value_inline_ench_effect_changeling_summer_protect_from_hot_weather_1_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_fire_melee_damage_0_melee_damage_0_add", function(ctx)
    return (random.native_float((1 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] / 2)), (5 + ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"])) / 2.5)
end)

ccb.runtime.handler("inline_active_inline_ench_effect_changeling_fire_melee_damage_0", function(ctx)
    return ctx.character_inputs.armed
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_fire_melee_damage_0",
    condition_handler = "inline_active_inline_ench_effect_changeling_fire_melee_damage_0",
    load_character_inputs = { armed = true, spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_SUMMER" } },
    native_modifier_order = true,
}
    :melee_damage("heat", { add_handler = "inline_value_inline_ench_effect_changeling_fire_melee_damage_0_melee_damage_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_fire_melee_damage_1_melee_damage_0_add", function(ctx)
    return random.native_float((1 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] / 2)), (5 + ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"]))
end)

ccb.runtime.handler("inline_active_inline_ench_effect_changeling_fire_melee_damage_1", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_fire_melee_damage_1",
    condition_handler = "inline_active_inline_ench_effect_changeling_fire_melee_damage_1",
    load_character_inputs = { armed = true, spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_SUMMER" } },
    native_modifier_order = true,
}
    :melee_damage("heat", { add_handler = "inline_value_inline_ench_effect_changeling_fire_melee_damage_1_melee_damage_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_absorb_strength_self_0_value_0_add", function(ctx)
    return math.min(((1 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] / 8)) + (ctx.skills["gramarye"] * 0.3)), 6)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_absorb_strength_self_0",
    load_character_inputs = { spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_SUMMER" } },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_effect_changeling_summer_absorb_strength_self_0_value_0_add", load_skills = { "gramarye" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_5_add", function(ctx)
    return ((3 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] * 0.1)) + (ctx.skills["gramarye"] * 0.2))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_6_add", function(ctx)
    return ((3 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] * 0.1)) + (ctx.skills["gramarye"] * 0.2))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_7_add", function(ctx)
    return ((2 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] * 0.05)) + (ctx.skills["gramarye"] * 0.25))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_9_add", function(ctx)
    return (((-20) + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] * (-2))) + (ctx.skills["gramarye"] * (-5)))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_melee_damage_0_multiply", function(ctx)
    return ((0.1 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] * 0.01)) + (ctx.skills["gramarye"] * 0.05))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_melee_damage_1_multiply", function(ctx)
    return ((0.1 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] * 0.01)) + (ctx.skills["gramarye"] * 0.05))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_melee_damage_2_multiply", function(ctx)
    return ((0.1 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SUMMER"] * 0.01)) + (ctx.skills["gramarye"] * 0.05))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_combat_prowess_powerful_buff_0",
    load_character_inputs = { spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_SUMMER" } },
    native_modifier_order = true,
}
    :value("LUMINATION", { add = 20 })
    :value("ATTACK_SPEED", { multiply = -0.3333 })
    :value("MELEE_TO_HIT", { add = 3 })
    :value("KNOCKBACK_RESIST", { add = 100 })
    :value("ARMOR_ALL", { multiply = -0.15 })
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_5_add", load_skills = { "gramarye" } })
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_6_add", load_skills = { "gramarye" } })
    :value("THROW_STR", { add_handler = "inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_7_add", load_skills = { "gramarye" } })
    :value("THROW_DAMAGE", { multiply = 0.4 })
    :value("OVERKILL_DAMAGE", { add_handler = "inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_value_9_add", load_skills = { "gramarye" } })
    :value("WEAKPOINT_ACCURACY", { multiply = 1 })
    :value("FORCEFIELD", { add = 0.05 })
    :melee_damage("bash", { multiply_handler = "inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_melee_damage_0_multiply", load_skills = { "gramarye" } })
    :melee_damage("cut", { multiply_handler = "inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_melee_damage_1_multiply", load_skills = { "gramarye" } })
    :melee_damage("stab", { multiply_handler = "inline_value_inline_ench_effect_changeling_summer_combat_prowess_powerful_buff_0_melee_damage_2_multiply", load_skills = { "gramarye" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_changeling_autumn_protection_from_ranged_0_value_0_multiply", function(ctx)
    return math.min(((15 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_AUTUMN"] * 0.75)) + (ctx.skills["gramarye"] * 1.5)), 50)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_autumn_protection_from_ranged_0",
    load_character_inputs = { spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_AUTUMN" } },
    native_modifier_order = true,
}
    :value("RANGE_DODGE", { multiply_handler = "inline_value_inline_ench_effect_changeling_autumn_protection_from_ranged_0_value_0_multiply", load_skills = { "gramarye" } }))

-- effects/effects_nether_sorcery.json
ccb.runtime.handler("inline_value_inline_ench_effect_xe_nether_resonance_consequences_0_value_0_add", function(ctx)
    return ctx.character_inputs.effect_intensities["effect_xe_nether_resonance_consequences"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_nether_resonance_consequences_0",
    load_character_inputs = { effect_intensities = { "effect_xe_nether_resonance_consequences" } },
    native_modifier_order = true,
}
    :value("ARTIFACT_RESONANCE", { add_handler = "inline_value_inline_ench_effect_xe_nether_resonance_consequences_0_value_0_add", load_skills = {  } }))

-- mutations/mutations.json
ccb.runtime.handler("inline_value_inline_ench_vampire_1_value_0_add", function(ctx)
    return ((((1 + (ctx.character_inputs.traits["VAMPIRE2"] and 1 or 0)) + (ctx.character_inputs.traits["VAMPIRE3"] and 1 or 0)) + (ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0)) + (ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_1",
    load_character_inputs = { traits = { "BLOOD_DRINKER", "VAMPIRE2", "VAMPIRE3", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "inline_value_inline_ench_vampire_1_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_eyegleam_0_value_0_add", function(ctx)
    return ((((2 + (ctx.character_inputs.traits["VAMPIRE2"] and 1 or 0)) + (ctx.character_inputs.traits["VAMPIRE3"] and 1 or 0)) + ((ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0) * 2))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_EYEGLEAM_0",
    load_character_inputs = { traits = { "BLOOD_DRINKER", "VAMPIRE2", "VAMPIRE3", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "inline_value_inline_ench_eyegleam_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_vampiric_strength_0_value_0_add", function(ctx)
    return ((1 + (ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0)) + ((ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0) * 2))
end)

ccb.runtime.handler("inline_active_inline_ench_vampiric_strength_0", function(ctx)
    return (ctx.character_inputs.traits["VAMPIRE"] or
        (ctx.character_inputs.traits["DHAMPIR_TRAIT"] and
        not (ctx.character_inputs.effects["effect_dhampir_enervated_blood"])))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRIC_STRENGTH_0",
    condition_handler = "inline_active_inline_ench_vampiric_strength_0",
    load_character_inputs = { effects = { "effect_dhampir_enervated_blood" }, traits = { "BLOOD_DRINKER", "DHAMPIR_TRAIT", "VAMPIRE", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_vampiric_strength_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_vampiric_dodge_0_value_0_add", function(ctx)
    return ((1 + (ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0)) + ((ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0) * 2))
end)

ccb.runtime.handler("inline_active_inline_ench_vampiric_dodge_0", function(ctx)
    return (ctx.character_inputs.traits["VAMPIRE"] or
        (ctx.character_inputs.traits["DHAMPIR_TRAIT"] and
        not (ctx.character_inputs.effects["effect_dhampir_enervated_blood"])))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRIC_DODGE_0",
    condition_handler = "inline_active_inline_ench_vampiric_dodge_0",
    load_character_inputs = { effects = { "effect_dhampir_enervated_blood" }, traits = { "BLOOD_DRINKER", "DHAMPIR_TRAIT", "VAMPIRE", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_vampiric_dodge_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_vampire_cardio_bonus_0_value_0_multiply", function(ctx)
    return ((0.25 + ((ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0) * 0.25)) + ((ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0) * 0.25))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_CARDIO_BONUS_0",
    load_character_inputs = { traits = { "BLOOD_DRINKER", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", { multiply_handler = "inline_value_inline_ench_vampire_cardio_bonus_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_vampire_bonus_hp_0_value_0_multiply", function(ctx)
    return ((0.2 + ((ctx.character_inputs.traits["VAMPIRE4"] and 1 or 0) * 0.25)) + ((ctx.character_inputs.traits["BLOOD_DRINKER"] and 1 or 0) * 0.25))
end)

ccb.runtime.handler("inline_active_inline_ench_vampire_bonus_hp_0", function(ctx)
    return ctx.character_inputs.traits["VAMPIRE"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_BONUS_HP_0",
    condition_handler = "inline_active_inline_ench_vampire_bonus_hp_0",
    load_character_inputs = { traits = { "BLOOD_DRINKER", "VAMPIRE", "VAMPIRE4" } },
    native_modifier_order = true,
}
    :value("MAX_HP", { multiply_handler = "inline_value_inline_ench_vampire_bonus_hp_0_value_0_multiply", load_skills = {  } }))

-- mutations/paraclesians/homullus_mutations.json
ccb.runtime.handler("inline_active_inline_ench_homullus_city_strider_0", function(ctx)
    return ((ctx.character_inputs.character_variables["homullus_is_near_faction"] == 1) or
        (ctx.character_inputs.character_variables["homullus_is_in_civilization"] == 1) or
        ctx.character_inputs.environment.terrain == "t_pavement" or
        ctx.character_inputs.environment.terrain == "t_pavement_y")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_CITY_STRIDER_0",
    condition_handler = "inline_active_inline_ench_homullus_city_strider_0",
    load_character_inputs = { character_variables = { "homullus_is_in_civilization", "homullus_is_near_faction" }, environment = { terrain = true } },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = -0.1 }))

-- mutations/playable_changeling.json
ccb.runtime.handler("inline_value_inline_ench_brownie_homebody_0_value_0_add", function(ctx)
    return ctx.character_inputs.character_variables["brownie_homebody_speed_bonus"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BROWNIE_HOMEBODY_0",
    load_character_inputs = { character_variables = { "brownie_homebody_speed_bonus" } },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "inline_value_inline_ench_brownie_homebody_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_pooka_speed_bonuses_0_value_0_add", function(ctx)
    return math.min((((((((((((3 + ((ctx.character_inputs.traits["ANTLERS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["HORNS_CURLED"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["FANGS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["SABER_TEETH"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["CLAWS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["CLAWS_ST"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["WINGS_BIRD"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["URSINE_FUR"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["CHITIN2"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["TAIL_FLUFFY"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["TAIL_LONG"] and 1 or 0) * 2)), 30)
end)

ccb.runtime.handler("inline_active_inline_ench_pooka_speed_bonuses_0", function(ctx)
    return (not ((ctx.character_inputs.armed and not ctx.character_inputs.wielded_flags.NO_UNWIELD)) and
        not (ctx.character_inputs.worn_flags["STURDY"]) and
        (ctx.character_inputs.traits["ANTLERS"] or
        ctx.character_inputs.traits["HORNS_CURLED"] or
        ctx.character_inputs.traits["FANGS"] or
        ctx.character_inputs.traits["SABER_TEETH"] or
        ctx.character_inputs.traits["CLAWS"] or
        ctx.character_inputs.traits["CLAWS_ST"] or
        ctx.character_inputs.traits["WINGS_BIRD"] or
        ctx.character_inputs.traits["URSINE_FUR"] or
        ctx.character_inputs.traits["CHITIN2"] or
        ctx.character_inputs.traits["TAIL_FLUFFY"] or
        ctx.character_inputs.traits["TAIL_LONG"]) and
        not ((ctx.character_inputs.traits["VAMPIRE_BAT_FORM_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_RAVEN_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_BEAR_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_DEER_TRAITS"] or
        ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_COUGAR_TRAITS"])))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_POOKA_SPEED_BONUSES_0",
    condition_handler = "inline_active_inline_ench_pooka_speed_bonuses_0",
    load_character_inputs = { armed = true, traits = { "ANTLERS", "CHITIN2", "CLAWS", "CLAWS_ST", "FANGS", "HORNS_CURLED", "SABER_TEETH", "TAIL_FLUFFY", "TAIL_LONG", "TURN_INTO_BEAR_TRAITS", "TURN_INTO_COUGAR_TRAITS", "TURN_INTO_DEER_TRAITS", "TURN_INTO_RAVEN_TRAITS", "URSINE_FUR", "VAMPIRE_BAT_FORM_TRAITS", "VAMPIRE_WOLF_FORM_TRAITS", "WINGS_BIRD" }, wielded_flags = { "NO_UNWIELD" }, worn_flags = { "STURDY" } },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "inline_value_inline_ench_pooka_speed_bonuses_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_fae_nightvision_0_value_0_add", function(ctx)
    return (ctx.stats.perception * 0.65)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_FAE_NIGHTVISION_0",
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "inline_value_inline_ench_fae_nightvision_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_fae_nightvision2_0_value_0_add", function(ctx)
    return (ctx.stats.perception * 1.3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_FAE_NIGHTVISION2_0",
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "inline_value_inline_ench_fae_nightvision2_0_value_0_add", load_skills = {  } }))

-- mutations/temporary.json
ccb.runtime.handler("inline_value_inline_ench_ethereal_wings_0_value_0_add", function(ctx)
    return (2500 * ctx.spell_levels["spell_ethereal_wings"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ethereal_wings_0",
    native_modifier_order = true,
}
    :value("CARRY_WEIGHT", { add_handler = "inline_value_inline_ench_ethereal_wings_0_value_0_add", load_skills = {  }, load_spell_levels = { "spell_ethereal_wings" } })
    :effect("effect_vampire_bat_form_levitation", 1))

-- mutations/xe_lilin.json
ccb.runtime.handler("inline_value_inline_ench_lilin_night_vision_0_value_0_add", function(ctx)
    return (ctx.stats.perception * 1.5)
end)

ccb.runtime.handler("inline_active_inline_ench_lilin_night_vision_0", function(ctx)
    return ctx.character_inputs.environment.outside
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_NIGHT_VISION_0",
    condition_handler = "inline_active_inline_ench_lilin_night_vision_0",
    load_character_inputs = { environment = { outside = true } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "inline_value_inline_ench_lilin_night_vision_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_lilin_night_vision_1_value_0_add", function(ctx)
    return (ctx.stats.perception * 0.75)
end)

ccb.runtime.handler("inline_active_inline_ench_lilin_night_vision_1", function(ctx)
    return not (ctx.character_inputs.environment.outside)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_NIGHT_VISION_1",
    condition_handler = "inline_active_inline_ench_lilin_night_vision_1",
    load_character_inputs = { environment = { outside = true } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "inline_value_inline_ench_lilin_night_vision_1_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_lilin_night_vision_2_value_0_add", function(ctx)
    return (6 + (ctx.stats.perception / 5))
end)

ccb.runtime.handler("inline_active_inline_ench_lilin_night_vision_2", function(ctx)
    return (ctx.character_inputs.environment.outside and
        not (ctx.character_inputs.environment.daylight))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_NIGHT_VISION_2",
    condition_handler = "inline_active_inline_ench_lilin_night_vision_2",
    load_character_inputs = { environment = { daylight = true, outside = true } },
    native_modifier_order = true,
}
    :value("OVERMAP_SIGHT", { add_handler = "inline_value_inline_ench_lilin_night_vision_2_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_lilin_night_vision_upgrade_1_value_0_add", function(ctx)
    return (6 + ctx.stats.perception)
end)

ccb.runtime.handler("inline_active_inline_ench_lilin_night_vision_upgrade_1", function(ctx)
    return not (ctx.character_inputs.environment.daylight)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_NIGHT_VISION_UPGRADE_1",
    condition_handler = "inline_active_inline_ench_lilin_night_vision_upgrade_1",
    load_character_inputs = { environment = { daylight = true } },
    native_modifier_order = true,
}
    :value("OVERMAP_SIGHT", { add_handler = "inline_value_inline_ench_lilin_night_vision_upgrade_1_value_0_add", load_skills = {  } }))
