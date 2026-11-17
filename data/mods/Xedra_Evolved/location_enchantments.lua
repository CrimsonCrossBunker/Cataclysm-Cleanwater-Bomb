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

ccb.runtime.handler("eater_sixth_sense_range", function(ctx)
    return ctx.character_inputs.spell_school_counts.EATER
end)

ccb.runtime.handler("eater_sixth_sense_detects_target", function(ctx)
    local species = ctx.target_inputs.species
    return species.HORROR or species.NETHER or species.nether_player_hate
end)

content.add(content.Enchantment {
    id = "EATER_SIXTH_SENSE",
    condition = "ALWAYS",
    load_character_inputs = { spell_school_counts = { "EATER" } },
}:vision {
    distance_handler = "eater_sixth_sense_range",
    condition_handler = "eater_sixth_sense_detects_target",
    target_inputs = { species = { "HORROR", "NETHER", "nether_player_hate" } },
    descriptions = { {
        id = "moving_creature", symbol = "?", color = "c_white",
        text = content.text("You sense an otherworldy danger here."),
    } },
})

ccb.runtime.handler("arvore_sight_range", function(ctx)
    return ctx.stats.perception + ctx.stats.intelligence
end)

local natural_species = {
    "MAMMAL", "BIRD", "REPTILE", "PLANT", "AMPHIBIAN", "FISH", "INSECT", "CENTIPEDE",
    "SPIDER", "INSECT_FLYING", "MOLLUSK", "ARVORE",
}
local unnatural_species = {
    "ZOMBIE", "FUNGUS", "MIGO", "NETHER", "NETHER_BURROWING", "VAMPIRE", "NIGHTMARE", "HORROR", "ABERRATION",
}
local function any_species(species, kinds)
    for _, kind in ipairs(kinds) do
        if species[kind] then
            return true
        end
    end
    return false
end

ccb.runtime.handler("arvore_sight_detects_humans", function(ctx)
    local target = ctx.target_inputs
    local species = target.species
    return not species.ZOMBIE and (target.npc or species.FERAL or species.HUMAN or species.RENFIELD
        or target.flags.HUMAN)
end)

ccb.runtime.handler("arvore_sight_detects_natural_creatures", function(ctx)
    local species = ctx.target_inputs.species
    return not species.ZOMBIE and any_species(species, natural_species)
end)

ccb.runtime.handler("arvore_sight_detects_unnatural_creatures", function(ctx)
    return any_species(ctx.target_inputs.species, unnatural_species)
end)

local natural_vision_inputs = { "ZOMBIE" }
for _, kind in ipairs(natural_species) do
    natural_vision_inputs[#natural_vision_inputs + 1] = kind
end

content.add(content.Enchantment {
    id = "arvore_forest_detect_enemies",
    condition_handler = "arvore_overmap_sight_active",
    load_character_inputs = { environment = forest_environment, traits = { "ARVORE_TREE_FORM_TRAITS" } },
}
    :vision {
        distance_handler = "arvore_sight_range",
        condition_handler = "arvore_sight_detects_humans",
        target_inputs = { species = { "ZOMBIE", "FERAL", "HUMAN", "RENFIELD" }, flags = { "HUMAN" }, npc = true },
        descriptions = { {
            id = "human_sense", symbol = "@", color = "c_white",
            text = content.text("The forest nervously whispers to you about the presence of humans."),
        } },
    }
    :vision {
        distance_handler = "arvore_sight_range",
        condition_handler = "arvore_sight_detects_natural_creatures",
        target_inputs = { species = natural_vision_inputs },
        descriptions = { {
            id = "infrared_creature_medium", symbol = "?", color = "c_green",
            text = content.text("The forest gently whispers to you about the creatures of nature."),
        } },
    }
    :vision {
        distance_handler = "arvore_sight_range",
        condition_handler = "arvore_sight_detects_unnatural_creatures",
        target_inputs = { species = unnatural_species },
        descriptions = { {
            id = "alien_being_sense", symbol = "?", color = "c_red",
            text = content.text("The forest whispers warnings of unnatural creatures nearby."),
        } },
    })

content.add(content.Enchantment {
    id = "ench_arvore_tree_form",
    condition = "ALWAYS",
    load_character_inputs = {},
}
    :vision {
        distance_handler = "arvore_sight_range",
        descriptions = { {
            id = "moving_creature", symbol = "?", color = "c_white",
            text = content.text("You sense something moving here."),
        } },
    }
    :value("SLEEPY", { add = 150 })
    :value("CLIMATE_CONTROL_HEAT", { add = 150 }))
