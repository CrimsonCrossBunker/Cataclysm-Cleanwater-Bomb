local ccb = require("ccb")
local content = ccb.content

-- mutations/mutations.json
ccb.runtime.handler("world_enchantment_active_inline_ench_xe_faction_camp_brownie_blessing_0", function(ctx)
    return ctx.character_inputs.environment.faction_camp
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_XE_FACTION_CAMP_BROWNIE_BLESSING_0",
    condition_handler = "world_enchantment_active_inline_ench_xe_faction_camp_brownie_blessing_0",
    load_character_inputs = { environment = { faction_camp = true } },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.02 }))

-- mutations/paraclesians/arvore_mutations.json
ccb.runtime.handler("world_enchantment_active_inline_ench_greenstride_upgrade_1", function(ctx)
    return ((ctx.character_inputs.character_variables["arvore_is_in_forest"] == 1) or
        ctx.character_inputs.environment.overmap_terrain == "forest_trail")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_GREENSTRIDE_UPGRADE_1",
    condition_handler = "world_enchantment_active_inline_ench_greenstride_upgrade_1",
    load_character_inputs = {
        character_variables = { "arvore_is_in_forest" },
        environment = { overmap_terrain = true }
    },
    native_modifier_order = true,
}
    :value("PHASE_DISTANCE", { add = 5 }))

ccb.runtime.handler("world_enchantment_active_inline_ench_arvore_str_bonus_3_1", function(ctx)
    return (ctx.character_inputs.environment.outside and
        ctx.character_inputs.traits["THRESH_ARVORE"] and
        (ctx.character_inputs.environment.overmap_terrain == "forest" or
        ctx.character_inputs.environment.overmap_terrain == "forest_trail" or
        ctx.character_inputs.environment.overmap_terrain == "forest_thick"))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_STR_BONUS_3_1",
    condition_handler = "world_enchantment_active_inline_ench_arvore_str_bonus_3_1",
    load_character_inputs = {
        environment = { outside = true, overmap_terrain = true },
        traits = { "THRESH_ARVORE" }
    },
    native_modifier_order = true,
}
    :effect("effect_xe_blocking_huge_attacks", 1))
