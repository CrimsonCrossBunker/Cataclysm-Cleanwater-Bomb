local content = require("ccb").content

-- mutations/combat_brute.json
content.add(content.Enchantment { id = "INLINE_ENCH_AFS_THROWING_STRENGTH_0", condition = "ALWAYS" }
    :value("THROW_STR", { multiply = 2 })
    :value("THROW_DAMAGE", { multiply = 1.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_STRONG_0", condition = "ALWAYS" }
    :value("STRENGTH", { add = 2 })
    :value("MENDING_MODIFIER", { multiply = -0.25 })
    :value("REGEN_HP", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_GOOD_HEAD_0", condition = "ALWAYS" }
    :value("INTELLIGENCE", { add = -2 })
    :value("LEARNING_FOCUS", { multiply = -0.15 })
    :effect("afs_remove_stun_biological", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_WAR_BUILD_0", condition = "ALWAYS" }
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 2 })
    :value("PERCEPTION", { add = 2 })
    :value("SPEED", { add = 10 })
    :value("THROW_STR", { multiply = 1 })
    :value("METABOLISM", { multiply = 1 })
    :value("THROW_DAMAGE", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_HYPERMETABOLISM_active_0" }
    :value("REGEN_HP", { multiply = 349 })
    :value("REGEN_HP_AWAKE", { multiply = 0.85 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_FAST_BLOOD_PRODUCTION_0" }
    :value("THIRST", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_REDUNDANT_ORGANS_0", condition = "ALWAYS" }
    :post_armor_damage("bash", { multiply = -0.25 })
    :post_armor_damage("cut", { multiply = -0.25 })
    :post_armor_damage("bullet", { multiply = -0.5 })
    :post_armor_damage("pierce", { multiply = -0.5 })
    :post_armor_damage("afs_laser", { multiply = -0.15 })
    :post_armor_damage("afs_plasma", { multiply = -0.15 })
    :post_armor_damage("afs_toxin_bullet", { multiply = -0.5 })
    :post_armor_damage("afs_toxin_pierce", { multiply = -0.5 })
    :post_armor_damage("psi_telekinetic_damage", { multiply = -0.15 }))

-- mutations/human_plus.json
content.add(content.Enchantment { id = "INLINE_ENCH_AFS_PHYSICAL_CAPABILITY_GENEMOD_0" }
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 2 })
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_MENTAL_CAPABILITY_GENEMOD_0" }
    :value("INTELLIGENCE", { add = 2 })
    :value("LEARNING_FOCUS", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_HEALTH_CAPABILITY_GENEMOD_0" }
    :mutation("DISRESISTANT")
    :mutation("FASTHEALER")
    :mutation("INFRESIST"))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_RECOVERY_CAPABILITY_GENEMOD_0" }
    :value("CARDIO_MULTIPLIER", { multiply = 0.2 })
    :value("REGEN_STAMINA", { multiply = 0.2 })
    :value("SLEEPINESS_REGEN", { multiply = 0.2 })
    :value("SLEEPINESS", { multiply = -0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_AFS_BEAUTY_GENEMOD_0" }
    :mutation("BEAUTIFUL"))

-- mutations/mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_FACIAL_TENTACLES_0" }
    :value("CONSUME_TIME_MOD", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_NEURAL_IMPROVEMENT_0" }
    :value("INTELLIGENCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_EXPANDED_CONSCIOUSNESS_0" }
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_UPLIFTED_CONSCIOUSNESS_0" }
    :value("INTELLIGENCE", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ALIEN_INT_0" }
    :value("INTELLIGENCE", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_ENHANCED_REACTIONS_0" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_QUICKENING_0" }
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_OTHERWORLDLY_GRACE_0" }
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_NEW_MUSCLES_0" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MUSCLE_FIBER_0" }
    :value("STRENGTH", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MIGO_EARS_0" }
    :value("HEARING_MULT", { multiply = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_HAULER_0" }
    :value("CARRY_WEIGHT", { multiply = 0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MASTODON_FUR_0" }
    :value("BODYTEMP_SLEEP", { add = 1.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_SKULLGUN_STUPID_0" }
    :value("INTELLIGENCE", { add = -4 })
    :value("PERCEPTION", { add = -2 }))

-- mutations/origins.json
content.add(content.Enchantment { id = "INLINE_ENCH_AFS_BRUTAL_STRENGTH_0" }
    :value("STRENGTH", { add = 7 }))
