local ccb = require("ccb")
local content = ccb.content

-- player/traits.json
ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 2)
end)

ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_0_detect", function(ctx)
    return (ctx.target_inputs.line_of_sight and
        (ctx.target_inputs.species["HORROR"] or
        ctx.target_inputs.species["NETHER"] or
        ctx.target_inputs.species["UMMONED_CREATURE"] or
        ctx.target_inputs.species["nether_player_hate"]))
end)

ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_1_range", function(ctx)
    return (ctx.character_inputs.stats.perception / 2)
end)

ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_1_detect", function(ctx)
    return (ctx.target_inputs.species["HORROR"] or
        ctx.target_inputs.species["NETHER"] or
        ctx.target_inputs.species["UMMONED_CREATURE"] or
        ctx.target_inputs.species["nether_player_hate"])
end)

ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_2_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 2)
end)

ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_2_detect", function(ctx)
    return (ctx.target_inputs.line_of_sight and
        (ctx.target_inputs.species["ELDRITCH_BEING"] or
        ctx.target_inputs.species["FOREST_SPIRIT"]))
end)

ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_3_range", function(ctx)
    return (ctx.character_inputs.stats.perception / 2)
end)

ccb.runtime.handler("inline_vision_inline_ench_witchsight_0_3_detect", function(ctx)
    return (ctx.target_inputs.species["ELDRITCH_BEING"] or
        ctx.target_inputs.species["FOREST_SPIRIT"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WITCHSIGHT_0",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        precise = true,
        distance_handler = "inline_vision_inline_ench_witchsight_0_0_range",
        condition_handler = "inline_vision_inline_ench_witchsight_0_0_detect",
        target_inputs = {
            line_of_sight = true,
            species = { "HORROR", "NETHER", "UMMONED_CREATURE", "nether_player_hate" }
        },
        descriptions = {
            {
                id = "nether_creature_sense",
                symbol = "?",
                color = "c_pink",
                text = content.text("You see an otherworldy danger here.")
            }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_witchsight_0_1_range",
        condition_handler = "inline_vision_inline_ench_witchsight_0_1_detect",
        target_inputs = {
            species = { "HORROR", "NETHER", "UMMONED_CREATURE", "nether_player_hate" }
        },
        descriptions = {
            {
                id = "nether_creature_sense",
                symbol = "?",
                color = "c_pink",
                text = content.text("You sense an otherworldy danger here.")
            }
        }
    })
    :vision({
        precise = true,
        distance_handler = "inline_vision_inline_ench_witchsight_0_2_range",
        condition_handler = "inline_vision_inline_ench_witchsight_0_2_detect",
        target_inputs = {
            line_of_sight = true,
            species = { "ELDRITCH_BEING", "FOREST_SPIRIT" }
        },
        descriptions = {
            {
                id = "wizard_sense",
                symbol = "?",
                color = "c_pink",
                text = content.text("You see a being of the Unseen World here.")
            }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_witchsight_0_3_range",
        condition_handler = "inline_vision_inline_ench_witchsight_0_3_detect",
        target_inputs = {
            species = { "ELDRITCH_BEING", "FOREST_SPIRIT" }
        },
        descriptions = {
            {
                id = "wizard_sense",
                symbol = "?",
                color = "c_pink",
                text = content.text("You sense a being of the Unseen World here.")
            }
        }
    }))
