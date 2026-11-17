local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("inline_enchantment_wielded_flags_spellcasting_aid", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.wielded_flags["SPELLCASTING_AID"]
end)

ccb.runtime.handler("inline_enchantment_wildwalker_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.terrain == "t_tree_young" or
        inputs.environment.terrain == "t_mega_fern" or
        inputs.environment.terrain == "t_fungus_colony" or
        inputs.environment.terrain_flags["SHRUB"] or
        inputs.environment.terrain == "t_bamboo_long" or
        inputs.environment.terrain == "t_bamboo_tall" or
        inputs.environment.terrain == "t_grass_tall" or
        inputs.environment.terrain == "t_grass_long" or
        inputs.environment.terrain == "t_bamboo" or
        inputs.environment.terrain == "t_bamboo_harvested" or
        inputs.environment.terrain == "t_grass" or
        inputs.environment.terrain == "t_grass_white" or
        inputs.environment.terrain == "t_moss" or
        inputs.environment.terrain == "t_forestfloor")
end)

ccb.runtime.handler("inline_enchantment_not_daylight", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.environment.daylight)
end)

ccb.runtime.handler("inline_enchantment_daylight", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.daylight
end)

ccb.runtime.handler("inline_enchantment_effects_effect_manatouched_mana_flash_active", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["effect_manatouched_mana_flash_active"]
end)

ccb.runtime.handler("inline_enchantment_not_can_drop_weapon", function(ctx)
    local inputs = ctx.character_inputs
    return not ((inputs.armed and not inputs.wielded_flags.NO_UNWIELD))
end)

ccb.runtime.handler("inline_enchantment_move_mode_run", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.move_mode == "run"
end)

ccb.runtime.handler("inline_enchantment_armed", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.armed
end)

ccb.runtime.handler("inline_enchantment_not_terrain_flag_swimmable", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.environment.terrain_flags["SWIMMABLE"])
end)

ccb.runtime.handler("inline_enchantment_terrain_flag_swimmable", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.terrain_flags["SWIMMABLE"]
end)

ccb.runtime.handler("inline_enchantment_druid_shifter_raven_form_traits_1", function(ctx)
    local inputs = ctx.character_inputs
    return (not (inputs.body_part_effects["arm_l"]["disabled"]) and
        not (inputs.body_part_effects["arm_r"]["disabled"]))
end)

ccb.runtime.handler("inline_enchantment_terrain_t_open_air", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.terrain == "t_open_air"
end)

-- mutations/magic_classes/classes.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_SPELLCASTING_DEFAULT_TRAIT_0",
    condition_handler = "inline_enchantment_wielded_flags_spellcasting_aid",
    load_character_inputs = { wielded_flags = { "SPELLCASTING_AID" } },
}
    :effect("effect_magiclysm_spellcasting_aid_item_wielded", 1))

-- mutations/mutation_paths/fantasy_species.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_WILDWALKER_0",
    condition_handler = "inline_enchantment_wildwalker_0",
    load_character_inputs = { environment = { terrain = true, terrain_flags = { "SHRUB" } } },
}
    :value("MOVE_COST", { multiply = -0.1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_NOCTURNAL_0",
    condition_handler = "inline_enchantment_not_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("SLEEPY", { add = -50 })
    :value("OVERMAP_SIGHT", { add = 6 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_NOCTURNAL_1",
    condition_handler = "inline_enchantment_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("SLEEPY", { add = 50 })
    :value("OVERMAP_SIGHT", { add = -2 }))

-- mutations/mutation_paths/manatouched.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_MANA_LUM_FLASH_0",
    condition_handler = "inline_enchantment_effects_effect_manatouched_mana_flash_active",
    load_character_inputs = { effects = { "effect_manatouched_mana_flash_active" } },
}
    :mutation("MANA_LUM_FLASH_ACTIVE"))

-- mutations/shapeshifter_mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_not_can_drop_weapon",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.15 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_not_can_drop_weapon",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.15 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_not_can_drop_weapon",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_not_terrain_flag_swimmable",
    load_character_inputs = { environment = { terrain_flags = { "SWIMMABLE" } } },
}
    :effect("effect_druid_shifter_fish_form_cant_move", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_terrain_flag_swimmable",
    load_character_inputs = { environment = { terrain_flags = { "SWIMMABLE" } } },
}
    :value("DEXTERITY", { add = 8 })
    :value("PERCEPTION", { add = 4 })
    :value("MOVECOST_SWIM_MOD", { multiply = -0.6 })
    :value("REGEN_STAMINA", { multiply = 10 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_druid_shifter_raven_form_traits_1",
    load_character_inputs = { body_part_effects = { arm_l = { "disabled" }, arm_r = { "disabled" } } },
}
    :effect("effect_druid_shifter_raven_form_levitation", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_terrain_t_open_air",
    load_character_inputs = { environment = { terrain = true } },
}
    :value("MOVE_COST", { multiply = -0.6 }))
