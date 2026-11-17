local ccb = require("ccb")
local content = ccb.content

-- effects_esper.json
ccb.runtime.handler("inline_vision_inline_ench_effect_afs_electrokin_see_electricity_0_0_range", function(ctx)
    return (((ctx.character_inputs.spell_levels["electrokinesis_see_electric"] * 1.5) + 6) * ccb.runtime.call_number("attribute_scaling", ctx.character_inputs.stats.intelligence))
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_afs_electrokin_see_electricity_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["ROBOT"] or
        ctx.target_inputs.species["CYBORG"] or
        ctx.target_inputs.species["ROBOT_FLYING"] or
        ctx.target_inputs.species["LEECH_PLANT"] or
        ctx.target_inputs.flags["ELECTRIC"] or
        (ctx.target_inputs.traits["EXODII_BODY_1"] or ctx.target_inputs.traits["EXODII_BODY_2"] or ctx.target_inputs.traits["EXODII_BODY_9"]) or
        ctx.target_inputs.effects["absorbed_electric"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_electrokin_see_electricity_0", condition = "ALWAYS",
    load_character_inputs = { spell_levels = { "electrokinesis_see_electric" }, stats = true },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_afs_electrokin_see_electricity_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_afs_electrokin_see_electricity_0_0_detect",
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

ccb.runtime.handler("inline_vision_inline_ench_effect_afs_telepath_sense_minds_0_0_range", function(ctx)
    return ((ctx.character_inputs.spell_levels["afs_telepathic_mind_sense"] * 2) * ccb.runtime.call_number("attribute_scaling", ctx.character_inputs.stats.intelligence))
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_afs_telepath_sense_minds_0_0_detect", function(ctx)
    return (((not (ctx.target_inputs.species["PSI_NULL"]) and
        ctx.target_inputs.flags["HAS_MIND"]) or
        (not (ctx.target_inputs.species["PSI_NULL"]) and
        not (ctx.target_inputs.species["ZOMBIE"]) and
        ctx.target_inputs.flags["HUMAN"]) or
        ctx.target_inputs.npc) and
        not (ctx.target_inputs.effects["eff_monster_immune_to_telepathy"]) and
        not (ctx.target_inputs.flags["TEEP_IMMUNE"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_telepath_sense_minds_0", condition = "ALWAYS",
    load_character_inputs = { spell_levels = { "afs_telepathic_mind_sense" }, stats = true },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_afs_telepath_sense_minds_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_afs_telepath_sense_minds_0_0_detect",
        target_inputs = {
            effects = { "eff_monster_immune_to_telepathy" },
            flags = { "HAS_MIND", "HUMAN", "TEEP_IMMUNE" },
            npc = true,
            species = { "PSI_NULL", "ZOMBIE" }
        },
        descriptions = {
            {
                id = "sense_minds",
                symbol = "@",
                color = "c_white",
                text = content.text("You sense something sapient here.")
            }
        }
    }))
