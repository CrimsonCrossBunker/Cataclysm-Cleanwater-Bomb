local ccb = require("ccb")
local content = ccb.content

local progression = require("enchantment_progression")

-- effects/effects.json
ccb.runtime.handler("innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_0_add", function(ctx)
    return (1 + ((ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 0.08) + (ctx.character_inputs.skills["gramarye"] * 0.25)))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_1_add", function(ctx)
    return (1 + ((ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 0.05) + (ctx.character_inputs.skills["gramarye"] * 0.2)))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_2_add", function(ctx)
    return (1 + ((ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 0.07) + (ctx.character_inputs.skills["gramarye"] * 0.35)))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_3_add", function(ctx)
    return math.min((0.33 + ((ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 0.005) + (ctx.character_inputs.skills["gramarye"] * 0.02))), 0.98)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_4_multiply", function(ctx)
    return ((-0.1) - ((ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 0.0015) - (ctx.character_inputs.skills["gramarye"] * 0.015)))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_5_multiply", function(ctx)
    return ((-0.1) - ((ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 0.0015) - (ctx.character_inputs.skills["gramarye"] * 0.015)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_noble_movement_buffs_0",
    load_character_inputs = { category_counts = { "FAIR_FOLK_NOBLE" }, skills = { "gramarye" } },
    native_modifier_order = true,
}
    :value("DODGE_CHANCE", {
        add_handler = "innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_0_add",
        load_skills = {}
    })
    :value("BONUS_DODGE", {
        add_handler = "innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_1_add",
        load_skills = {}
    })
    :value("THROW_STR", {
        add_handler = "innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_2_add",
        load_skills = {}
    })
    :value("RANGE_DODGE", {
        add_handler = "innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_3_add",
        load_skills = {}
    })
    :value("MOVE_COST", {
        multiply_handler = "innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_4_multiply",
        load_skills = {}
    })
    :value("ATTACK_SPEED", {
        multiply_handler = "innate_enchantment_inline_ench_effect_changeling_noble_movement_buffs_0_value_5_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_effect_bloodthorne_druid_gain_strength_dexterity_buff_0_value_0_add", function(ctx)
    return math.min((((1 + (0.3 * progression.bloodthorn_traits(ctx))) + (0.1 * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"])) * ((ctx.character_inputs.character_variables["arvore_is_in_wilderness"] == 1) and 1.5 or 1)), 10)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_effect_bloodthorne_druid_gain_strength_dexterity_buff_0_value_1_add", function(ctx)
    return math.min((((1 + (0.3 * progression.bloodthorn_traits(ctx))) + (0.1 * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"])) * ((ctx.character_inputs.character_variables["arvore_is_in_wilderness"] == 1) and 1.5 or 1)), 10)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_effect_bloodthorne_druid_gain_strength_dexterity_buff_0_value_2_multiply", function(ctx)
    return math.min((((0.1 + (0.02 * progression.bloodthorn_traits(ctx))) + (0.005 * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"])) * ((ctx.character_inputs.character_variables["arvore_is_in_wilderness"] == 1) and 1.5 or 1)), 0.6)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_bloodthorne_druid_gain_strength_dexterity_buff_0",
    load_character_inputs = {
        category_counts = { "ARVORE_ALCHEMY" },
        character_variables = { "arvore_is_in_wilderness" },
        traits = {
            "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
            "BLOODTHORNE_DRUID_CREATE_THORN_PRISON",
            "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
            "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
            "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
            "BLOODTHORNE_DRUID_REGAIN_BLOOD",
            "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
            "BLOODTHORNE_DRUID_STOP_BLEEDING",
            "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP",
            "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE"
        }
    },
    native_modifier_order = true,
}
    :value("STRENGTH", {
        add_handler = "innate_enchantment_inline_ench_effect_bloodthorne_druid_gain_strength_dexterity_buff_0_value_0_add",
        load_skills = {}
    })
    :value("DEXTERITY", {
        add_handler = "innate_enchantment_inline_ench_effect_bloodthorne_druid_gain_strength_dexterity_buff_0_value_1_add",
        load_skills = {}
    })
    :value("MAX_HP", {
        multiply_handler = "innate_enchantment_inline_ench_effect_bloodthorne_druid_gain_strength_dexterity_buff_0_value_2_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_effect_xe_werewolf_primal_strength_human_form_0_value_0_add", function(ctx)
    return math.min(((2 + (progression.werewolf_tier_four(ctx) * 0.2)) + (progression.werewolf_tier_five(ctx) * 0.35)), 8)
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_effect_xe_werewolf_primal_strength_human_form_0", function(ctx)
    return not ((ctx.character_inputs.traits["WEREWOLF_HYBRID_FORM_TRAITS"] or
        ctx.character_inputs.traits["WEREWOLF_PRIMAL_FORM_TRAITS"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_werewolf_primal_strength_human_form_0",
    condition_handler = "innate_enchantment_active_inline_ench_effect_xe_werewolf_primal_strength_human_form_0",
    load_character_inputs = {
        traits = {
            "WEREWOLF_CLOSE_TEAR_IN_REALITY",
            "WEREWOLF_HYBRID_FORM_TRAITS",
            "WEREWOLF_MOON_ARMOR",
            "WEREWOLF_PRIMAL_FORM_TRAITS",
            "WEREWOLF_SUMMON_FOG",
            "WEREWOLF_SUMMON_SHADOW_PACK",
            "WEREWOLF_SUPER_FAST_REGENERATION",
            "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
            "WEREWOLF_WALK_THROUGH_WALLS"
        }
    },
    native_modifier_order = true,
}
    :value("STRENGTH", {
        add_handler = "innate_enchantment_inline_ench_effect_xe_werewolf_primal_strength_human_form_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_effect_xe_werewolf_camouflage_as_wolf_1_value_0_add", function(ctx)
    return math.min((((25 + (progression.werewolf_tier_three(ctx) * 1)) + (progression.werewolf_tier_four(ctx) * 2)) + (progression.werewolf_tier_five(ctx) * 4)), 50)
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_effect_xe_werewolf_camouflage_as_wolf_1", function(ctx)
    return ctx.character_inputs.traits["WOLF_VAMPIRE_WOLF_FORM_TRAITS"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_werewolf_camouflage_as_wolf_1",
    condition_handler = "innate_enchantment_active_inline_ench_effect_xe_werewolf_camouflage_as_wolf_1",
    load_character_inputs = {
        traits = {
            "WEREWOLF_BATTLE_FURY",
            "WEREWOLF_CLOSE_TEAR_IN_REALITY",
            "WEREWOLF_MANA_BONUS_AFTER_KILL",
            "WEREWOLF_MOON_ARMOR",
            "WEREWOLF_PARTIAL_SHIFT",
            "WEREWOLF_SILVER_CLAWS",
            "WEREWOLF_STRENGTH_BONUS",
            "WEREWOLF_SUMMON_FOG",
            "WEREWOLF_SUMMON_SHADOW_PACK",
            "WEREWOLF_SUPER_FAST_REGENERATION",
            "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
            "WEREWOLF_WALK_THROUGH_WALLS",
            "WOLF_VAMPIRE_WOLF_FORM_TRAITS"
        }
    },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", {
        add_handler = "innate_enchantment_inline_ench_effect_xe_werewolf_camouflage_as_wolf_1_value_0_add",
        load_skills = {}
    }))

-- mutations/bloodthorne_druid_traits.json
ccb.runtime.handler("innate_enchantment_inline_ench_bloodthorne_druid_symbiotic_plant_0_value_2_add", function(ctx)
    return ((50 * progression.bloodthorn_traits(ctx)) + (25 * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_0",
    load_character_inputs = {
        category_counts = { "ARVORE_ALCHEMY" },
        traits = {
            "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
            "BLOODTHORNE_DRUID_CREATE_THORN_PRISON",
            "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
            "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
            "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
            "BLOODTHORNE_DRUID_REGAIN_BLOOD",
            "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
            "BLOODTHORNE_DRUID_STOP_BLEEDING",
            "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP",
            "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE"
        }
    },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = 0.1 })
    :value("THIRST", { multiply = 0.1 })
    :value("MAX_MANA", {
        add_handler = "innate_enchantment_inline_ench_bloodthorne_druid_symbiotic_plant_0_value_2_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_bloodthorne_druid_reduced_pain_penalties_0_value_0_multiply", function(ctx)
    return math.max((((-0.15) + ((-0.02) * progression.bloodthorn_traits(ctx))) + ((-0.01) * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"])), (-0.6))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_bloodthorne_druid_reduced_pain_penalties_0_value_1_multiply", function(ctx)
    return math.max((((-0.15) + ((-0.02) * progression.bloodthorn_traits(ctx))) + ((-0.01) * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"])), (-0.6))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_bloodthorne_druid_reduced_pain_penalties_0_value_2_multiply", function(ctx)
    return math.max((((-0.15) + ((-0.02) * progression.bloodthorn_traits(ctx))) + ((-0.01) * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"])), (-0.6))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES_0",
    load_character_inputs = {
        category_counts = { "ARVORE_ALCHEMY" },
        traits = {
            "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
            "BLOODTHORNE_DRUID_CREATE_THORN_PRISON",
            "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
            "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
            "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
            "BLOODTHORNE_DRUID_REGAIN_BLOOD",
            "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
            "BLOODTHORNE_DRUID_STOP_BLEEDING",
            "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP",
            "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE"
        }
    },
    native_modifier_order = true,
}
    :value("PAIN_PENALTY_MOD_STR", {
        multiply_handler = "innate_enchantment_inline_ench_bloodthorne_druid_reduced_pain_penalties_0_value_0_multiply",
        load_skills = {}
    })
    :value("PAIN_PENALTY_MOD_DEX", {
        multiply_handler = "innate_enchantment_inline_ench_bloodthorne_druid_reduced_pain_penalties_0_value_1_multiply",
        load_skills = {}
    })
    :value("PAIN_PENALTY_MOD_SPEED", {
        multiply_handler = "innate_enchantment_inline_ench_bloodthorne_druid_reduced_pain_penalties_0_value_2_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_bloodthorne_druid_bonus_mana_regen_0_value_0_multiply", function(ctx)
    return ((0.02 * progression.bloodthorn_traits(ctx)) + (0.01 * ctx.character_inputs.category_counts["ARVORE_ALCHEMY"]))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_bloodthorne_druid_bonus_mana_regen_0", function(ctx)
    return ((ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"] or
        ctx.character_inputs.environment.terrain == "t_barkfloor" or
        ctx.character_inputs.environment.terrain == "t_barkfloor_noroof") or
        (ctx.character_inputs.character_variables["arvore_is_in_forest"] == 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BLOODTHORNE_DRUID_BONUS_MANA_REGEN_0",
    condition_handler = "innate_enchantment_active_inline_ench_bloodthorne_druid_bonus_mana_regen_0",
    load_character_inputs = {
        category_counts = { "ARVORE_ALCHEMY" },
        character_variables = { "arvore_is_in_forest" },
        environment = {
            terrain = true,
            terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" }
        },
        traits = {
            "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
            "BLOODTHORNE_DRUID_CREATE_THORN_PRISON",
            "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
            "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
            "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
            "BLOODTHORNE_DRUID_REGAIN_BLOOD",
            "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
            "BLOODTHORNE_DRUID_STOP_BLEEDING",
            "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
            "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP",
            "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE"
        }
    },
    native_modifier_order = true,
}
    :value("REGEN_MANA", {
        multiply_handler = "innate_enchantment_inline_ench_bloodthorne_druid_bonus_mana_regen_0_value_0_multiply",
        load_skills = {}
    }))

-- mutations/paraclesians/homullus_mutations.json
ccb.runtime.handler("innate_enchantment_inline_ench_homullus_passive_bionic_power_0_value_0_add", function(ctx)
    return (ctx.character_inputs.category_counts["HOMULLUS"] * 50000000)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_PASSIVE_BIONIC_POWER_0",
    load_character_inputs = { category_counts = { "HOMULLUS" } },
    native_modifier_order = true,
}
    :value("BIONIC_POWER", {
        add_handler = "innate_enchantment_inline_ench_homullus_passive_bionic_power_0_value_0_add",
        load_skills = {}
    }))

-- mutations/paraclesians/salamander_mutations.json
ccb.runtime.handler("innate_enchantment_inline_ench_salamander_ectotherm_0_value_0_add", function(ctx)
    return ccb.runtime.call_number("thermal_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_SALAMANDER_ECTOTHERM_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_salamander_ectotherm_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_salamander_heat_heal_1_value_0_add", function(ctx)
    return ccb.runtime.call_number("thermal_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_SALAMANDER_HEAT_HEAL_1",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_salamander_heat_heal_1_value_0_add",
        load_skills = {}
    }))

-- mutations/playable_changeling.json
ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_noble_0_value_0_add", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 70)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_noble_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_NOBLE"] * 0.02)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNKNOWING_CHANGELING_NOBLE_0",
    load_character_inputs = { category_counts = { "FAIR_FOLK_NOBLE" } },
    native_modifier_order = true,
}
    :value("MAX_MANA", {
        add_handler = "innate_enchantment_inline_ench_unknowing_changeling_noble_0_value_0_add",
        load_skills = {}
    })
    :value("REGEN_MANA", {
        multiply_handler = "innate_enchantment_inline_ench_unknowing_changeling_noble_0_value_1_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_brownie_0_value_0_add", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_BROWNIE"] * 40)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_brownie_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_BROWNIE"] * 0.01)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_BROWNIE_0",
    load_character_inputs = { category_counts = { "FAIR_FOLK_COMMONER_BROWNIE" } },
    native_modifier_order = true,
}
    :value("MAX_MANA", {
        add_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_brownie_0_value_0_add",
        load_skills = {}
    })
    :value("REGEN_MANA", {
        multiply_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_brownie_0_value_1_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_pooka_0_value_0_add", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_POOKA"] * 50)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_pooka_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_POOKA"] * 0.01)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_POOKA_0",
    load_character_inputs = { category_counts = { "FAIR_FOLK_COMMONER_POOKA" } },
    native_modifier_order = true,
}
    :value("MAX_MANA", {
        add_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_pooka_0_value_0_add",
        load_skills = {}
    })
    :value("REGEN_MANA", {
        multiply_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_pooka_0_value_1_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_selkie_0_value_0_add", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_SELKIE"] * 25)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_selkie_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_SELKIE"] * 0.01)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_SELKIE_0",
    load_character_inputs = { category_counts = { "FAIR_FOLK_COMMONER_SELKIE" } },
    native_modifier_order = true,
}
    :value("MAX_MANA", {
        add_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_selkie_0_value_0_add",
        load_skills = {}
    })
    :value("REGEN_MANA", {
        multiply_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_selkie_0_value_1_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_trow_0_value_0_add", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_TROW"] * 15)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_unknowing_changeling_commoner_trow_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_TROW"] * 0.01)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_TROW_0",
    load_character_inputs = { category_counts = { "FAIR_FOLK_COMMONER_TROW" } },
    native_modifier_order = true,
}
    :value("MAX_MANA", {
        add_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_trow_0_value_0_add",
        load_skills = {}
    })
    :value("REGEN_MANA", {
        multiply_handler = "innate_enchantment_inline_ench_unknowing_changeling_commoner_trow_0_value_1_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_pooka_unarmed_attack_bonuses_0_value_0_multiply", function(ctx)
    return (0.1 + (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_POOKA"] * 0.01))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_pooka_unarmed_attack_bonuses_0", function(ctx)
    return (not ((ctx.character_inputs.armed and not ctx.character_inputs.wielded_flags.NO_UNWIELD)) and
        not (ctx.character_inputs.worn_flags["STURDY"]) and
        (ctx.character_inputs.traits["ANTLERS"] or
        ctx.character_inputs.traits["HORNS_CURLED"] or
        ctx.character_inputs.traits["FANGS"] or
        ctx.character_inputs.traits["SABER_TEETH"] or
        ctx.character_inputs.traits["CLAWS"] or
        ctx.character_inputs.traits["CLAWS_ST"] or
        ctx.character_inputs.traits["TAIL_STING"]) and
        not ((ctx.character_inputs.traits["VAMPIRE_BAT_FORM_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_RAVEN_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_BEAR_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_DEER_TRAITS"] or
        ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] or
        ctx.character_inputs.traits["TURN_INTO_COUGAR_TRAITS"])))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_POOKA_UNARMED_ATTACK_BONUSES_0",
    condition_handler = "innate_enchantment_active_inline_ench_pooka_unarmed_attack_bonuses_0",
    load_character_inputs = {
        armed = true,
        category_counts = { "FAIR_FOLK_COMMONER_POOKA" },
        traits = {
            "ANTLERS",
            "CLAWS",
            "CLAWS_ST",
            "FANGS",
            "HORNS_CURLED",
            "SABER_TEETH",
            "TAIL_STING",
            "TURN_INTO_BEAR_TRAITS",
            "TURN_INTO_COUGAR_TRAITS",
            "TURN_INTO_DEER_TRAITS",
            "TURN_INTO_RAVEN_TRAITS",
            "VAMPIRE_BAT_FORM_TRAITS",
            "VAMPIRE_WOLF_FORM_TRAITS"
        },
        wielded_flags = { "NO_UNWIELD" },
        worn_flags = { "STURDY" }
    },
    native_modifier_order = true,
}
    :value("MELEE_DAMAGE", {
        multiply_handler = "innate_enchantment_inline_ench_pooka_unarmed_attack_bonuses_0_value_0_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_pooka_unarmed_dodge_bonuses_0_value_0_add", function(ctx)
    return math.min((1 + (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_POOKA"] * 0.1)), 4)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_pooka_unarmed_dodge_bonuses_0_value_1_add", function(ctx)
    return math.min((2 + (ctx.character_inputs.category_counts["FAIR_FOLK_COMMONER_POOKA"] * 0.25)), 12)
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_pooka_unarmed_dodge_bonuses_0", function(ctx)
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
        ctx.character_inputs.traits["POOKA_QUADRUPED_TRAITS"] or
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
    id = "INLINE_ENCH_POOKA_UNARMED_DODGE_BONUSES_0",
    condition_handler = "innate_enchantment_active_inline_ench_pooka_unarmed_dodge_bonuses_0",
    load_character_inputs = {
        armed = true,
        category_counts = { "FAIR_FOLK_COMMONER_POOKA" },
        traits = {
            "ANTLERS",
            "CHITIN2",
            "CLAWS",
            "CLAWS_ST",
            "FANGS",
            "HORNS_CURLED",
            "POOKA_QUADRUPED_TRAITS",
            "SABER_TEETH",
            "TAIL_FLUFFY",
            "TAIL_LONG",
            "TURN_INTO_BEAR_TRAITS",
            "TURN_INTO_COUGAR_TRAITS",
            "TURN_INTO_DEER_TRAITS",
            "TURN_INTO_RAVEN_TRAITS",
            "URSINE_FUR",
            "VAMPIRE_BAT_FORM_TRAITS",
            "VAMPIRE_WOLF_FORM_TRAITS",
            "WINGS_BIRD"
        },
        wielded_flags = { "NO_UNWIELD" },
        worn_flags = { "STURDY" }
    },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", {
        add_handler = "innate_enchantment_inline_ench_pooka_unarmed_dodge_bonuses_0_value_0_add",
        load_skills = {}
    })
    :value("DODGE_CHANCE", {
        add_handler = "innate_enchantment_inline_ench_pooka_unarmed_dodge_bonuses_0_value_1_add",
        load_skills = {}
    }))

-- mutations/shapeshifters.json
ccb.runtime.handler("innate_enchantment_active_inline_ench_werewolf_hybrid_form_traits_1", function(ctx)
    return (not (ctx.character_inputs.environment.daylight) and
        (ctx.character_inputs.environment.moon_phase == 4))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_HYBRID_FORM_TRAITS_1",
    condition_handler = "innate_enchantment_active_inline_ench_werewolf_hybrid_form_traits_1",
    load_character_inputs = { environment = { daylight = true, moon_phase = true } },
    native_modifier_order = true,
}
    :value("DEXTERITY", { add = 2 })
    :value("STRENGTH", { add = 2 })
    :value("SPEED", { multiply = 0.05 })
    :value("REGEN_MANA", { multiply = 1 }))

-- mutations/werewolf_traits.json
ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_extra_weakpoint_hits_0_value_0_multiply", function(ctx)
    return math.min((((0.25 + (progression.werewolf_tier_three(ctx) * 0.1)) + (progression.werewolf_tier_four(ctx) * 0.15)) + (progression.werewolf_tier_five(ctx) * 0.2)), 2)
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_werewolf_extra_weakpoint_hits_0", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_EXTRA_WEAKPOINT_HITS_0",
    condition_handler = "innate_enchantment_active_inline_ench_werewolf_extra_weakpoint_hits_0",
    load_character_inputs = {
        armed = true,
        traits = {
            "WEREWOLF_BATTLE_FURY",
            "WEREWOLF_CLOSE_TEAR_IN_REALITY",
            "WEREWOLF_MANA_BONUS_AFTER_KILL",
            "WEREWOLF_MOON_ARMOR",
            "WEREWOLF_PARTIAL_SHIFT",
            "WEREWOLF_SILVER_CLAWS",
            "WEREWOLF_STRENGTH_BONUS",
            "WEREWOLF_SUMMON_FOG",
            "WEREWOLF_SUMMON_SHADOW_PACK",
            "WEREWOLF_SUPER_FAST_REGENERATION",
            "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
            "WEREWOLF_WALK_THROUGH_WALLS"
        }
    },
    native_modifier_order = true,
}
    :value("WEAKPOINT_ACCURACY", {
        multiply_handler = "innate_enchantment_inline_ench_werewolf_extra_weakpoint_hits_0_value_0_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_strength_bonus_0_value_0_add", function(ctx)
    return math.min(((2 + (progression.werewolf_tier_four(ctx) * 0.2)) + (progression.werewolf_tier_five(ctx) * 0.35)), 8)
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_werewolf_strength_bonus_0", function(ctx)
    return (ctx.character_inputs.traits["WEREWOLF_HYBRID_FORM_TRAITS"] or
        ctx.character_inputs.traits["WEREWOLF_PRIMAL_FORM_TRAITS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_STRENGTH_BONUS_0",
    condition_handler = "innate_enchantment_active_inline_ench_werewolf_strength_bonus_0",
    load_character_inputs = {
        traits = {
            "WEREWOLF_CLOSE_TEAR_IN_REALITY",
            "WEREWOLF_HYBRID_FORM_TRAITS",
            "WEREWOLF_MOON_ARMOR",
            "WEREWOLF_PRIMAL_FORM_TRAITS",
            "WEREWOLF_SUMMON_FOG",
            "WEREWOLF_SUMMON_SHADOW_PACK",
            "WEREWOLF_SUPER_FAST_REGENERATION",
            "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
            "WEREWOLF_WALK_THROUGH_WALLS"
        }
    },
    native_modifier_order = true,
}
    :value("STRENGTH", {
        add_handler = "innate_enchantment_inline_ench_werewolf_strength_bonus_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_moon_armor_0_value_0_add", function(ctx)
    return math.min((10 + (progression.werewolf_tier_five(ctx) * 1)), 30)
end)

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_0_add", function(ctx)
    return math.max(((-6) + (progression.werewolf_tier_five(ctx) * (-0.4))), (-12))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_0_multiply", function(ctx)
    return math.max(((-0.2) + (progression.werewolf_tier_five(ctx) * (-0.05))), (-0.5))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_1_add", function(ctx)
    return math.max(((-4) + (progression.werewolf_tier_five(ctx) * (-0.4))), (-8))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_1_multiply", function(ctx)
    return math.max(((-0.15) + (progression.werewolf_tier_five(ctx) * (-0.04))), (-0.5))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_2_add", function(ctx)
    return math.max(((-2) + (progression.werewolf_tier_five(ctx) * (-0.4))), (-4))
end)

ccb.runtime.handler("innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_2_multiply", function(ctx)
    return math.max(((-0.1) + (progression.werewolf_tier_five(ctx) * (-0.03))), (-0.5))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_MOON_ARMOR_0", condition = "ACTIVE",
    load_character_inputs = {
        traits = {
            "WEREWOLF_CLOSE_TEAR_IN_REALITY",
            "WEREWOLF_SUMMON_SHADOW_PACK",
            "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
            "WEREWOLF_WALK_THROUGH_WALLS"
        }
    },
    native_modifier_order = true,
}
    :value("LUMINATION", {
        add_handler = "innate_enchantment_inline_ench_werewolf_moon_armor_0_value_0_add",
        load_skills = {}
    })
    :incoming_damage("bash", {
        add_handler = "innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_0_add",
        multiply_handler = "innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_0_multiply",
        load_skills = {}
    })
    :incoming_damage("cut", {
        add_handler = "innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_1_add",
        multiply_handler = "innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_1_multiply",
        load_skills = {}
    })
    :incoming_damage("stab", {
        add_handler = "innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_2_add",
        multiply_handler = "innate_enchantment_inline_ench_werewolf_moon_armor_0_incoming_damage_2_multiply",
        load_skills = {}
    }))

-- mutations/xe_lilin.json
ccb.runtime.handler("innate_enchantment_inline_ench_lilin_traits_0_value_0_add", function(ctx)
    return (ctx.character_inputs.category_counts["LILIN"] * (-1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_TRAITS_0",
    load_character_inputs = { category_counts = { "LILIN" } },
    native_modifier_order = true,
}
    :value("MUT_INSTABILITY_MOD", {
        add_handler = "innate_enchantment_inline_ench_lilin_traits_0_value_0_add",
        load_skills = {}
    })
    :effect("effect_lilin_vampire_immune", 1))

ccb.runtime.handler("innate_enchantment_inline_ench_lilin_unarmed_extra_damage_0_melee_damage_0_add", function(ctx)
    return ((3 + (ctx.character_inputs.effect_intensities["effect_lilin_attribute_bonuses"] * 3)) + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 1000))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_0", function(ctx)
    return (not (ctx.character_inputs.armed) and
        not ((ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside)) and
        ((ctx.character_inputs.environment.moon_phase == 3) or
        (ctx.character_inputs.environment.moon_phase == 4) or
        (ctx.character_inputs.environment.moon_phase == 5)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_0",
    condition_handler = "innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_0",
    load_character_inputs = {
        armed = true,
        effect_intensities = { "effect_lilin_attribute_bonuses" },
        environment = { daylight = true, moon_phase = true, outside = true },
        vitamins = { "lilin_ruach_vitamin" }
    },
    native_modifier_order = true,
}
    :melee_damage("biological", {
        add_handler = "innate_enchantment_inline_ench_lilin_unarmed_extra_damage_0_melee_damage_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_lilin_unarmed_extra_damage_1_melee_damage_0_add", function(ctx)
    return ((3 + (ctx.character_inputs.effect_intensities["effect_lilin_attribute_bonuses"] * 3)) + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 1000))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_1", function(ctx)
    return (not (ctx.character_inputs.armed) and
        not ((ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside)) and
        ctx.character_inputs.traits["LILIN_STRONGER_MOON"] and
        ((ctx.character_inputs.environment.moon_phase == 2) or
        (ctx.character_inputs.environment.moon_phase == 6) or
        (ctx.character_inputs.environment.moon_phase == 7) or
        (ctx.character_inputs.environment.moon_phase == 1)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_1",
    condition_handler = "innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_1",
    load_character_inputs = {
        armed = true,
        effect_intensities = { "effect_lilin_attribute_bonuses" },
        environment = { daylight = true, moon_phase = true, outside = true },
        traits = { "LILIN_STRONGER_MOON" },
        vitamins = { "lilin_ruach_vitamin" }
    },
    native_modifier_order = true,
}
    :melee_damage("biological", {
        add_handler = "innate_enchantment_inline_ench_lilin_unarmed_extra_damage_1_melee_damage_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_lilin_unarmed_extra_damage_2_melee_damage_0_add", function(ctx)
    return ((2 + (ctx.character_inputs.effect_intensities["effect_lilin_attribute_bonuses"] * 2)) + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 2000))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_2", function(ctx)
    return (not (ctx.character_inputs.armed) and
        not ((ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside)) and
        not (ctx.character_inputs.traits["LILIN_STRONGER_MOON"]) and
        ((ctx.character_inputs.environment.moon_phase == 2) or
        (ctx.character_inputs.environment.moon_phase == 6) or
        (ctx.character_inputs.environment.moon_phase == 7) or
        (ctx.character_inputs.environment.moon_phase == 1)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_2",
    condition_handler = "innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_2",
    load_character_inputs = {
        armed = true,
        effect_intensities = { "effect_lilin_attribute_bonuses" },
        environment = { daylight = true, moon_phase = true, outside = true },
        traits = { "LILIN_STRONGER_MOON" },
        vitamins = { "lilin_ruach_vitamin" }
    },
    native_modifier_order = true,
}
    :melee_damage("biological", {
        add_handler = "innate_enchantment_inline_ench_lilin_unarmed_extra_damage_2_melee_damage_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_lilin_unarmed_extra_damage_3_melee_damage_0_add", function(ctx)
    return (1 + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 3000))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_3", function(ctx)
    return (not (ctx.character_inputs.armed) and
        not ((ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside)) and
        (ctx.character_inputs.environment.moon_phase == 8))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_3",
    condition_handler = "innate_enchantment_active_inline_ench_lilin_unarmed_extra_damage_3",
    load_character_inputs = {
        armed = true,
        environment = { daylight = true, moon_phase = true, outside = true },
        vitamins = { "lilin_ruach_vitamin" }
    },
    native_modifier_order = true,
}
    :melee_damage("biological", {
        add_handler = "innate_enchantment_inline_ench_lilin_unarmed_extra_damage_3_melee_damage_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_lilin_stealth_modifier_in_darkness_0_value_0_add", function(ctx)
    return (10 + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 500))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_lilin_stealth_modifier_in_darkness_0", function(ctx)
    return (not ((ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside)) and
        (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1) and
        ((ctx.character_inputs.environment.moon_phase == 6) or
        (ctx.character_inputs.environment.moon_phase == 2)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_STEALTH_MODIFIER_IN_DARKNESS_0",
    condition_handler = "innate_enchantment_active_inline_ench_lilin_stealth_modifier_in_darkness_0",
    load_character_inputs = {
        environment = { daylight = true, moon_phase = true, outside = true },
        vitamins = { "lilin_ruach_vitamin" }
    },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", {
        add_handler = "innate_enchantment_inline_ench_lilin_stealth_modifier_in_darkness_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_lilin_stealth_modifier_in_darkness_1_value_0_add", function(ctx)
    return (25 + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 400))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_lilin_stealth_modifier_in_darkness_1", function(ctx)
    return (not ((ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside)) and
        (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1) and
        ((ctx.character_inputs.environment.moon_phase == 7) or
        (ctx.character_inputs.environment.moon_phase == 1)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_STEALTH_MODIFIER_IN_DARKNESS_1",
    condition_handler = "innate_enchantment_active_inline_ench_lilin_stealth_modifier_in_darkness_1",
    load_character_inputs = {
        environment = { daylight = true, moon_phase = true, outside = true },
        vitamins = { "lilin_ruach_vitamin" }
    },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", {
        add_handler = "innate_enchantment_inline_ench_lilin_stealth_modifier_in_darkness_1_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_lilin_stealth_modifier_in_darkness_2_value_0_add", function(ctx)
    return (40 + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 300))
end)

ccb.runtime.handler("innate_enchantment_active_inline_ench_lilin_stealth_modifier_in_darkness_2", function(ctx)
    return (not ((ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside)) and
        (ctx.character_inputs.environment.moon_phase == 0) and
        (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_STEALTH_MODIFIER_IN_DARKNESS_2",
    condition_handler = "innate_enchantment_active_inline_ench_lilin_stealth_modifier_in_darkness_2",
    load_character_inputs = {
        environment = { daylight = true, moon_phase = true, outside = true },
        vitamins = { "lilin_ruach_vitamin" }
    },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", {
        add_handler = "innate_enchantment_inline_ench_lilin_stealth_modifier_in_darkness_2_value_0_add",
        load_skills = {}
    }))
