local content = require("ccb").content

-- legacy_artifact_passive.json
content.add(content.Enchantment { id = "AEP_STR_UP", has = "WIELD" }
    :value("STRENGTH", { add = 4 }))

content.add(content.Enchantment { id = "AEP_STR_DOWN", has = "WIELD" }
    :value("STRENGTH", { add = -3 }))

content.add(content.Enchantment { id = "AEP_DEX_UP", has = "WIELD" }
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment { id = "AEP_DEX_DOWN", has = "WIELD" }
    :value("STRENGTH", { add = -3 }))

content.add(content.Enchantment { id = "AEP_PER_UP", has = "WIELD" }
    :value("PERCEPTION", { add = 4 }))

content.add(content.Enchantment { id = "AEP_PER_DOWN", has = "WIELD" }
    :value("STRENGTH", { add = -3 }))

content.add(content.Enchantment { id = "AEP_INT_UP", has = "WIELD" }
    :value("INTELLIGENCE", { add = 4 }))

content.add(content.Enchantment { id = "AEP_ALL_UP", has = "WIELD" }
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 2 })
    :value("PERCEPTION", { add = 2 })
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "AEP_ALL_DOWN", has = "WIELD" }
    :value("STRENGTH", { add = -2 })
    :value("DEXTERITY", { add = -2 })
    :value("PERCEPTION", { add = -2 })
    :value("INTELLIGENCE", { add = -2 }))

content.add(content.Enchantment { id = "AEP_SPEED_UP" }
    :value("SPEED", { add = 20 }))

content.add(content.Enchantment { id = "AEP_SPEED_DOWN" }
    :value("SPEED", { add = -20 }))

content.add(content.Enchantment { id = "AEP_SMOKE", emitter = "emit_AEP_SMOKE" })

content.add(content.Enchantment { id = "AEP_EVIL" }
    :every(900, { id = "AEP_EVIL_SPELL" }))

-- enchantments.json
content.add(content.Enchantment { id = "ENCH_DEBUG_TAIL", condition = "ALWAYS" }
    :bodypart_change("debug_tail", ""))

