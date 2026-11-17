local ccb = require("ccb")
local content = ccb.content

local progression = require("enchantment_progression")

-- effects/effects_changeling_seasonal_magic.json
ccb.runtime.handler("body_enchantment_inline_ench_effect_changeling_summer_bonus_stamina_near_enemies_0_value_0_add", function(ctx)
    return (((ctx.character_inputs.nearby_monsters["monsters_1"] + ctx.character_inputs.nearby_characters["characters_1"]) * 75) * ((ctx.character_inputs.global_variables["global_what_is_the_season"] == 4) and 0.6 or 1))
end)

ccb.runtime.handler("body_enchantment_inline_ench_effect_changeling_summer_bonus_stamina_near_enemies_0_value_1_add", function(ctx)
    return math.max(((ctx.character_inputs.nearby_monsters["monsters_1"] + ctx.character_inputs.nearby_characters["characters_1"]) / 3), 1)
end)

ccb.runtime.handler("body_enchantment_active_inline_ench_effect_changeling_summer_bonus_stamina_near_enemies_0", function(ctx)
    return ((ctx.character_inputs.nearby_monsters["monsters_1"] > 0) or
        (ctx.character_inputs.nearby_characters["characters_1"] > 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_bonus_stamina_near_enemies_0",
    condition_handler = "body_enchantment_active_inline_ench_effect_changeling_summer_bonus_stamina_near_enemies_0",
    load_character_inputs = {
        global_variables = { "global_what_is_the_season" },
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "any", radius = 1 }
        },
        nearby_monsters = {
            monsters_1 = { attitude = "hostile", radius = 1 }
        }
    },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", {
        add_handler = "body_enchantment_inline_ench_effect_changeling_summer_bonus_stamina_near_enemies_0_value_0_add",
        load_skills = {}
    })
    :value("BONUS_DODGE", {
        add_handler = "body_enchantment_inline_ench_effect_changeling_summer_bonus_stamina_near_enemies_0_value_1_add",
        load_skills = {}
    }))

-- effects/goblin_fruit_effects.json
ccb.runtime.handler("body_enchantment_active_inline_ench_effect_goblin_fruit_craft_speed_boost_0", function(ctx)
    return ((ctx.character_inputs.nearby_monsters["monsters_1"] == 0) and
        (ctx.character_inputs.nearby_characters["characters_1"] == 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_goblin_fruit_craft_speed_boost_0",
    condition_handler = "body_enchantment_active_inline_ench_effect_goblin_fruit_craft_speed_boost_0",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "any", radius = 8 }
        },
        nearby_monsters = {
            monsters_1 = { attitude = "both", radius = 8 }
        }
    },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.15 }))

-- mutations/paraclesians/homullus_mutations.json
ccb.runtime.handler("body_enchantment_inline_ench_homullus_regen_stamina_0_value_0_multiply", function(ctx)
    return ((ctx.character_inputs.nearby_characters["characters_1"] + ctx.character_inputs.nearby_monsters["monsters_1"]) * (0.05 * progression.post_threshold_bonus(ctx, 1)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_REGEN_STAMINA_0",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "any", radius = 30 }
        },
        nearby_monsters = {
            monsters_1 = {
                attitude = "both",
                radius = 30,
                species = { "FERAL" }
            }
        },
        traits = {
            "THRESH_ARVORE",
            "THRESH_HOMULLUS",
            "THRESH_IERDE",
            "THRESH_SALAMANDER",
            "THRESH_SYLPH",
            "THRESH_UNDINE"
        }
    },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", {
        multiply_handler = "body_enchantment_inline_ench_homullus_regen_stamina_0_value_0_multiply",
        load_skills = {}
    }))

-- mutations/playable_changeling.json
ccb.runtime.handler("body_enchantment_active_inline_ench_brownie_crafting_bonus_0", function(ctx)
    return ((ctx.character_inputs.nearby_monsters["monsters_1"] == 0) and
        (ctx.character_inputs.nearby_characters["characters_1"] == 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BROWNIE_CRAFTING_BONUS_0",
    condition_handler = "body_enchantment_active_inline_ench_brownie_crafting_bonus_0",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "any", radius = 8 }
        },
        nearby_monsters = {
            monsters_1 = { attitude = "both", radius = 8 }
        }
    },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.33 }))

ccb.runtime.handler("body_enchantment_active_inline_ench_brownie_crafting_bonus2_0", function(ctx)
    return ((ctx.character_inputs.nearby_monsters["monsters_1"] == 0) and
        (ctx.character_inputs.nearby_characters["characters_1"] == 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BROWNIE_CRAFTING_BONUS2_0",
    condition_handler = "body_enchantment_active_inline_ench_brownie_crafting_bonus2_0",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "any", radius = 8 }
        },
        nearby_monsters = {
            monsters_1 = { attitude = "both", radius = 8 }
        }
    },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.75 }))

ccb.runtime.handler("body_enchantment_active_inline_ench_brownie_crafting_bonus3_0", function(ctx)
    return ((ctx.character_inputs.nearby_monsters["monsters_1"] == 0) and
        (ctx.character_inputs.nearby_characters["characters_1"] == 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BROWNIE_CRAFTING_BONUS3_0",
    condition_handler = "body_enchantment_active_inline_ench_brownie_crafting_bonus3_0",
    load_character_inputs = {
        nearby_characters = {
            characters_1 = { allow_hallucinations = false, attitude = "any", radius = 8 }
        },
        nearby_monsters = {
            monsters_1 = { attitude = "both", radius = 8 }
        }
    },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 1.5 }))
