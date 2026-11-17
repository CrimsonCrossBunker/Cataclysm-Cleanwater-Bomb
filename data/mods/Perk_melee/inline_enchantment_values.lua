local ccb = require("ccb")
local content = ccb.content

-- PERKS/tempo.json
ccb.runtime.handler("inline_value_inline_ench_melee_perk_tempo_throw_0_value_0_multiply", function(ctx)
    return ((ctx.character_inputs.effect_intensities["mabuff:buff_perk_tempo"] > 0) and ctx.character_inputs.effect_intensities["mabuff:buff_perk_tempo"] or 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_MELEE_PERK_TEMPO_THROW_0",
    load_character_inputs = { effect_intensities = { "mabuff:buff_perk_tempo" } },
    native_modifier_order = true,
}
    :value("THROW_DAMAGE", { multiply_handler = "inline_value_inline_ench_melee_perk_tempo_throw_0_value_0_multiply", load_skills = {  } }))
