local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_ench_ierde_stone_fists_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

ccb.runtime.handler("enchantment_ench_ierde_stone_fists_melee_damage_bash_add", function(ctx)
    return 10 * (1 + ((ctx.character_inputs.traits["IERDE_SKIN_3"] and 1 or 0) * 0.5))
end)

content.add(content.Enchantment {
    id = "ench_ierde_stone_fists",
    has = "WORN",
    condition_handler = "enchantment_ench_ierde_stone_fists_active",
    load_character_inputs = { armed = true, traits = { "IERDE_SKIN_3" } },
}
    :value("ATTACK_SPEED", { multiply = 0.15 })
    :melee_damage("bash", { add_handler = "enchantment_ench_ierde_stone_fists_melee_damage_bash_add" }))

ccb.runtime.handler("enchantment_ench_trow_stone_fists_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.add(content.Enchantment {
    id = "ench_trow_stone_fists",
    has = "WORN",
    condition_handler = "enchantment_ench_trow_stone_fists_active",
    load_character_inputs = { armed = true },
}
    :melee_damage("bash", { add = 6 }))

ccb.runtime.handler("enchantment_dreamer_regen_no_active", function(ctx)
    return (ctx.character_inputs.morale >= (-34)) and (ctx.character_inputs.morale <= 34)
end)

content.add(content.Enchantment {
    id = "dreamer_regen_no",
    has = "HELD",
    name = content.text("Calm or Bored"),
    description = content.text("Your mood is stable and stilled.  Your ability to regenerate mana is nonexistent."),
    condition_handler = "enchantment_dreamer_regen_no_active",
    load_character_inputs = { morale = true },
}
    :value("REGEN_MANA", { multiply = -1 }))

ccb.runtime.handler("enchantment_dreamer_regen_yes_active", function(ctx)
    return (ctx.character_inputs.morale < (-34)) or (ctx.character_inputs.morale > 34)
end)

ccb.runtime.handler("enchantment_dreamer_regen_yes_value_regen_mana_multiply", function(ctx)
    return math.abs(ctx.character_inputs.morale) / 41
end)

content.add(content.Enchantment {
    id = "dreamer_regen_yes",
    has = "HELD",
    name = content.text("Passionate"),
    description = content.text("You can feel your emotions filling your reservoirs of magickal energy."),
    condition_handler = "enchantment_dreamer_regen_yes_active",
    load_character_inputs = { morale = true },
}
    :value("REGEN_MANA", { multiply_handler = "enchantment_dreamer_regen_yes_value_regen_mana_multiply" }))

ccb.runtime.handler("enchantment_max_mana_str_value_strength_add", function(ctx)
    return ctx.character_inputs.max_mana / 4
end)

content.add(content.Enchantment {
    id = "MAX_MANA_STR",
    condition = "ALWAYS",
    load_character_inputs = { max_mana = true },
}
    :value("STRENGTH", { add_handler = "enchantment_max_mana_str_value_strength_add" }))

ccb.runtime.handler("enchantment_pain_str_value_strength_add", function(ctx)
    return ctx.character_inputs.pain / 4
end)

content.add(content.Enchantment {
    id = "PAIN_STR",
    condition = "ALWAYS",
    load_character_inputs = { pain = true },
}
    :value("STRENGTH", { add_handler = "enchantment_pain_str_value_strength_add" }))

ccb.runtime.handler("enchantment_dream_dagger_melee_damage_cut_add", function(ctx)
    return ctx.character_inputs.max_mana / 100
end)

content.add(content.Enchantment {
    id = "DREAM_DAGGER",
    has = "WIELD",
    condition = "ALWAYS",
    load_character_inputs = { max_mana = true },
}
    :melee_damage("cut", { add_handler = "enchantment_dream_dagger_melee_damage_cut_add" }))

ccb.runtime.handler("enchantment_ench_jagged_claws_faster_attack_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.add(content.Enchantment {
    id = "ench_jagged_claws_faster_attack",
    has = "WORN",
    condition_handler = "enchantment_ench_jagged_claws_faster_attack_active",
    load_character_inputs = { armed = true },
}
    :value("ATTACK_SPEED", { add = -10 }))

ccb.runtime.handler("enchantment_sylph_extra_dodges_value_bonus_dodge_add", function(ctx)
    return 1 + (ctx.character_inputs.traits["THRESH_SYLPH"] and 1 or 0)
end)

content.add(content.Enchantment {
    id = "sylph_extra_dodges",
    condition = "ALWAYS",
    load_character_inputs = { traits = { "THRESH_SYLPH" } },
}
    :value("BONUS_DODGE", { add_handler = "enchantment_sylph_extra_dodges_value_bonus_dodge_add" }))

ccb.runtime.handler("enchantment_sylph_wind_weapons_value_range_multiply", function(ctx)
    return 0.1 + ((ctx.character_inputs.traits["THRESH_SYLPH"] and 1 or 0) * 0.1)
end)

content.add(content.Enchantment {
    id = "sylph_wind_weapons",
    condition = "ALWAYS",
    load_character_inputs = { traits = { "THRESH_SYLPH" } },
}
    :value("RANGE", { multiply_handler = "enchantment_sylph_wind_weapons_value_range_multiply" }))

ccb.runtime.handler("enchantment_ench_vampire_heightened_senses_hearing_value_hearing_mult_multiply", function(ctx)
    return (0.25 + ((ctx.character_inputs.traits["VAMPIRE2"] and 1 or 0) * 0.25)) + ((ctx.character_inputs.traits["VAMPIRE3"] and 1 or 0) * 0.5)
end)

content.add(content.Enchantment {
    id = "ench_vampire_heightened_senses_hearing",
    condition = "ALWAYS",
    load_character_inputs = { traits = { "VAMPIRE2", "VAMPIRE3" } },
}
    :value("HEARING_MULT", { multiply_handler = "enchantment_ench_vampire_heightened_senses_hearing_value_hearing_mult_multiply" }))
