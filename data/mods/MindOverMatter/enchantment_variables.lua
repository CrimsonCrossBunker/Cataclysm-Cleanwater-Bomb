local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_ench_nemesis_buff_value_speed_add", function(ctx)
    return ctx.character_inputs.global_variables["Nemesis_iteration"] * 1
end)

ccb.runtime.handler("enchantment_ench_nemesis_buff_incoming_damage_bash_add", function(ctx)
    return ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1)
end)

ccb.runtime.handler("enchantment_ench_nemesis_buff_incoming_damage_stab_add", function(ctx)
    return ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1)
end)

ccb.runtime.handler("enchantment_ench_nemesis_buff_incoming_damage_cut_add", function(ctx)
    return ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1)
end)

ccb.runtime.handler("enchantment_ench_nemesis_buff_incoming_damage_bullet_add", function(ctx)
    return ctx.character_inputs.global_variables["Nemesis_iteration"] * (-1)
end)

content.add(content.Enchantment {
    id = "ench_nemesis_buff",
    condition = "ALWAYS",
    load_character_inputs = { global_variables = { "Nemesis_iteration" } },
}
    :value("SPEED", { add_handler = "enchantment_ench_nemesis_buff_value_speed_add" })
    :incoming_damage("bash", { add_handler = "enchantment_ench_nemesis_buff_incoming_damage_bash_add" })
    :incoming_damage("stab", { add_handler = "enchantment_ench_nemesis_buff_incoming_damage_stab_add" })
    :incoming_damage("cut", { add_handler = "enchantment_ench_nemesis_buff_incoming_damage_cut_add" })
    :incoming_damage("bullet", { add_handler = "enchantment_ench_nemesis_buff_incoming_damage_bullet_add" }))

ccb.runtime.handler("enchantment_enchant_pyrokin_cloak_value_climate_control_chill_add", function(ctx)
    return (60 + ((ctx.spell_levels["pyrokinetic_cloak"] * 4) * ((ctx.stats.intelligence + 10) / 20))) * ctx.character_inputs.character_variables["nether_attunement_power_scaling"]
end)

ccb.runtime.handler("enchantment_enchant_pyrokin_cloak_value_climate_control_heat_add", function(ctx)
    return ((ctx.spell_levels["pyrokinetic_cloak"] * 10) * ((ctx.stats.intelligence + 10) / 20)) * ctx.character_inputs.character_variables["nether_attunement_power_scaling"]
end)

ccb.runtime.handler("enchantment_enchant_pyrokin_cloak_incoming_damage_heat_multiply", function(ctx)
    return ((ctx.spell_levels["pyrokinetic_cloak"] * (-1)) * ((ctx.stats.intelligence + 10) / 20)) * ctx.character_inputs.character_variables["nether_attunement_power_scaling"]
end)

ccb.runtime.handler("enchantment_enchant_pyrokin_cloak_incoming_damage_cold_multiply", function(ctx)
    return ((ctx.spell_levels["pyrokinetic_cloak"] * (-3)) * ((ctx.stats.intelligence + 10) / 20)) * ctx.character_inputs.character_variables["nether_attunement_power_scaling"]
end)

content.add(content.Enchantment {
    id = "enchant_pyrokin_cloak",
    has = "HELD",
    emitter = "emit_pyrokin_cloak",
    condition = "ALWAYS",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" } },
}
    :value("CLIMATE_CONTROL_CHILL", { add_handler = "enchantment_enchant_pyrokin_cloak_value_climate_control_chill_add", load_spell_levels = { "pyrokinetic_cloak" } })
    :value("CLIMATE_CONTROL_HEAT", { add_handler = "enchantment_enchant_pyrokin_cloak_value_climate_control_heat_add", load_spell_levels = { "pyrokinetic_cloak" } })
    :incoming_damage("heat", { multiply_handler = "enchantment_enchant_pyrokin_cloak_incoming_damage_heat_multiply", load_spell_levels = { "pyrokinetic_cloak" } })
    :incoming_damage("cold", { multiply_handler = "enchantment_enchant_pyrokin_cloak_incoming_damage_cold_multiply", load_spell_levels = { "pyrokinetic_cloak" } }))
