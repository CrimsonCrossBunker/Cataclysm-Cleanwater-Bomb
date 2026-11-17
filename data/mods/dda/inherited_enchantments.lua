local content = require("ccb").content

-- data/json/mutations/mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_RESISTWARM_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_QUICK_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FAST_REFLEXES_0" }
    :value("DODGE_CHANCE", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FLEET_0" }
    :value("MOVECOST_FLATGROUND_MOD", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLOWRUNNER_0" }
    :value("MOVECOST_FLATGROUND_MOD", { multiply = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LIGHTSTEP_0" }
    :value("FOOTSTEP_NOISE", { multiply = -0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOODCARDIO_0" }
    :value("CARDIO_MULTIPLIER", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BADKNEES_0" }
    :value("MOVECOST_OBSTACLE_MOD", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGBACK_0" }
    :value("CARRY_WEIGHT", { multiply = 0.35 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BADBACK_0" }
    :value("CARRY_WEIGHT", { multiply = -0.35 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PACKMULE_0" }
    :value("OBTAIN_COST_MULTIPLIER", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TOUGH_0" }
    :value("MAX_HP", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TOUGH2_0" }
    :value("MAX_HP", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TOUGH3_0" }
    :value("MAX_HP", { multiply = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FLIMSY_0" }
    :value("MAX_HP", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FASTHEALER_0" }
    :value("MENDING_MODIFIER", { multiply = 1 })
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.133 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PAINRESIST_0", condition = "ALWAYS" }
    :value("PAIN", { multiply = -0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MORE_PAIN_0", condition = "ALWAYS" }
    :value("PAIN", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VERY_TALL_0" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.5 })
    :value("CARRY_WEIGHT", { multiply = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLEEPY_0" }
    :value("SLEEPINESS_REGEN", { multiply = 0.333 })
    :value("SLEEPINESS", { multiply = 0.333 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HUNGER_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.1 })
    :value("METABOLISM", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THIRST_0" }
    :value("THIRST", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THIRST2_0" }
    :value("THIRST", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THIRST3_0" }
    :value("THIRST", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WEAKSTOMACH_0" }
    :value("VOMIT_MUL", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_NAUSEA_0" }
    :value("VOMIT_MUL", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VOMITOUS_0" }
    :value("VOMIT_MUL", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOURMAND_0" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CONSUME_TIME_MOD", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LIGHTEATER_0" }
    :value("METABOLISM", { multiply = -0.333 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TABLEMANNERS_0" }
    :value("CONSUME_TIME_MOD", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CLUMSY_0" }
    :value("FOOTSTEP_NOISE", { multiply = 0.7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INSOMNIA_0", condition = "ALWAYS" }
    :value("SLEEPY", { add = -12 }))

content.add(content.Enchantment { id = "INLINE_ENCH_COMPUTER_ILLITERATE_0" }
    :skill("computer", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOODMEMORY_0" }
    :value("SKILL_RUST_RESIST", { multiply = -0.34 })
    :value("THEORETICAL_SKILL_CATCHUP_BONUS", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FASTREADER_0" }
    :value("READING_SPEED_MULTIPLIER", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLOWREADER_0" }
    :value("READING_SPEED_MULTIPLIER", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLOWLEARNER_0", condition = "ALWAYS" }
    :value("LEARNING_FOCUS", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHOUT1_0" }
    :value("SHOUT_NOISE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LARGE_0" }
    :value("STRENGTH", { add = 2 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.5 })
    :value("CARRY_WEIGHT", { multiply = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LARGE_OK_0" }
    :value("STRENGTH", { add = 2 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.5 })
    :value("CARRY_WEIGHT", { multiply = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HUGE_0" }
    :value("MAX_HP", { add = -6 })
    :value("STRENGTH", { add = 4 })
    :value("SLEEPINESS", { multiply = 0.15 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HUGE_OK_0" }
    :value("STRENGTH", { add = 4 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUT_TOUGH_0" }
    :value("MAX_HP", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUT_TOUGH2_0" }
    :value("MAX_HP", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUT_TOUGH3_0" }
    :value("MAX_HP", { multiply = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STR_UP_0" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STR_UP_2_0" }
    :value("STRENGTH", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STR_UP_3_0" }
    :value("STRENGTH", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STR_UP_4_0" }
    :value("STRENGTH", { add = 7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_UP_0" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_UP_2_0" }
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_UP_3_0" }
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_UP_4_0" }
    :value("DEXTERITY", { add = 7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INT_UP_0" }
    :value("INTELLIGENCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INT_UP_2_0" }
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INT_UP_3_0" }
    :value("INTELLIGENCE", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INT_UP_4_0" }
    :value("INTELLIGENCE", { add = 7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_UP_0" }
    :value("PERCEPTION", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_UP_2_0" }
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_UP_3_0" }
    :value("PERCEPTION", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_UP_4_0" }
    :value("PERCEPTION", { add = 7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PRED2_0", condition = "ALWAYS" }
    :value("COMBAT_CATCHUP", { multiply = 2.0 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PRED3_0" }
    :value("COMBAT_CATCHUP", { multiply = 2.0 })
    :value("INTELLIGENCE", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PRED4_0" }
    :value("COMBAT_CATCHUP", { multiply = 3.0 })
    :value("INTELLIGENCE", { add = -3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DENSE_BONES_0" }
    :value("MOVE_COST", { multiply = 0.05 })
    :value("ATTACK_SPEED", { multiply = 0.05 })
    :value("MAX_HP", { multiply = 0.05 })
    :value("MOVECOST_SWIM_MOD", { multiply = 0.2 })
    :value("DODGE_CHANCE", { add = -1 })
    :value("CARRY_WEIGHT", { multiply = 0.15 })
    :value("WEIGHT", { multiply = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MET_RAT_0" }
    :value("SLEEPINESS_REGEN", { multiply = 0.333 })
    :value("SLEEPINESS", { multiply = 0.5 })
    :value("METABOLISM", { multiply = 0.333 })
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.133 }))

content.add(content.Enchantment { id = "INLINE_ENCH_REGEN_LIZ_0" }
    :value("MENDING_MODIFIER", { multiply = 19 })
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLIT_NOSTRILS_0" }
    :effect("effect_slit_nostrils_breathing_penalty", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_LIGHT_BONES_0", condition = "ALWAYS" }
    :value("MOVE_COST", { multiply = -0.1 })
    :value("ATTACK_SPEED", { multiply = -0.1 })
    :value("CARRY_WEIGHT", { multiply = -0.2 })
    :value("WEIGHT", { multiply = -0.05 })
    :post_armor_damage("bash", { multiply = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOLLOW_BONES_0" }
    :value("MOVE_COST", { multiply = -0.2 })
    :value("ATTACK_SPEED", { multiply = -0.2 })
    :value("CARRY_WEIGHT", { multiply = -0.4 })
    :value("WEIGHT", { multiply = -0.1 })
    :post_armor_damage("bash", { multiply = 0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BIRD_EYE_0" }
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BIRD_EYE_1" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_avian", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_GIZZARD_0" }
    :value("KCAL", { multiply = -0.4 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BEAK_0" }
    :bodypart_change("", "mouth")
    :bodypart_change("beak_bird", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_GASTROPOD_FOOT_0" }
    :value("MOVECOST_FLATGROUND_MOD", { multiply = 0.25 })
    :value("FOOTSTEP_NOISE", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INTERSTICE_MIND_0" }
    :value("SKILL_RUST_RESIST", { multiply = 0.5 })
    :value("LEARNING_FOCUS", { multiply = -0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_COMPOUND_EYES_0", condition = "ALWAYS" }
    :value("BONUS_DODGE", { add = 1 })
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_compound", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_ROT1_0" }
    :value("REGEN_HP", { multiply = -0.25 })
    :value("REGEN_HP_AWAKE", { multiply = -0.166 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ROT2_0" }
    :value("REGEN_HP", { multiply = -0.25 })
    :value("REGEN_HP_AWAKE", { multiply = -0.266 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PONDEROUS1_0" }
    :value("MOVE_COST", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PONDEROUS2_0" }
    :value("MOVE_COST", { multiply = 0.2 }))

-- data/json/mutations/mutations_limbs.json
content.add(content.Enchantment { id = "INLINE_ENCH_CLAWS_0" }
    :effect("effect_claw_manipulation_penalty", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_LONG_0", condition = "ALWAYS" }
    :bodypart_change("tail_long", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_THICK_0", condition = "ALWAYS" }
    :bodypart_change("tail_thick", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_CLUB_0", condition = "ALWAYS" }
    :bodypart_change("tail_club", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_PADDED_FEET_0", condition = "ALWAYS" }
    :value("FOOTSTEP_NOISE", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LEG_TENTACLES_2" }
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

-- data/json/mutations/mutations_skin.json
content.add(content.Enchantment { id = "INLINE_ENCH_DOWN_0" }
    :value("BODYTEMP_SLEEP", { add = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LIGHTFUR_0" }
    :value("BODYTEMP_SLEEP", { add = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FUR_0" }
    :value("BODYTEMP_SLEEP", { add = 0.4 }))
