local content = require("ccb").content

-- effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_smart_targeted_0", condition = "ALWAYS" }
    :value("ARMOR_ALL", { add = -15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_afs_android_crawling_0" }
    :value("SPEED", { multiply = -0.5 }))

-- effects_esper.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_afs_esper_tincture_side_effects_0", condition = "ALWAYS" }
    :effect("hallu", 1)
    :effect("visuals", 1)
    :effect("nausea", 2))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_afs_esper_tincture_geist_0", condition = "ALWAYS" }
    :effect("effect_afs_esper_tincture_side_effects", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_afs_esper_tincture_spark_0", condition = "ALWAYS" }
    :effect("effect_afs_esper_tincture_side_effects", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_afs_esper_tincture_sybil_0", condition = "ALWAYS" }
    :effect("effect_afs_esper_tincture_side_effects", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_afs_esper_tincture_whisper_0", condition = "ALWAYS" }
    :effect("effect_afs_esper_tincture_side_effects", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_afs_precog_damage_foresee_0" }
    :value("FORCEFIELD", { add = 1 }))
