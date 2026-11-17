local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/Magiclysm/Spells/attunements/Blood_Mage.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_demon_possession_aura_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("DEMON_HORNS")
    :mutation("DEMON_HOOVES")
    :mutation("DEMON_POSSES")
    :mutation("DEMON_CLAWS")
    :mutation("DEMON_SKIN")
    :mutation("DEMON_TAIL")
    :mutation("DEMON_HUGE")
    :mutation("NOPAIN")
    :mutation("FACIAL_HAIR_GOATEE"))

-- data/mods/Magiclysm/Spells/attunements/Crusader.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_holy_shield_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -6 })
    :incoming_damage("stab", { add = -6 })
    :incoming_damage("cut", { add = -6 })
    :incoming_damage("bullet", { add = -3 }))

-- data/mods/Magiclysm/Spells/attunements/Force_Mage.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_force_magical_armor_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { multiply = -0.3 })
    :incoming_damage("stab", { multiply = -0.3 })
    :incoming_damage("cut", { multiply = -0.3 })
    :incoming_damage("bullet", { multiply = -0.3 }))

-- data/mods/Magiclysm/Spells/attunements/Permafrost_Mage.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_aura_cold_energy_0",
    has = "WORN",
    emitter = "emit_cold_energy_strong",
    condition = "ALWAYS",
})

-- data/mods/Magiclysm/items/druid_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mag_awoken_weaver_0", has = "WORN", condition = "ALWAYS",
}
    :skill("tailor", { add = 1 }))

