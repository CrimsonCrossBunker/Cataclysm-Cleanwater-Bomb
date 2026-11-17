local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("inline_enchantment_not_traits_disimmune", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["DISIMMUNE"])
end)

ccb.runtime.handler("inline_enchantment_not_traits_infimmune", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["INFIMMUNE"])
end)

ccb.runtime.handler("inline_enchantment_armed", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.armed
end)

ccb.runtime.handler("inline_enchantment_not_traits_turn_into_owl_traits", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["TURN_INTO_OWL_TRAITS"])
end)

ccb.runtime.handler("inline_enchantment_effect_lilin_owl_form_pass_through_walls_1", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.traits["TURN_INTO_OWL_TRAITS"] and
        not (inputs.environment.daylight))
end)

ccb.runtime.handler("inline_enchantment_effect_xe_werewolf_illuminate_target_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.daylight or
        not (inputs.environment.outside))
end)

ccb.runtime.handler("inline_enchantment_effect_xe_werewolf_illuminate_target_1", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.outside and
        not (inputs.environment.daylight))
end)

ccb.runtime.handler("inline_enchantment_not_traits_wolf_vampire_wolf_form_traits", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["WOLF_VAMPIRE_WOLF_FORM_TRAITS"])
end)

ccb.runtime.handler("inline_enchantment_not_armed", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.armed)
end)

ccb.runtime.handler("inline_enchantment_effect_goblin_fruit_wild_travel_boost_0", function(ctx)
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

ccb.runtime.handler("inline_enchantment_traits_vampire_torpor_refinement_feign_death", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["VAMPIRE_TORPOR_REFINEMENT_FEIGN_DEATH"]
end)

ccb.runtime.handler("inline_enchantment_effects_effect_dhampir_empowered_blood_indicator", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["effect_dhampir_empowered_blood_indicator"]
end)

ccb.runtime.handler("inline_enchantment_dhampir_weakness_sun_sensitivity_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.daylight and
        inputs.environment.outside)
end)

ccb.runtime.handler("inline_enchantment_dhampir_weakness_sun_sleepiness_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.daylight and
        inputs.environment.outside and
        not (inputs.effects["sleep"]))
end)

ccb.runtime.handler("inline_enchantment_dhampir_weakness_sun_sleepiness_1", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.daylight and
        not (inputs.effects["sleep"]))
end)

ccb.runtime.handler("inline_enchantment_daylight", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.daylight
end)

ccb.runtime.handler("inline_enchantment_dhampir_weakness_slow_healing_0", function(ctx)
    local inputs = ctx.character_inputs
    return not ((inputs.traits["SLOWHEALER"] or
        inputs.traits["SLOWHEALER2"] or
        inputs.traits["SLOWHEALER3"]))
end)

ccb.runtime.handler("inline_enchantment_dhampir_weakness_slow_healing_1", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.traits["SLOWHEALER"] or
        inputs.traits["SLOWHEALER2"])
end)

ccb.runtime.handler("inline_enchantment_traits_slowhealer3", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["SLOWHEALER3"]
end)

ccb.runtime.handler("inline_enchantment_dhampir_weakness_water_pain_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.body_part_effects["leg_r"]["wet"] and
        inputs.body_part_effects["leg_l"]["wet"] and
        (inputs.environment.terrain_flags["LIQUID"] and
        inputs.environment.terrain_flags["CURRENT"] and
        inputs.environment.terrain_flags["SWIMMABLE"]))
end)

ccb.runtime.handler("inline_enchantment_vampire_0", function(ctx)
    local inputs = ctx.character_inputs
    return not ((inputs.effects["vampire_attacked_vampire_or_renfield"] or
        inputs.traits["VAMPIRE_ANATHEMA"]))
end)

ccb.runtime.handler("inline_enchantment_eyegleam_1", function(ctx)
    local inputs = ctx.character_inputs
    return (not (inputs.environment.daylight) and
        inputs.environment.outside)
end)

