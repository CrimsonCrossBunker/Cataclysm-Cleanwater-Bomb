local ccb = require("ccb")
local content = ccb.content

local natural_floors = {
    t_barkfloor = true,
    t_barkfloor_noroof = true,
    t_heartwood_floor = true,
    t_floor_primitive = true,
    t_dirtfloor_thatchroof = true,
    t_dirtfloor = true,
    t_dirtfloor_no_roof = true,
}
local groundsheets = {
    f_large_groundsheet = true,
    f_fema_groundsheet = true,
    f_center_groundsheet = true,
}

local function wilderness_equivalent(ctx)
    local environment = ctx.character_inputs.environment
    return natural_floors[environment.terrain] == true
        or groundsheets[environment.furniture] == true
        or environment.overmap_terrain == "park"
        or environment.overmap_terrain == "park_5"
        or environment.overmap_terrain == "park_7"
end

-- effects/effects.json
-- The native reversed clamp bounds return the original operand.
ccb.runtime.handler("world_enchantment_inline_ench_effect_ethereal_grasp_4_value_0_add", function(ctx)
    return (((-5) + (ctx.character_inputs.character_variables["ethereal_grasp_affected_level"] - 15)) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("world_enchantment_active_inline_ench_effect_ethereal_grasp_4", function(ctx)
    return ((ctx.character_inputs.physiology.body_size >= 5) and
        (ctx.character_inputs.character_variables["ethereal_grasp_affected_level"] >= 15))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_4",
    condition_handler = "world_enchantment_active_inline_ench_effect_ethereal_grasp_4",
    load_character_inputs = {
        character_variables = { "ethereal_grasp_affected_level", "evocation_spell_affected_proficiency" },
        physiology = true
    },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "world_enchantment_inline_ench_effect_ethereal_grasp_4_value_0_add",
        load_skills = {}
    }))

-- mutations/mutation_paths/fantasy_species.json
ccb.runtime.handler("world_enchantment_active_inline_ench_elven_need_for_wilderness_0", function(ctx)
    return ((ctx.character_inputs.character_variables["magiclysm_elf_is_in_wilderness"] == 1) and
        (ctx.character_inputs.environment.outside or
        (not (ctx.character_inputs.environment.outside) and
        wilderness_equivalent(ctx))))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_NEED_FOR_WILDERNESS_0",
    condition_handler = "world_enchantment_active_inline_ench_elven_need_for_wilderness_0",
    load_character_inputs = {
        character_variables = { "magiclysm_elf_is_in_wilderness" },
        environment = { furniture = true, outside = true, overmap_terrain = true, terrain = true }
    },
    native_modifier_order = true,
}
    :effect("effect_elven_wilderness_bonus_gain_vitamin", 1))

ccb.runtime.handler("world_enchantment_active_inline_ench_elven_need_for_wilderness_1", function(ctx)
    return ((ctx.character_inputs.character_variables["magiclysm_elf_is_in_wilderness"] == 0) and
        (wilderness_equivalent(ctx) or
        ctx.character_inputs.effects["natures_commune"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_NEED_FOR_WILDERNESS_1",
    condition_handler = "world_enchantment_active_inline_ench_elven_need_for_wilderness_1",
    load_character_inputs = {
        character_variables = { "magiclysm_elf_is_in_wilderness" },
        effects = { "natures_commune" },
        environment = { furniture = true, overmap_terrain = true, terrain = true }
    },
    native_modifier_order = true,
}
    :effect("effect_elven_wilderness_bonus_steady_state", 1))

ccb.runtime.handler("world_enchantment_active_inline_ench_elven_need_for_wilderness_2", function(ctx)
    return (((ctx.character_inputs.character_variables["magiclysm_elf_is_in_wilderness"] == 0) or
        (ctx.character_inputs.environment.position_z <= (-1))) and
        not (wilderness_equivalent(ctx)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_NEED_FOR_WILDERNESS_2",
    condition_handler = "world_enchantment_active_inline_ench_elven_need_for_wilderness_2",
    load_character_inputs = {
        character_variables = { "magiclysm_elf_is_in_wilderness" },
        environment = { furniture = true, overmap_terrain = true, position_z = true, terrain = true }
    },
    native_modifier_order = true,
}
    :effect("effect_elven_wilderness_bonus_lose_vitamin", 1))
