local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
ccb.runtime.handler("body_enchantment_active_inline_ench_effect_biomancer_hyper_regeneration_0", function(ctx)
    return ((ctx.character_inputs.hit_points["arm_l"] < ctx.character_inputs.max_hit_points["arm_l"]) or
        (ctx.character_inputs.hit_points["arm_r"] < ctx.character_inputs.max_hit_points["arm_r"]) or
        (ctx.character_inputs.hit_points["leg_l"] < ctx.character_inputs.max_hit_points["leg_l"]) or
        (ctx.character_inputs.hit_points["leg_r"] < ctx.character_inputs.max_hit_points["leg_r"]) or
        (ctx.character_inputs.hit_points["torso"] < ctx.character_inputs.max_hit_points["torso"]) or
        (ctx.character_inputs.hit_points["head"] < ctx.character_inputs.max_hit_points["head"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biomancer_hyper_regeneration_0",
    condition_handler = "body_enchantment_active_inline_ench_effect_biomancer_hyper_regeneration_0",
    load_character_inputs = {
        hit_points = { "arm_l", "arm_r", "head", "leg_l", "leg_r", "torso" },
        max_hit_points = { "arm_l", "arm_r", "head", "leg_l", "leg_r", "torso" }
    },
    native_modifier_order = true,
}
    :every(1, { id = "flask_regeneration_effect" }))
