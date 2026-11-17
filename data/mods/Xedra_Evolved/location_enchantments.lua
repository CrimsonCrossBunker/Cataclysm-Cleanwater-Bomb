local ccb = require("ccb")
local content = ccb.content

local forest_environment = {
    outside = true,
    terrain = true,
    terrain_flags = { "SHRUB", "YOUNG" },
    overmap_terrain = true,
}

local function on_wooded_ground(environment)
    local flags = environment.terrain_flags
    local terrain = environment.terrain
    if flags.SHRUB or flags.YOUNG or terrain == "t_bamboo_tall" or terrain == "t_grass_long" then
        return true
    end
    local overmap = environment.overmap_terrain
    return overmap == "forest" or overmap == "forest_thick"
end

ccb.runtime.handler("arvore_overmap_sight_active", function(ctx)
    local state = ctx.character_inputs
    return state.environment.outside
        and (state.traits.ARVORE_TREE_FORM_TRAITS or on_wooded_ground(state.environment))
end)

ccb.runtime.handler("arvore_overmap_sight_bonus", function(ctx)
    local traits = ctx.character_inputs.traits
    return (traits.ARVORE_FOREST_DETECT_AND_OVERMAP and 2 or 0) + (traits.THRESH_ARVORE and 2 or 0)
end)

content.add(content.Enchantment {
    id = "arvore_forest_see_overmap",
    condition_handler = "arvore_overmap_sight_active",
    load_character_inputs = {
        environment = forest_environment,
        traits = { "ARVORE_TREE_FORM_TRAITS", "ARVORE_FOREST_DETECT_AND_OVERMAP", "THRESH_ARVORE" },
    },
}:value("OVERMAP_SIGHT", { add_handler = "arvore_overmap_sight_bonus" }))

ccb.runtime.handler("arvore_forest_stealth_active", function(ctx)
    local environment = ctx.character_inputs.environment
    return environment.outside and on_wooded_ground(environment)
end)

ccb.runtime.handler("arvore_forest_stealth_bonus", function(ctx)
    return ctx.character_inputs.traits.THRESH_ARVORE and 60 or 40
end)

content.add(content.Enchantment {
    id = "ench_arvore_forest_stealth",
    condition_handler = "arvore_forest_stealth_active",
    load_character_inputs = { environment = forest_environment, traits = { "THRESH_ARVORE" } },
}:value("STEALTH_MODIFIER", { add_handler = "arvore_forest_stealth_bonus" }))

ccb.runtime.handler("arvore_sense_sun_active", function(ctx)
    return ctx.character_inputs.environment.position_z >= 0
end)

content.add(content.Enchantment {
    id = "ench_arvore_sense_sun",
    condition_handler = "arvore_sense_sun_active",
    load_character_inputs = { environment = { position_z = true } },
}:effect("effect_arvore_sense_sun", 1))

ccb.runtime.handler("arvore_wilds_mending_active", function(ctx)
    local environment = ctx.character_inputs.environment
    local flags = environment.terrain_flags
    return environment.outside and (flags.SHRUB or flags.DIGGABLE or flags.YOUNG)
        and not environment.nearby_overmap_terrain.road
end)

content.add(content.Enchantment {
    id = "ench_arvore_wilds_super_mending",
    condition_handler = "arvore_wilds_mending_active",
    load_character_inputs = {
        environment = {
            outside = true,
            terrain_flags = { "SHRUB", "DIGGABLE", "YOUNG" },
            nearby_overmap_terrain = { road = 1 },
        },
    },
}:value("MENDING_MODIFIER", { multiply = 10 }))

local photosynthesis_terrain = {
    t_tree_young = true, t_bamboo_tall = true, t_dirt = true, t_dirtmound = true,
    t_clay = true, t_sand = true, t_sandmound = true, t_grave = true,
    t_forestfloor = true, t_grass = true, t_grass_long = true, t_grass_tall = true,
    t_grass_dead = true, t_mud = true, t_dirtfloor_no_roof = true, t_moss = true,
}

ccb.runtime.handler("arvore_sun_foods_active", function(ctx)
    local environment = ctx.character_inputs.environment
    return environment.daylight and environment.outside
        and (environment.terrain_flags.SHRUB or photosynthesis_terrain[environment.terrain] == true)
end)

content.add(content.Enchantment {
    id = "ench_arvore_sun_foods_on",
    condition_handler = "arvore_sun_foods_active",
    load_character_inputs = {
        environment = { daylight = true, outside = true, terrain = true, terrain_flags = { "SHRUB" } },
    },
}
    :value("HUNGER", { multiply = -1 })
    :effect("effect_xe_hidden_hunger", 1))

ccb.runtime.handler("sylph_fast_cast_outdoors", function(ctx)
    return ctx.character_inputs.environment.outside
end)

local sylph_outdoors = { environment = { outside = true } }
content.add(content.Enchantment {
    id = "sylph_fast_cast",
    condition_handler = "sylph_fast_cast_outdoors",
    load_character_inputs = sylph_outdoors,
}:value("CASTING_TIME_MULTIPLIER", { multiply = -0.15 }))

content.add(content.Enchantment {
    id = "sylph_fast_cast2",
    condition_handler = "sylph_fast_cast_outdoors",
    load_character_inputs = sylph_outdoors,
}
    :value("CASTING_TIME_MULTIPLIER", { multiply = -0.15 })
    :effect("effect_subtle_spell_flag", 1))

ccb.runtime.handler("undine_deep_water_hiding", function(ctx)
    return ctx.character_inputs.environment.divable
end)

content.add(content.Enchantment {
    id = "undine_water_form_hiding",
    condition_handler = "undine_deep_water_hiding",
    load_character_inputs = { environment = { divable = true } },
}:value("STEALTH_MODIFIER", { add = 60 }))

-- 80 °F converted using the engine's single-precision temperature units.
local warm_weather_kelvin = 299.816680908203125
ccb.runtime.handler("salamander_warmth_active", function(ctx)
    local state = ctx.character_inputs
    local environment = state.environment
    return environment.temperature_kelvin >= warm_weather_kelvin
        or state.character_variables.salamander_near_fire == 1
        or environment.fields.fd_salamander_heat
        or environment.fields.fd_migo_atmosphere
end)

local salamander_heat = {
    character_variables = { "salamander_near_fire" },
    environment = { temperature_kelvin = true, fields = { "fd_salamander_heat", "fd_migo_atmosphere" } },
}
content.add(content.Enchantment {
    id = "ench_salamander_heat_healing",
    condition_handler = "salamander_warmth_active",
    load_character_inputs = salamander_heat,
}
    :value("REGEN_HP", { multiply = 0.4 })
    :value("MENDING_MODIFIER", { multiply = 3 }))

content.add(content.Enchantment {
    id = "ench_salamander_heat_crafting",
    condition_handler = "salamander_warmth_active",
    load_character_inputs = salamander_heat,
}:value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.15 }))