content.add(content.Enchantment { id = "ENCH_DEBUG_ONLY_HEAD", condition = "ALWAYS" }
    :bodypart_change("", "torso")
    :bodypart_change("", "arm_l")
    :bodypart_change("", "arm_r")
    :bodypart_change("", "leg_l")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("", "foot_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("", "hand_r"))

content.add(content.Enchantment { id = "ENCH_DEBUG_BIG_HEAD", condition = "ALWAYS" }
    :bodypart_change("", "head")
    :bodypart_change("big_head", ""))

content.add(content.Enchantment { id = "ENCH_DEBUG_WEIGHT_MODIFIER", condition = "ALWAYS" }
    :value("WEIGHT", { multiply = -0.5 }))

content.add(content.Enchantment { id = "RM13", condition = "ACTIVE" }
    :value("FOOTSTEP_NOISE", { multiply = -0.67 })
    :value("CLIMATE_CONTROL_HEAT", { add = 50 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment { id = "ench_rm13_environmental", has = "WORN", condition = "ACTIVE", name = content.text("Environmental Protection"), description = content.text("You are wearing equipment that protects you from caustic threats and fire.") }
    :mutation("RM13_ENVIRONMENTAL"))

content.add(content.Enchantment { id = "ENCH_DEBUG_FREE_DODGES", condition = "ALWAYS" }
    :value("FREE_DODGES", { add = 10 }))

content.add(content.Enchantment { id = "SQUEAKY_ANKLES", condition = "ALWAYS" }
    :value("FOOTSTEP_NOISE", { multiply = 3 }))

content.add(content.Enchantment { id = "nvg_great_mech", condition = "ALWAYS" }
    :value("NIGHT_VIS", { add = 14 }))

content.add(content.Enchantment { id = "nvg_great", has = "WORN", condition = "ACTIVE", name = content.text("Night Vision Goggles"), description = content.text("You are wearing night vision goggles which allow you to see really well in the dark.") }
    :value("NIGHT_VIS", { add = 14 }))

content.add(content.Enchantment { id = "nvg_good", has = "WORN", condition = "ACTIVE", name = content.text("Night Vision Goggles"), description = content.text("You are wearing night vision goggles which allow you to see quite well in the dark.") }
    :value("NIGHT_VIS", { add = 12 }))

content.add(content.Enchantment { id = "nvg_normal", has = "WORN", condition = "ACTIVE", name = content.text("Night Vision Goggles"), description = content.text("You are wearing night vision goggles which allow you to see in the dark.") }
    :value("NIGHT_VIS", { add = 10 }))

content.add(content.Enchantment { id = "nvg_bad", has = "WORN", condition = "ACTIVE", name = content.text("Night Vision Goggles"), description = content.text("You are wearing night vision goggles which allow you to poorly see in the dark.") }
    :value("NIGHT_VIS", { add = 8 }))

content.add(content.Enchantment { id = "ench_climate_control_warm", has = "WORN", condition = "ALWAYS", name = content.text("Cold Climate Control"), description = content.text("You are wearing equipment that helps handle harsh climates.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 }))

content.add(content.Enchantment { id = "ench_climate_control_all", has = "WORN", condition = "ACTIVE", name = content.text("Complete Climate Control"), description = content.text("You are wearing equipment that helps handle harsh climates.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment { id = "ench_string_dimension_biosuit", has = "WORN", condition = "ALWAYS", name = content.text("Passive Temperature Regulation"), description = content.text("You are wearing equipment that moderates temperature change in your core.  It's can't protect against extreme conditions, but it helps.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 25 })
    :value("CLIMATE_CONTROL_CHILL", { add = 25 }))

content.add(content.Enchantment { id = "ench_climate_control_all_permanent", has = "WORN", condition = "ALWAYS", name = content.text("Complete Climate Control"), description = content.text("You are wearing equipment that helps handle harsh climates.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment { id = "ench_exo_strength", has = "WORN", condition = "ACTIVE", name = content.text("EXO Frame Strength"), description = content.text("You are wearing equipment that gives 10 strength.") }
    :value("STRENGTH", { add = 10 }))

content.add(content.Enchantment { id = "ench_meteor_armor", has = "WORN", condition = "ALWAYS", name = content.text("Hyperdense"), description = content.text("Your armor's massive weight makes it nearly impossible to be knocked over or pushed back.") }
    :value("KNOCKBACK_RESIST", { add = 1.0 })
    :value("KNOCKDOWN_RESIST", { add = 1.0 }))

content.add(content.Enchantment { id = "ench_dampened_steps", has = "WORN", condition = "ACTIVE", name = content.text("Dampened Steps"), description = content.text("You are wearing equipment that muffles your footsteps.") }
    :value("FOOTSTEP_NOISE", { multiply = -0.67 }))

content.add(content.Enchantment { id = "combat_exoskeleton_inactive", has = "WORN", condition = "INACTIVE", name = content.text("Inactive exoskeleton"), description = content.text("The exoskeleton is inactive and makes moving in it difficult and exhausting.") }
    :value("MOVEMENT_EXERTION_MODIFIER", { multiply = 0.5 }))

content.add(content.Enchantment { id = "combat_exoskeleton_heavy_active", has = "WORN", condition = "ACTIVE", name = content.text("Active combat exoskeleton mk.1"), description = content.text("Now powered, the exoskeleton provides <color_white>significant</color> improvements to your carry weight and movement exertion while the life support system shields you against harmful gas, cools you down, and dampens harmful sounds.") }
    :value("MOVEMENT_EXERTION_MODIFIER", { multiply = -0.2 })
    :value("CARRY_WEIGHT", { multiply = 0.8 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment { id = "combat_exoskeleton_medium_active", has = "WORN", condition = "ACTIVE", name = content.text("Active combat exoskeleton mk.2"), description = content.text("Now powered, the exoskeleton provides <color_white>moderate</color> improvements to your carry weight and movement exertion while the life support system shields you against harmful gas, cools you down, and dampens harmful sounds.") }
    :value("MOVEMENT_EXERTION_MODIFIER", { multiply = -0.3 })
    :value("CARRY_WEIGHT", { multiply = 0.6 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment { id = "combat_exoskeleton_light_active", has = "WORN", condition = "ACTIVE", name = content.text("Active combat exoskeleton mk.3"), description = content.text("Now powered, the exoskeleton provides <color_white>slight</color> improvements to your carry weight and movement exertion while the life support system shields you against harmful gas, cools you down, and dampens harmful sounds.") }
    :value("MOVEMENT_EXERTION_MODIFIER", { multiply = -0.4 })
    :value("CARRY_WEIGHT", { multiply = 0.4 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment { id = "resonance_suit_active", has = "WORN", condition = "ACTIVE", name = content.text("Anomaly protection"), description = content.text("The electronics in your suit are protecting you from some types of extra-dimensional interference.") }
    :value("ARTIFACT_RESONANCE", { add = -750 }))

content.add(content.Enchantment { id = "AR_targeting_system", has = "WORN", condition = "ACTIVE", name = content.text("Adaptive targeting system"), description = content.text("Your AR HUD includes an adaptive targeting system, making firearm target acquisition easier.") }
    :value("WEAPON_DISPERSION", { add = -0.25 }))

content.add(content.Enchantment { id = "robofac_XM_LEG_on", has = "WORN", condition = "ACTIVE", name = content.text("Active XM-LEG"), description = content.text("Your active wearable leg cybernetics are helping you move quicker and easier over flat ground and obstacles, and are increasing the amount of weight you can carry.") }
    :value("MOVEMENT_EXERTION_MODIFIER", { multiply = -0.2 })
    :value("MOVE_COST", { multiply = -0.15 })
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -0.5 })
    :value("CARRY_WEIGHT", { add = 20000 }))

content.add(content.Enchantment { id = "robofac_XM_ARM_on", has = "WORN", condition = "ACTIVE", name = content.text("Active XM-ARM"), description = content.text("Your active wearable arm cybernetics are improving your weapon handling and throwing ability.") }
    :value("RECOIL_MODIFIER", { multiply = -0.3 })
    :value("WEAPON_DISPERSION", { multiply = -0.1 })
    :value("THROW_STR", { multiply = 0.5 })
    :value("THROW_DAMAGE", { multiply = 0.25 }))

content.add(content.Enchantment { id = "robofac_XM_BACK_on", has = "WORN", condition = "ACTIVE", name = content.text("Active XM-BACK"), description = content.text("Your active wearable torso cybernetics are <color_white>slightly</color> increasing your carry weight and improving your ability to throw and absorb recoil.") }
    :value("CARRY_WEIGHT", { multiply = 0.35 })
    :value("RECOIL_MODIFIER", { multiply = -0.05 })
    :value("WEAPON_DISPERSION", { multiply = -0.05 })
    :value("THROW_STR", { multiply = 0.05 })
    :value("THROW_DAMAGE", { multiply = 0.05 }))