ccb.runtime.handler("inline_enchantment_vampiric_resilience_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.traits["VAMPIRE"] or
        (inputs.traits["DHAMPIR_TRAIT"] and
        not (inputs.effects["effect_dhampir_enervated_blood"])))
end)

ccb.runtime.handler("inline_enchantment_traits_vampire4", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["VAMPIRE4"]
end)

ccb.runtime.handler("inline_enchantment_not_daylight", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.environment.daylight)
end)

ccb.runtime.handler("inline_enchantment_traits_dhampir_trait", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["DHAMPIR_TRAIT"]
end)

ccb.runtime.handler("inline_enchantment_not_traits_vampire_bat_form_refinement_swarm", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["VAMPIRE_BAT_FORM_REFINEMENT_SWARM"])
end)

ccb.runtime.handler("inline_enchantment_vampire_bat_form_traits_2", function(ctx)
    local inputs = ctx.character_inputs
    return (not (inputs.body_part_effects["arm_l"]["disabled"]) and
        not (inputs.body_part_effects["arm_r"]["disabled"]))
end)

ccb.runtime.handler("inline_enchantment_terrain_t_open_air", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.terrain == "t_open_air"
end)

ccb.runtime.handler("inline_enchantment_not_can_drop_weapon", function(ctx)
    local inputs = ctx.character_inputs
    return not ((inputs.armed and not inputs.wielded_flags.NO_UNWIELD))
end)

ccb.runtime.handler("inline_enchantment_move_mode_run", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.move_mode == "run"
end)

ccb.runtime.handler("inline_enchantment_worn_flags_warding_symbol", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.worn_flags["WARDING_SYMBOL"]
end)

ccb.runtime.handler("inline_enchantment_wielded_flags_wooden_weapon", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.wielded_flags["WOODEN_WEAPON"]
end)

ccb.runtime.handler("inline_enchantment_worn_flags_sturdy", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.worn_flags["STURDY"]
end)

ccb.runtime.handler("inline_enchantment_not_terrain_flag_road", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.environment.terrain_flags["ROAD"])
end)

ccb.runtime.handler("inline_enchantment_effects_effect_ierde_sense_nearby_monsters", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["effect_ierde_sense_nearby_monsters"]
end)

ccb.runtime.handler("inline_enchantment_terrain_t_rock", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.terrain == "t_rock"
end)

ccb.runtime.handler("inline_enchantment_arvore_3", function(ctx)
    local inputs = ctx.character_inputs
    return (not (inputs.effects["effect_arvore_attacked_a_triffid"]) and
        (inputs.traits["ARVORE_VERDANT_HAIR"] and
        (inputs.traits["ARVORE_SKIN_2"] or
        inputs.traits["ARVORE_SKIN_3"]) and
        (inputs.traits["ARVORE_FLORAL_SCENT"] or
        inputs.traits["ARVORE_MIND_CONTROL_POLLEN"]) and
        (inputs.traits["ARVORE_BLOOD"] or
        inputs.traits["ARVORE_BLOOD_2"] or
        inputs.traits["ARVORE_BLOOD_3"] or
        inputs.traits["ARVORE_BLOOD_4"])))
end)

ccb.runtime.handler("inline_enchantment_outside", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.outside
end)

ccb.runtime.handler("inline_enchantment_divable", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.divable
end)

ccb.runtime.handler("inline_enchantment_not_effects_effect_brownie_attacked_someone", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.effects["effect_brownie_attacked_someone"])
end)

ccb.runtime.handler("inline_enchantment_pooka_quadruped_traits_0", function(ctx)
    local inputs = ctx.character_inputs
    return ((inputs.move_mode == "crouch" or
        inputs.move_mode == "run") and
        not ((inputs.armed and not inputs.wielded_flags.NO_UNWIELD)))
end)

ccb.runtime.handler("inline_enchantment_selkie_watersleep_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.terrain_flags["DEEP_WATER"] or
        inputs.environment.terrain_flags["SWIMMABLE"])
