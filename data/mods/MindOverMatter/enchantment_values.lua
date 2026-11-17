local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_telekin_ritual_summon_strength_enchant_strength_add", function(ctx)
    return ((ctx.spell_levels["telekinetic_pull"] + ctx.spell_levels["telekinetic_push"]) + ctx.spell_levels["telekinetic_wave"]) + ctx.spell_levels["telekinetic_momentum"]
end)

ccb.runtime.handler("enchantment_enchant_electrokin_electric_strikes_electric_add", function(ctx)
    return ctx.spell_levels["electrokinetic_melee_attacks"] * (-1)
end)

content.add(content.Enchantment {
    id = "telekin_ritual_summon_strength_enchant",
    has = "HELD",
    condition = "ALWAYS",
}
    :value("STRENGTH", {
        add_handler = "enchantment_telekin_ritual_summon_strength_enchant_strength_add",
        load_spell_levels = { "telekinetic_momentum", "telekinetic_pull", "telekinetic_push", "telekinetic_wave" },
    })
    :value("ATTACK_SPEED", { multiply = 10 })
    :value("BONUS_DODGE", { add = -5 })
    :value("BONUS_BLOCK", { add = -5 }))

content.add(content.Enchantment {
    id = "enchant_electrokin_electric_strikes",
    has = "HELD",
    condition = "ALWAYS",
}
    :incoming_damage("electric", {
        add_handler = "enchantment_enchant_electrokin_electric_strikes_electric_add",
        load_spell_levels = { "electrokinetic_melee_attacks" },
    })
    :hit_you({ id = "electrokin_zap_attack", self = false, trigger_once_in = 2 }))