-- data/mods/Magiclysm/items/enchanted.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_belt_str_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_belt_haste_0", has = "WORN", condition = "ALWAYS",
}
    :value("SPEED", { add = 5, multiply = 0.15 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_magi_staff_minor_0", has = "WIELD", condition = "ALWAYS",
}
    :value("REGEN_MANA", { multiply = 0.5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_magi_staff_lesser_0", has = "WIELD", condition = "ALWAYS",
}
    :value("REGEN_MANA", { multiply = 1.25 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_magi_staff_greater_0", has = "WIELD", condition = "ALWAYS",
}
    :value("REGEN_MANA", { multiply = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_wizard_hat_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 500, multiply = 0.2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_debug_fireball_hammer_0", has = "WIELD", condition = "ALWAYS",
}
    :hit_me({ id = "light_healing", self = true })
    :hit_you({ id = "fireball" }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_cloak_morthylla_0", has = "WORN", condition = "ALWAYS",
}
    :value("BONUS_DODGE", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_magic_knife_bag_0", has = "WORN", condition = "ALWAYS",
}
    :skill("throw", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_wolfshead_cufflinks_0", has = "WORN", condition = "ALWAYS",
}
    :value("PERCEPTION", { add = 1 }))

-- data/mods/Magiclysm/items/enchanted_belts.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbelt_haste_0", has = "WORN", condition = "ALWAYS",
}
    :value("SPEED", { add = 5, multiply = 0.15 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbelt_thor_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { multiply = 1.0 })
    :value("CARRY_WEIGHT", { add = 50000 }))

-- data/mods/Magiclysm/items/enchanted_boots.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mboots_sevenleague_0", has = "WORN", condition = "ALWAYS",
}
    :value("MOVE_COST", { add = -30 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mboots_haste_0", has = "WORN", condition = "ALWAYS",
}
    :value("MOVE_COST", { add = -20 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mboots_haste_1", has = "WORN", condition = "ALWAYS",
}
    :value("SPEED", { add = 10 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mboots_freerunner_0", has = "WORN", condition = "ALWAYS",
}
    :value("MOVE_COST", { add = -5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mboots_grounding_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("electric", { add = -20 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_boots_of_elvenkind_0", has = "WORN", condition = "ALWAYS",
}
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

ccb.runtime.handler("item_ench_magiclysm_boots_of_elvenkind_1_active", function(ctx)
    return (ctx.character_inputs.environment.outside and
        (ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road"]))
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_boots_of_elvenkind_1", has = "WORN",
    condition_handler = "item_ench_magiclysm_boots_of_elvenkind_1_active",
    load_character_inputs = {
        environment = {
            nearby_overmap_terrain = { road = 1 },
            outside = true,
            terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" }
        }
    },
}
    :value("MOVE_COST", { multiply = -0.1 }))

-- data/mods/Magiclysm/items/enchanted_bracelet.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mana_leech_shackle_0", has = "WORN", condition = "ALWAYS",
}
    :value("REGEN_MANA", { multiply = -100 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mana_leech_shackle_1", has = "WORN", condition = "ALWAYS",
}
    :mutation("MANA_LEECH_EFFECT"))

-- data/mods/Magiclysm/items/enchanted_bracers.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbracer_defense_lesser_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -2 })
    :incoming_damage("stab", { add = -2 })
    :incoming_damage("cut", { add = -2 })
    :incoming_damage("bullet", { add = -1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbracer_defense_greater_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -4 })
    :incoming_damage("stab", { add = -4 })
    :incoming_damage("cut", { add = -4 })
    :incoming_damage("bullet", { add = -2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbracer_lightning_lesser_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("electric", { add = -5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbracer_lightning_greater_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("electric", { add = -10 }))

ccb.runtime.handler("item_ench_magiclysm_mbracer_archery_0_active", function(ctx)
    return ctx.character_inputs.wielded_flags["SHEATH_BOW"]
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbracer_archery_0", has = "WORN",
    condition_handler = "item_ench_magiclysm_mbracer_archery_0_active",
    load_character_inputs = { wielded_flags = { "SHEATH_BOW" } },
}
    :value("RANGE", { multiply = 0.2 })
    :value("WEAPON_DISPERSION", { multiply = -0.33 })
    :effect("effect_plus_two_to_hit", 1)
    :effect("archerybracers", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mbracer_blinding_strike_0", has = "WORN", condition = "ALWAYS",
}
    :value("ATTACK_SPEED", { multiply = -0.15 }))

-- data/mods/Magiclysm/items/enchanted_cloaks.json

ccb.runtime.handler("item_ench_magiclysm_cloak_of_elvenkind_0_active", function(ctx)
    return (ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain == "t_tree_young" or
        ctx.character_inputs.environment.terrain == "t_bamboo_tall" or
        ctx.character_inputs.environment.terrain == "t_grass_long" or
        ctx.character_inputs.environment.overmap_terrain == "forest" or
        ctx.character_inputs.environment.overmap_terrain == "forest_thick")
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_cloak_of_elvenkind_0", has = "WORN",
    condition_handler = "item_ench_magiclysm_cloak_of_elvenkind_0_active",
    load_character_inputs = {
        environment = {
            overmap_terrain = true,
            terrain = true,
            terrain_flags = { "SHRUB" }
        }
    },
}
    :value("STEALTH_MODIFIER", { add = 60 }))

-- data/mods/Magiclysm/items/enchanted_clothes.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_parabolan_enchanted_breeches_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("stab", { add = -3 })
    :incoming_damage("cut", { add = -3 })
    :incoming_damage("bullet", { add = -8 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_coat_lab_plus_one_0", has = "WORN", condition = "ALWAYS",
}
    :value("REGEN_MANA", { multiply = 0.4 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_coat_lab_plus_two_0", has = "WORN", condition = "ALWAYS",
}
    :value("REGEN_MANA", { multiply = 0.5 })
    :value("MAX_MANA", { add = 500 }))

-- data/mods/Magiclysm/items/enchanted_masks.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mmask_vision_0", has = "WORN", condition = "ALWAYS",
}
    :value("PERCEPTION", { multiply = 0.25 }))

-- data/mods/Magiclysm/items/enchanted_melee.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_rune_magus_weapon_adept_0", has = "WIELD", condition = "ALWAYS",
}
    :value("REGEN_MANA", { multiply = 0.75 }))

ccb.runtime.handler("item_ench_magiclysm_rune_druid_nature_staff_0_active", function(ctx)
    return (ctx.character_inputs.environment.outside and
        (ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_curved"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_four_way"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_tee"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_straight"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_end"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_sw"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_ne"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_ew"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_ns"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road_nesw"]) and
        not (ctx.character_inputs.environment.nearby_overmap_terrain["road"]))
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_rune_druid_nature_staff_0", has = "WIELD",
    condition_handler = "item_ench_magiclysm_rune_druid_nature_staff_0_active",
    load_character_inputs = {
        environment = {
            nearby_overmap_terrain = {
                road = 2,
                road_curved = 2,
                road_end = 2,
                road_ew = 2,
                road_four_way = 2,
                road_ne = 2,
                road_nesw = 2,
                road_ns = 2,
                road_straight = 2,
                road_sw = 2,
                road_tee = 2
            },
            outside = true,
            terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" }
        }
    },
}
    :value("REGEN_MANA", { multiply = 0.75 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_rune_kelvinist_ice_adept_weapon_0", has = "WIELD", condition = "ALWAYS",
}
    :hit_you({ id = "chilling_touch" }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_rune_animist_weapon_adept_0", has = "WIELD", condition = "ALWAYS",
}
    :value("PAIN", { multiply = -0.3 }))

-- data/mods/Magiclysm/items/enchanted_necklaces.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_periapt_health_0", has = "WORN", condition = "ALWAYS",
}
    :value("EFFECTIVE_HEALTH_MOD", { add = 100 })
    :effect("effect_periapt_health", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_periapt_proof_against_poison_0", has = "WORN", condition = "ALWAYS",
}
    :effect("effect_periapt_proof_against_poison", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_periapt_wound_closure_0", has = "WORN", condition = "ALWAYS",
}
    :value("BANDAGE_BONUS", { multiply = 1 })
    :value("DISINFECTANT_BONUS", { multiply = 1 }))