end)

ccb.runtime.handler("inline_enchantment_traits_vampire_wolf_form_traits", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"]
end)

ccb.runtime.handler("inline_enchantment_werewolf_primal_form_traits_1", function(ctx)
    local inputs = ctx.character_inputs
    return (not ((inputs.armed and not inputs.wielded_flags.NO_UNWIELD)))
end)

ccb.runtime.handler("inline_enchantment_lilin_unarmed_extra_damage_4", function(ctx)
    local inputs = ctx.character_inputs
    return (not (inputs.armed) and
        not ((inputs.environment.daylight and
        inputs.environment.outside)))
end)

-- effects/effects.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_dhampir_resist_disease_poison_infection_1",
    condition_handler = "inline_enchantment_not_traits_disimmune",
    load_character_inputs = { traits = { "DISIMMUNE" } },
}
    :mutation("DISRESISTANT"))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_dhampir_resist_disease_poison_infection_2",
    condition_handler = "inline_enchantment_not_traits_infimmune",
    load_character_inputs = { traits = { "INFIMMUNE" } },
}
    :mutation("INFRESIST"))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_noble_burning_weapon_0",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("LUMINATION", { add = 25 })
    :hit_you({ id = "changeling_noble_burning_weapon_fire_damage" })
    :hit_you({ id = "changeling_noble_burning_weapon_anti_nether" }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_speed_boost_1",
    condition_handler = "inline_enchantment_not_traits_turn_into_owl_traits",
    load_character_inputs = { traits = { "TURN_INTO_OWL_TRAITS" } },
}
    :value("MOVE_COST", { multiply = -0.5 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_owl_form_pass_through_walls_1",
    condition_handler = "inline_enchantment_effect_lilin_owl_form_pass_through_walls_1",
    load_character_inputs = { environment = { daylight = true }, traits = { "TURN_INTO_OWL_TRAITS" } },
}
    :value("PHASE_DISTANCE", { add = 1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_werewolf_illuminate_target_0",
    condition_handler = "inline_enchantment_effect_xe_werewolf_illuminate_target_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("LUMINATION", { add = 20 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_werewolf_illuminate_target_1",
    condition_handler = "inline_enchantment_effect_xe_werewolf_illuminate_target_1",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("LUMINATION", { add = 45 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_werewolf_camouflage_as_wolf_0",
    condition_handler = "inline_enchantment_not_traits_wolf_vampire_wolf_form_traits",
    load_character_inputs = { traits = { "WOLF_VAMPIRE_WOLF_FORM_TRAITS" } },
}
    :value("STEALTH_MODIFIER", { add = 10 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_werewolf_redhanded_rage_0",
    condition_handler = "inline_enchantment_not_armed",
    load_character_inputs = { armed = true },
}
    :value("ATTACK_SPEED", { multiply = -0.1 })
    :value("PAIN", { multiply = -0.25 }))

-- effects/goblin_fruit_effects.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_goblin_fruit_wild_travel_boost_0",
    condition_handler = "inline_enchantment_effect_goblin_fruit_wild_travel_boost_0",
    load_character_inputs = { environment = { terrain = true, terrain_flags = { "SHRUB" } } },
}
    :value("MOVE_COST", { multiply = -0.1 }))

-- mutations/vampire_trait_eocs.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampire_torpor_0",
    condition_handler = "inline_enchantment_traits_vampire_torpor_refinement_feign_death",
    load_character_inputs = { traits = { "VAMPIRE_TORPOR_REFINEMENT_FEIGN_DEATH" } },
}
    :mutation("WINTER_FEIGN_DEATH_TRAITS"))

