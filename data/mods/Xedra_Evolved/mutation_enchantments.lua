local content = require("ccb").content

-- effects/effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_eater_unbreakable_0" }
    :value("PAIN", { multiply = -1 }))

-- mutations/bloodthorne_druid_traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP_0", condition = "ACTIVE" }
    :value("METABOLISM", { multiply = 0.2 })
    :value("THIRST", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BLOODTHORNE_DRUID_AURA_OF_VINES_TRAIT_0" }
    :value("METABOLISM", { multiply = 0.25 })
    :value("THIRST", { multiply = 0.25 })
    :value("BONUS_BLOCK", { add = 2 })
    :value("MOTION_ALARM", { add = 6 })
    :hit_me({ id = "bloodthorne_druid_aura_of_vines_retaliate", trigger_once_in = 3, trigger_message = content.text("Your vines whip out at your attacker."), npc_trigger_message = content.text("%1$s's vines whip out at their attacker.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_BLOODTHORNE_DRUID_SLOWER_BLEEDING_0" }
    :value("BLEEDING_RATE", { multiply = -0.333 }))

-- mutations/chronomancer_traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_XEDRA_CHRONOMANCER_TIME_SLOWDOWN_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = -0.1 }))

-- mutations/mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_DHAMPIR_TRAIT_5", condition = "ALWAYS" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_DHAMPIR_FANGS_0", condition = "ACTIVE" }
    :mutation("DHAMPIR_FANGS_ACTIVE"))

