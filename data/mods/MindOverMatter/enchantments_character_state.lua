local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_pyrokinetic_banked_fire_damage_enchant_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

ccb.runtime.handler("enchantment_pyrokinetic_banked_fire_damage_enchant_melee_damage_heat_add", function(ctx)
    return ctx.spell_levels["pyrokinetic_call_flames"] + 5
end)

content.add(content.Enchantment {
    id = "pyrokinetic_banked_fire_damage_enchant",
    has = "WORN",
    condition_handler = "enchantment_pyrokinetic_banked_fire_damage_enchant_active",
    load_character_inputs = { armed = true },
}
    :melee_damage("heat", { add_handler = "enchantment_pyrokinetic_banked_fire_damage_enchant_melee_damage_heat_add", load_spell_levels = { "pyrokinetic_call_flames" } }))

ccb.runtime.handler("enchantment_enchant_photokin_potion_rads_active", function(ctx)
    return ctx.character_inputs.radiation > 0
end)

content.add(content.Enchantment {
    id = "enchant_photokin_potion_rads",
    has = "HELD",
    condition_handler = "enchantment_enchant_photokin_potion_rads_active",
    load_character_inputs = { radiation = true },
}
    :value("LUMINATION", { add = 10 }))