-- mutations/mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_REDUCED_COLD_TEMPS_0",
    condition_handler = "inline_enchantment_effects_effect_dhampir_empowered_blood_indicator",
    load_character_inputs = { effects = { "effect_dhampir_empowered_blood_indicator" } },
}
    :value("CLIMATE_CONTROL_CHILL", { add = 25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_RESIST_DISEASE_POISON_INFECTION_0",
    condition_handler = "inline_enchantment_effects_effect_dhampir_empowered_blood_indicator",
    load_character_inputs = { effects = { "effect_dhampir_empowered_blood_indicator" } },
}
    :effect("effect_dhampir_resist_disease_poison_infection", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_SLOWFALL_0",
    condition_handler = "inline_enchantment_effects_effect_dhampir_empowered_blood_indicator",
    load_character_inputs = { effects = { "effect_dhampir_empowered_blood_indicator" } },
}
    :value("FALL_DAMAGE", { multiply = -0.8 })
    :effect("effect_dhampir_fall_one_story", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SENSITIVITY_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("STRENGTH", { add = -1 })
    :value("DEXTERITY", { add = -1 })
    :value("INTELLIGENCE", { add = -1 })
    :value("PERCEPTION", { add = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SLEEPINESS_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sleepiness_0",
    load_character_inputs = { effects = { "sleep" }, environment = { daylight = true, outside = true } },
}
    :value("SLEEPINESS", { multiply = 2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SLEEPINESS_1",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sleepiness_1",
    load_character_inputs = { effects = { "sleep" }, environment = { daylight = true } },
}
    :value("SLEEPINESS", { multiply = 0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SLEEPINESS_2",
    condition_handler = "inline_enchantment_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("SLEEPY", { add = 50 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SLOW_HEALING_0",
    condition_handler = "inline_enchantment_dhampir_weakness_slow_healing_0",
    load_character_inputs = { traits = { "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3" } },
}
    :value("REGEN_HP", { multiply = -0.5 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SLOW_HEALING_1",
    condition_handler = "inline_enchantment_dhampir_weakness_slow_healing_1",
    load_character_inputs = { traits = { "SLOWHEALER", "SLOWHEALER2" } },
}
    :value("REGEN_HP", { multiply = -0.2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SLOW_HEALING_2",
    condition_handler = "inline_enchantment_traits_slowhealer3",
    load_character_inputs = { traits = { "SLOWHEALER3" } },
}
    :value("REGEN_HP", { multiply = -0.05 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_WATER_PAIN_0",
    condition_handler = "inline_enchantment_dhampir_weakness_water_pain_0",
    load_character_inputs = { body_part_effects = { leg_l = { "wet" }, leg_r = { "wet" } }, environment = { terrain_flags = { "CURRENT", "LIQUID", "SWIMMABLE" } } },
}
    :effect("effect_dhampir_water_weakness_pain", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_0",
    condition_handler = "inline_enchantment_vampire_0",
    load_character_inputs = { effects = { "vampire_attacked_vampire_or_renfield" }, traits = { "VAMPIRE_ANATHEMA" } },
}
    :mutation("VAMPIRE_TRUCE"))

content.add(content.Enchantment {
    id = "INLINE_ENCH_EYEGLEAM_1",
    condition_handler = "inline_enchantment_eyegleam_1",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("OVERMAP_SIGHT", { add = 2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRIC_RESILIENCE_0",
    condition_handler = "inline_enchantment_vampiric_resilience_0",
    load_character_inputs = { effects = { "effect_dhampir_enervated_blood" }, traits = { "DHAMPIR_TRAIT", "VAMPIRE" } },
}
    :incoming_damage("bash", { multiply = -0.05 })
    :incoming_damage("stab", { multiply = -0.02 })
    :incoming_damage("cut", { multiply = -0.03 })
    :incoming_damage("bullet", { multiply = -0.08 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRIC_RESILIENCE_1",
    condition_handler = "inline_enchantment_traits_vampire4",
    load_character_inputs = { traits = { "VAMPIRE4" } },
}
    :incoming_damage("bash", { multiply = -0.05 })
    :incoming_damage("stab", { multiply = -0.02 })
    :incoming_damage("cut", { multiply = -0.03 })
    :incoming_damage("bullet", { multiply = -0.08 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_SILENT_MOVE_0",
    condition_handler = "inline_enchantment_vampiric_resilience_0",
    load_character_inputs = { effects = { "effect_dhampir_enervated_blood" }, traits = { "DHAMPIR_TRAIT", "VAMPIRE" } },
}
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE3_0",
    condition_handler = "inline_enchantment_not_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("OVERMAP_SIGHT", { add = 1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_BONUS_HP_1",
    condition_handler = "inline_enchantment_traits_dhampir_trait",
    load_character_inputs = { traits = { "DHAMPIR_TRAIT" } },
}
    :value("MAX_HP", { multiply = 0.15 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_0",
    condition_handler = "inline_enchantment_not_traits_vampire_bat_form_refinement_swarm",
    load_character_inputs = { traits = { "VAMPIRE_BAT_FORM_REFINEMENT_SWARM" } },
}
    :value("MAX_HP", { multiply = -0.85 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_vampire_bat_form_traits_2",
    load_character_inputs = { body_part_effects = { arm_l = { "disabled" }, arm_r = { "disabled" } } },
}
    :effect("effect_vampire_bat_form_levitation", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_4",
    condition_handler = "inline_enchantment_terrain_t_open_air",
    load_character_inputs = { environment = { terrain = true } },
}
    :value("MOVE_COST", { multiply = -0.6 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_not_can_drop_weapon",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.15 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_WEAKNESS_HOLY_BURN_0",
    condition_handler = "inline_enchantment_worn_flags_warding_symbol",
    load_character_inputs = { worn_flags = { "WARDING_SYMBOL" } },
}
    :effect("effect_xe_holy_burnt_carrying_holy", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_INVISIBLE_IN_DARK_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :effect("effect_vampire_lose_invisible_in_dark", 1))

-- mutations/paraclesians/arvore_mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_GREENSTRIDE_0",
    condition_handler = "inline_enchantment_effect_goblin_fruit_wild_travel_boost_0",
    load_character_inputs = { environment = { terrain = true, terrain_flags = { "SHRUB" } } },
}
    :value("MOVE_COST", { multiply = -0.1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_GREENSTRIDE_UPGRADE_0",
    condition_handler = "inline_enchantment_effect_goblin_fruit_wild_travel_boost_0",
    load_character_inputs = { environment = { terrain = true, terrain_flags = { "SHRUB" } } },
}
    :value("MOVE_COST", { multiply = -0.1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_WOOD_WEAPON_DAMAGE_0",
    condition_handler = "inline_enchantment_wielded_flags_wooden_weapon",
    load_character_inputs = { wielded_flags = { "WOODEN_WEAPON" } },
}
    :value("MELEE_DAMAGE", { multiply = 0.25 })
    :value("RANGED_DAMAGE", { multiply = 0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_SUN_NUTRIENTS_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.2 })
    :value("MENDING_MODIFIER", { multiply = 1 })
    :effect("effect_arvore_vitamin_bonus", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_SUN_NUTRIENTS_AND_MANA_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.2 })
    :value("REGEN_MANA", { multiply = 0.5 })
    :value("MENDING_MODIFIER", { multiply = 1 })
    :effect("effect_arvore_vitamin_bonus", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_SUN_MANA_BONUS_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.2 })
    :value("REGEN_MANA", { multiply = 0.5 })
    :value("MAX_MANA", { multiply = 0.5 })
    :value("MENDING_MODIFIER", { multiply = 1 })
    :effect("effect_arvore_vitamin_bonus", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_SUN_POWER_MANA_STATS_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.2 })
    :value("REGEN_MANA", { multiply = 0.5 })
    :value("MAX_MANA", { multiply = 0.5 })
    :value("MENDING_MODIFIER", { multiply = 1 })
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 2 })
    :value("INTELLIGENCE", { add = 2 })
    :value("PERCEPTION", { add = 2 })
    :effect("effect_arvore_vitamin_bonus", 1))

-- mutations/paraclesians/homullus_mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_ARMOR_MULT_1_0",
    condition_handler = "inline_enchantment_worn_flags_sturdy",
    load_character_inputs = { worn_flags = { "STURDY" } },
}
    :value("ARMOR_ALL", { multiply = -0.2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_ARMOR_MULT_2_0",
    condition_handler = "inline_enchantment_worn_flags_sturdy",
    load_character_inputs = { worn_flags = { "STURDY" } },
})

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_DOLL_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_not_terrain_flag_road",
    load_character_inputs = { environment = { terrain_flags = { "ROAD" } } },
}
    :value("MOVE_COST", { multiply = 2.5 }))

-- mutations/paraclesians/ierde_mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_IERDE_CRAFT_IN_DARKNESS_0",
    condition_handler = "inline_enchantment_effects_effect_ierde_sense_nearby_monsters",
    load_character_inputs = { effects = { "effect_ierde_sense_nearby_monsters" } },
}
    :effect("effect_ierde_craft_in_darkness", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_IERDE_SINK_INTO_EARTH_0",
    condition_handler = "inline_enchantment_terrain_t_rock",
    load_character_inputs = { environment = { terrain = true } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 300 }))

-- mutations/paraclesians/paraclesian_mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_3",
    condition_handler = "inline_enchantment_arvore_3",
    load_character_inputs = { effects = { "effect_arvore_attacked_a_triffid" }, traits = { "ARVORE_BLOOD", "ARVORE_BLOOD_2", "ARVORE_BLOOD_3", "ARVORE_BLOOD_4", "ARVORE_FLORAL_SCENT", "ARVORE_MIND_CONTROL_POLLEN", "ARVORE_SKIN_2", "ARVORE_SKIN_3", "ARVORE_VERDANT_HAIR" } },
}
    :mutation("ARVORE_TRIFFID_NEUTRALITY"))

-- mutations/paraclesians/sylph_mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_SYLPH_SPEED_INCREASE_0",
    condition_handler = "inline_enchantment_outside",
    load_character_inputs = { environment = { outside = true } },
}
    :value("MOVE_COST", { multiply = -0.1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_SYLPH_SPEED_INCREASE2_0",
    condition_handler = "inline_enchantment_outside",
    load_character_inputs = { environment = { outside = true } },
}
    :value("MOVE_COST", { multiply = -0.1 })
    :value("SPEED", { multiply = 0.1 }))

-- mutations/paraclesians/undine_mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_UNDINE_SLEEP_WATER_0",
    condition_handler = "inline_enchantment_divable",
    load_character_inputs = { environment = { divable = true } },
}
    :value("SLEEPY", { add = 40 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNDINE_NO_COLD_UNDERWATER_0",
    condition_handler = "inline_enchantment_divable",
    load_character_inputs = { environment = { divable = true } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 1000 }))

