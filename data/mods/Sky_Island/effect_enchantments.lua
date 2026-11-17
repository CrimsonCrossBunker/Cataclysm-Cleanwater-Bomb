local content = require("ccb").content

-- effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_warped_phasing_0" }
    :value("PHASE_DISTANCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_challenge_mode_speed_reduction_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = -0.2 }))
