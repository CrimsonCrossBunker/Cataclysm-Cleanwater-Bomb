local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/Xedra_Evolved/items/armor/armor.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_dreamforged_armguard_plate_gunslinger_0", has = "WORN", condition = "ALWAYS",
}
    :value("WEAPON_DISPERSION", { multiply = -0.4 })
    :value("RECOIL_MODIFIER", { multiply = -0.4 }))

-- data/mods/Xedra_Evolved/items/armor/changeling.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_banner_dark_forest_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_banner_butterfly_knight_0", has = "WORN", condition = "ALWAYS",
}
    :value("DEXTERITY", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_banner_angry_darkness_0", has = "WORN", condition = "ALWAYS",
}
    :value("PERCEPTION", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_banner_starry_wisdom_0", has = "WORN", condition = "ALWAYS",
}
    :skill("gramarye", { add = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_gown_gossamer_boann_unique_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("bash", { add = -10 })
    :incoming_damage("cut", { add = -20 })
    :incoming_damage("stab", { add = -30 })
    :incoming_damage("bullet", { multiply = -0.75 }))

-- data/mods/Xedra_Evolved/items/armor/headgear.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_bloody_cap_0", has = "WORN", condition = "ALWAYS",
}
    :value("REGEN_STAMINA", { multiply = 0.2 })
    :value("REGEN_HP", { multiply = 0.2 })
    :value("SOCIAL_INTIMIDATE", { add = 4 })
    :value("HUNGER", { add = 40 }))

-- data/mods/Xedra_Evolved/items/armor/integrated.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_salamander_cooking_heat_0", has = "HELD", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 }))

-- data/mods/Xedra_Evolved/items/artifact_grade_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_dream_attuning_necklace_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 }))

-- data/mods/Xedra_Evolved/items/ethereal_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_blurred_aura_0", has = "WORN", condition = "ALWAYS",
}
    :value("BONUS_DODGE", { add = 2 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_aura_futuresight_0", has = "WORN", condition = "ALWAYS",
}
    :value("BONUS_DODGE", { add = 2 })
    :mutation("FUTURESIGHT"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_aura_drunken_master_0", has = "WORN", condition = "ALWAYS",
}
    :value("STRENGTH", { add = 3 })
    :value("DEXTERITY", { add = 3 })
    :value("INTELLIGENCE", { add = -6 })
    :value("PERCEPTION", { add = -3 })
    :mutation("DRUNKEN")
    :mutation("GOODCARDIO"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_xe_oneiric_hammer_0", has = "WIELD", condition = "ALWAYS",
}
    :value("MAX_MANA", { multiply = -1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_ierde_iron_armor_0", has = "WORN", condition = "ALWAYS",
}
    :value("ATTACK_SPEED", { multiply = -0.2 })
    :value("FORCEFIELD", { add = 0.1 })
    :value("PAIN_REMOVE", { add = 45 }))

ccb.runtime.handler("item_ench_xedra_evolved_item_ierde_iron_armor_1_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_ierde_iron_armor_1", has = "WORN",
    condition_handler = "item_ench_xedra_evolved_item_ierde_iron_armor_1_active",
    load_character_inputs = { armed = true },
}
    :melee_damage("bash", { add = 10 }))

-- data/mods/Xedra_Evolved/items/hedge_magic_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_hedge_witchlight_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 }))

ccb.runtime.handler("item_ench_xedra_evolved_item_hedge_see_fae_necklace_0_vision_0_detect", function(ctx)
    return (ctx.target_inputs.flags["FAE_CREATURE"] or
        ctx.target_inputs.flags["FAERIECREATURE"])
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_0", has = "WORN", condition = "ACTIVE",
}
    :vision({
        condition_handler = "item_ench_xedra_evolved_item_hedge_see_fae_necklace_0_vision_0_detect",
        target_inputs = {
            flags = { "FAERIECREATURE", "FAE_CREATURE" }
        },
        distance = 20,
        descriptions = {
            { id = "fae_sense", text = content.text("You sense fae here.") }
        }
    }))