-- mutations/playable_changeling.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_BROWNIE_EASY_OVERLOOK_0",
    condition_handler = "inline_enchantment_not_effects_effect_brownie_attacked_someone",
    load_character_inputs = { effects = { "effect_brownie_attacked_someone" } },
}
    :value("STEALTH_MODIFIER", { add = 25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_BROWNIE_EASY_OVERLOOK2_0",
    condition_handler = "inline_enchantment_not_effects_effect_brownie_attacked_someone",
    load_character_inputs = { effects = { "effect_brownie_attacked_someone" } },
}
    :value("STEALTH_MODIFIER", { add = 50 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_POOKA_QUADRUPED_TRAITS_0",
    condition_handler = "inline_enchantment_pooka_quadruped_traits_0",
    load_character_inputs = { armed = true, move_mode = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.5 })
    :value("CARRY_WEIGHT", { multiply = 0.35 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_SELKIE_WATERSLEEP_0",
    condition_handler = "inline_enchantment_selkie_watersleep_0",
    load_character_inputs = { environment = { terrain_flags = { "DEEP_WATER", "SWIMMABLE" } } },
}
    :value("SLEEPINESS_REGEN", { multiply = 0.25 }))

-- mutations/revenant.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_XE_REVENANT_TRAITS_2",
    condition_handler = "inline_enchantment_not_armed",
    load_character_inputs = { armed = true },
}
    :melee_damage("bash", { add = 4 })
    :melee_damage("cut", { add = 2 }))

