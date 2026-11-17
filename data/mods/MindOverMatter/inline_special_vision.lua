local ccb = require("ccb")
local content = ccb.content

local power_modifier = require("psychic_enchantment_scaling").power

-- effects/effects_artifact.json
ccb.runtime.handler("inline_vision_inline_ench_effect_mom_artifact_mind_sight_0_0_detect", function(ctx)
    return (((not (ctx.target_inputs.species["PSI_NULL"]) and
        ctx.target_inputs.flags["HAS_MIND"]) or
        (not (ctx.target_inputs.species["PSI_NULL"]) and
        not (ctx.target_inputs.species["ZOMBIE"]) and
        ctx.target_inputs.flags["HUMAN"]) or
        ctx.target_inputs.npc) and
        not (ctx.target_inputs.effects["eff_monster_immune_to_telepathy"]) and
        not (ctx.target_inputs.flags["TEEP_IMMUNE"]))
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_mom_artifact_mind_sight_0_active", function(ctx)
    return ctx.character_inputs.wielded_flags["MATRIX_CRYSTAL_TELEPATHY"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_mom_artifact_mind_sight_0",
    condition_handler = "inline_vision_inline_ench_effect_mom_artifact_mind_sight_0_active",
    load_character_inputs = { wielded_flags = { "MATRIX_CRYSTAL_TELEPATHY" } },
    native_modifier_order = true,
}
    :vision({
        distance = 15,
        condition_handler = "inline_vision_inline_ench_effect_mom_artifact_mind_sight_0_0_detect",
        target_inputs = {
            effects = { "eff_monster_immune_to_telepathy" },
            flags = { "HAS_MIND", "HUMAN", "TEEP_IMMUNE" },
            npc = true,
            species = { "PSI_NULL", "ZOMBIE" }
        },
        descriptions = {
            {
                id = "sense_minds",
                symbol = "?",
                color = "c_white",
                text = content.text("You sense something sapient here.")
            }
        }
    }))

-- effects/effects_psionic.json
ccb.runtime.handler("inline_vision_inline_ench_effect_clair_better_senses_4_active", function(ctx)
    return (not ((ctx.character_inputs.effects["hallu"] or ctx.character_inputs.effects["datura"] or ctx.character_inputs.effects["taint"] or ctx.character_inputs.effects["hallucination_attacks"] or ctx.character_inputs.effects["visuals"] or ctx.character_inputs.effects["fearparalyze"])) and
        (ctx.character_inputs.character_flags["BLIND"] or
        ctx.character_inputs.effects["blind"] or
        ctx.character_inputs.environment.fields["fd_smoke"] or
        (((ctx.character_inputs.spell_levels["clair_better_senses"] + ctx.character_inputs.spell_levels["clair_better_senses_knack"]) * power_modifier(ctx)) >= 15)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_better_senses_4",
    condition_handler = "inline_vision_inline_ench_effect_clair_better_senses_4_active",
    load_character_inputs = {
        character_flags = { "BLIND" },
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        effects = { "blind", "datura", "fearparalyze", "hallu", "hallucination_attacks", "taint", "visuals" },
        environment = {
            fields = { "fd_smoke" }
        },
        spell_levels = { "clair_better_senses", "clair_better_senses_knack" },
        stats = true
    },
    native_modifier_order = true,
}
    :vision({
        distance = 2,
        descriptions = {
            {
                id = "moving_creature",
                symbol = "?",
                color = "c_white",
                text = content.text("You sense something moving here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_effect_clair_sense_hostile_creatures_0_0_range", function(ctx)
    return ((ctx.character_inputs.spell_levels["clair_sense_hostile_creatures"] * 2) * power_modifier(ctx))
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_clair_sense_hostile_creatures_0_0_detect", function(ctx)
    return ((not (ctx.target_inputs.character) and
        (ctx.target_inputs.anger >= 10)) or
        (ctx.target_inputs.character and
        ctx.target_inputs.hostile))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_sense_hostile_creatures_0",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "clair_sense_hostile_creatures" },
        stats = true
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_clair_sense_hostile_creatures_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_clair_sense_hostile_creatures_0_0_detect",
        target_inputs = { anger = true, character = true, hostile = true },
        descriptions = {
            {
                id = "moving_creature",
                symbol = "?",
                color = "c_white",
                text = content.text("You sense a danger here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_effect_electrokin_see_electricity_0_0_range", function(ctx)
    return ((((ctx.character_inputs.spell_levels["electrokinetic_see_electric"] + ctx.character_inputs.spell_levels["electrokinetic_see_electric_knack"]) * 1.5) + 6) * power_modifier(ctx))
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_electrokin_see_electricity_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["ROBOT"] or
        ctx.target_inputs.species["CYBORG"] or
        ctx.target_inputs.species["ROBOT_FLYING"] or
        ctx.target_inputs.species["LEECH_PLANT"] or
        ctx.target_inputs.flags["ELECTRIC"] or
        (ctx.target_inputs.traits["EXODII_BODY_1"] or ctx.target_inputs.traits["EXODII_BODY_2"] or ctx.target_inputs.traits["EXODII_BODY_9"]) or
        ctx.target_inputs.effects["absorbed_electric"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_electrokin_see_electricity_0", condition = "ALWAYS",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "electrokinetic_see_electric", "electrokinetic_see_electric_knack" },
        stats = true
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_electrokin_see_electricity_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_electrokin_see_electricity_0_0_detect",
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

ccb.runtime.handler("inline_vision_inline_ench_effect_telepath_sense_minds_0_0_range", function(ctx)
    return (((ctx.character_inputs.spell_levels["telepathic_mind_sense"] + ctx.character_inputs.spell_levels["telepathic_mind_sense_knack"]) * 2) * power_modifier(ctx))
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_telepath_sense_minds_0_0_detect", function(ctx)
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
    id = "INLINE_ENCH_effect_telepath_sense_minds_0", condition = "ALWAYS",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "telepathic_mind_sense", "telepathic_mind_sense_knack" },
        stats = true
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_telepath_sense_minds_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_telepath_sense_minds_0_0_detect",
        target_inputs = {
            effects = { "eff_monster_immune_to_telepathy" },
            flags = { "HAS_MIND", "HUMAN", "TEEP_IMMUNE" },
            npc = true,
            species = { "PSI_NULL", "ZOMBIE" }
        },
        descriptions = {
            {
                id = "sense_minds",
                symbol = "?",
                color = "c_white",
                text = content.text("You sense something sapient here.")
            }
        }
    }))

-- mutations/psi_passives.json
ccb.runtime.handler("inline_vision_inline_ench_clair_senses_0_0_range", function(ctx)
    return (2 + (0.075 * ctx.character_inputs.spell_school_level_sums["CLAIRSENTIENT"]))
end)

ccb.runtime.handler("inline_vision_inline_ench_clair_senses_0_0_detect", function(ctx)
    return (not (ctx.character_inputs.character_flags["NO_PSIONICS"]) and
        (ctx.target_inputs.species["HORROR"] or
        ctx.target_inputs.species["NETHER"] or
        ctx.target_inputs.species["nether_player_hate"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_CLAIR_SENSES_0",
    load_character_inputs = {
        character_flags = { "NO_PSIONICS" },
        spell_school_level_sums = { "CLAIRSENTIENT" }
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_clair_senses_0_0_range",
        condition_handler = "inline_vision_inline_ench_clair_senses_0_0_detect",
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
