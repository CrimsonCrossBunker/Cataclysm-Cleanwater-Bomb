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

local weapon_perks = {
    { id = "INLINE_ENCH_perk_slice&dice_0", damage = "cut", bonus = 5 },
    { id = "INLINE_ENCH_perk_bash&mash_0", damage = "bash", bonus = 5 },
    { id = "INLINE_ENCH_perk_knifey_0", damage = "stab", bonus = 5 },
}

for _, perk in ipairs(weapon_perks) do
    local damage = perk.damage
    local handler = "weapon_" .. damage .. "_perk_active"
    ccb.runtime.handler(handler, function(ctx)
        return ctx.character_inputs.wielded_damage[damage] > 1
    end)
    content.upsert_enchantment(content.Enchantment {
        id = perk.id,
        condition_handler = handler,
        load_character_inputs = { wielded_damage = { damage } },
        native_modifier_order = true,
    }
        :melee_damage(damage, { add = perk.bonus }))
end

ccb.content.add(ccb.content.EffectType {
    id = "mysterious_stranger_cooldown",
    name = ccb.content.text("Mysterious Stranger's Break"),
    description = ccb.content.text("The stranger will be back…"),
    apply_message = ccb.content.text("The stranger will be back…"),
    rating = "bad",
})
