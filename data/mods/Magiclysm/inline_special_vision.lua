local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
ccb.runtime.handler("inline_vision_inline_ench_effect_tremorsense_0_0_range", function(ctx)
    return (ctx.character_inputs.spell_levels["earthshaper_danger_sense"] * 3)
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_tremorsense_0_0_detect", function(ctx)
    return not (ctx.target_inputs.flags["FLIES"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_tremorsense_0", condition = "ALWAYS",
    load_character_inputs = { spell_levels = { "earthshaper_danger_sense" } },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_tremorsense_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_tremorsense_0_0_detect",
        target_inputs = {
            flags = { "FLIES" }
        },
        descriptions = {
            {
                id = "moving_creature",
                symbol = "?",
                color = "c_white",
                text = content.text("You sense something moving here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_effect_sense_outsiders_0_0_range", function(ctx)
    return ((ctx.character_inputs.spell_levels["animist_sense_outsiders"] * 2.5) + 3)
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_sense_outsiders_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["HORROR"] or
        ctx.target_inputs.species["NETHER"] or
        ctx.target_inputs.species["nether_player_hate"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_sense_outsiders_0",
    load_character_inputs = { spell_levels = { "animist_sense_outsiders" } },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_sense_outsiders_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_sense_outsiders_0_0_detect",
        target_inputs = {
            species = { "HORROR", "NETHER", "nether_player_hate" }
        },
        descriptions = {
            {
                id = "nether_creature_sense",
                symbol = "?",
                color = "c_pink",
                text = content.text("You sense an otherworldy danger here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_effect_animist_detect_wizards_0_0_range", function(ctx)
    return ((ctx.character_inputs.spell_levels["animist_detect_wizards"] * 2) + 3)
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_animist_detect_wizards_0_0_detect", function(ctx)
    return (ctx.target_inputs.flags["MAGIC_USER"] or
        (ctx.target_inputs.character and
        (ctx.target_inputs.spell_count >= 6)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_animist_detect_wizards_0",
    load_character_inputs = { spell_levels = { "animist_detect_wizards" } },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_animist_detect_wizards_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_animist_detect_wizards_0_0_detect",
        target_inputs = {
            character = true,
            flags = { "MAGIC_USER" },
            spell_count = true
        },
        descriptions = {
            {
                id = "wizard_sense",
                symbol = "?",
                color = "cyan",
                text = content.text("You see the ley lines of a wielder of magic.")
            }
        }
    }))

-- mutations/spell_triggering_mutations.json
ccb.runtime.handler("inline_vision_inline_ench_mind_read_on_0_0_range", function(ctx)
    return (10 + ((ctx.character_inputs.spell_school_counts["ANIMIST"] + ctx.character_inputs.spell_school_counts["DRUID"]) / 2))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_MIND_READ_ON_0", condition = "ALWAYS",
    load_character_inputs = { spell_school_counts = { "ANIMIST", "DRUID" } },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_mind_read_on_0_0_range",
        descriptions = {
            {
                id = "moving_creature",
                symbol = "?",
                color = "c_white",
                text = content.text("You sense something here.")
            }
        }
    }))