-- mutations/temporary.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_1",
    condition_handler = "inline_enchantment_not_can_drop_weapon",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.15 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_DEER_TRAITS_1",
    condition_handler = "inline_enchantment_not_can_drop_weapon",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_DEER_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_DEER_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_1",
    condition_handler = "inline_enchantment_not_can_drop_weapon",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.15 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_OWL_TRAITS_1",
    condition_handler = "inline_enchantment_vampire_bat_form_traits_2",
    load_character_inputs = { body_part_effects = { arm_l = { "disabled" }, arm_r = { "disabled" } } },
}
    :effect("effect_vampire_bat_form_levitation", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_OWL_TRAITS_2",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_OWL_TRAITS_3",
    condition_handler = "inline_enchantment_terrain_t_open_air",
    load_character_inputs = { environment = { terrain = true } },
}
    :value("MOVE_COST", { multiply = -0.6 })
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_1",
    condition_handler = "inline_enchantment_vampire_bat_form_traits_2",
    load_character_inputs = { body_part_effects = { arm_l = { "disabled" }, arm_r = { "disabled" } } },
}
    :effect("effect_vampire_bat_form_levitation", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_2",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_3",
    condition_handler = "inline_enchantment_terrain_t_open_air",
    load_character_inputs = { environment = { terrain = true } },
}
    :value("MOVE_COST", { multiply = -0.6 })
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