ccb.runtime.handler("item_ench_xedra_evolved_item_hedge_see_fae_necklace_on_0_vision_0_detect", function(ctx)
    return (ctx.target_inputs.flags["FAE_CREATURE"] or
        ctx.target_inputs.flags["FAERIECREATURE"])
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_on_0", has = "WORN", condition = "ACTIVE",
}
    :vision({
        condition_handler = "item_ench_xedra_evolved_item_hedge_see_fae_necklace_on_0_vision_0_detect",
        target_inputs = {
            flags = { "FAERIECREATURE", "FAE_CREATURE" }
        },
        distance = 20,
        descriptions = {
            { id = "fae_sense", text = content.text("You sense fae here.") }
        }
    }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_done_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_item_hedge_raziel_amulet_protection_0", has = "WORN",
}
    :incoming_damage("bash", { multiply = -0.2 })
    :incoming_damage("stab", { multiply = -0.2 })
    :incoming_damage("cut", { multiply = -0.2 })
    :incoming_damage("bullet", { multiply = -0.2 })
    :effect("effect_hedge_magic_kamea_of_protection", 1))

-- data/mods/Xedra_Evolved/items/inventor/armor.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_helmet_inventor_0", has = "WORN", condition = "ACTIVE",
}
    :value("INTELLIGENCE", { add = 5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_inventor_leg_weight_0", has = "WORN", condition = "ACTIVE",
}
    :value("CARRY_WEIGHT", { add = 35000 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_aura_force_0", has = "WORN", condition = "ACTIVE",
}
    :incoming_damage("bash", { multiply = -0.5 })
    :incoming_damage("stab", { multiply = -0.5 })
    :incoming_damage("cut", { multiply = -0.5 })
    :incoming_damage("bullet", { multiply = -0.5 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_vision_halo_0", has = "WORN", condition = "ACTIVE",
}
    :value("BONUS_DODGE", { add = 1 })
    :value("PERCEPTION", { add = 2 })
    :value("RANGED_DAMAGE", { multiply = 0.33 })
    :value("WEAPON_DISPERSION", { multiply = -0.33 })
    :vision({
        distance = 30,
        descriptions = {
            {
                id = "moving_creature",
                color = "c_white",
                symbol = "?",
                text = content.text("Your halo register potential hazard from this direction.")
            }
        }
    }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_inventor_electric_fist_0", has = "WORN", condition = "ACTIVE",
}
    :hit_you({ id = "inventor_electric_fist_spell", trigger_once_in = 6 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_wolf_mask_0", has = "WORN", condition = "ACTIVE",
}
    :value("REGEN_STAMINA", { multiply = 0.6 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_crafting_assistant_0", has = "WORN", condition = "ACTIVE",
}
    :mutation("CRAFTING_ASSISTANT_ARMS"))

-- data/mods/Xedra_Evolved/items/melee.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_spring_lord_estoc_0", has = "WIELD", condition = "ALWAYS",
}
    :value("ATTACK_SPEED", { add = -20 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_summer_lord_estoc_0", has = "WIELD", condition = "ALWAYS",
}
    :value("ATTACK_SPEED", { add = -20 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_autumn_lord_estoc_0", has = "WIELD", condition = "ALWAYS",
}
    :value("ATTACK_SPEED", { add = -20 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_winter_lord_estoc_0", has = "WIELD", condition = "ALWAYS",
}
    :value("ATTACK_SPEED", { add = -20 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_wild_huntsman_hunting_blade_0", has = "WIELD", condition = "ALWAYS",
}
    :value("BONUS_BLOCK", { add = 1 })
    :value("ATTACK_SPEED", { add = -10 })
    :value("WEAKPOINT_ACCURACY", { multiply = 1 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_redcap_club_0", has = "WIELD", condition = "ALWAYS",
}
    :hit_you({ id = "blood_tendrils" }))

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_pooka_gladius_0", has = "WIELD", condition = "ALWAYS",
}
    :hit_you({ id = "distant_thunder" }))

-- data/mods/Xedra_Evolved/items/melee_moons_tears.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_boann_unique_weapon_sword_0", has = "WIELD", condition = "ALWAYS",
}
    :value("ATTACK_SPEED", { add = -25 })
    :value("MELEE_DAMAGE", { multiply = 0.15 })
    :hit_you({ id = "boann_unique_weapon_sword_onhit_blind", trigger_once_in = 3 }))

-- data/mods/Xedra_Evolved/obsoletion_and_migration/items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Xedra_Evolved_aura_ward_off_rain_0", has = "WORN", condition = "ALWAYS",
}
    :value("MAX_MANA", { add = 0 }))
