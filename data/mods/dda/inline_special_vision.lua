local ccb = require("ccb")
local content = ccb.content

-- data/json/effects_on_condition/medicine_eocs/speed_serum_eoc.json
ccb.runtime.handler("inline_vision_inline_ench_speed_serum_main_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["ROBOT"] or
        ctx.target_inputs.species["CYBORG"] or
        ctx.target_inputs.species["ROBOT_FLYING"] or
        ctx.target_inputs.species["LEECH_PLANT"] or
        ctx.target_inputs.flags["ELECTRIC"] or
        (ctx.target_inputs.traits["EXODII_BODY_1"] or ctx.target_inputs.traits["EXODII_BODY_2"] or ctx.target_inputs.traits["EXODII_BODY_9"]) or
        ctx.target_inputs.effects["absorbed_electric"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_speed_serum_main_0",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = -0.1 })
    :value("ATTACK_SPEED", { multiply = -0.33 })
    :value("AIMING_SPEED", { multiply = 0.8 })
    :value("RELOADING_SPEED", { multiply = -0.5 })
    :value("CARDIO_MULTIPLIER", { multiply = 0.2 })
    :value("PAIN", { multiply = 0.333 })
    :value("EXTRA_ELEC_PAIN", { multiply = 1 })
    :value("PAIN_PENALTY_MOD_STR", { multiply = 0.4 })
    :value("PAIN_PENALTY_MOD_DEX", { multiply = 0.4 })
    :value("PAIN_PENALTY_MOD_INT", { multiply = 0.4 })
    :value("PAIN_PENALTY_MOD_PER", { multiply = 0.4 })
    :value("PAIN_PENALTY_MOD_SPEED", { multiply = 0.4 })
    :value("SLEEPY", { add = -25 })
    :value("KCAL", { multiply = -0.15 })
    :vision({
        distance = 5,
        condition_handler = "inline_vision_inline_ench_speed_serum_main_0_0_detect",
        target_inputs = {
            effects = { "absorbed_electric" },
            flags = { "ELECTRIC" },
            species = { "CYBORG", "LEECH_PLANT", "ROBOT", "ROBOT_FLYING" },
            traits = { "EXODII_BODY_1", "EXODII_BODY_2", "EXODII_BODY_9" }
        },
        descriptions = {
            {
                id = "electric_creature_sense",
                symbol = "?",
                color = "c_cyan",
                text = content.text("You sense something emitting electricity here.")
            }
        }
    }))
