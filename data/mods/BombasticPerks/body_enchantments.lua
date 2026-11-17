local ccb = require("ccb")
local content = ccb.content

local function calorie_percentage(ctx)
    local reserves = ctx.character_inputs.calorie_reserves
    local divisor = reserves.healthy / 100.0
    if divisor == 0 then
        return reserves.stored
    end
    return reserves.stored / divisor
end

-- perks.json
ccb.runtime.handler("body_enchantment_active_inline_ench_perk_ghost_stealth_0", function(ctx)
    return (ctx.character_inputs.nearby_characters["characters_1"] == 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_ghost_stealth_0",
    condition_handler = "body_enchantment_active_inline_ench_perk_ghost_stealth_0",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "allies", radius = 20 }
        }
    },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", { add = 15 }))

ccb.runtime.handler("body_enchantment_active_inline_ench_perk_kevlard_0", function(ctx)
    local percentage = calorie_percentage(ctx)
    return percentage >= 200 and percentage < 300
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_kevlard_0",
    condition_handler = "body_enchantment_active_inline_ench_perk_kevlard_0",
    load_character_inputs = { calorie_reserves = true },
    native_modifier_order = true,
}
    :mutation("perk_kevlard_obese"))

ccb.runtime.handler("body_enchantment_active_inline_ench_perk_kevlard_1", function(ctx)
    local percentage = calorie_percentage(ctx)
    return percentage >= 300 and percentage < 400
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_kevlard_1",
    condition_handler = "body_enchantment_active_inline_ench_perk_kevlard_1",
    load_character_inputs = { calorie_reserves = true },
    native_modifier_order = true,
}
    :mutation("perk_kevlard_veryobese"))

ccb.runtime.handler("body_enchantment_active_inline_ench_perk_kevlard_2", function(ctx)
    local percentage = calorie_percentage(ctx)
    return percentage >= 400
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_kevlard_2",
    condition_handler = "body_enchantment_active_inline_ench_perk_kevlard_2",
    load_character_inputs = { calorie_reserves = true },
    native_modifier_order = true,
}
    :mutation("perk_kevlard_morbidlyobese"))

ccb.runtime.handler("body_enchantment_inline_ench_perk_peer_pressure_0_value_0_add", function(ctx)
    return ctx.character_inputs.nearby_characters["characters_1"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_peer_pressure_0",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "allies", radius = 15 }
        }
    },
    native_modifier_order = true,
}
    :value("SOCIAL_LIE", {
        add_handler = "body_enchantment_inline_ench_perk_peer_pressure_0_value_0_add",
        load_skills = {}
    })
    :value("SOCIAL_PERSUADE", {
        add_handler = "body_enchantment_inline_ench_perk_peer_pressure_0_value_0_add",
        load_skills = {}
    })
    :value("SOCIAL_INTIMIDATE", {
        add_handler = "body_enchantment_inline_ench_perk_peer_pressure_0_value_0_add",
        load_skills = {}
    }))
