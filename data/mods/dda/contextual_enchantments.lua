local ccb = require("ccb")
local content = ccb.content

-- data/json/effects.json
ccb.runtime.handler("contextual_enchantment_inline_ench_effect_hound_of_tindalos_slobber_0_value_0_add", function(ctx)
    return (ctx.character_inputs.body_part_effect_intensities["torso"]["effect_hound_of_tindalos_slobber"] * 250)
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_hound_of_tindalos_slobber_0", function(ctx)
    return ctx.character_inputs.environment.fields["fd_tindalos_gas"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_hound_of_tindalos_slobber_0",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_hound_of_tindalos_slobber_0",
    load_character_inputs = {
        body_part_effect_intensities = {
            torso = { "effect_hound_of_tindalos_slobber" }
        },
        environment = {
            fields = { "fd_tindalos_gas" }
        }
    },
    native_modifier_order = true,
}
    :value("ARTIFACT_RESONANCE", {
        add_handler = "contextual_enchantment_inline_ench_effect_hound_of_tindalos_slobber_0_value_0_add",
        load_skills = {}
    }))

-- data/json/mutations/mutations_limbs.json
ccb.runtime.handler("contextual_enchantment_active_inline_ench_nails_0", function(ctx)
    return (not (ctx.character_inputs.armed) and
        ((ctx.character_inputs.encumbrance["hand_l"] + ctx.character_inputs.encumbrance["hand_r"]) <= 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_NAILS_0",
    condition_handler = "contextual_enchantment_active_inline_ench_nails_0",
    load_character_inputs = { armed = true, encumbrance = { "hand_l", "hand_r" } },
    native_modifier_order = true,
}
    :melee_damage("stab", { add = 0.5 }))
