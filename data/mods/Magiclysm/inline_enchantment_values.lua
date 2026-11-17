local ccb = require("ccb")
local content = ccb.content

local random = ccb.services.random

-- Spells/attunements/Gaias_Chosen.json
ccb.runtime.handler("inline_value_inline_ench_effect_terra_armor_0_value_0_add", function(ctx)
    return (ctx.spell_levels["terra_armor"] * (-3))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_terra_armor_0",
    native_modifier_order = true,
}
    :value("ARMOR_ALL", { add_handler = "inline_value_inline_ench_effect_terra_armor_0_value_0_add", load_skills = {  }, load_spell_levels = { "terra_armor" } }))

-- Spells/attunements/Storm_Elemental.json
ccb.runtime.handler("inline_value_inline_ench_eff_storm_elemental_electric_melee_0_melee_damage_0_add", function(ctx)
    return ((ctx.spell_levels["storm_elemental_electric_melee"] * 0.9) * random.native_float(0.5, 1.4))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_eff_storm_elemental_electric_melee_0",
    native_modifier_order = true,
}
    :melee_damage("electric", { add_handler = "inline_value_inline_ench_eff_storm_elemental_electric_melee_0_melee_damage_0_add", load_skills = {  }, load_spell_levels = { "storm_elemental_electric_melee" } }))

-- effects/effects.json
ccb.runtime.handler("inline_value_inline_ench_enchant_windrun_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["windrun"] * 2) + 10)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_enchant_windrun_0",
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "inline_value_inline_ench_enchant_windrun_0_value_0_add", load_skills = {  }, load_spell_levels = { "windrun" } }))

ccb.runtime.handler("inline_value_inline_ench_bless_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["bless"] / 8) + 1)
end)

ccb.runtime.handler("inline_value_inline_ench_bless_0_value_1_add", function(ctx)
    return ((ctx.spell_levels["bless"] / 8) + 1)
end)

ccb.runtime.handler("inline_value_inline_ench_bless_0_value_2_add", function(ctx)
    return ((ctx.spell_levels["bless"] / 8) + 1)
end)

ccb.runtime.handler("inline_value_inline_ench_bless_0_value_3_add", function(ctx)
    return (ctx.spell_levels["bless"] + 5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_bless_0",
    native_modifier_order = true,
}
    :value("PERCEPTION", { add_handler = "inline_value_inline_ench_bless_0_value_0_add", load_skills = {  }, load_spell_levels = { "bless" } })
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_bless_0_value_1_add", load_skills = {  }, load_spell_levels = { "bless" } })
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_bless_0_value_2_add", load_skills = {  }, load_spell_levels = { "bless" } })
    :value("SPEED", { add_handler = "inline_value_inline_ench_bless_0_value_3_add", load_skills = {  }, load_spell_levels = { "bless" } }))

ccb.runtime.handler("inline_value_inline_ench_bio_boost_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["bio_grotesque"] / 10) + 1)
end)

ccb.runtime.handler("inline_value_inline_ench_bio_boost_0_value_1_add", function(ctx)
    return ((ctx.spell_levels["bio_grotesque"] / 10) + 1)
end)

ccb.runtime.handler("inline_value_inline_ench_bio_boost_0_value_2_add", function(ctx)
    return ((ctx.spell_levels["bio_grotesque"] / 5) + 1)
end)

ccb.runtime.handler("inline_value_inline_ench_bio_boost_0_value_3_add", function(ctx)
    return ((ctx.spell_levels["bio_grotesque"] / 4) + 5)
end)

ccb.runtime.handler("inline_value_inline_ench_bio_boost_0_value_4_add", function(ctx)
    return ((ctx.spell_levels["bio_grotesque"] / 2) + 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_bio_boost_0",
    native_modifier_order = true,
}
    :value("PERCEPTION", { add_handler = "inline_value_inline_ench_bio_boost_0_value_0_add", load_skills = {  }, load_spell_levels = { "bio_grotesque" } })
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_bio_boost_0_value_1_add", load_skills = {  }, load_spell_levels = { "bio_grotesque" } })
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_bio_boost_0_value_2_add", load_skills = {  }, load_spell_levels = { "bio_grotesque" } })
    :value("SPEED", { add_handler = "inline_value_inline_ench_bio_boost_0_value_3_add", load_skills = {  }, load_spell_levels = { "bio_grotesque" } })
    :value("UGLINESS", { add_handler = "inline_value_inline_ench_bio_boost_0_value_4_add", load_skills = {  }, load_spell_levels = { "bio_grotesque" } }))

