local content = require("ccb").content

-- data/json/mutations/cybernetic_traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_CBM_Interface_brain_lesion_0" }
    :value("INTELLIGENCE", { add = -1 })
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CBM_Interface_brain_lesion_2_0" }
    :value("INTELLIGENCE", { add = -4 })
    :value("DEXTERITY", { add = -4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EXODII_CYBERFRAME_GENERIC_0" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("", "torso")
    :bodypart_change("torso_bionic_basic", "")
    :bodypart_change("", "head")
    :bodypart_change("head_bionic_basic", "")
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_bionic_basic", "")
    :bodypart_change("", "mouth")
    :bodypart_change("mouth_bionic_basic", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_EXODII_BODY_1_0" }
    :value("STRENGTH", { add = 4 })
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EXODII_BODY_1_1" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("arm_bionic_basic_l", "")
    :bodypart_change("hand_bionic_basic_l", "")
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("arm_bionic_basic_r", "")
    :bodypart_change("hand_bionic_basic_r", "")
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("leg_bionic_basic_l", "")
    :bodypart_change("foot_bionic_basic_l", "")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("leg_bionic_basic_r", "")
    :bodypart_change("foot_bionic_basic_r", "")
    :bodypart_change("", "torso")
    :bodypart_change("torso_bionic_basic", "")
    :bodypart_change("", "head")
    :bodypart_change("head_bionic_basic", "")
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_bionic_basic", "")
    :bodypart_change("", "mouth")
    :bodypart_change("mouth_bionic_basic", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_EXODII_BODY_1b_0" }
    :value("STRENGTH", { add = 4 })
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EXODII_BODY_1b_1" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("arm_bionic_basic_l", "")
    :bodypart_change("hand_bionic_basic_l", "")
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("arm_bionic_basic_r", "")
    :bodypart_change("hand_bionic_basic_r", "")
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("leg_bionic_basic_l", "")
    :bodypart_change("foot_bionic_basic_l", "")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("leg_bionic_basic_r", "")
    :bodypart_change("foot_bionic_basic_r", "")
    :bodypart_change("", "torso")
    :bodypart_change("torso_bionic_basic", "")
    :bodypart_change("", "head")
    :bodypart_change("head_bionic_basic", "")
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_bionic_basic", "")
    :bodypart_change("", "mouth")
    :bodypart_change("mouth_bionic_basic", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_EXODII_BODY_2_0" }
    :value("MAX_HP", { add = 10 })
    :value("STRENGTH", { add = 4 })
    :value("DEXTERITY", { add = 4 })
    :value("CARRY_WEIGHT", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BIONIC_ARM_BASIC_LEFT_0" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("robofac_arm_bionic_basic_l", "")
    :bodypart_change("robofac_hand_bionic_basic_l", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BIONIC_ARM_BASIC_RIGHT_0" }
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("robofac_arm_bionic_basic_r", "")
    :bodypart_change("robofac_hand_bionic_basic_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BIONIC_ARM_BASIC_BOTH_0" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("robofac_arm_bionic_basic_l", "")
    :bodypart_change("robofac_hand_bionic_basic_l", "")
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("robofac_arm_bionic_basic_r", "")
    :bodypart_change("robofac_hand_bionic_basic_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BIONIC_LEG_BASIC_LEFT_0" }
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("robofac_leg_bionic_basic_l", "")
    :bodypart_change("robofac_foot_bionic_basic_l", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BIONIC_LEG_BASIC_RIGHT_0" }
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("robofac_leg_bionic_basic_r", "")
    :bodypart_change("robofac_foot_bionic_basic_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BIONIC_LEG_BASIC_BOTH_0" }
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("robofac_leg_bionic_basic_l", "")
    :bodypart_change("robofac_foot_bionic_basic_l", "")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("robofac_leg_bionic_basic_r", "")
    :bodypart_change("robofac_foot_bionic_basic_r", ""))

-- data/json/mutations/debug.json
content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_SPEED_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_STAMINA_0" }
    :value("STAMINA_REGEN_MOD", { add = 9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_CARDIO_0" }
    :value("CARDIO_MULTIPLIER", { multiply = 10000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_HP_0" }
    :value("MAX_HP", { add = 9000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_HP_REGEN_0" }
    :value("REGEN_HP", { add = 100 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_LIGHT_0" }
    :value("LUMINATION", { add = 9000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_CS_0" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_MANA_0", condition = "ALWAYS" }
    :value("MAX_MANA", { add = 500000 })
    :value("REGEN_MANA", { multiply = 1000 })
    :value("CASTING_TIME_MULTIPLIER", { multiply = -0.99 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_NO_ENCUMBRANCE_0" }
    :encumbrance("head", { multiply = -1 })
    :encumbrance("torso", { multiply = -1 })
    :encumbrance("mouth", { multiply = -1 })
    :encumbrance("eyes", { multiply = -1 })
    :encumbrance("arm_l", { multiply = -1 })
    :encumbrance("arm_r", { multiply = -1 })
    :encumbrance("hand_l", { multiply = -1 })
    :encumbrance("hand_r", { multiply = -1 })
    :encumbrance("leg_r", { multiply = -1 })
    :encumbrance("leg_l", { multiply = -1 })
    :encumbrance("foot_r", { multiply = -1 })
    :encumbrance("foot_l", { multiply = -1 }))

-- data/json/mutations/mutation_item_traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_well_distributed_0" }
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

-- data/json/mutations/mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_VULNERABLECHILL_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGER_VULNERABLECHILL_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = -25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RESISTCHILL_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGER_RESISTCHILL_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VULNERABLEWARM_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGER_VULNERABLEWARM_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = -25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGER_RESISTWARM_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = 25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RESISTCHILL_RESISTWARM_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = 25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RESISTCHILL_RESISTWARM_1", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_1", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_2_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_2_1", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_RESONANCE_0", condition = "ALWAYS" }
    :value("ARTIFACT_RESONANCE", { add = 750 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FLEET2_0" }
    :value("MOVECOST_FLATGROUND_MOD", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOODCARDIO2_0" }
    :value("CARDIO_MULTIPLIER", { multiply = 0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BADCARDIO_0" }
    :value("CARDIO_MULTIPLIER", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_REALLYBADKNEES_0" }
    :value("MOVECOST_OBSTACLE_MOD", { multiply = 2.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DISORGANIZED_0" }
    :value("OBTAIN_COST_MULTIPLIER", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOODHEARING_0" }
    :value("HEARING_MULT", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BADHEARING_0" }
    :value("HEARING_MULT", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEAF_0" }
    :value("HEARING_MULT", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FLIMSY2_0" }
    :value("MAX_HP", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FLIMSY3_0" }
    :value("MAX_HP", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FASTHEALER2_0" }
    :value("MENDING_MODIFIER", { multiply = 3 })
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.44 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLOWHEALER_0" }
    :value("MENDING_MODIFIER", { multiply = -0.25 })
    :value("REGEN_HP", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLOWHEALER2_0" }
    :value("MENDING_MODIFIER", { multiply = -0.67 })
    :value("REGEN_HP", { multiply = -0.67 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLOWHEALER3_0" }
    :value("MENDING_MODIFIER", { multiply = -0.9 })
    :value("REGEN_HP", { multiply = -0.9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_NOHEAL_0" }
    :value("MENDING_MODIFIER", { multiply = -1 })
    :value("REGEN_HP", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MORE_PAIN2_0", condition = "ALWAYS" }
    :value("PAIN", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MORE_PAIN3_0", condition = "ALWAYS" }
    :value("PAIN", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VERY_SHORT_0" }
    :value("MAX_HP", { multiply = -0.05 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.5 })
    :value("CARRY_WEIGHT", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_VISION2_0", condition = "ALWAYS" }
    :vision({ distance = 10, descriptions = { { id = "interstice_creature_sense", color = "c_pink", symbol = "?", text = content.text("You sense something here.") } } }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNOBSERVANT_0" }
    :value("OVERMAP_SIGHT", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLEEPY2_0" }
    :value("SLEEPINESS", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WAKEFUL_0" }
    :value("SLEEPINESS", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WAKEFUL2_0" }
    :value("SLEEPINESS", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WAKEFUL3_0" }
    :value("SLEEPINESS_REGEN", { multiply = 0.5 })
    :value("SLEEPINESS", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EASYSLEEPER_0", condition = "ALWAYS" }
    :value("SLEEPY", { add = 24 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EASYSLEEPER2_0", condition = "ALWAYS" }
    :value("SLEEPY", { add = 40 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HUNGER2_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.3 })
    :value("METABOLISM", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HUNGER3_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.5 })
    :value("METABOLISM", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TINYSTOMACH_0" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGSTOMACH_0" }
    :value("VOMIT_MUL", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FORGETFUL_0" }
    :value("SKILL_RUST_RESIST", { multiply = 0.33 })
    :value("THEORETICAL_SKILL_CATCHUP_BONUS", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FASTLEARNER_0", condition = "ALWAYS" }
    :value("LEARNING_FOCUS", { multiply = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BOOMING_VOICE_0" }
    :value("SHOUT_NOISE", { add = 10 })
    :value("SHOUT_NOISE_STR_MULT", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHOUT2_0" }
    :value("SHOUT_NOISE", { add = 5 })
    :value("SHOUT_NOISE_STR_MULT", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHOUT3_0" }
    :value("SHOUT_NOISE", { add = 10 })
    :value("SHOUT_NOISE_STR_MULT", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_POSTURE_0" }
    :value("STRENGTH", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_POSTURE_2_0" }
    :value("STRENGTH", { add = -1 })
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_INTERSTICE_0" }
    :value("MOVE_COST", { multiply = -0.1 })
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_INTERSTICE_0" }
    :value("PERCEPTION", { add = 12 })
    :value("INTELLIGENCE", { add = -3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_SLIME_OK_0" }
    :value("PERCEPTION", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUTE_BIRD_OK_0" }
    :value("SOCIAL_LIE", { multiply = -0.4 })
    :value("SOCIAL_PERSUADE", { multiply = -0.4 })
    :value("SOCIAL_INTIMIDATE", { multiply = -0.4 })
    :skill("speech", { add = -4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUTE_CEPH_OK_0" }
    :value("SOCIAL_LIE", { multiply = -0.6 })
    :value("SOCIAL_PERSUADE", { multiply = -0.6 })
    :value("SOCIAL_INTIMIDATE", { multiply = -0.6 })
    :skill("speech", { add = -6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUTE_GASTROPOD_OK_0" }
    :value("SOCIAL_LIE", { multiply = -0.7 })
    :value("SOCIAL_PERSUADE", { multiply = -0.7 })
    :value("SOCIAL_INTIMIDATE", { multiply = -0.7 })
    :skill("speech", { add = -7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUTE_INSECT_OK_0" }
    :value("SOCIAL_LIE", { multiply = -0.7 })
    :value("SOCIAL_PERSUADE", { multiply = -0.7 })
    :value("SOCIAL_INTIMIDATE", { multiply = -0.7 })
    :skill("speech", { add = -7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUTE_SLIME_OK_0" }
    :value("SOCIAL_LIE", { multiply = -0.9 })
    :value("SOCIAL_PERSUADE", { multiply = -0.9 })
    :value("SOCIAL_INTIMIDATE", { multiply = -0.9 })
    :skill("speech", { add = -9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ADRENALINE2_0" }
    :value("MOVE_COST", { multiply = -0.1 })
    :value("DODGE_CHANCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EATHEALTH_active_0" }
    :value("REGEN_HP", { multiply = 349 })
    :value("REGEN_HP_AWAKE", { multiply = 0.85 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BOVINE_BULK_0" }
    :value("MOVE_COST", { multiply = 0.02 })
    :value("MOVECOST_SWIM_MOD", { multiply = 0.3 })
    :value("MAX_HP", { add = 14 })
    :value("WEIGHT", { multiply = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BOVINE_BULK2_0" }
    :value("MOVE_COST", { multiply = 0.04 })
    :value("MOVECOST_SWIM_MOD", { multiply = 0.7 })
    :value("MAX_HP", { add = 21 })
    :value("WEIGHT", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_URSINE_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUZZLE_BEAR_0", condition = "ALWAYS" }
    :bodypart_change("", "mouth")
    :bodypart_change("muzzle_bear", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_URSINE_EYE_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_ursine", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_FAT_0" }
    :value("MOVE_COST", { multiply = 0.05 })
    :value("MOVECOST_SWIM_MOD", { multiply = -0.05 })
    :value("WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HIBERNATE_0" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CANINE_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LUPINE_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUZZLE_0", condition = "ALWAYS" }
    :bodypart_change("", "mouth")
    :bodypart_change("muzzle_lupine", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_PERSISTENCE_HUNTER_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.1 })
    :value("SLEEPINESS", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PERSISTENCE_HUNTER2_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.2 })
    :value("SLEEPINESS", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FEL_NV_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_feline", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_FELINE_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FELINE_FLEXIBILITY_0" }
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RABBIT_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RABBIT_NOSE_0", condition = "ALWAYS" }
    :bodypart_change("", "mouth")
    :bodypart_change("muzzle_rabbit", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_MUZZLE_RAT_0", condition = "ALWAYS" }
    :bodypart_change("", "mouth")
    :bodypart_change("muzzle_rodent", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_MOUSE_EARS_0" }
    :value("HEARING_MULT", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SMALL_0" }
    :value("DODGE_CHANCE", { add = 1 })
    :value("MAX_HP", { multiply = -0.05 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.5 })
    :value("CARRY_WEIGHT", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SMALL2_0" }
    :value("DODGE_CHANCE", { add = 2 })
    :value("MAX_HP", { multiply = -0.3 })
    :value("FOOTSTEP_NOISE", { multiply = -1 })
    :value("CARRY_WEIGHT", { multiply = -0.5 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SMALL_OK_0" }
    :value("DODGE_CHANCE", { add = 2 })
    :value("MAX_HP", { multiply = -0.25 })
    :value("FOOTSTEP_NOISE", { multiply = -1 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.5 })
    :value("CARRY_WEIGHT", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CRAFTY_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.15 })
    :value("MOVE_COST", { multiply = -0.25 })
    :value("STEALTH_MODIFIER", { add = 40 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUZZLE_LONG_0" }
    :bodypart_change("", "mouth")
    :bodypart_change("muzzle_long", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_MUZZLE_RAPTOR_0" }
    :bodypart_change("", "mouth")
    :bodypart_change("muzzle_long", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BATEARS_0" }
    :value("HEARING_MULT", { multiply = 5.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BEAK_PECK_0" }
    :bodypart_change("", "mouth")
    :bodypart_change("beak_woodpecker", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BEAK_HUM_0" }
    :bodypart_change("", "mouth")
    :bodypart_change("beak_hummingbird", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_GASTROPOD_EXTREMITY1_0" }
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GASTROPOD_EXTREMITY2_0" }
    :bodypart_change("", "mouth")
    :bodypart_change("gastropod_tongue", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_GASTROPOD_EXTREMITY3_0" }
    :bodypart_change("", "mouth")
    :bodypart_change("gastropod_tongue", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_SHELL2_0" }
    :value("BODYTEMP_SLEEP", { add = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EYESTALKS1_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_snail", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_EYESTALKS2_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_snail_good", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_EYESTALKS_RIGID_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_crab", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_FROG_EYES_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_frog", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_WIDE_MOUTH_0" }
    :value("CONSUME_TIME_MOD", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VOMITSTOMACH_0" }
    :value("VOMIT_MUL", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGKNEES_0" }
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AMPHIBIAN_0" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.55 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELECTRORECEPTORS_1", condition = "ALWAYS" }
    :value("EXTRA_ELEC_PAIN", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHARKTEETH_0" }
    :value("CONSUME_TIME_MOD", { multiply = -0.7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CEPH_VISION_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_ceph", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_CEPH_MIND_0" }
    :value("LEARNING_FOCUS", { add = 17 })
    :value("SKILL_RUST_RESIST", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INK_GLANDS_0", condition = "ACTIVE" }
    :hit_me({ id = "ink_gland_spray_primer", trigger_once_in = 2, self = true }))

content.add(content.Enchantment { id = "INLINE_ENCH_MOUTH_TENTACLES_0" }
    :value("CONSUME_TIME_MOD", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INSECT_RESERVOIR_0" }
    :value("THIRST", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ANTENNAE_0", condition = "ACTIVE" }
    :vision({ distance = 3, descriptions = { { id = "antennae_sense", color = "c_white", symbol = "?", text = content.text("You sense something here.") } } }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANDIBLES_0" }
    :value("CONSUME_TIME_MOD", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PROBOSCIS_0", condition = "ALWAYS" }
    :bodypart_change("", "mouth")
    :bodypart_change("insect_proboscis", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_FANGS_SPIDER_0" }
    :value("CONSUME_TIME_MOD", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ROT3_0" }
    :value("REGEN_HP", { multiply = -0.25 })
    :value("REGEN_HP_AWAKE", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HYDE_0" }
    :value("STRENGTH", { add = 3 })
    :value("INTELLIGENCE", { add = -8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CENOBITE_0" }
    :value("PAIN_PENALTY_MOD_STR", { multiply = -10 })
    :value("PAIN_PENALTY_MOD_DEX", { multiply = -10 })
    :value("PAIN_PENALTY_MOD_SPEED", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TOUGH_MEDICAL_0" }
    :value("MAX_HP", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TOUGH2_MEDICAL_0" }
    :value("MAX_HP", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PAINRESIST_TROGLO_0", condition = "ALWAYS" }
    :value("PAIN", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STOCKY_TROGLO_0" }
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_REGEN_0" }
    :value("MENDING_MODIFIER", { multiply = 15 })
    :value("REGEN_HP", { multiply = 1.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AMORPHOUS_0" }
    :value("MOVE_COST", { multiply = 0.25 })
    :value("CONSUME_TIME_MOD", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLIMESPAWNER_0" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLIMESPAWNER_1" }
    :bodypart_change("", "head")
    :bodypart_change("head_slime", "")
    :bodypart_change("", "mouth")
    :bodypart_change("mouth_slime", "")
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_slime", "")
    :bodypart_change("", "torso")
    :bodypart_change("torso_slime", "")
    :bodypart_change("", "arm_l")
    :bodypart_change("arm_slime_l", "")
    :bodypart_change("", "hand_l")
    :bodypart_change("hand_slime_complete_l", "")
    :bodypart_change("", "arm_r")
    :bodypart_change("arm_slime_r", "")
    :bodypart_change("", "hand_r")
    :bodypart_change("hand_slime_complete_r", "")
    :bodypart_change("", "leg_l")
    :bodypart_change("leg_slime_l", "")
    :bodypart_change("", "foot_l")
    :bodypart_change("foot_slime_l", "")
    :bodypart_change("", "leg_r")
    :bodypart_change("leg_slime_r", "")
    :bodypart_change("", "foot_r")
    :bodypart_change("foot_slime_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_FEYHEARING_0" }
    :value("HEARING_MULT", { multiply = 0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICEHEARING_0" }
    :value("HEARING_MULT", { multiply = 0.95 })
    :value("INTELLIGENCE", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELFA_NV_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_fey", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_ELFA_FNV_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_fey_full", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_FLOWERS_0" }
    :value("SCENT_MASK", { add = -200 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PONDEROUS3_0" }
    :value("MOVE_COST", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VINES2_0", condition = "ALWAYS" }
    :bodypart_change("vine_limb_upper_r", "")
    :bodypart_change("vine_limb_upper_l", "")
    :bodypart_change("vine_limb_lower_r", "")
    :bodypart_change("vine_limb_lower_l", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_VINES3_0", condition = "ALWAYS" }
    :bodypart_change("vine_limb_upper_r", "")
    :bodypart_change("vine_limb_upper_l", "")
    :bodypart_change("vine_limb_lower_r", "")
    :bodypart_change("vine_limb_lower_l", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_PHYSIOLOGY_0" }
    :value("DODGE_CHANCE", { add = 3 })
    :value("FOOTSTEP_NOISE", { multiply = -1 })
    :value("SLEEPINESS_REGEN", { multiply = 0.333 })
    :value("SLEEPINESS", { multiply = 0.333 }))

-- data/json/mutations/mutations_limbs.json
content.add(content.Enchantment { id = "INLINE_ENCH_SHORTER_FINGERS_0" }
    :effect("effect_shorter_fingers_manipulation_penalty", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_PAWS_1" }
    :bodypart_change("", "hand_l")
    :bodypart_change("", "hand_r")
    :bodypart_change("paw_l", "")
    :bodypart_change("paw_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_PAWS_RAT_0" }
    :value("RECOIL_MODIFIER", { multiply = 0.5 })
    :value("WEAPON_DISPERSION", { multiply = 0.1 })
    :bodypart_change("", "hand_l")
    :bodypart_change("", "hand_r")
    :bodypart_change("paw_rat_l", "")
    :bodypart_change("paw_rat_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_PAWS_LARGE_1" }
    :bodypart_change("", "hand_l")
    :bodypart_change("", "hand_r")
    :bodypart_change("paw_broad_l", "")
    :bodypart_change("paw_broad_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_SLIME_HANDS_0" }
    :bodypart_change("", "hand_l")
    :bodypart_change("", "hand_r")
    :bodypart_change("hand_slime_l", "")
    :bodypart_change("hand_slime_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BENDY1_0" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BENDY2_0" }
    :value("MAX_HP", { add = 3 })
    :value("STRENGTH", { add = -2 })
    :value("DEXTERITY", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BENDY3_0" }
    :value("MAX_HP", { add = 6 })
    :value("STRENGTH", { add = -4 })
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARACHNID_ARMS_0" }
    :value("DEXTERITY", { add = -4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INSECT_ARMS_0" }
    :bodypart_change("arm_insect_l", "")
    :bodypart_change("arm_insect_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_INSECT_ARMS_OK_0" }
    :bodypart_change("arm_insect_good_l", "")
    :bodypart_change("arm_insect_good_r", "")
    :bodypart_change("insect_hand_l", "")
    :bodypart_change("insect_hand_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_WEBBED_0" }
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PAWS_LITTLE_2" }
    :value("RECOIL_MODIFIER", { multiply = 0.5 })
    :value("WEAPON_DISPERSION", { multiply = 0.1 })
    :bodypart_change("", "hand_l")
    :bodypart_change("", "hand_r")
    :bodypart_change("paw_little_l", "")
    :bodypart_change("paw_little_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_CLAWS_RAT_0" }
    :effect("effect_claw_st_manipulation_penalty", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_CLAWS_ST_0" }
    :effect("effect_claw_st_manipulation_penalty", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_CLAWS_RETRACT_active_0" }
    :effect("effect_claw_manipulation_penalty", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_ARMS_BAT_0" }
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARMS_BAT_1", condition = "ALWAYS" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "arm_r")
    :bodypart_change("arm_leathery_l", "")
    :bodypart_change("arm_leathery_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_WINGS_BUTTERFLY_0", condition = "ALWAYS" }
    :bodypart_change("wing_butterfly_l", "")
    :bodypart_change("wing_butterfly_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_WINGS_BUTTERFLY_1" }
    :value("MOVE_COST", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WINGS_INSECT_0", condition = "ALWAYS" }
    :bodypart_change("wing_insect_l", "")
    :bodypart_change("wing_insect_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_WINGS_INSECT_1", condition = "ACTIVE" }
    :mutation("WINGS_INSECT_active"))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_STING_0", condition = "ALWAYS" }
    :bodypart_change("tail_scorpion", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_FLUFFY_0", condition = "ALWAYS" }
    :bodypart_change("tail_fluffy", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_CATTLE_0", condition = "ALWAYS" }
    :bodypart_change("tail_bovine", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_RAPTOR_0", condition = "ALWAYS" }
    :bodypart_change("tail_raptor", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_FIN_0", condition = "ALWAYS" }
    :bodypart_change("tail_finned", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_RAT_0", condition = "ALWAYS" }
    :bodypart_change("tail_rat", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONG_LEGS_0" }
    :value("MOVE_COST", { multiply = -0.12 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LEGS_BAT_2" }
    :value("MOVE_COST", { multiply = 0.38 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RABBIT_FEET_1" }
    :value("CARRY_WEIGHT", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ANIMAL_FEET_2" }
    :value("CARRY_WEIGHT", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SCUTTLE_0" }
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -0.13 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CRAB_LEGS_0", condition = "ALWAYS" }
    :value("FOOTSTEP_NOISE", { multiply = -0.1 })
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("leg_crab_front_l", "")
    :bodypart_change("leg_crab_front_r", "")
    :bodypart_change("leg_crab_rear_l", "")
    :bodypart_change("leg_crab_rear_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_ARM_TENTACLES_0" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARM_TENTACLES_4_0" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARM_TENTACLES_8_0" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HEAD_INSECT_0", condition = "ALWAYS" }
    :bodypart_change("", "head")
    :bodypart_change("head_dragonfly", ""))

-- data/json/mutations/mutations_skin.json
content.add(content.Enchantment { id = "INLINE_ENCH_SLEEK_SCALES_0" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LUPINE_FUR_0" }
    :value("BODYTEMP_SLEEP", { add = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LUPINE_FUR_SUMMER_0" }
    :value("BODYTEMP_SLEEP", { add = 0.35 }))

content.add(content.Enchantment { id = "INLINE_ENCH_URSINE_FUR_0" }
    :value("BODYTEMP_SLEEP", { add = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_URSINE_FUR_SUMMER_0" }
    :value("BODYTEMP_SLEEP", { add = 0.45 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FELINE_FUR_0" }
    :value("BODYTEMP_SLEEP", { add = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RABBIT_FUR_0" }
    :value("BODYTEMP_SLEEP", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PATCHSKIN1_0" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.05 })
    :value("BODYTEMP_SLEEP", { add = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PATCHSKIN2_0" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.1 })
    :value("BODYTEMP_SLEEP", { add = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PATCHSKIN3_0" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.15 })
    :value("BODYTEMP_SLEEP", { add = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHITIN3_1" }
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHITIN_FUR_0" }
    :value("BODYTEMP_SLEEP", { add = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHITIN_FUR2_0" }
    :value("BODYTEMP_SLEEP", { add = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHITIN_FUR3_0" }
    :value("BODYTEMP_SLEEP", { add = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CRUSTACEAN_CARAPACE_0" }
    :value("DEXTERITY", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CRUSTACEAN_CARAPACE_MOLTED_0" }
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CAMO1_0" }
    :value("STEALTH_MODIFIER", { add = 20 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CAMO2_0" }
    :value("STEALTH_MODIFIER", { add = 20 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PLANTSKIN_0" }
    :value("THIRST", { multiply = -0.2 }))

-- data/json/mutations/mycus.json
content.add(content.Enchantment { id = "INLINE_ENCH_M_SKIN2_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_M_SKIN3_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = -0.2 }))

-- data/json/mutations/professions.json
content.add(content.Enchantment { id = "INLINE_ENCH_PROF_DICEMASTER_0" }
    :value("READING_SPEED_MULTIPLIER", { multiply = -0.1 }))

-- data/json/mutations/supernatural.json
content.add(content.Enchantment { id = "INLINE_ENCH_anti_shape_0" }
    :value("INTELLIGENCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_NOT_GLASS_0" }
    :value("DEXTERITY", { add = 1 }))

-- data/json/npcs/exodii/exodii_weaponmaster.json
content.add(content.Enchantment { id = "INLINE_ENCH_EXODII_BODY_9_0" }
    :value("MAX_HP", { add = 250 })
    :value("STRENGTH", { add = 12 })
    :value("DEXTERITY", { add = 12 }))