content.add(content.Enchantment { id = "INLINE_ENCH_DHAMPIR_REDUCED_PAIN_0" }
    :value("PAIN", { multiply = -0.4 })
    :value("PAIN_PENALTY_MOD_STR", { multiply = -0.25 })
    :value("PAIN_PENALTY_MOD_DEX", { multiply = -0.25 })
    :value("PAIN_PENALTY_MOD_SPEED", { multiply = -0.25 })
    :value("PAIN_PENALTY_MOD_INT", { multiply = -0.5 })
    :value("PAIN_PENALTY_MOD_PER", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DHAMPIR_AVOID_EAT_SLEEP_DRINK_0", condition = "ACTIVE" }
    :value("HUNGER", { multiply = -1 })
    :value("METABOLISM", { multiply = -1 })
    :value("THIRST", { multiply = -1 })
    :value("SLEEPINESS", { multiply = -1 })
    :effect("effect_dhampir_the_blood_is_the_life", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_DHAMPIR_WEAKNESS_CORPSELIKE_PALLOR_0" }
    :effect("effect_dhampir_corpselike_pallor_pale", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD_0" }
    :value("KCAL", { multiply = -0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_FEIGN_DEATH_0", condition = "ACTIVE" }
    :effect("effect_vampire_feign_death", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_BEAST_CLAWS_active_0" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE3_1" }
    :value("STAMINA_REGEN_MOD", { add = 0.2 })
    :value("METABOLISM", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_MOTION_ALARM_0", condition = "ACTIVE" }
    :value("MOTION_ALARM", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE4_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.5 })
    :value("METABOLISM", { multiply = -0.5 })
    :value("DISINFECTANT_BONUS", { multiply = -1 })
    :value("BANDAGE_BONUS", { multiply = -1 })
    :value("REGEN_MANA", { multiply = -50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE4_5" }
    :effect("effect_vampire_immune_to_classic_zombification", 1)
    :effect("effect_dhampir_corpselike_pallor_pale", 1)
    :effect("effect_xe_nonhuman_super_soldier_serum_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_TORPOR_0", condition = "ALWAYS" }
    :value("SLEEPY", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_1", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.1 })
    :value("MELEE_DAMAGE", { multiply = -0.95 })
    :value("NIGHT_VIS", { add = 6 })
    :value("DEXTERITY", { add = 8 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :skill("dodge", { add = 8 })
    :mutation("ECHOLOCATION"))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.2 })
    :value("DEXTERITY", { add = 2 })
    :value("NIGHT_VIS", { add = 8 })
    :value("MELEE_DAMAGE", { multiply = 0.2 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :mutation("FANGS")
    :mutation("MUZZLE")
    :mutation("TAIL_FLUFFY")
    :mutation("PAWS")
    :mutation("LUPINE_FUR")
    :mutation("LUPINE_EARS")
    :mutation("PERSISTENCE_HUNTER2")
    :mutation("PRED3"))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_MIST_FORM_TRAITS_0" }
    :effect("effect_vampire_mist_form", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_SHADOW_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.5 })
    :value("STRENGTH", { add = 3 })
    :value("DEXTERITY", { add = 3 })
    :value("NIGHT_VIS", { add = 50 })
    :value("STAMINA_REGEN_MOD", { add = 0.5 })
    :value("DODGE_CHANCE", { add = 15 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_RENFIELD_0" }
    :value("INTELLIGENCE", { add = -4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MENTOR_PEACE_0", condition = "ALWAYS" }
    :value("FORCEFIELD", { add = 1 })
    :hit_me({ id = "mentor_vanish", self = true, trigger_message = content.text("You're not supposed to see this.  Open a bug report on GitHub about having the Mentor's Peace trait."), npc_trigger_message = content.text("%1$s vanishes in a fine mist.") }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_WEAKNESS_FIRE_VULNERABLE_0" }
    :incoming_damage("heat", { multiply = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_BIG_STOMACH_0" }
    :value("VOMIT_MUL", { multiply = -100 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 100 })
    :value("CONSUME_TIME_MOD", { multiply = -0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_SILENT_MOVE_UPGRADE_0" }
    :value("ATTACK_NOISE", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_NO_ILLNESS_UPGRADE_0" }
    :effect("effect_vampire_no_illness", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_BOANN_RETALIATION_0" }
    :hit_me({ id = "boann_retaliation_mark", self = false }))

content.add(content.Enchantment { id = "INLINE_ENCH_BOANN_RETALIATION_1" }
    :hit_me({ id = "boann_retaliation", self = true }))

-- mutations/paraclesians/arvore_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_SKIN_2_0" }
    :value("THIRST", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_MOSS_0" }
    :value("BODYTEMP_SLEEP", { add = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_PAIN_RESISTANCE_0", condition = "ALWAYS" }
    :value("PAIN", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_WOOD_CLAWS_active_0" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_DEX_BONUS_0" }
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_STR_BONUS_1_0" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_STR_BONUS_2_0" }
    :value("STRENGTH", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_STR_BONUS_3_0" }
    :value("STRENGTH", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_PER_BONUS_0" }
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_EYES_0" }
    :bodypart_change("", "eyes")
    :bodypart_change("fae_eyes_arvore", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_BLOOD_2_0" }
    :value("BLEEDING_RATE", { multiply = -0.333 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_BLOOD_3_0" }
    :value("BLEEDING_RATE", { multiply = -0.333 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_BLOOD_4_0" }
    :value("BLEEDING_RATE", { multiply = -0.666 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_TREE_FORM_TRAITS_0" }
    :value("METABOLISM", { multiply = -0.5 })
    :value("SLEEPINESS_REGEN", { multiply = 0.5 })
    :value("MENDING_MODIFIER", { multiply = 15 })
    :value("REGEN_HP", { multiply = 1.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.8 })
    :value("SLEEPY", { add = 150 })
    :value("CLIMATE_CONTROL_HEAT", { add = 150 }))

-- mutations/paraclesians/homullus_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_SKIN_2_0" }
    :value("REGEN_HP", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_SKIN_3_0" }
    :value("REGEN_HP", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_EYES_0" }
    :bodypart_change("", "eyes")
    :bodypart_change("fae_eyes_homullus", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_CBM_MANA_1_0" }
    :value("BIONIC_MANA_PENALTY", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_CBM_MANA_2_0" }
    :value("BIONIC_MANA_PENALTY", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_ARMOR_MULT_2_1" }
    :value("ARMOR_ALL", { multiply = -0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_DURABILITY_MULT_1_0" }
    :value("EQUIPMENT_DAMAGE_CHANCE", { multiply = -0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_DURABILITY_MULT_2_0" }
    :value("EQUIPMENT_DAMAGE_CHANCE", { multiply = -0.66 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_THE_HUNTER_0" }
    :value("MAX_STAMINA", { multiply = 0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_TEMPERATURE_TOLERANCE_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = 15 })
    :value("CLIMATE_CONTROL_HEAT", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_THE_HUNTER2_0" }
    :value("MAX_STAMINA", { multiply = 0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_DOLL_FORM_TRAITS_0" }
    :value("METABOLISM", { multiply = -1.0 })
    :value("HUNGER", { multiply = -1.0 })
    :value("THIRST", { multiply = -1.0 })
    :value("REGEN_HP", { multiply = -1.0 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -0.4 })
    :value("ATTACK_SPEED", { multiply = 0.8 })
    :value("MENDING_MODIFIER", { multiply = -1.0 })
    :value("EQUIPMENT_DAMAGE_CHANCE", { multiply = -1 })
    :skill("dodge", { add = -5 }))

-- mutations/paraclesians/ierde_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_SKIN_2_0" }
    :value("WEIGHT", { multiply = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_SKIN_3_0" }
    :value("WEIGHT", { multiply = 0.35 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_EYES_0" }
    :bodypart_change("", "eyes")
    :bodypart_change("fae_eyes_ierde", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_CARDIO_0" }
    :value("CARDIO_MULTIPLIER", { multiply = 0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_CARDIO2_0" }
    :value("CARDIO_MULTIPLIER", { multiply = 1.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_CARDIO3_0" }
    :value("CARDIO_MULTIPLIER", { multiply = 2.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_FEEL_HALF_PAIN_0" }
    :value("PAIN", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_STONE_SLEEP_0" }
    :value("HUNGER", { multiply = -1 })
    :value("THIRST", { multiply = -1 })
    :value("METABOLISM", { multiply = -1 })
    :value("SLEEPINESS_REGEN", { multiply = 0.5 })
    :value("MENDING_MODIFIER", { multiply = 15 })
    :value("REGEN_HP", { multiply = 1.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_SLOW_BLEEDING_0" }
    :value("BLEEDING_RATE", { multiply = -0.666 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_NO_KNOCKBACK_0", condition = "ALWAYS" }
    :value("KNOCKBACK_RESIST", { add = 100 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_TOUGH_0" }
    :value("MAX_HP", { multiply = 0.15 })
    :value("WEIGHT", { multiply = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_TOUGH2_0" }
    :value("MAX_HP", { multiply = 0.3 })
    :value("WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_TOUGH3_0" }
    :value("MAX_HP", { multiply = 0.45 })
    :value("WEIGHT", { multiply = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_STR_BONUS_1_0" }
    :value("STRENGTH", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_STR_BONUS_2_0" }
    :value("STRENGTH", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_STR_BONUS_3_0" }
    :value("STRENGTH", { add = 7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_STR_BONUS_4_0" }
    :value("STRENGTH", { add = 9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_PER_BONUS_0" }
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_NO_BROKEN_BONES_0" }
    :value("WEIGHT", { multiply = 0.1 })
    :value("FORCEFIELD", { add = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_NO_BROKEN_BONES_1" }
    :effect("effect_ierde_limb_breaking_stopper", 1))

-- mutations/paraclesians/paraclesian_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_IERDE_2" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_ARVORE_2" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_2" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_2" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_3" }
    :value("WEAKNESS_TO_WATER", { add = -0.000347 })
    :value("THIRST", { multiply = -1 })
    :value("SWEAT_MULTIPLIER", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_2" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_2" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_PARACLESIAN_STR_DEX_1_0" }
    :value("STRENGTH", { add = 1 })
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PARACLESIAN_STR_DEX_2_0" }
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PARACLESIAN_INT_PER_1_0" }
    :value("INTELLIGENCE", { add = 1 })
    :value("PERCEPTION", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PARACLESIAN_INT_PER_2_0" }
    :value("INTELLIGENCE", { add = 2 })
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELEMENTAL_MANA1_0" }
    :value("MAX_MANA", { add = 500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELEMENTAL_MANA2_0" }
    :value("MAX_MANA", { add = 1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ELEMENTAL_MANA3_0" }
    :value("MAX_MANA", { add = 2000 }))

-- mutations/paraclesians/salamander_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_SKIN_2_0" }
    :value("WEAKNESS_TO_WATER", { multiply = 0.016 })
    :value("SWEAT_MULTIPLIER", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_SKIN_3_0" }
    :value("WEAKNESS_TO_WATER", { add = 4 })
    :value("SWEAT_MULTIPLIER", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_EYES_0" }
    :bodypart_change("", "eyes")
    :bodypart_change("fae_eyes_salamander", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_BIGGER_STOMACH_0" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_BIGGER_STOMACH2_0" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 2 })
    :value("CONSUME_TIME_MOD", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_SLEEP_LESS_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.1 })
    :value("SLEEPINESS_REGEN", { multiply = 0.25 })
    :value("SLEEPINESS", { multiply = -0.25 })
    :value("METABOLISM", { multiply = 0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_SLEEP_LESS2_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.2 })
    :value("SLEEPINESS_REGEN", { multiply = 0.5 })
    :value("SLEEPINESS", { multiply = -0.5 })
    :value("METABOLISM", { multiply = 0.66 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_SLEEP_LESS3_0" }
    :value("STAMINA_REGEN_MOD", { add = 0.3 })
    :value("SLEEPINESS_REGEN", { multiply = 0.5 })
    :value("SLEEPINESS", { multiply = -0.5 })
    :value("METABOLISM", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_NO_SMOKE_DAMAGE_0", condition = "ALWAYS" }
    :effect("effect_salamander_smoke_immunity", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_STR_BONUS_1_0" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_STR_BONUS_2_0" }
    :value("STRENGTH", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_DEX_BONUS_1_0" }
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_DEX_BONUS_2_0" }
    :value("DEXTERITY", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_INT_BONUS_0" }
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_FIRE_IMMUNE_0", condition = "ALWAYS" }
    :incoming_damage("heat", { multiply = -1 })
    :incoming_damage("cold", { multiply = 0.5 })
    :effect("effect_hidden_flame_immunity", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_MANA_BONUS_0" }
    :value("MAX_MANA", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SALAMANDER_FAST_CAST_0" }
    :value("CASTING_TIME_MULTIPLIER", { multiply = -0.15 })
    :value("MAX_MANA", { multiply = 0.25 }))

-- mutations/paraclesians/sylph_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_SKIN_2_0" }
    :value("WEIGHT", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_SKIN_3_0" }
    :value("WEIGHT", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_EYES_0" }
    :bodypart_change("", "eyes")
    :bodypart_change("fae_eyes_sylph", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLOWFALL_0" }
    :value("WEIGHT", { multiply = -0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLYPH_RESIST_COLD_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 15 })
    :incoming_damage("cold", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLYPH_RESIST_COLD2_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 45 })
    :incoming_damage("cold", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SLYPH_RESIST_COLD3_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 150 })
    :incoming_damage("cold", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_DEX_BONUS_1_0" }
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_DEX_BONUS_2_0" }
    :value("DEXTERITY", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_INT_BONUS_1_0" }
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_INT_BONUS_2_0" }
    :value("INTELLIGENCE", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_PER_BONUS_1_0" }
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_FAST_CAST2_1" }
    :value("WEIGHT", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_CANNOT_BE_SLOWED_OR_STOPPED_0", condition = "ALWAYS" }
    :value("WEIGHT", { multiply = -0.05 })
    :effect("effect_sylph_cannot_be_slowed", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_SYLPH_PAIN_DOESNT_AFFECT_DEX_SPEED_0" }
    :value("PAIN_PENALTY_MOD_SPEED", { multiply = -1 })
    :value("PAIN_PENALTY_MOD_DEX", { multiply = -1 }))

-- mutations/paraclesians/undine_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_EYES_0" }
    :bodypart_change("", "eyes")
    :bodypart_change("fae_eyes_undine", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_FAST_SWIM_SPEED_0" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_DO_MORE_MELEE_DAMAGE_0", condition = "ACTIVE" }
    :value("MELEE_DAMAGE", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_STR_UP_1_0" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_STR_UP_2_0" }
    :value("STRENGTH", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_DEX_UP_1_0" }
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_DEX_UP_2_0" }
    :value("DEXTERITY", { add = 4 })
    :value("THIRST", { multiply = 0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_DEX_UP_3_0" }
    :value("DEXTERITY", { add = 6 })
    :value("THIRST", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_PER_UP_1_0" }
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_WATER_BODY_1" }
    :value("THIRST", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UNDINE_WATER_FORM_TRAITS_2" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.4 }))

-- mutations/playable_changeling.json
content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_NOBLE_0" }
    :value("MAX_MANA", { multiply = 0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_NOBLE_1" }
    :mutation("IRON_ALLERGY"))

content.add(content.Enchantment { id = "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_SPRING_0" }
    :value("MAX_MANA", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_SUMMER_0" }
    :value("MAX_MANA", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_AUTUMN_0" }
    :value("MAX_MANA", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_WINTER_0" }
    :value("MAX_MANA", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_BROWNIE_0" }
    :value("MAX_MANA", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_BROWNIE_1" }
    :mutation("IRON_ALLERGY"))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_POOKA_0" }
    :value("MAX_MANA", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_POOKA_1" }
    :mutation("IRON_ALLERGY"))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_SELKIE_0" }
    :value("MAX_MANA", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_SELKIE_1" }
    :mutation("IRON_ALLERGY"))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_TROW_0" }
    :value("MAX_MANA", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_TROW_1" }
    :mutation("IRON_ALLERGY"))

content.add(content.Enchantment { id = "INLINE_ENCH_CHANGELING_GAIN_DREAMDROSS_FROM_MORTAL_DREAMS_0", condition = "ACTIVE" }
    :effect("effect_changeling_active_banquet_of_dreams", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_STR_UP_NOBLE_0" }
    :value("STRENGTH", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_UP_NOBLE_0" }
    :value("DEXTERITY", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SPEED_UP_NOBLE_0" }
    :value("SPEED", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INT_UP_NOBLE_0" }
    :value("INTELLIGENCE", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_UP_NOBLE_0" }
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_0", condition = "ACTIVE" }
    :effect("effect_changeling_temporary_psychopath", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_BROWNIE_COLD_TOLERANCE_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BROWNIE_COLD_TOLERANCE2_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_BROWNIE_COLD_TOLERANCE3_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 120 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_UP_BROWNIE_0" }
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INT_UP_BROWNIE_0" }
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STR_UP_POOKA_0" }
    :value("STRENGTH", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_UP_POOKA_0" }
    :value("DEXTERITY", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEX_UP_SELKIE_0" }
    :value("DEXTERITY", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PER_UP_SELKIE_0" }
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_INT_UP_SELKIE_0" }
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_PAINRESIST_TROW2_1" }
    :value("PAIN_PENALTY_MOD_STR", { multiply = -1 }))

-- mutations/revenant.json
content.add(content.Enchantment { id = "INLINE_ENCH_XE_REVENANT_TRAITS_1" }
    :mutation("STR_UP_3")
    :mutation("PALE")
    :mutation("MUT_TOUGH3")
    :mutation("DEFORMED3")
    :mutation("POISRESIST")
    :mutation("INFIMMUNE")
    :mutation("DISIMMUNE")
    :mutation("PARAIMMUNE")
    :mutation("NOHEAL")
    :mutation("TOUGH_FEET")
    :mutation("DREAMLESS"))

-- mutations/shapeshifters.json
content.add(content.Enchantment { id = "INLINE_ENCH_NATIVE_SHAPESHIFTER_0" }
    :value("REGEN_HP", { multiply = 0.25 })
    :value("REGEN_HP_AWAKE", { multiply = 0.1 })
    :effect("effect_xe_nonhuman_super_soldier_serum_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_WEREWOLF_HYBRID_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.2 })
    :value("DEXTERITY", { add = 2 })
    :value("STRENGTH", { add = 6 })
    :value("NIGHT_VIS", { add = 8 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -0.8 })
    :value("STAMINA_REGEN_MOD", { add = 0.2 })
    :value("MELEE_STAMINA_CONSUMPTION", { multiply = -0.33 })
    :value("SOCIAL_PERSUADE", { add = -50 })
    :value("SOCIAL_INTIMIDATE", { add = 40 })
    :value("METABOLISM", { multiply = 4 })
    :value("LEARNING_FOCUS", { add = -10 })
    :value("OBTAIN_COST_MULTIPLIER", { multiply = 2 })
    :encumbrance("hand_r", { add = -10 })
    :encumbrance("hand_l", { add = -10 })
    :mutation("WEREWOLF_HEAD")
    :mutation("TAIL_FLUFFY")
    :mutation("LUPINE_FUR")
    :mutation("ANIMAL_FEET")
    :mutation("LUPINE_EARS")
    :mutation("PERSISTENCE_HUNTER2")
    :mutation("PRED3"))

-- mutations/temporary.json
content.add(content.Enchantment { id = "INLINE_ENCH_GOBLIN_FRUIT_GIANT_GROWTH_1" }
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 1 })
    :value("CARDIO_MULTIPLIER", { multiply = 0.25 })
    :value("CARRY_WEIGHT", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ethereal_wings_1" }
    :value("MAX_MANA", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_karma_arms_0", condition = "ALWAYS" }
    :bodypart_change("karma_arm_up_r", "")
    :bodypart_change("karma_arm_up_l", "")
    :bodypart_change("karma_arm_lw_r", "")
    :bodypart_change("karma_arm_lw_l", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_karma_arms_1" }
    :value("MAX_MANA", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_devil_tail_0", condition = "ALWAYS" }
    :bodypart_change("devil_tail", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_devil_tail_1" }
    :value("MAX_MANA", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_stalker_eyes_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("stalker_eyes", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_stalker_eyes_1" }
    :value("MAX_MANA", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_0", condition = "ALWAYS" }
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

content.add(content.Enchantment { id = "INLINE_ENCH_TURN_INTO_DEER_TRAITS_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = 0.1 })
    :value("SPEED", { multiply = 0.2 })
    :value("MOVE_COST", { multiply = -0.5 })
    :value("DEXTERITY", { add = 3 })
    :value("NIGHT_VIS", { add = 6 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :skill("dodge", { add = 2 })
    :mutation("ANTLERS")
    :mutation("HOOVES"))

content.add(content.Enchantment { id = "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_0", condition = "ALWAYS" }
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

content.add(content.Enchantment { id = "INLINE_ENCH_TURN_INTO_OWL_TRAITS_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = -0.75 })
    :value("SPEED", { multiply = 0.1 })
    :value("MELEE_DAMAGE", { multiply = -0.95 })
    :value("DEXTERITY", { add = 6 })
    :value("PERCEPTION", { add = 6 })
    :value("NIGHT_VIS", { add = 8 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :skill("dodge", { add = 4 })
    :mutation("BIRD_EYE")
    :mutation("DOWN")
    :mutation("EAGLEEYED")
    :mutation("LIGHTEATER"))

content.add(content.Enchantment { id = "INLINE_ENCH_LILIN_WAR_OWL_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = 1.25 })
    :value("SPEED", { multiply = 0.1 })
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 6 })
    :value("PERCEPTION", { add = 6 })
    :value("NIGHT_VIS", { add = 8 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -0.6 })
    :skill("dodge", { add = 4 })
    :skill("unarmed", { add = 1 })
    :mutation("BEAK")
    :mutation("TOUGH_FEET")
    :mutation("BIRD_EYE")
    :mutation("TALONS_STRIX")
    :mutation("BIRD_LEGS")
    :mutation("DOWN")
    :mutation("EAGLEEYED")
    :mutation("HOLLOW_BONES")
    :mutation("LIGHTEATER")
    :mutation("SCREECH")
    :mutation("WINGS_STRIX")
    :mutation("STRIX_SKIN"))

content.add(content.Enchantment { id = "INLINE_ENCH_WINGS_STRIX_0", condition = "ALWAYS" }
    :bodypart_change("wing_strix_l", "")
    :bodypart_change("wing_strix_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_0", condition = "ALWAYS" }
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

content.add(content.Enchantment { id = "INLINE_ENCH_CRAFTING_ASSISTANT_ARMS_0", condition = "ALWAYS" }
    :bodypart_change("assist_arm_r", "")
    :bodypart_change("assist_arm_l", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_CRAFTING_ASSISTANT_ARMS_1" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.6 }))

-- mutations/vampire_trait_refinements.json
content.add(content.Enchantment { id = "INLINE_ENCH_VAMPIRE_WALK_ON_WALLS_REFINEMENT_LOW_GRAVITY_0" }
    :value("CARRY_WEIGHT", { multiply = 0.25 }))

-- mutations/werewolf_traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_WEREWOLF_CAMOUFLAGE_COAT_0", condition = "ACTIVE" }
    :effect("effect_xe_werewolf_camouflage_as_wolf", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_WEREWOLF_SILVER_CLAWS_ACTIVE_0" }
    :hit_you({ id = "xe_werewolf_argent_claws_damage" }))

content.add(content.Enchantment { id = "INLINE_ENCH_WEREWOLF_STRENGTH_BONUS_1", condition = "ACTIVE" }
    :effect("effect_xe_werewolf_primal_strength_human_form", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_WEREWOLF_BATTLE_FURY_0", condition = "ACTIVE" }
    :effect("effect_xe_werewolf_redhanded_rage", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.2 })
    :value("RANGE", { multiply = -1 })
    :value("MAX_HP", { multiply = 0.35 })
    :value("DEXTERITY", { add = 2 })
    :value("STRENGTH", { add = 8 })
    :value("NIGHT_VIS", { add = 8 })
    :value("MELEE_DAMAGE", { multiply = 0.3 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = -1000 })
    :mutation("MUZZLE")
    :mutation("TAIL_FLUFFY")
    :mutation("PAWS")
    :mutation("LUPINE_FUR")
    :mutation("LUPINE_EARS")
    :mutation("PERSISTENCE_HUNTER2")
    :mutation("PRED3"))

-- mutations/xe_lilin.json
content.add(content.Enchantment { id = "INLINE_ENCH_THRESH_LILIN_2" }
    :effect("effect_xe_nonhuman_super_soldier_serum_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_LILIN_NIGHT_VISION_UPGRADE_0" }
    :value("NIGHT_VIS", { add = 250 }))

-- mutations/xe_playable_gracken.json
content.add(content.Enchantment { id = "INLINE_ENCH_GRACKEN_0" }
    :effect("effect_lilin_vampire_immune", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_EYES_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("gracken_eyes", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_SHORT_LEGS_0" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_LONG_LEGS_0" }
    :value("MOVECOST_FLATGROUND_MOD", { multiply = -0.12 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_STRONG_ARMS_0" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_DEXTROUS_HANDS_0" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_STOMACH_0" }
    :value("KCAL", { multiply = -1 })
    :value("METABOLISM", { multiply = -0.8 })
    :value("CLIMATE_CONTROL_HEAT", { add = 30 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_CARNIVORE_0" }
    :value("STRENGTH", { add = 1 })
    :value("METABOLISM", { multiply = 0.8 })
    :value("STOMACH_SIZE_MULTIPLIER", { add = 500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SHADE_HERBIVORE_0" }
    :value("KCAL", { multiply = 1.3 })
    :value("DODGE_CHANCE", { add = 3 })
    :value("STOMACH_SIZE_MULTIPLIER", { add = 1000 }))