ccb.runtime.handler("inline_value_inline_ench_entangled_0_value_0_add", function(ctx)
    return (((-5) + (ctx.character_inputs.character_variables["vegetative_grasp_affected_level"] * (-2))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_0",
    load_character_inputs = { character_variables = { "evocation_spell_affected_proficiency", "vegetative_grasp_affected_level" } },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "inline_value_inline_ench_entangled_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_obfuscating_aura_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["obfuscated_body"] / 7) + 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_obfuscating_aura_0",
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "inline_value_inline_ench_effect_obfuscating_aura_0_value_0_add", load_skills = {  }, load_spell_levels = { "obfuscated_body" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_acid_res_aura_0_incoming_damage_0_multiply", function(ctx)
    return ((ctx.spell_levels["acid_resistance"] * (-0.02)) - 0.2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_acid_res_aura_0",
    native_modifier_order = true,
}
    :incoming_damage("acid", { multiply_handler = "inline_value_inline_ench_effect_acid_res_aura_0_incoming_damage_0_multiply", load_skills = {  }, load_spell_levels = { "acid_resistance" } }))

ccb.runtime.handler("inline_value_inline_ench_ogres_strength_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["technomancer_strength_buff_spell"] / 3) + 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ogres_strength_0",
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_ogres_strength_0_value_0_add", load_skills = {  }, load_spell_levels = { "technomancer_strength_buff_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_eagles_sight_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["technomancer_perception_buff_spell"] / 3) + 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_eagles_sight_0",
    native_modifier_order = true,
}
    :value("PERCEPTION", { add_handler = "inline_value_inline_ench_eagles_sight_0_value_0_add", load_skills = {  }, load_spell_levels = { "technomancer_perception_buff_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_cats_grace_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["technomancer_dexterity_buff_spell"] / 3) + 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cats_grace_0",
    native_modifier_order = true,
}
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_cats_grace_0_value_0_add", load_skills = {  }, load_spell_levels = { "technomancer_dexterity_buff_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_foxs_cunning_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["technomancer_intelligence_buff_spell"] / 3) + 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_foxs_cunning_0",
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add_handler = "inline_value_inline_ench_foxs_cunning_0_value_0_add", load_skills = {  }, load_spell_levels = { "technomancer_intelligence_buff_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_bio_weave_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["biomancer_coagulant_weave"] / 4) + 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_bio_weave_0",
    native_modifier_order = true,
}
    :value("UGLINESS", { add_handler = "inline_value_inline_ench_bio_weave_0_value_0_add", load_skills = {  }, load_spell_levels = { "biomancer_coagulant_weave" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_technomancer_gain_electronics_computer_0_skill_0_add", function(ctx)
    return ((ctx.spell_levels["technomancer_gain_electronics_computer_spell"] / 7) + 1)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_technomancer_gain_electronics_computer_0_skill_1_add", function(ctx)
    return ((ctx.spell_levels["technomancer_gain_electronics_computer_spell"] / 7) + 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_technomancer_gain_electronics_computer_0",
    native_modifier_order = true,
}
    :skill("computer", { add_handler = "inline_value_inline_ench_effect_technomancer_gain_electronics_computer_0_skill_0_add", load_skills = {  }, load_spell_levels = { "technomancer_gain_electronics_computer_spell" } })
    :skill("electronics", { add_handler = "inline_value_inline_ench_effect_technomancer_gain_electronics_computer_0_skill_1_add", load_skills = {  }, load_spell_levels = { "technomancer_gain_electronics_computer_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_0_multiply", function(ctx)
    return ((ctx.spell_levels["technomancer_pain_ignore"] * (-0.02)) - 0.7)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_1_multiply", function(ctx)
    return ((ctx.spell_levels["technomancer_pain_ignore"] * (-0.02)) - 0.7)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_2_multiply", function(ctx)
    return ((ctx.spell_levels["technomancer_pain_ignore"] * (-0.02)) - 0.7)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_3_multiply", function(ctx)
    return ((ctx.spell_levels["technomancer_pain_ignore"] * (-0.02)) - 0.7)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_4_multiply", function(ctx)
    return ((ctx.spell_levels["technomancer_pain_ignore"] * (-0.02)) - 0.7)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_technomancer_pain_ignore_0",
    native_modifier_order = true,
}
    :value("PAIN_PENALTY_MOD_STR", { multiply_handler = "inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "technomancer_pain_ignore" } })
    :value("PAIN_PENALTY_MOD_DEX", { multiply_handler = "inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "technomancer_pain_ignore" } })
    :value("PAIN_PENALTY_MOD_INT", { multiply_handler = "inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_2_multiply", load_skills = {  }, load_spell_levels = { "technomancer_pain_ignore" } })
    :value("PAIN_PENALTY_MOD_PER", { multiply_handler = "inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_3_multiply", load_skills = {  }, load_spell_levels = { "technomancer_pain_ignore" } })
    :value("PAIN_PENALTY_MOD_SPEED", { multiply_handler = "inline_value_inline_ench_effect_technomancer_pain_ignore_0_value_4_multiply", load_skills = {  }, load_spell_levels = { "technomancer_pain_ignore" } }))

ccb.runtime.handler("inline_value_inline_ench_electric_eye_1_value_1_add", function(ctx)
    return (ctx.spell_levels["electric_eye"] / 7)
end)

ccb.runtime.handler("inline_value_inline_ench_electric_eye_1_value_2_add", function(ctx)
    return (ctx.spell_levels["electric_eye"] / 10)
end)

ccb.runtime.handler("inline_value_inline_ench_electric_eye_1_value_3_add", function(ctx)
    return (ctx.spell_levels["electric_eye"] / 5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_electric_eye_1",
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add = 1 })
    :value("DODGE_CHANCE", { add_handler = "inline_value_inline_ench_electric_eye_1_value_1_add", load_skills = {  }, load_spell_levels = { "electric_eye" } })
    :value("DEXTERITY", { add_handler = "inline_value_inline_ench_electric_eye_1_value_2_add", load_skills = {  }, load_spell_levels = { "electric_eye" } })
    :value("PERCEPTION", { add_handler = "inline_value_inline_ench_electric_eye_1_value_3_add", load_skills = {  }, load_spell_levels = { "electric_eye" } }))

ccb.runtime.handler("inline_value_inline_ench_electric_arts_0_incoming_damage_0_add", function(ctx)
    return (ctx.spell_levels["electric_arts"] * (-1.5))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_electric_arts_0",
    native_modifier_order = true,
}
    :incoming_damage("electric", { add_handler = "inline_value_inline_ench_electric_arts_0_incoming_damage_0_add", load_skills = {  }, load_spell_levels = { "electric_arts" } }))

ccb.runtime.handler("inline_value_inline_ench_earthshaper_fortitude_of_stone_0_value_0_multiply", function(ctx)
    return ((-0.2) - (0.04 * ctx.spell_levels["earthshaper_fortitude_of_stone"]))
end)

ccb.runtime.handler("inline_value_inline_ench_earthshaper_fortitude_of_stone_0_value_1_multiply", function(ctx)
    return ((-0.2) - (0.04 * ctx.spell_levels["earthshaper_fortitude_of_stone"]))
end)

ccb.runtime.handler("inline_value_inline_ench_earthshaper_fortitude_of_stone_0_value_2_multiply", function(ctx)
    return ((-0.2) - (0.04 * ctx.spell_levels["earthshaper_fortitude_of_stone"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_earthshaper_fortitude_of_stone_0",
    native_modifier_order = true,
}
    :value("HUNGER", { multiply_handler = "inline_value_inline_ench_earthshaper_fortitude_of_stone_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "earthshaper_fortitude_of_stone" } })
    :value("THIRST", { multiply_handler = "inline_value_inline_ench_earthshaper_fortitude_of_stone_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "earthshaper_fortitude_of_stone" } })
    :value("METABOLISM", { multiply_handler = "inline_value_inline_ench_earthshaper_fortitude_of_stone_0_value_2_multiply", load_skills = {  }, load_spell_levels = { "earthshaper_fortitude_of_stone" } })
    :value("REGEN_HP", { multiply = -1.0 }))

ccb.runtime.handler("inline_value_inline_ench_effect_animist_add_evasion_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["animist_add_evasion_spell"] * 0.02) + 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_animist_add_evasion_0",
    native_modifier_order = true,
}
    :value("EVASION", { add_handler = "inline_value_inline_ench_effect_animist_add_evasion_0_value_0_add", load_skills = {  }, load_spell_levels = { "animist_add_evasion_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_druid_anti_heat_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["druid_anti_heat"] * 2.5) + 10)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_druid_anti_heat_0",
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_CHILL", { add_handler = "inline_value_inline_ench_effect_druid_anti_heat_0_value_0_add", load_skills = {  }, load_spell_levels = { "druid_anti_heat" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_kelvinist_anti_cold_0_incoming_damage_0_add", function(ctx)
    return (ctx.spell_levels["kelvinist_anti_cold"] * (-1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_kelvinist_anti_cold_0", emitter = "emit_kelvinist_anti_cold",
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add = 50 })
    :incoming_damage("cold", { add_handler = "inline_value_inline_ench_effect_kelvinist_anti_cold_0_incoming_damage_0_add", load_skills = {  }, load_spell_levels = { "kelvinist_anti_cold" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_kelvinist_anti_heat_0_incoming_damage_0_add", function(ctx)
    return (ctx.spell_levels["kelvinist_anti_heat"] * (-1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_kelvinist_anti_heat_0", emitter = "emit_kelvinist_anti_heat",
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_CHILL", { add = 50 })
    :incoming_damage("heat", { add_handler = "inline_value_inline_ench_effect_kelvinist_anti_heat_0_incoming_damage_0_add", load_skills = {  }, load_spell_levels = { "kelvinist_anti_heat" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_kelvinist_flames_of_passion_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["kelvinist_persuasion_spell"] * 1.5) + 3)
end)

ccb.runtime.handler("inline_value_inline_ench_effect_kelvinist_flames_of_passion_0_value_1_add", function(ctx)
    return ((ctx.spell_levels["kelvinist_persuasion_spell"] * 1.5) + 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_kelvinist_flames_of_passion_0",
    native_modifier_order = true,
}
    :value("SOCIAL_PERSUADE", { add_handler = "inline_value_inline_ench_effect_kelvinist_flames_of_passion_0_value_0_add", load_skills = {  }, load_spell_levels = { "kelvinist_persuasion_spell" } })
    :value("SOCIAL_INTIMIDATE", { add_handler = "inline_value_inline_ench_effect_kelvinist_flames_of_passion_0_value_1_add", load_skills = {  }, load_spell_levels = { "kelvinist_persuasion_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_magus_slowfall_0_value_0_multiply", function(ctx)
    return ((ctx.spell_levels["magus_slowfall"] * (-0.01)) - 0.9)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_magus_slowfall_0",
    native_modifier_order = true,
}
    :value("FALL_DAMAGE", { multiply_handler = "inline_value_inline_ench_effect_magus_slowfall_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "magus_slowfall" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_magus_ranged_increase_0_value_0_multiply", function(ctx)
    return ((ctx.spell_levels["magus_ranged_increase"] * 0.02) + 0.25)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_magus_ranged_increase_0",
    native_modifier_order = true,
}
    :value("RANGE", { multiply_handler = "inline_value_inline_ench_effect_magus_ranged_increase_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "magus_ranged_increase" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_biomancer_remove_instability_0_value_0_add", function(ctx)
    return ((-1) - (ctx.spell_levels["biomancer_remove_instability"] / 5))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biomancer_remove_instability_0",
    native_modifier_order = true,
}
    :value("MUT_INSTABILITY_MOD", { add_handler = "inline_value_inline_ench_effect_biomancer_remove_instability_0_value_0_add", load_skills = {  }, load_spell_levels = { "biomancer_remove_instability" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_biomancer_control_mutations_0_value_0_add", function(ctx)
    return (1 + (ctx.spell_levels["biomancer_control_mutations"] / 5))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biomancer_control_mutations_0",
    native_modifier_order = true,
}
    :value("MUT_ADDITIONAL_OPTIONS", { add_handler = "inline_value_inline_ench_effect_biomancer_control_mutations_0_value_0_add", load_skills = {  }, load_spell_levels = { "biomancer_control_mutations" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_classless_magic_light_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["create_atomic_light"] * 2) + 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_classless_magic_light_0",
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "inline_value_inline_ench_effect_classless_magic_light_0_value_0_add", load_skills = {  }, load_spell_levels = { "create_atomic_light" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_classless_easy_sleep_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["classless_easy_sleep_spell"] * 3) + 15)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_classless_easy_sleep_0",
    native_modifier_order = true,
}
    :value("SLEEPY", { add_handler = "inline_value_inline_ench_effect_classless_easy_sleep_0_value_0_add", load_skills = {  }, load_spell_levels = { "classless_easy_sleep_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_stormshaper_loud_voice_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["stormshaper_loud_voice_spell"] * 3) + 15)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_stormshaper_loud_voice_0",
    native_modifier_order = true,
}
    :value("SHOUT_NOISE", { add_handler = "inline_value_inline_ench_effect_stormshaper_loud_voice_0_value_0_add", load_skills = {  }, load_spell_levels = { "stormshaper_loud_voice_spell" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_biomancer_disturbing_0_value_0_add", function(ctx)
    return ctx.character_inputs.effect_intensities["effect_biomancer_disturbing"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biomancer_disturbing_0",
    load_character_inputs = { effect_intensities = { "effect_biomancer_disturbing" } },
    native_modifier_order = true,
}
    :value("UGLINESS", { add_handler = "inline_value_inline_ench_effect_biomancer_disturbing_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_biomancer_eat_tons_of_food_0_value_0_multiply", function(ctx)
    return (ctx.spell_levels["biomancer_eat_tons_of_food"] * 0.5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biomancer_eat_tons_of_food_0",
    native_modifier_order = true,
}
    :value("STOMACH_SIZE_MULTIPLIER", { multiply_handler = "inline_value_inline_ench_effect_biomancer_eat_tons_of_food_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "biomancer_eat_tons_of_food" } })
    :value("UGLINESS", { add = 1 }))

ccb.runtime.handler("inline_value_inline_ench_effect_druid_traverse_the_wilds_0_value_0_multiply", function(ctx)
    return ((ctx.spell_levels["druid_traverse_the_wilds"] * (-0.015)) - 0.05)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_druid_traverse_the_wilds_0",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "inline_value_inline_ench_effect_druid_traverse_the_wilds_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "druid_traverse_the_wilds" } }))

ccb.runtime.handler("inline_value_inline_ench_archerybracers_0_value_0_multiply", function(ctx)
    return (1 + (ctx.skills["archery"] / 3))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_archerybracers_0",
    native_modifier_order = true,
}
    :value("WEAKPOINT_ACCURACY", { multiply_handler = "inline_value_inline_ench_archerybracers_0_value_0_multiply", load_skills = { "archery" } }))

ccb.runtime.handler("inline_value_inline_ench_effect_mana_overload_0_value_0_multiply", function(ctx)
    return ((-0.3) + (ctx.character_inputs.effect_intensities["effect_mana_overload"] * (-0.2)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_mana_overload_0",
    load_character_inputs = { effect_intensities = { "effect_mana_overload" } },
    native_modifier_order = true,
}
    :value("REGEN_MANA", { multiply_handler = "inline_value_inline_ench_effect_mana_overload_0_value_0_multiply", load_skills = {  } }))

-- effects/effects_fantasy_species.json
ccb.runtime.handler("inline_value_inline_ench_effect_vitamin_elven_wilderness_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vitamin_elven_wilderness"] * (-0.05))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitamin_elven_wilderness_0",
    load_character_inputs = { effect_intensities = { "effect_vitamin_elven_wilderness" } },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { multiply_handler = "inline_value_inline_ench_effect_vitamin_elven_wilderness_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_vitamin_elven_wilderness_1_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vitamin_elven_wilderness"] * (-0.05))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitamin_elven_wilderness_1",
    load_character_inputs = { effect_intensities = { "effect_vitamin_elven_wilderness" } },
    native_modifier_order = true,
}
    :value("MAX_STAMINA", { multiply_handler = "inline_value_inline_ench_effect_vitamin_elven_wilderness_1_value_0_multiply", load_skills = {  } }))

-- mutations/mutation_paths/fantasy_species.json
ccb.runtime.handler("inline_active_inline_ench_elven_build_1", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vitamin_elven_wilderness"] <= 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_BUILD_1",
    condition_handler = "inline_active_inline_ench_elven_build_1",
    load_character_inputs = { effect_intensities = { "effect_vitamin_elven_wilderness" } },
    native_modifier_order = true,
}
    :mutation("DISIMMUNE"))
