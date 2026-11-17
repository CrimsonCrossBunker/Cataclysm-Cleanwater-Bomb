local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_melee_perk_ench_insight_active", function(ctx)
    return ctx.character_inputs.effects["perk_insight"]
end)

ccb.runtime.handler("enchantment_melee_perk_ench_insight_melee_damage_cut_add", function(ctx)
    return ctx.character_inputs.effect_intensities["perk_insight"] * ctx.character_inputs.character_variables["perk_insight_cut_scaling"]
end)

ccb.runtime.handler("enchantment_melee_perk_ench_insight_melee_damage_stab_add", function(ctx)
    return ctx.character_inputs.effect_intensities["perk_insight"] * ctx.character_inputs.character_variables["perk_insight_stab_scaling"]
end)

ccb.runtime.handler("enchantment_melee_perk_ench_insight_melee_damage_bash_add", function(ctx)
    return ctx.character_inputs.effect_intensities["perk_insight"] * ctx.character_inputs.character_variables["perk_insight_bash_scaling"]
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_insight",
    condition_handler = "enchantment_melee_perk_ench_insight_active",
    load_character_inputs = { character_variables = { "perk_insight_bash_scaling", "perk_insight_cut_scaling", "perk_insight_stab_scaling" }, effect_intensities = { "perk_insight" }, effects = { "perk_insight" } },
}
    :melee_damage("cut", { add_handler = "enchantment_melee_perk_ench_insight_melee_damage_cut_add" })
    :melee_damage("stab", { add_handler = "enchantment_melee_perk_ench_insight_melee_damage_stab_add" })
    :melee_damage("bash", { add_handler = "enchantment_melee_perk_ench_insight_melee_damage_bash_add" }))

ccb.runtime.handler("enchantment_melee_perk_ench_poise_incoming_damage_bash_multiply", function(ctx)
    return ctx.character_inputs.character_variables["poise"] * (-0.4)
end)

ccb.runtime.handler("enchantment_melee_perk_ench_poise_incoming_damage_cut_multiply", function(ctx)
    return ctx.character_inputs.character_variables["poise"] * (-0.4)
end)

ccb.runtime.handler("enchantment_melee_perk_ench_poise_incoming_damage_stab_multiply", function(ctx)
    return ctx.character_inputs.character_variables["poise"] * (-0.4)
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_poise",
    load_character_inputs = { character_variables = { "poise" } },
}
    :incoming_damage("bash", { multiply_handler = "enchantment_melee_perk_ench_poise_incoming_damage_bash_multiply" })
    :incoming_damage("cut", { multiply_handler = "enchantment_melee_perk_ench_poise_incoming_damage_cut_multiply" })
    :incoming_damage("stab", { multiply_handler = "enchantment_melee_perk_ench_poise_incoming_damage_stab_multiply" })
    :hit_me({ id = "perk_lose_poise_spell", self = true }))

ccb.runtime.handler("enchantment_melee_perk_ench_no_poise_active", function(ctx)
    return ctx.character_inputs.character_variables["poise"] == 0
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_no_poise",
    condition_handler = "enchantment_melee_perk_ench_no_poise_active",
    load_character_inputs = { character_variables = { "poise" } },
}
    :incoming_damage("bash", { multiply = 1 })
    :incoming_damage("cut", { multiply = 1 })
    :incoming_damage("stab", { multiply = 1 })
    :hit_me({ id = "perk_lose_poise_spell", self = true }))

ccb.runtime.handler("enchantment_melee_perk_ench_shrug_off_active", function(ctx)
    return ctx.character_inputs.character_variables["poise"] == 4
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_shrug_off",
    condition_handler = "enchantment_melee_perk_ench_shrug_off_active",
    load_character_inputs = { character_variables = { "poise" } },
}
    :incoming_damage("bullet", { multiply = -0.6 }))

ccb.runtime.handler("enchantment_melee_perk_ench_poise_reckless_active", function(ctx)
    return ctx.character_inputs.character_variables["poise"] == 0
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_poise_reckless",
    condition_handler = "enchantment_melee_perk_ench_poise_reckless_active",
    load_character_inputs = { character_variables = { "poise" } },
}
    :value("REGEN_STAMINA", { multiply = 3.0 }))
