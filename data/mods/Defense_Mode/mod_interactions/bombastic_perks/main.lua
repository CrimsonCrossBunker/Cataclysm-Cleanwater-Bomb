local ccb = require("ccb")
local content = ccb.content

-- mod_interactions/bombastic_perks/perks.json
ccb.runtime.handler("interaction_enchantment_active_inline_ench_perk_melee_master_0", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_melee_master_0",
    condition_handler = "interaction_enchantment_active_inline_ench_perk_melee_master_0",
    load_character_inputs = { armed = true },
    native_modifier_order = true,
}
    :melee_damage("cut", { add = 10 })
    :melee_damage("stab", { add = 10 })
    :melee_damage("bash", { add = 10 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_gymrat_king_0",
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", { multiply = 0.8 }))
