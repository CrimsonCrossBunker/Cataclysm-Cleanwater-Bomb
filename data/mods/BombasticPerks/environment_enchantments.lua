local ccb = require("ccb")
local content = ccb.content

local function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

-- perkdata/closetland.json
ccb.runtime.handler("context_enchantment_active_inline_ench_effect_perk_closetland_sleepiness_0", function(ctx)
    return ctx.character_inputs.environment.dimension == "dimension_perk_closetland"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_perk_closetland_sleepiness_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_perk_closetland_sleepiness_0",
    load_character_inputs = { environment = { dimension = true } },
    native_modifier_order = true,
}
    :value("SLEEPINESS", { multiply = 25 }))

-- perks.json
ccb.runtime.handler("context_enchantment_active_inline_ench_perk_rage_against_unnatural_0", function(ctx)
    return ((ctx.character_inputs.nearby_monsters["monsters_1"] > 0) and
        not (ctx.character_inputs.effects["effect_perk_rage_against_the_unnatural_penalty"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_rage_against_unnatural_0",
    condition_handler = "context_enchantment_active_inline_ench_perk_rage_against_unnatural_0",
    load_character_inputs = { effects = { "effect_perk_rage_against_the_unnatural_penalty" }, nearby_monsters = { monsters_1 = { attitude = "both", radius = 1, species = { "NETHER" } } } },
    native_modifier_order = true,
}
    :value("ARMOR_ALL", { multiply = -0.15 })
    :melee_damage("bash", { multiply = 0.35 })
    :melee_damage("stab", { multiply = 0.35 })
    :melee_damage("cut", { multiply = 0.35 }))

ccb.runtime.handler("context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_0_add", function(ctx)
    return clamp(((ctx.character_inputs.physiology.thirst / 120) + (ctx.character_inputs.physiology.sleepiness / 150)), 0, 50)
end)

ccb.runtime.handler("context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_1_add", function(ctx)
    return clamp(((ctx.character_inputs.physiology.thirst / 120) + (ctx.character_inputs.physiology.sleepiness / 150)), 0, 50)
end)

ccb.runtime.handler("context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_2_add", function(ctx)
    return clamp(((ctx.character_inputs.physiology.thirst / 120) + (ctx.character_inputs.physiology.sleepiness / 150)), 0, 50)
end)

ccb.runtime.handler("context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_3_add", function(ctx)
    return clamp(((ctx.character_inputs.physiology.thirst / 120) + (ctx.character_inputs.physiology.sleepiness / 150)), 0, 50)
end)

ccb.runtime.handler("context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_4_add", function(ctx)
    return clamp(((ctx.character_inputs.physiology.thirst - 80) / 10), 0, 50)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_ascetic_empowerment_0", condition = "ALWAYS",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_0_add", load_skills = {  } })
    :value("DEXTERITY", { add_handler = "context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_1_add", load_skills = {  } })
    :value("INTELLIGENCE", { add_handler = "context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_2_add", load_skills = {  } })
    :value("PERCEPTION", { add_handler = "context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_3_add", load_skills = {  } })
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_perk_ascetic_empowerment_0_value_4_add", load_skills = {  } }))
