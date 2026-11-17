local content = require("ccb").content

-- mutations/cultivation_traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_immortal_path_body_evergreen_0", condition = "ALWAYS" }
    :value("REGEN_HP_AWAKE", { multiply = 0.5 })
    :value("STAMINA_REGEN_MOD", { add = 1 })
    :custom("polarization_wood", { add = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_immortal_path_body_blazing_sun_0", condition = "ALWAYS" }
    :value("MELEE_DAMAGE", { add = 1 })
    :value("CLIMATE_CONTROL_HEAT", { add = 15 })
    :custom("polarization_fire", { add = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_immortal_path_body_deep_earth_0", condition = "ALWAYS" }
    :value("ARMOR_ALL", { add = -1 })
    :value("KNOCKBACK_RESIST", { add = 3 })
    :value("KNOCKDOWN_RESIST", { add = 3 })
    :custom("polarization_earth", { add = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_immortal_path_body_true_metal_0", condition = "ALWAYS" }
    :value("MELEE_DAMAGE", { add = 1 })
    :value("MELEE_TO_HIT", { add = 1 })
    :custom("polarization_metal", { add = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_immortal_path_body_cold_pool_0", condition = "ALWAYS" }
    :custom("qi_max", { add = 30 })
    :custom("polarization_water", { add = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_immortal_path_body_blood_fiend_0", condition = "ALWAYS" }
    :value("MELEE_DAMAGE", { add = 2 })
    :value("MOD_HEALTH", { add = -1 }))
