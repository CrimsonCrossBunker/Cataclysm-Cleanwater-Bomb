local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_melee_perk_ench_six_sense_active", function(ctx)
    return ctx.character_inputs.effect_intensities["perk_insight"] > 9
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_six_sense",
    condition_handler = "enchantment_melee_perk_ench_six_sense_active",
    load_character_inputs = { effect_intensities = { "perk_insight" } },
}
    :vision({ distance = 10, descriptions = { { id = "moving_creature", color = "c_white", symbol = "?", text = content.text("Something hides here.") } } }))

ccb.runtime.handler("enchantment_melee_perk_ench_insight_dodge_active", function(ctx)
    return ctx.character_inputs.effect_intensities["perk_insight"] > 9
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_insight_dodge",
    condition_handler = "enchantment_melee_perk_ench_insight_dodge_active",
    load_character_inputs = { effect_intensities = { "perk_insight" } },
}
    :value("DODGE_CHANCE", { add = 25 }))

ccb.runtime.handler("enchantment_melee_perk_ench_perfect_tempo_active", function(ctx)
    return ctx.character_inputs.effect_intensities["mabuff:buff_perk_tempo"] > 2
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_perfect_tempo",
    name = content.text("Perfect Tempo"),
    description = content.text(" +15 quickness as long as you have the maximum number of combat tempo stacks."),
    condition_handler = "enchantment_melee_perk_ench_perfect_tempo_active",
    load_character_inputs = { effect_intensities = { "mabuff:buff_perk_tempo" } },
}
    :value("SPEED", { add = 15 }))

ccb.runtime.handler("enchantment_melee_perk_ench_insight_mystic_shot_active", function(ctx)
    return (ctx.character_inputs.wielded_flags["PRIMITIVE_RANGED_WEAPON"]) and (ctx.character_inputs.effects["perk_insight"])
end)

ccb.runtime.handler("enchantment_melee_perk_ench_insight_mystic_shot_value_weapon_dispersion_multiply", function(ctx)
    return math.max(-0.9, ctx.character_inputs.effect_intensities["perk_insight"] * -0.02)
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_insight_mystic_shot",
    name = content.text("Mystic Shot"),
    description = content.text("Insight empowers your ranged attacks with bows and crossbows."),
    condition_handler = "enchantment_melee_perk_ench_insight_mystic_shot_active",
    load_character_inputs = { effect_intensities = { "perk_insight" }, effects = { "perk_insight" }, wielded_flags = { "PRIMITIVE_RANGED_WEAPON" } },
}
    :value("WEAPON_DISPERSION", { multiply_handler = "enchantment_melee_perk_ench_insight_mystic_shot_value_weapon_dispersion_multiply" }))

ccb.runtime.handler("enchantment_melee_perk_ench_insight_mystic_shot_2_active", function(ctx)
    return (ctx.character_inputs.wielded_flags["PRIMITIVE_RANGED_WEAPON"]) and (ctx.character_inputs.effects["perk_insight"])
end)

ccb.runtime.handler("enchantment_melee_perk_ench_insight_mystic_shot_2_value_ranged_damage_multiply", function(ctx)
    return ctx.character_inputs.effect_intensities["perk_insight"] * 0.01
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_insight_mystic_shot_2",
    condition_handler = "enchantment_melee_perk_ench_insight_mystic_shot_2_active",
    load_character_inputs = { effect_intensities = { "perk_insight" }, effects = { "perk_insight" }, wielded_flags = { "PRIMITIVE_RANGED_WEAPON" } },
}
    :value("RANGED_DAMAGE", { multiply_handler = "enchantment_melee_perk_ench_insight_mystic_shot_2_value_ranged_damage_multiply" }))

ccb.runtime.handler("enchantment_melee_perk_ench_momentum_bullet_dodge_active", function(ctx)
    return ctx.character_inputs.effect_intensities["perk_insight"] > 9
end)

ccb.runtime.handler("enchantment_melee_perk_ench_momentum_bullet_dodge_value_range_dodge_add", function(ctx)
    local scale = ctx.character_inputs.effect_intensities["mabuff:buff_perk_momentum"] > 4 and 0.05 or 0.01
    return ctx.stats.dexterity * scale
end)

content.add(content.Enchantment {
    id = "melee_perk_ench_momentum_bullet_dodge",
    condition_handler = "enchantment_melee_perk_ench_momentum_bullet_dodge_active",
    load_character_inputs = { effect_intensities = { "mabuff:buff_perk_momentum", "perk_insight" } },
}
    :value("RANGE_DODGE", { add_handler = "enchantment_melee_perk_ench_momentum_bullet_dodge_value_range_dodge_add" }))
