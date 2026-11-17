local content = require("ccb").content

-- Spells/attunements/Gravity_Mage.json
content.add(content.Enchantment { id = "INLINE_ENCH_gravity_mage_melee_0" }
    :value("ATTACK_SPEED", { add = -30 })
    :value("BONUS_BLOCK", { add = 2 })
    :value("MELEE_DAMAGE", { multiply = 1 }))

-- Spells/attunements/Soulfire.json
content.add(content.Enchantment { id = "INLINE_ENCH_soul_burn_0" }
    :value("REGEN_HP", { multiply = -0.7 }))

-- Spells/attunements/Storm_Elemental.json
content.add(content.Enchantment { id = "INLINE_ENCH_eff_storm_elemental_electric_melee_1" }
    :value("MELEE_DAMAGE", { multiply = 0.4 }))

-- effects/effect_potion_fruit.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_pfruit_heal_0" }
    :every(30, { id = "pfruit_regeneration_spell" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_pfruit_attack_speed_0" }
    :value("ATTACK_SPEED", { add = -15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_pfruit_keep_warm_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_pfruit_dodge_0" }
    :value("BONUS_DODGE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_pfruit_vision_0" }
    :value("PERCEPTION", { add = 2 }))

-- effects/effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_enchant_windrun_monster_0" }
    :value("SPEED", { add = 20 }))

content.add(content.Enchantment { id = "INLINE_ENCH_root_impale_0" }
    :value("SPEED", { add = -25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_acid_res_aura_greater_0" }
    :incoming_damage("acid", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_thorns_electric_0", condition = "ALWAYS" }
    :hit_me({ id = "thorns_zap" }))

content.add(content.Enchantment { id = "INLINE_ENCH_magic_slowed_0" }
    :value("SPEED", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_earthshaper_petrifying_touch_0" }
    :incoming_damage("bash", { add = -30 })
    :incoming_damage("stab", { add = -80 })
    :incoming_damage("cut", { add = -80 })
    :incoming_damage("bullet", { add = -120 })
    :incoming_damage("heat", { add = -80 })
    :incoming_damage("cold", { add = -50 })
    :incoming_damage("necrotic", { add = -120 })
    :incoming_damage("poison", { add = -120 })
    :incoming_damage("gravity", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_eshaper_melee_damage_0" }
    :value("ATTACK_SPEED", { multiply = 0.25 })
    :value("MELEE_DAMAGE", { multiply = 0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_technomancer_arete_0" }
    :mutation("STR_ALPHA")
    :mutation("DEX_ALPHA")
    :mutation("PER_ALPHA")
    :mutation("INT_ALPHA"))

content.add(content.Enchantment { id = "INLINE_ENCH_eshaper_crystal_wrap_0" }
    :melee_damage("cut", { add = 17 })
    :hit_me({ id = "eshaper_crystal_wrap_damage" }))

content.add(content.Enchantment { id = "INLINE_ENCH_flask_excitement_0" }
    :value("SPEED", { add = 30 })
    :value("ATTACK_SPEED", { add = -20 })
    :value("BONUS_DODGE", { add = 2 })
    :value("MELEE_DAMAGE", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_flask_resistance_0" }
    :incoming_damage("bash", { add = -10 })
    :incoming_damage("stab", { add = -10 })
    :incoming_damage("cut", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_flask_illumination_0" }
    :value("LUMINATION", { add = 800 }))

content.add(content.Enchantment { id = "INLINE_ENCH_flask_mana_regen_0" }
    :value("REGEN_MANA", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_flask_max_mana_0" }
    :value("MAX_MANA", { add = 1500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_flask_regeneration_0" }
    :every(30, { id = "flask_regeneration_effect" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_magus_faerie_fire_0" }
    :value("LUMINATION", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_biomancer_swim_speed_0" }
    :mutation("WEBBED")
    :mutation("WEBBED_FEET"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_biomancer_lashing_tentacles_0" }
    :mutation("BIO_LASHING_TENTACLES"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_biomancer_caustic_blood_0" }
    :mutation("ACIDPROOF")
    :mutation("ACIDBLOOD"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_biomancer_slow_bleeding_01_0" }
    :value("BLEEDING_RATE", { multiply = -0.333 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_biomancer_slow_bleeding_02_0" }
    :value("BLEEDING_RATE", { multiply = -0.666 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_spirit_walking_0" }
    :value("SPEED", { multiply = 3 })
    :value("MOVE_COST", { multiply = -0.66 })
    :value("PHASE_DISTANCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_magus_mageshield_0" }
    :value("FORCEFIELD", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_magus_silence_0" }
    :value("ATTACK_NOISE", { multiply = -1 })
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_bracers_of_the_blinding_strike_0" }
    :value("ATTACK_SPEED", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_druid_thornskin_0" }
    :incoming_damage("bash", { multiply = -0.2 })
    :incoming_damage("cut", { multiply = -0.1 })
    :incoming_damage("stab", { multiply = -0.2 })
    :hit_me({ id = "druid_thorn_skin_attacked", self = false, trigger_once_in = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_high_technomancer_mage_armor_0" }
    :value("LUMINATION", { add = 15 })
    :incoming_damage("cut", { add = -30 })
    :incoming_damage("bash", { add = -30 })
    :incoming_damage("stab", { add = -30 })
    :incoming_damage("bullet", { add = -30 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_clay_golem_unhealing_0" }
    :value("REGEN_HP", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_dust_reborn_0" }
    :value("MAX_HP", { multiply = -0.7 })
    :value("MAX_MANA", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_golemancer_block_0" }
    :value("ARMOR_ALL", { add = -20 }))

content.add(content.Enchantment { id = "INLINE_ENCH_sun_mage_buff_0" }
    :value("STRENGTH", { add = 1, multiply = 0.25 })
    :value("DEXTERITY", { add = 1, multiply = 0.25 })
    :value("INTELLIGENCE", { add = 1, multiply = 0.25 })
    :value("PERCEPTION", { add = 1, multiply = 0.25 })
    :value("CLIMATE_CONTROL_HEAT", { add = 30 })
    :value("CLIMATE_CONTROL_CHILL", { add = 30 }))

-- effects/effects_monster.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_demon_spider_speed_0" }
    :value("SPEED", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_demon_spider_venom_0" }
    :incoming_damage("heat", { multiply = 0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_demon_spider_venom_1" }
    :value("CLIMATE_CONTROL_CHILL", { add = -40 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_migo_nether_shield_monster_0" }
    :incoming_damage("nether", { multiply = -1 })
    :incoming_damage("bullet", { multiply = -0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_migo_fleshwarper_block_healing_0" }
    :value("REGEN_HP", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_migo_enhance_flesh_monster_0" }
    :incoming_damage("bash", { multiply = -0.2 })
    :incoming_damage("cut", { multiply = -0.2 })
    :incoming_damage("stab", { multiply = -0.2 })
    :incoming_damage("acid", { multiply = -0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_migo_enhance_flesh_monster_1" }
    :value("SPEED", { multiply = 0.15 }))

-- migration_and_obsoletion/effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_technomancer_mage_armor_0" }
    :incoming_damage("cut", { add = -15 })
    :incoming_damage("bash", { add = -15 })
    :incoming_damage("stab", { add = -15 })
    :incoming_damage("bullet", { add = -15 }))
