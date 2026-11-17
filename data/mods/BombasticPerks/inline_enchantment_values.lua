local ccb = require("ccb")
local content = ccb.content

local function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

-- perkdata/percussive_entry.json
ccb.runtime.handler("inline_value_inline_ench_effect_perk_percussive_entry_0_value_0_multiply", function(ctx)
    return (0 + (ctx.character_inputs.effect_intensities["effect_perk_percussive_entry"] / 100))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_perk_percussive_entry_0",
    load_character_inputs = { effect_intensities = { "effect_perk_percussive_entry" } },
    native_modifier_order = true,
}
    :value("STRENGTH", { multiply_handler = "inline_value_inline_ench_effect_perk_percussive_entry_0_value_0_multiply", load_skills = {  } }))

-- perks.json
ccb.runtime.handler("inline_value_inline_ench_perk_redrage_0_melee_damage_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["bleed"] * 0.05)
end)

ccb.runtime.handler("inline_value_inline_ench_perk_redrage_0_melee_damage_1_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["bleed"] * 0.05)
end)

ccb.runtime.handler("inline_value_inline_ench_perk_redrage_0_melee_damage_2_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["bleed"] * 0.05)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_redrage_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "bleed" } },
    native_modifier_order = true,
}
    :melee_damage("bash", { multiply_handler = "inline_value_inline_ench_perk_redrage_0_melee_damage_0_multiply", load_skills = {  } })
    :melee_damage("stab", { multiply_handler = "inline_value_inline_ench_perk_redrage_0_melee_damage_1_multiply", load_skills = {  } })
    :melee_damage("cut", { multiply_handler = "inline_value_inline_ench_perk_redrage_0_melee_damage_2_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_perk_smash_boost_0_value_0_add", function(ctx)
    return (16 - clamp(ctx.stats.strength, 0, 16))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_smash_boost_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("SMASH_BONUS", { add_handler = "inline_value_inline_ench_perk_smash_boost_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_perk_dexterous_speed_0_value_0_add", function(ctx)
    return (math.max(0, (ctx.stats.dexterity - 8)) * 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_dexterous_speed_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "inline_value_inline_ench_perk_dexterous_speed_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_perk_dexterous_speed_1_value_0_multiply", function(ctx)
    return (math.min(0, (8 - ctx.stats.dexterity)) * 0.04)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_dexterous_speed_1", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("CARRY_WEIGHT", { multiply_handler = "inline_value_inline_ench_perk_dexterous_speed_1_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_perk_dexterous_speed_2_value_0_multiply", function(ctx)
    return (math.min(0, (20 - ctx.stats.dexterity)) * (-0.02))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_dexterous_speed_2", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("CARRY_WEIGHT", { multiply_handler = "inline_value_inline_ench_perk_dexterous_speed_2_value_0_multiply", load_skills = {  } }))