-- data/mods/Magiclysm/items/enchanted_ranged.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_bow_of_elvenkind_0", has = "WIELD", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 }))

-- data/mods/Magiclysm/items/enchanted_rings.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_wizardry_minor_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 200 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_wizardry_lesser_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 400 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_wizardry_moderate_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 800 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_wizardry_greater_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 1200 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_dodge_bonus_1_0", has = "WORN", condition = "ALWAYS",
}
    :value("BONUS_DODGE", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_dodge_bonus_2_0", has = "WORN", condition = "ALWAYS",
}
    :value("BONUS_DODGE", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_strength_1_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_strength_2_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_strength_3_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_strength_4_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 4 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_dexterity_1_0", has = "WORN", condition = "ALWAYS",
}
    :value("DEXTERITY", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_dexterity_2_0", has = "WORN", condition = "ALWAYS",
}
    :value("DEXTERITY", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_dexterity_3_0", has = "WORN", condition = "ALWAYS",
}
    :value("DEXTERITY", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_dexterity_4_0", has = "WORN", condition = "ALWAYS",
}
    :value("DEXTERITY", { add = 4 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_intelligence_1_0", has = "WORN", condition = "ALWAYS",
}
    :value("INTELLIGENCE", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_intelligence_2_0", has = "WORN", condition = "ALWAYS",
}
    :value("INTELLIGENCE", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_intelligence_3_0", has = "WORN", condition = "ALWAYS",
}
    :value("INTELLIGENCE", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_intelligence_4_0", has = "WORN", condition = "ALWAYS",
}
    :value("INTELLIGENCE", { add = 4 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_perception_1_0", has = "WORN", condition = "ALWAYS",
}
    :value("PERCEPTION", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_perception_2_0", has = "WORN", condition = "ALWAYS",
}
    :value("PERCEPTION", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_perception_3_0", has = "WORN", condition = "ALWAYS",
}
    :value("PERCEPTION", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_perception_4_0", has = "WORN", condition = "ALWAYS",
}
    :value("PERCEPTION", { add = 4 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_speed_3_0", has = "WORN", condition = "ALWAYS",
}
    :value("SPEED", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_speed_5_0", has = "WORN", condition = "ALWAYS",
}
    :value("SPEED", { add = 5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_speed_7_0", has = "WORN", condition = "ALWAYS",
}
    :value("SPEED", { add = 7 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_speed_10_0", has = "WORN", condition = "ALWAYS",
}
    :value("SPEED", { add = 10 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_protection_2_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -2 })
    :incoming_damage("stab", { add = -2 })
    :incoming_damage("cut", { add = -2 })
    :incoming_damage("bullet", { add = -1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_protection_4_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -4 })
    :incoming_damage("stab", { add = -4 })
    :incoming_damage("cut", { add = -4 })
    :incoming_damage("bullet", { add = -2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_protection_6_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -6 })
    :incoming_damage("stab", { add = -6 })
    :incoming_damage("cut", { add = -6 })
    :incoming_damage("bullet", { add = -3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_protection_8_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -8 })
    :incoming_damage("stab", { add = -8 })
    :incoming_damage("cut", { add = -8 })
    :incoming_damage("bullet", { add = -4 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_fire_protection_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("heat", { multiply = -0.5 })
    :effect("effect_mring_fire_protection", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_flying_0", has = "WORN", condition = "ALWAYS",
}
    :value("FALL_DAMAGE", { multiply = -1 }))

ccb.runtime.handler("item_ench_magiclysm_mring_sustenance_0_active", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_mring_sustenance"] >= 25)
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_mring_sustenance_0", has = "WORN",
    condition_handler = "item_ench_magiclysm_mring_sustenance_0_active",
    load_character_inputs = { effect_intensities = { "effect_mring_sustenance" } },
}
    :value("THIRST", { multiply = -0.75 })
    :value("SLEEPINESS_REGEN", { multiply = 3 })
    :value("SLEEPINESS", { multiply = -0.375 }))

-- data/mods/Magiclysm/items/ethereal_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_ice_gliders_0", has = "WORN", condition = "ALWAYS",
}
    :value("MOVE_COST", { add = -5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_tentacle_whip_0", has = "WIELD", condition = "ALWAYS",
}
    :value("UGLINESS", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_fleshpouch_0", has = "WORN", condition = "ALWAYS",
}
    :value("UGLINESS", { add = 5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_bonespear_0", has = "WIELD", condition = "ALWAYS",
}
    :value("UGLINESS", { add = 3 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_armor_frost_0", has = "WORN", condition = "ALWAYS",
}
    :hit_me({ id = "armor_frost_counterattack" }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_aura_werewolf_0",
}
    :every(120, { id = "pfruit_regeneration_spell", self = true }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_aura_werewolf_1", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 3 })
    :value("DEXTERITY", { add = 3 })
    :value("INTELLIGENCE", { add = -6 })
    :value("PERCEPTION", { add = 3 })
    :mutation("LUPINE_FUR")
    :mutation("CLAWS")
    :mutation("ADRENALINE")
    :mutation("PADDED_FEET")
    :mutation("TAIL_FLUFFY")
    :mutation("PRED4")
    :mutation("LUPINE_EARS")
    :mutation("MUZZLE")
    :mutation("PAWS")
    :mutation("SHOUT3")
    :mutation("GOODCARDIO")
    :mutation("ANIMALDISCORD2")
    :mutation("MUTE")
    :mutation("LARGE_OK"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_dragon_shell_black_0", has = "WORN", condition = "ALWAYS",
}
    :hit_me({ id = "dragon_shell_retaliation_black", self = false }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_item_armor_magus_mage_conjured_armor_1", has = "WORN", condition = "ALWAYS",
}
    :mutation("well_distributed"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_druid_bramble_spear_item_0", has = "WIELD",
}
    :hit_you({ id = "bramble_spear_slow", self = false }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_druid_thorn_skin_item_0", has = "WORN", condition = "ALWAYS",
}
    :value("DEXTERITY", { add = -1 })
    :value("STRENGTH", { add = 1 })
    :value("CLIMATE_CONTROL_HEAT", { add = 20 })
    :melee_damage("stab", { add = 3 })
    :incoming_damage("heat", { multiply = 0.6 })
    :hit_me({ id = "druid_thorn_skin_attacked", self = false, trigger_once_in = 2 }))

ccb.runtime.handler("item_ench_magiclysm_item_biomancer_scalpel_fingers_0_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_item_biomancer_scalpel_fingers_0", has = "WORN",
    condition_handler = "item_ench_magiclysm_item_biomancer_scalpel_fingers_0_active",
    load_character_inputs = { armed = true },
}
    :value("ATTACK_SPEED", { multiply = -0.1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_aura_druid_breathing_water_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 })
    :effect("effect_item_protection_water", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_aura_bearmantle_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("HEAVYSLEEPER2")
    :mutation("FAT")
    :mutation("URSINE_FUR")
    :mutation("SMELLY2")
    :mutation("STRONGER_RESISTCHILL")
    :mutation("HIBERNATE"))

-- data/mods/Magiclysm/items/melee.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_wolfsbane_0", has = "WIELD", condition = "ALWAYS",
}
    :hit_you({ id = "wolfsbane" }))

-- data/mods/Magiclysm/migration_and_obsoletion/items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_aura_druid_waterwalk_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 })
    :effect("effect_item_protection_water", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_obfuscating_aura_0", has = "WORN", condition = "ALWAYS",
}
    :value("BONUS_DODGE", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_shape_of_dust_0",
    has = "WORN",
    emitter = "emit_eshaper_dust",
    condition = "ALWAYS",
}
    :value("BONUS_DODGE", { add = 2 })
    :effect("invisibility", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_thorns_electric_0", has = "WORN", condition = "ALWAYS",
}
    :hit_me({ id = "thorns_zap" }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Magiclysm_item_kelvinist_frozen_heart_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("NUMB")
    :mutation("PSYCHOPATH"))
