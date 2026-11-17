local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_technomancer_arete_1", function(ctx)
    return ((ctx.character_inputs.base_stats.strength + ctx.character_inputs.stat_bonuses.strength) >= 16)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_technomancer_arete_1",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_technomancer_arete_1",
    load_character_inputs = { base_stats = true, stat_bonuses = true },
    native_modifier_order = true,
}
    :value("STRENGTH", { add = 2 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_technomancer_arete_2", function(ctx)
    return ((ctx.character_inputs.base_stats.dexterity + ctx.character_inputs.stat_bonuses.dexterity) >= 16)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_technomancer_arete_2",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_technomancer_arete_2",
    load_character_inputs = { base_stats = true, stat_bonuses = true },
    native_modifier_order = true,
}
    :value("DEXTERITY", { add = 2 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_technomancer_arete_3", function(ctx)
    return ((ctx.character_inputs.base_stats.intelligence + ctx.character_inputs.stat_bonuses.intelligence) >= 16)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_technomancer_arete_3",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_technomancer_arete_3",
    load_character_inputs = { base_stats = true, stat_bonuses = true },
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add = 2 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_technomancer_arete_4", function(ctx)
    return ((ctx.character_inputs.base_stats.perception + ctx.character_inputs.stat_bonuses.perception) >= 16)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_technomancer_arete_4",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_technomancer_arete_4",
    load_character_inputs = { base_stats = true, stat_bonuses = true },
    native_modifier_order = true,
}
    :value("PERCEPTION", { add = 2 }))

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_magus_impact_sling_buff_0_value_0_multiply", function(ctx)
    return ((ctx.character_inputs.spell_levels["magus_summon_impact_sling"] + ctx.character_inputs.spell_levels["magus_summon_impact_sling_plus"]) * 0.05)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_magus_impact_sling_buff_0_value_1_multiply", function(ctx)
    return (((ctx.character_inputs.spell_levels["magus_summon_impact_sling"] + ctx.character_inputs.spell_levels["magus_summon_impact_sling_plus"]) * 0.05) + 0.25)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_magus_impact_sling_buff_0_value_2_add", function(ctx)
    return (((ctx.character_inputs.spell_levels["magus_summon_impact_sling"] + ctx.character_inputs.spell_levels["magus_summon_impact_sling_plus"]) * 0.25) + 4)
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_magus_impact_sling_buff_0", function(ctx)
    return (ctx.character_inputs.wielded_skills["throw"] and
        ctx.character_inputs.wielded_flags["PRIMITIVE_RANGED_WEAPON"] and
        (ctx.character_inputs.wielded_ammunition["pebble"] or
        ctx.character_inputs.wielded_ammunition["rock"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_magus_impact_sling_buff_0",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_magus_impact_sling_buff_0",
    load_character_inputs = {
        spell_levels = { "magus_summon_impact_sling", "magus_summon_impact_sling_plus" },
        wielded_ammunition = { "pebble", "rock" },
        wielded_flags = { "PRIMITIVE_RANGED_WEAPON" },
        wielded_skills = { "throw" }
    },
    native_modifier_order = true,
}
    :value("RANGE", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_magus_impact_sling_buff_0_value_0_multiply",
        load_skills = {}
    })
    :value("RANGED_DAMAGE", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_magus_impact_sling_buff_0_value_1_multiply",
        load_skills = {}
    })
    :value("RANGED_ARMOR_PENETRATION", {
        add_handler = "contextual_enchantment_inline_ench_effect_magus_impact_sling_buff_0_value_2_add",
        load_skills = {}
    }))