-- mutations/werewolf_traits.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_CLIMB_IN_WOLF_FORM_0",
    condition_handler = "inline_enchantment_traits_vampire_wolf_form_traits",
    load_character_inputs = { traits = { "VAMPIRE_WOLF_FORM_TRAITS" } },
}
    :effect("effect_xe_werewolf_climb_in_wolf_form", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_1",
    condition_handler = "inline_enchantment_werewolf_primal_form_traits_1",
    load_character_inputs = { armed = true, wielded_flags = { "NO_UNWIELD" } },
}
    :value("MOVE_COST", { multiply = -0.15 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_2",
    condition_handler = "inline_enchantment_move_mode_run",
    load_character_inputs = { move_mode = true },
}
    :value("MOVE_COST", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_3",
    condition_handler = "inline_enchantment_armed",
    load_character_inputs = { armed = true },
}
    :value("MELEE_DAMAGE", { multiply = -1 })
    :value("RANGE", { multiply = -1 }))

-- mutations/xe_lilin.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_THRESH_LILIN_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("STRENGTH", { add = -1 })
    :value("DEXTERITY", { add = -1 })
    :value("INTELLIGENCE", { add = -1 })
    :value("PERCEPTION", { add = -1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_SLEEP_EASY_DURING_DAY_0",
    condition_handler = "inline_enchantment_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("SLEEPY", { add = 50 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_4",
    condition_handler = "inline_enchantment_lilin_unarmed_extra_damage_4",
    load_character_inputs = { armed = true, environment = { daylight = true, outside = true } },
}
    :melee_damage("biological", { add = 1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_INCREMENTAL_SPEED_BOOST_0",
    condition_handler = "inline_enchantment_dhampir_weakness_sun_sensitivity_0",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :effect("effect_lilin_lose_incremental_speed_boost", 1))

-- mutations/xe_playable_gracken.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_SHADE_SHARP_NAILS_0",
    condition_handler = "inline_enchantment_not_armed",
    load_character_inputs = { armed = true },
}
    :melee_damage("cut", { add = 2 }))
