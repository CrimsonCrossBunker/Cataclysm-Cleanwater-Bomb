local content = require("ccb").content

-- mutations/debug_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_VAULT_DEFENDER_0", condition = "ALWAYS" }
    :value("PERCEPTION", { add = 15 })
    :incoming_damage("bullet", { add = -100 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LIBRARY_DEFENDER_0", condition = "ALWAYS" }
    :value("PERCEPTION", { add = 5 })
    :hit_me({ id = "librarian_blinding", self = false }))

-- mutations/magic_classes/attunements.json
content.add(content.Enchantment { id = "INLINE_ENCH_ARTIFICER_0" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BIOTEK_0" }
    :value("BIONIC_MANA_PENALTY", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BLOOD_MAGE_0" }
    :hit_you({ id = "blood_mage_healing", self = true, trigger_once_in = 12 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BOREAL_MAGE_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 })
    :value("CLIMATE_CONTROL_CHILL", { add = 30 })
    :melee_damage("cold", { add = 9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CLEANSING_FLAME_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 30 })
    :value("CLIMATE_CONTROL_CHILL", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CRUSADER_0" }
    :value("MAX_HP", { multiply = 1 })
    :value("DEXTERITY", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EARTH_ELEMENTAL_0" }
    :value("STRENGTH", { add = 5 })
    :value("MAX_STAMINA", { multiply = 3 })
    :value("REGEN_STAMINA", { multiply = 3 })
    :incoming_damage("cut", { add = -15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FIRE_ELEMENTAL_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 30 })
    :value("CLIMATE_CONTROL_CHILL", { add = 10 })
    :incoming_damage("heat", { multiply = -0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_FIRE_ELEMENTAL_1" }
    :hit_me({ id = "FIRE_ELEMENTAL_BURNBACK", trigger_message = content.text("Flames and heat flash out from where you've been hit."), npc_trigger_message = content.text("%1$s's body jets fire and heat out from the wound.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_FORCE_MAGE_0" }
    :value("MELEE_DAMAGE", { multiply = 1 })
    :value("SPEED", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GAIAS_CHOSEN_0" }
    :value("MAX_HP", { multiply = 0.3 })
    :value("PAIN", { multiply = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GAIAS_CHOSEN_1" }
    :hit_me({ id = "GAIAS_CHOSEN_THORNS", trigger_once_in = 2, trigger_message = content.text("Thorns tear at your opponent as they strike you."), npc_trigger_message = content.text("%1$s's thorny brambles bite into their attacker.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_GLACIER_MAGE_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 })
    :value("CLIMATE_CONTROL_CHILL", { add = 30 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GLACIER_MAGE_1" }
    :hit_you({ id = "glacier_mage_attack", trigger_once_in = 14 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOLEMANCER_0" }
    :hit_me({ id = "golemancer_block", self = true, trigger_once_in = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GRAVITY_MAGE_0" }
    :value("CARRY_WEIGHT", { multiply = 1 })
    :value("ATTACK_SPEED", { multiply = -0.1 })
    :value("MELEE_DAMAGE", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_OVERCLOCKER_0" }
    :value("INTELLIGENCE", { add = 5 })
    :value("CASTING_TIME_MULTIPLIER", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ICE_ELEMENTAL_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 })
    :value("CLIMATE_CONTROL_CHILL", { add = 30 })
    :melee_damage("cold", { add = 9 })
    :incoming_damage("cold", { multiply = -0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ICE_ELEMENTAL_1" }
    :hit_you({ id = "ICE_ELEMENTAL_COLD_DAMAGE", trigger_message = content.text("Frost rimes over your attacker as they strike you."), npc_trigger_message = content.text("A coating of frost appears on their opponent as %1$s is struck.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_MAGNETISM_MAGE_1" }
    :incoming_damage("bullet", { add = -50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PERMAFROST_MAGE_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 })
    :value("CLIMATE_CONTROL_CHILL", { add = 30 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PERMAFROST_MAGE_1" }
    :hit_me({ id = "permafrost_mage_moves_substract" }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHAMAN_0" }
    :value("REGEN_MANA", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHAPESHIFTER_0" }
    :encumbrance("mouth", { multiply = -0.6 })
    :encumbrance("arm_r", { multiply = -0.6 })
    :encumbrance("arm_l", { multiply = -0.6 })
    :encumbrance("hand_r", { multiply = -0.6 })
    :encumbrance("hand_l", { multiply = -0.6 })
    :encumbrance("leg_r", { multiply = -0.6 })
    :encumbrance("leg_l", { multiply = -0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SOULFIRE_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 30 })
    :value("CLIMATE_CONTROL_CHILL", { add = 10 })
    :melee_damage("pure", { add = 9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STORM_ELEMENTAL_0" }
    :incoming_damage("electric", { multiply = -0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STORM_ELEMENTAL_1" }
    :hit_me({ id = "STORM_ELEMENTAL_ZAPBACK", trigger_message = content.text("Electricity arcs out from where you've been hit."), npc_trigger_message = content.text("%1$s's body arcs electricity from the wound.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_SUN_MAGE_0" }
    :hit_me({ id = "solar_blinding", trigger_message = content.text("A brilliant light radiates from where you've been hit."), npc_trigger_message = content.text("%1$s's body is enveloped in a bright glare.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_TUNDRA_MAGE_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 })
    :value("CLIMATE_CONTROL_CHILL", { add = 30 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VOID_MAGE_0" }
    :effect("void_mage_night_vision", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_VOID_MAGE_1" }
    :hit_you({ id = "void_claws", trigger_message = content.text("Shadowy claws follow behind your strikes and the afterimage shrivels flesh as it passes through."), npc_trigger_message = content.text("%1$s's attacks seems to have an afterimage of shadowy claws striking behind them about a half a second.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_VULCANIST_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 30 })
    :incoming_damage("heat", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VULCANIST_1" }
    :effect("effect_vulcanist_no_smoke_or_blisters", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_WITHER_MAGE_0" }
    :hit_you({ id = "wither_mage_withering", self = true, trigger_once_in = 6 }))

-- mutations/mutation_paths/black_dragon.json
content.add(content.Enchantment { id = "INLINE_ENCH_LARGE_DRAGON_0" }
    :value("STRENGTH", { add = 2 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.5 })
    :value("CARRY_WEIGHT", { multiply = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_LARGE_OK_DRAGON_0" }
    :value("STRENGTH", { add = 2 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.5 })
    :value("CARRY_WEIGHT", { multiply = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HUGE_DRAGON_0" }
    :value("MAX_HP", { add = -6 })
    :value("STRENGTH", { add = 4 })
    :value("SLEEPINESS", { multiply = 0.15 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRAGON_STR_0" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRAGON_STR2_0" }
    :value("STRENGTH", { add = 3 })
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRAGON_STR3_0" }
    :value("STRENGTH", { add = 5 })
    :value("DEXTERITY", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRAGON_STR4_0" }
    :value("STRENGTH", { add = 8 })
    :value("DEXTERITY", { add = -3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HUGE_OK_DRAGON_0" }
    :value("STRENGTH", { add = 4 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRAGON_WINGS_BLACK_0" }
    :value("DODGE_CHANCE", { add = -3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_OVERLY_ACID_GUT_0" }
    :value("METABOLISM", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRAGON_MAGIC_0" }
    :value("INTELLIGENCE", { add = 2 })
    :value("MAX_MANA", { add = 250 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRAGON_SPELLS_0" }
    :value("INTELLIGENCE", { add = 4 })
    :value("MAX_MANA", { add = 750 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PRED4_DRAGON_0" }
    :value("INTELLIGENCE", { add = 1 }))

-- mutations/mutation_paths/fantasy_species.json
content.add(content.Enchantment { id = "INLINE_ENCH_DWARVEN_BUILD_0" }
    :value("MOVE_COST", { multiply = 0.05 })
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = -1 })
    :value("WEIGHT", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BORN_ARTISAN_0" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELVEN_BUILD_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = -0.12 })
    :value("STRENGTH", { add = -1 })
    :value("DEXTERITY", { add = 2 })
    :value("WEIGHT", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELVEN_HEARING_0" }
    :value("HEARING_MULT", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELVEN_SLEEP_0" }
    :value("SLEEPINESS_REGEN", { multiply = 1 })
    :value("SLEEPINESS", { multiply = -0.166667 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOBLIN_BUILD_0" }
    :value("DODGE_CHANCE", { add = 2 })
    :value("MAX_HP", { multiply = -0.25 })
    :value("STRENGTH", { add = -3 })
    :value("DEXTERITY", { add = 2 })
    :value("FOOTSTEP_NOISE", { multiply = -1 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = -0.5 })
    :value("CARRY_WEIGHT", { multiply = 0.7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_GOBLIN_EYES_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_goblin", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_RAVENFOLK_BUILD_0" }
    :value("WEIGHT", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RAVENFOLK_LEGS_0", condition = "ALWAYS" }
    :bodypart_change("", "foot_l")
    :bodypart_change("", "foot_r")
    :bodypart_change("avian_talon_l", "")
    :bodypart_change("avian_talon_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_RAVENFOLK_EYES_0" }
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RAVENFOLK_EYES_1" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_avian", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_RAVENFOLK_WINGS_0", condition = "ALWAYS" }
    :bodypart_change("wing_ravenfolk_l", "")
    :bodypart_change("wing_ravenfolk_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_BEAK_RAVEN_0", condition = "ALWAYS" }
    :bodypart_change("", "mouth")
    :bodypart_change("beak_bird", ""))

-- mutations/mutation_paths/manatouched.json
content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_MANA_0" }
    :value("MAX_MANA", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_SEEKER_BOLTS_0" }
    :value("MAX_MANA", { add = 250 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WEAK_0" }
    :value("STRENGTH", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_ADD_MANATOUCHED_0" }
    :value("MAX_MANA", { add = 2500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_REGEN_MANATOUCHED_0" }
    :value("REGEN_MANA", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_MULT_MANATOUCHED_0" }
    :value("MAX_MANA", { multiply = 1.65 }))

-- mutations/mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_MANA_ADD1_0" }
    :value("MAX_MANA", { add = 500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_ADD2_0" }
    :value("MAX_MANA", { add = 1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_ADD3_0" }
    :value("MAX_MANA", { add = 2000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_SUB1_0" }
    :value("MAX_MANA", { add = -500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_SUB2_0" }
    :value("MAX_MANA", { add = -1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_SUB3_0" }
    :value("MAX_MANA", { add = -2000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_REGEN1_0" }
    :value("REGEN_MANA", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_REGEN2_0" }
    :value("REGEN_MANA", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_REGEN3_0" }
    :value("REGEN_MANA", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BAD_MANA_REGEN1_0" }
    :value("REGEN_MANA", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BAD_MANA_REGEN2_0" }
    :value("REGEN_MANA", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BAD_MANA_REGEN3_0" }
    :value("REGEN_MANA", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_MULT1_0" }
    :value("MAX_MANA", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_MULT2_0" }
    :value("MAX_MANA", { multiply = 0.9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MANA_MULT3_0" }
    :value("MAX_MANA", { multiply = 1.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BAD_MANA_MULT1_0" }
    :value("MAX_MANA", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BAD_MANA_MULT2_0" }
    :value("MAX_MANA", { multiply = -0.35 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BAD_MANA_MULT3_0" }
    :value("MAX_MANA", { multiply = -0.65 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MAGIC_EMPTY_0" }
    :value("REGEN_MANA", { multiply = -1 })
    :value("MAX_MANA", { multiply = -1 }))

-- mutations/shapeshifter_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = 2 })
    :value("SPEED", { multiply = 0.2 })
    :value("DEXTERITY", { add = 2 })
    :value("STRENGTH", { add = 10 })
    :value("NIGHT_VIS", { add = 5 })
    :value("MELEE_DAMAGE", { multiply = 0.4 })
    :value("CLIMATE_CONTROL_HEAT", { add = 25 })
    :value("PAIN", { multiply = -0.4 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :mutation("FANGS")
    :mutation("MUZZLE_BEAR")
    :mutation("TAIL_STUB")
    :mutation("PAWS_LARGE")
    :mutation("URSINE_FUR")
    :mutation("URSINE_EARS")
    :mutation("PRED3"))

content.add(content.Enchantment { id = "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.2 })
    :value("DEXTERITY", { add = 4 })
    :value("NIGHT_VIS", { add = 11 })
    :value("MELEE_DAMAGE", { multiply = 0.2 })
    :value("CLIMATE_CONTROL_HEAT", { add = 25 })
    :value("FOOTSTEP_NOISE", { multiply = -0.6 })
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -0.5 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :mutation("FANGS")
    :mutation("TAIL_LONG")
    :mutation("PAWS")
    :mutation("FELINE_FUR")
    :mutation("FELINE_EARS")
    :mutation("PRED3")
    :mutation("WHISKERS")
    :mutation("FELINE_LEAP"))

content.add(content.Enchantment { id = "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = 0.1 })
    :value("SPEED", { multiply = 0.2 })
    :value("MOVE_COST", { multiply = -0.5 })
    :value("DEXTERITY", { add = 3 })
    :value("NIGHT_VIS", { add = 6 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :skill("dodge", { add = 2 })
    :mutation("ANTLERS")
    :mutation("HOOVES"))

content.add(content.Enchantment { id = "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = -0.75 })
    :value("MELEE_DAMAGE", { multiply = -0.95 })
    :value("METABOLISM", { multiply = -0.333 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :value("CLIMATE_CONTROL_HEAT", { add = 40 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = -0.75 })
    :value("SPEED", { multiply = 0.1 })
    :value("MELEE_DAMAGE", { multiply = -0.95 })
    :value("DEXTERITY", { add = 8 })
    :value("PERCEPTION", { add = 4 })
    :value("NIGHT_VIS", { add = 4 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :skill("dodge", { add = 6 })
    :mutation("BIRD_EYE")
    :mutation("DOWN")
    :mutation("EAGLEEYED")
    :mutation("LIGHTEATER"))

content.add(content.Enchantment { id = "INLINE_ENCH_DRUID_SHIFTER_MANA_REDUCER_0", condition = "ALWAYS" }
    :value("MAX_MANA", { multiply = -1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEMON_POSSES_0" }
    :value("STRENGTH", { add = 4 })
    :value("DEXTERITY", { add = 4 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEMON_HUGE_0" }
    :value("STRENGTH", { add = 4 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BIOMANCER_NPC_WRETCH_POLYMORPH_0" }
    :value("SPEED", { multiply = -0.25 })
    :value("DEXTERITY", { add = -6 })
    :value("CARRY_WEIGHT", { multiply = -0.5 })
    :effect("effect_biomancer_npc_wretch_polymorph", 1))

-- mutations/spell_invoked_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_BIO_GIANT_GROWTH_0" }
    :value("MAX_HP", { multiply = 0.3 })
    :value("STRENGTH", { add = 6 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CARDIO_MULTIPLIER", { multiply = 0.25 })
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EARTHSHAPER_STONE_SLEEP_0" }
    :value("HUNGER", { multiply = -1.0 })
    :value("THIRST", { multiply = -1.0 })
    :value("METABOLISM", { multiply = -1.0 })
    :value("SLEEPINESS_REGEN", { multiply = 0.5 })
    :value("MENDING_MODIFIER", { multiply = 15 })
    :value("REGEN_HP", { multiply = 1.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.8 })
    :value("CLIMATE_CONTROL_HEAT", { add = 150 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BESTIAL_MIND_0" }
    :value("INTELLIGENCE", { add = -4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BESTIAL_MIND_COMBAT_0" }
    :value("COMBAT_CATCHUP", { multiply = 1 }))

-- mutations/spell_triggering_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_BOREAL_MAGE_COLD_AURA_0", condition = "ACTIVE" }
    :every(5, { id = "boreal_mage_cold_damage" }))

content.add(content.Enchantment { id = "INLINE_ENCH_FROZEN_PRESSURE_ON_0" }
    :every(5, { id = "glacier_mage_bash_damage" }))

content.add(content.Enchantment { id = "INLINE_ENCH_CLAIRVOYANCE_ON_0" }
    :every(1, { id = "radiation_mage_clairvoyance" }))

content.add(content.Enchantment { id = "INLINE_ENCH_MIND_READ_ON_1" }
    :value("SOCIAL_INTIMIDATE", { add = 20 })
    :value("SOCIAL_LIE", { add = 20 })
    :value("SOCIAL_PERSUADE", { add = 20 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MIND_READ_ON_2" }
    :every(5, { id = "mind_read" }))

content.add(content.Enchantment { id = "INLINE_ENCH_SOUL_PRESSURE_ON_0" }
    :every(5, { id = "soul_pressure" }))

content.add(content.Enchantment { id = "INLINE_ENCH_FREEZING_AURA_ON_0" }
    :every(5, { id = "tundra_mage_aoe" }))

content.add(content.Enchantment { id = "INLINE_ENCH_TOXIC_AURA_ON_0" }
    :every(5, { id = "wither_mage_bio_damage" }))
