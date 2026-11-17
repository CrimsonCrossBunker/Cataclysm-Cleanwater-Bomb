local ccb = require("ccb")
local content = ccb.content

local random = ccb.services.random

-- data/json/effects.json
ccb.runtime.handler("inline_value_inline_ench_grown_of_fuse_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["grown_of_fuse"] / 32)
end)

ccb.runtime.handler("inline_value_inline_ench_grown_of_fuse_0_value_1_add", function(ctx)
    return (ctx.character_inputs.effect_intensities["grown_of_fuse"] * 0.06)
end)

ccb.runtime.handler("inline_value_inline_ench_grown_of_fuse_0_incoming_damage_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["grown_of_fuse"] / (-900))
end)

ccb.runtime.handler("inline_value_inline_ench_grown_of_fuse_0_incoming_damage_1_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["grown_of_fuse"] / (-1500))
end)

ccb.runtime.handler("inline_value_inline_ench_grown_of_fuse_0_incoming_damage_2_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["grown_of_fuse"] / (-1500))
end)

ccb.runtime.handler("inline_value_inline_ench_grown_of_fuse_0_incoming_damage_3_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["grown_of_fuse"] / (-650))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_grown_of_fuse_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "grown_of_fuse" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_value_inline_ench_grown_of_fuse_0_value_0_multiply", load_skills = {  } })
    :value("SPEED", { add_handler = "inline_value_inline_ench_grown_of_fuse_0_value_1_add", load_skills = {  } })
    :incoming_damage("bash", { multiply_handler = "inline_value_inline_ench_grown_of_fuse_0_incoming_damage_0_multiply", load_skills = {  } })
    :incoming_damage("cut", { multiply_handler = "inline_value_inline_ench_grown_of_fuse_0_incoming_damage_1_multiply", load_skills = {  } })
    :incoming_damage("stab", { multiply_handler = "inline_value_inline_ench_grown_of_fuse_0_incoming_damage_2_multiply", load_skills = {  } })
    :incoming_damage("bullet", { multiply_handler = "inline_value_inline_ench_grown_of_fuse_0_incoming_damage_3_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_lung_collapse_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["lung_collapse"] * (-0.25))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_lung_collapse_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "lung_collapse" } },
    native_modifier_order = true,
}
    :value("SPEED", { multiply_handler = "inline_value_inline_ench_lung_collapse_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_bio_hydraulics_active_0_value_0_add", function(ctx)
    return math.max(10, (20 - ctx.character_inputs.character_variables["bio_hydraulics_strength_adjustment"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_bio_hydraulics_active_0",
    load_character_inputs = { character_variables = { "bio_hydraulics_strength_adjustment" } },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "inline_value_inline_ench_effect_bio_hydraulics_active_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_hypocalcemia_0_value_0_multiply", function(ctx)
    return math.max(((-0.08) * ctx.character_inputs.effect_intensities["hypocalcemia"]), (-0.24))
end)

ccb.runtime.handler("inline_value_inline_ench_hypocalcemia_0_incoming_damage_0_multiply", function(ctx)
    return math.min((ctx.character_inputs.effect_intensities["hypocalcemia"] * 0.1), 0.3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_hypocalcemia_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "hypocalcemia" } },
    native_modifier_order = true,
}
    :value("CARRY_WEIGHT", { multiply_handler = "inline_value_inline_ench_hypocalcemia_0_value_0_multiply", load_skills = {  } })
    :incoming_damage("bash", { multiply_handler = "inline_value_inline_ench_hypocalcemia_0_incoming_damage_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_vitrifying_0_value_0_add", function(ctx)
    return ((ctx.character_inputs.effect_intensities["VITRIFYING"] * (-1)) * math.ceil((ctx.stats.intelligence / 6)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VITRIFYING_0",
    load_character_inputs = { effect_intensities = { "VITRIFYING" } },
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add_handler = "inline_value_inline_ench_vitrifying_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_nether_shadow_unnatural_chill_0_value_0_add", function(ctx)
    return math.max(((-2) * ctx.character_inputs.effect_intensities["effect_nether_shadow_unnatural_chill"]), (-50))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_nether_shadow_unnatural_chill_0_incoming_damage_0_add", function(ctx)
    return math.max((1 + (ctx.character_inputs.effect_intensities["effect_nether_shadow_unnatural_chill"] * 0.5)), 10)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_nether_shadow_unnatural_chill_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "effect_nether_shadow_unnatural_chill" } },
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add_handler = "inline_value_inline_ench_effect_nether_shadow_unnatural_chill_0_value_0_add", load_skills = {  } })
    :incoming_damage("cold", { add_handler = "inline_value_inline_ench_effect_nether_shadow_unnatural_chill_0_incoming_damage_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_shocker_zombie_charge_up_0_value_0_add", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_shocker_zombie_charge_up"] * 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_shocker_zombie_charge_up_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "effect_shocker_zombie_charge_up" } },
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "inline_value_inline_ench_effect_shocker_zombie_charge_up_0_value_0_add", load_skills = {  } }))

-- data/json/mutations/mutations.json
ccb.runtime.handler("inline_value_inline_ench_int_slime_0_value_1_add", function(ctx)
    return (ctx.character_inputs.pain / 6)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_INT_SLIME_0",
    load_character_inputs = { pain = true },
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { multiply = 1 })
    :value("PAIN_PENALTY_MOD_INT", { add_handler = "inline_value_inline_ench_int_slime_0_value_1_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_per_slime_0_value_0_multiply", function(ctx)
    return random.native_float((-0.75), 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_PER_SLIME_0",
    native_modifier_order = true,
}
    :value("HEARING_MULT", { multiply_handler = "inline_value_inline_ench_per_slime_0_value_0_multiply", load_skills = {  } })
    :value("PERCEPTION", { add = -8 }))
