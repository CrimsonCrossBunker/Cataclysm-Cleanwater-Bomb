local ccb = require("ccb")
local content = ccb.content

-- perkdata/sight_beyond_sight.json
ccb.runtime.handler("inline_vision_inline_ench_perk_sight_beyond_sight_active_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception + ctx.character_inputs.stats.intelligence)
end)

ccb.runtime.handler("inline_vision_inline_ench_perk_sight_beyond_sight_active_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["HORROR"] or
        ctx.target_inputs.species["NETHER"] or
        ctx.target_inputs.species["nether_player_hate"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_sight_beyond_sight_active_0",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_perk_sight_beyond_sight_active_0_0_range",
        condition_handler = "inline_vision_inline_ench_perk_sight_beyond_sight_active_0_0_detect",
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

-- perks.json
ccb.runtime.handler("inline_vision_inline_ench_perk_tingly_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["ROBOT"] or
        ctx.target_inputs.species["CYBORG"] or
        ctx.target_inputs.species["ROBOT_FLYING"] or
        ctx.target_inputs.species["LEECH_PLANT"] or
        ctx.target_inputs.flags["ELECTRIC"] or
        (ctx.target_inputs.traits["EXODII_BODY_1"] or ctx.target_inputs.traits["EXODII_BODY_2"] or ctx.target_inputs.traits["EXODII_BODY_9"]) or
        ctx.target_inputs.effects["absorbed_electric"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_tingly_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :vision({
        precise = true,
        distance = 4,
        condition_handler = "inline_vision_inline_ench_perk_tingly_0_0_detect",
        target_inputs = {
            effects = { "absorbed_electric" },
            flags = { "ELECTRIC" },
            species = { "CYBORG", "LEECH_PLANT", "ROBOT", "ROBOT_FLYING" },
            traits = { "EXODII_BODY_1", "EXODII_BODY_2", "EXODII_BODY_9" }
        },
        descriptions = {
            {
                id = "electric_creature_sense",
                symbol = "?",
                color = "c_cyan",
                text = content.text("You sense something emitting electricity here.")
            }
        }
    }))
