local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("has_effect_iso_eff_backup", function(ctx)
    return ctx.activation_inputs.effects["iso_eff_backup"]
end)

ccb.runtime.handler("has_effect_iso_eff_hypo_o", function(ctx)
    return ctx.activation_inputs.effects["iso_eff_hypo_o"]
end)

ccb.runtime.handler("has_effect_iso_eff_geas_buff", function(ctx)
    return ctx.activation_inputs.effects["iso_eff_geas_buff"]
end)

content.add(content.Enchantment {
    id = "iso_ench_backup",
    name = content.text("The Backup"),
    description = content.text("We have a situation here."),
    condition_handler = "has_effect_iso_eff_backup",
    load_activation_inputs = { effects = { "iso_eff_backup" } },
}
    :value("MOVE_COST", { add = -50 }))

content.add(content.Enchantment {
    id = "iso_ench_hypo_o",
    name = content.text("Hypocrite's Oath"),
    description = content.text("OH you aren't getting away with that."),
    condition_handler = "has_effect_iso_eff_hypo_o",
    load_activation_inputs = { effects = { "iso_eff_hypo_o" } },
}
    :value("MELEE_DAMAGE", { multiply = 0.5 })
    :value("RANGED_DAMAGE", { multiply = 0.5 }))

content.add(content.Enchantment {
    id = "iso_ench_geas_buff",
    name = content.text("Ancient vow"),
    description = content.text("Lightless monster!  I give you oblivion!\n\n Deal 15% more damage and regen 100% more stamina per turn when fighting high danger enemies."),
    condition_handler = "has_effect_iso_eff_geas_buff",
    load_activation_inputs = { effects = { "iso_eff_geas_buff" } },
}
    :value("RANGED_DAMAGE", { multiply = 0.15 })
    :value("MELEE_DAMAGE", { multiply = 0.15 })
    :value("STAMINA_REGEN_MOD", { add = 1 }))
