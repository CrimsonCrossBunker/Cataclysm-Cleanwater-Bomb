local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_berserker_str_value_strength_add", function(ctx)
    return ctx.character_inputs.global_variables["BERSERKER"] / 3
end)

content.add(content.Enchantment {
    id = "BERSERKER_STR",
    has = "WORN",
    condition = "ALWAYS",
    load_character_inputs = { global_variables = { "BERSERKER" } },
}
    :value("STRENGTH", { add_handler = "enchantment_berserker_str_value_strength_add" }))

ccb.runtime.handler("enchantment_berserker_speed_value_speed_add", function(ctx)
    return ctx.character_inputs.global_variables["BERSERKER"]
end)

content.add(content.Enchantment {
    id = "BERSERKER_SPEED",
    has = "WORN",
    condition = "ALWAYS",
    load_character_inputs = { global_variables = { "BERSERKER" } },
}
    :value("SPEED", { add_handler = "enchantment_berserker_speed_value_speed_add" }))

ccb.runtime.handler("enchantment_berserker_regen_stamina_value_regen_stamina_multiply", function(ctx)
    return ctx.character_inputs.global_variables["BERSERKER"] / 5
end)

content.add(content.Enchantment {
    id = "BERSERKER_REGEN_STAMINA",
    has = "WORN",
    condition = "ALWAYS",
    load_character_inputs = { global_variables = { "BERSERKER" } },
}
    :value("REGEN_STAMINA", { multiply_handler = "enchantment_berserker_regen_stamina_value_regen_stamina_multiply" }))

ccb.runtime.handler("enchantment_exp_bash_melee_damage_bash_add", function(ctx)
    return (ctx.character_inputs.kill_xp + ctx.character_inputs.character_variables["bonus_exp"]) / 750
end)

content.add(content.Enchantment {
    id = "EXP_BASH",
    has = "WIELD",
    condition = "ALWAYS",
    load_character_inputs = { kill_xp = true, character_variables = { "bonus_exp" } },
}
    :melee_damage("bash", { add_handler = "enchantment_exp_bash_melee_damage_bash_add" }))
