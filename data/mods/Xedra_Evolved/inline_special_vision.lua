local ccb = require("ccb")
local content = ccb.content

local progression = require("enchantment_progression")

-- effects/effects.json
ccb.runtime.handler("inline_vision_inline_ench_effect_ierde_sense_nearby_monsters_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.strength + ctx.character_inputs.stats.perception)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ierde_sense_nearby_monsters_0",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_ierde_sense_nearby_monsters_0_0_range",
        descriptions = {
            {
                id = "moving_creature",
                symbol = "?",
                color = "c_white",
                text = content.text("You sense something moving here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_effect_paraclesian_see_fae_0_0_range", function(ctx)
    return ((ctx.character_inputs.stats.perception * 1.5) * progression.post_threshold_bonus(ctx, 1))
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_paraclesian_see_fae_0_0_detect", function(ctx)
    return (ctx.target_inputs.flags["FAE_CREATURE"] or
        ctx.target_inputs.flags["FAERIECREATURE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_paraclesian_see_fae_0",
    load_character_inputs = {
        stats = true,
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
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_paraclesian_see_fae_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_paraclesian_see_fae_0_0_detect",
        target_inputs = {
            flags = { "FAERIECREATURE", "FAE_CREATURE" }
        },
        descriptions = {
            { id = "fae_sense", text = content.text("You sense fae here.") }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_effect_sense_vampire_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 2)
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_sense_vampire_0_0_detect", function(ctx)
    return ((ctx.target_inputs.traits["VAMPIRE"] or ctx.target_inputs.traits["VAMPIRE2"] or ctx.target_inputs.traits["VAMPIRE3"] or ctx.target_inputs.traits["VAMPIRE4"] or ctx.target_inputs.traits["BLOOD_DRINKER"]) or
        ctx.target_inputs.species["VAMPIRE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_sense_vampire_0",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        precise = true,
        ignores_aiming_cone = true,
        distance_handler = "inline_vision_inline_ench_effect_sense_vampire_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_sense_vampire_0_0_detect",
        target_inputs = {
            species = { "VAMPIRE" },
            traits = { "BLOOD_DRINKER", "VAMPIRE", "VAMPIRE2", "VAMPIRE3", "VAMPIRE4" }
        },
        descriptions = {
            {
                id = "vamnpire_sense",
                symbol = "V",
                color = "red",
                text = content.text("You detect a vampire here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_effect_hedge_nether_eye_paste_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["HORROR"] or
        ctx.target_inputs.species["NETHER"] or
        ctx.target_inputs.species["nether_player_hate"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_hedge_nether_eye_paste_0",
    native_modifier_order = true,
}
    :vision({
        distance = 40,
        condition_handler = "inline_vision_inline_ench_effect_hedge_nether_eye_paste_0_0_detect",
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

-- effects/effects_changeling_seasonal_magic.json
ccb.runtime.handler("inline_vision_inline_ench_effect_changeling_autumn_detect_magic_user_0_0_range", function(ctx)
    return math.min(((3 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_AUTUMN"] * 0.2)) + (ctx.character_inputs.skills["gramarye"] * 0.5)), 25)
end)

ccb.runtime.handler("inline_vision_inline_ench_effect_changeling_autumn_detect_magic_user_0_0_detect", function(ctx)
    return (ctx.target_inputs.flags["MAGIC_USER"] or
        (ctx.target_inputs.character and
        (ctx.target_inputs.spell_count >= 6)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_autumn_detect_magic_user_0",
    load_character_inputs = {
        skills = { "gramarye" },
        spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_AUTUMN" }
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_effect_changeling_autumn_detect_magic_user_0_0_range",
        condition_handler = "inline_vision_inline_ench_effect_changeling_autumn_detect_magic_user_0_0_detect",
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
                text = content.text("You sense a sorcerer here.")
            }
        }
    }))

-- mutations/mutations.json
ccb.runtime.handler("inline_vision_inline_ench_dhampir_detect_vampires_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 1.5)
end)

ccb.runtime.handler("inline_vision_inline_ench_dhampir_detect_vampires_0_0_detect", function(ctx)
    return ctx.target_inputs.species["RENFIELD"]
end)

ccb.runtime.handler("inline_vision_inline_ench_dhampir_detect_vampires_0_1_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 1.5)
end)

ccb.runtime.handler("inline_vision_inline_ench_dhampir_detect_vampires_0_1_detect", function(ctx)
    return ((ctx.target_inputs.traits["VAMPIRE"] or ctx.target_inputs.traits["VAMPIRE2"] or ctx.target_inputs.traits["VAMPIRE3"] or ctx.target_inputs.traits["VAMPIRE4"] or ctx.target_inputs.traits["BLOOD_DRINKER"]) or
        ctx.target_inputs.species["VAMPIRE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_DETECT_VAMPIRES_0", condition = "ACTIVE",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_dhampir_detect_vampires_0_0_range",
        condition_handler = "inline_vision_inline_ench_dhampir_detect_vampires_0_0_detect",
        target_inputs = {
            species = { "RENFIELD" }
        },
        descriptions = {
            {
                id = "vampire_sense",
                symbol = "R",
                color = "red",
                text = content.text("You sense one of the vampires' servants here.")
            }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_dhampir_detect_vampires_0_1_range",
        condition_handler = "inline_vision_inline_ench_dhampir_detect_vampires_0_1_detect",
        target_inputs = {
            species = { "VAMPIRE" },
            traits = { "BLOOD_DRINKER", "VAMPIRE", "VAMPIRE2", "VAMPIRE3", "VAMPIRE4" }
        },
        descriptions = {
            {
                id = "vampire_sense",
                symbol = "V",
                color = "red",
                text = content.text("You sense a vampire here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_vampire_heightened_senses_2_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 2)
end)

ccb.runtime.handler("inline_vision_inline_ench_vampire_heightened_senses_2_0_detect", function(ctx)
    return ((progression.vampire_tier_three(ctx) >= 1) and
        (ctx.character_inputs.stats.perception >= 16) and
        (ctx.target_inputs.effects["bleed"] or
        (ctx.target_inputs.character and
        (ctx.target_inputs.body_part_effects["head"]["bleed"] or
        ctx.target_inputs.body_part_effects["torso"]["bleed"] or
        ctx.target_inputs.body_part_effects["arm_l"]["bleed"] or
        ctx.target_inputs.body_part_effects["arm_r"]["bleed"] or
        ctx.target_inputs.body_part_effects["leg_l"]["bleed"] or
        ctx.target_inputs.body_part_effects["leg_r"]["bleed"]))))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_HEIGHTENED_SENSES_2",
    load_character_inputs = {
        stats = true,
        traits = {
            "BLOODHASTE",
            "DHAMPIR_AVOID_EAT_SLEEP_DRINK",
            "DHAMPIR_MEND_WOUNDS_FASTER",
            "DHAMPIR_REDUCED_PAIN",
            "HYPNOTIC_GAZE",
            "MAGICFORBLOOD",
            "VAMPIRE_BIG_STOMACH",
            "VAMPIRE_BONUS_HP",
            "VAMPIRE_CARDIO_BONUS",
            "VAMPIRE_COMMAND_BEAST",
            "VAMPIRE_DETECT_VAMPIRES",
            "VAMPIRE_EARTH_SLUMBER",
            "VAMPIRE_INSTANT_BLEED",
            "VAMPIRE_MOTION_ALARM",
            "VAMPIRE_STORE_MORE_BLOOD"
        }
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_vampire_heightened_senses_2_0_range",
        condition_handler = "inline_vision_inline_ench_vampire_heightened_senses_2_0_detect",
        target_inputs = {
            body_part_effects = {
                arm_l = { "bleed" },
                arm_r = { "bleed" },
                head = { "bleed" },
                leg_l = { "bleed" },
                leg_r = { "bleed" },
                torso = { "bleed" }
            },
            character = true,
            effects = { "bleed" }
        },
        descriptions = {
            {
                id = "infrared_creature_medium",
                symbol = "?",
                color = "c_red",
                text = content.text("You can smell something bleeding here.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_vampire_sense_children_of_the_night_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 3)
end)

ccb.runtime.handler("inline_vision_inline_ench_vampire_sense_children_of_the_night_0_0_detect", function(ctx)
    return ctx.target_inputs.species["NIGHT_CREATURE"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT_0", condition = "ACTIVE",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        ignores_aiming_cone = true,
        distance_handler = "inline_vision_inline_ench_vampire_sense_children_of_the_night_0_0_range",
        condition_handler = "inline_vision_inline_ench_vampire_sense_children_of_the_night_0_0_detect",
        target_inputs = {
            species = { "NIGHT_CREATURE" }
        },
        descriptions = {
            {
                id = "night_creature_sense",
                symbol = "N",
                color = "white",
                text = content.text("You sense one of the creatures of the night.")
            }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_vampire_detect_vampires_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 3)
end)

ccb.runtime.handler("inline_vision_inline_ench_vampire_detect_vampires_0_0_detect", function(ctx)
    return ((ctx.target_inputs.traits["VAMPIRE"] or ctx.target_inputs.traits["VAMPIRE2"] or ctx.target_inputs.traits["VAMPIRE3"] or ctx.target_inputs.traits["VAMPIRE4"] or ctx.target_inputs.traits["BLOOD_DRINKER"]) or
        ctx.target_inputs.species["VAMPIRE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_DETECT_VAMPIRES_0",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        precise = true,
        ignores_aiming_cone = true,
        distance_handler = "inline_vision_inline_ench_vampire_detect_vampires_0_0_range",
        condition_handler = "inline_vision_inline_ench_vampire_detect_vampires_0_0_detect",
        target_inputs = {
            species = { "VAMPIRE" },
            traits = { "BLOOD_DRINKER", "VAMPIRE", "VAMPIRE2", "VAMPIRE3", "VAMPIRE4" }
        },
        descriptions = {
            {
                id = "vampire_sense",
                symbol = "V",
                color = "red",
                text = content.text("You detect a vampire here.")
            }
        }
    }))

-- mutations/paraclesians/homullus_mutations.json
ccb.runtime.handler("inline_vision_inline_ench_sense_the_toolmakers_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception * 1.5)
end)

ccb.runtime.handler("inline_vision_inline_ench_sense_the_toolmakers_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["HUMAN"] or
        ctx.target_inputs.species["FERAL"] or
        ctx.target_inputs.species["RENFIELD"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_SENSE_THE_TOOLMAKERS_0", condition = "ACTIVE",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_sense_the_toolmakers_0_0_range",
        condition_handler = "inline_vision_inline_ench_sense_the_toolmakers_0_0_detect",
        target_inputs = {
            species = { "FERAL", "HUMAN", "RENFIELD" }
        },
        descriptions = {
            {
                id = "human_sense",
                symbol = "@",
                color = "c_white",
                text = content.text("You sense a human here.")
            }
        }
    }))

-- mutations/playable_changeling.json
ccb.runtime.handler("inline_vision_inline_ench_brownie_sense_intruders_0_0_range", function(ctx)
    return (ctx.character_inputs.stats.perception + ctx.character_inputs.character_variables["brownie_homebody_speed_bonus"])
end)

ccb.runtime.handler("inline_vision_inline_ench_brownie_sense_intruders_0_active", function(ctx)
    return (not (ctx.character_inputs.environment.outside) and
        (ctx.character_inputs.character_variables["brownie_sense_intruders"] ~= 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BROWNIE_SENSE_INTRUDERS_0",
    condition_handler = "inline_vision_inline_ench_brownie_sense_intruders_0_active",
    load_character_inputs = {
        character_variables = { "brownie_homebody_speed_bonus", "brownie_sense_intruders" },
        environment = { outside = true },
        stats = true
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_brownie_sense_intruders_0_0_range",
        descriptions = {
            { id = "moving_creature", symbol = "?", color = "c_white", text = content.text("Intruder!") }
        }
    }))

-- mutations/revenant.json
ccb.runtime.handler("inline_vision_inline_ench_xe_revenant_traits_0_0_detect", function(ctx)
    return ctx.target_inputs.traits["XE_REVENANT_SENSING_TRAIT"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_XE_REVENANT_TRAITS_0",
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add = 9999 })
    :value("KCAL", { multiply = -100 })
    :value("VITAMIN_ABSORB_MOD", { multiply = -100 })
    :value("HUNGER", { multiply = -1 })
    :value("THIRST", { multiply = -1 })
    :value("SLEEPINESS", { multiply = -1 })
    :value("METABOLISM", { multiply = -1 })
    :value("CARDIO_MULTIPLIER", { multiply = 4 })
    :value("DISINFECTANT_BONUS", { multiply = -1 })
    :value("BANDAGE_BONUS", { multiply = -1 })
    :value("NIGHT_VIS", { add = 8 })
    :incoming_damage("bash", { add = -5, multiply = -0.5 })
    :incoming_damage("stab", { add = -3, multiply = -0.3333 })
    :incoming_damage("cut", { add = -3, multiply = -0.3333 })
    :incoming_damage("bullet", { multiply = -0.3333 })
    :incoming_damage("electric", { add = -2, multiply = -0.8 })
    :effect("effect_lilin_vampire_immune", 1)
    :vision({
        distance = 60,
        condition_handler = "inline_vision_inline_ench_xe_revenant_traits_0_0_detect",
        target_inputs = {
            traits = { "XE_REVENANT_SENSING_TRAIT" }
        },
        descriptions = {
            {
                id = "vampire_sense",
                symbol = "@",
                color = "c_white",
                text = content.text("You sense the target of your vengeance here.")
            }
        }
    }))

-- mutations/werewolf_traits.json
ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_0_range", function(ctx)
    return (((2 + ((ctx.character_inputs.traits["WEREWOLF_HYBRID_FORM_TRAITS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] and 1 or 0) * 4)) + ((ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] and 1 or 0) * 4))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_0_detect", function(ctx)
    return (ctx.target_inputs.npc or
        (ctx.target_inputs.species["FERAL"] and
        not (ctx.target_inputs.species["ZOMBIE"])))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_1_range", function(ctx)
    return ((2 + ((ctx.character_inputs.traits["WEREWOLF_HYBRID_FORM_TRAITS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] and 1 or 0) * 4))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_1_detect", function(ctx)
    return ctx.target_inputs.species["ZOMBIE"]
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_2_range", function(ctx)
    return ((2 + ((ctx.character_inputs.traits["WEREWOLF_HYBRID_FORM_TRAITS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] and 1 or 0) * 4))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_2_detect", function(ctx)
    return (not (ctx.target_inputs.species["ZOMBIE"]) and
        (ctx.target_inputs.species["MAMMAL"] or
        ctx.target_inputs.species["BIRD"] or
        ctx.target_inputs.species["REPTILE"] or
        ctx.target_inputs.species["AMPHIBIAN"] or
        ctx.target_inputs.species["MAMMAL"]))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_3_range", function(ctx)
    return ((2 + ((ctx.character_inputs.traits["WEREWOLF_HYBRID_FORM_TRAITS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] and 1 or 0) * 4))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_3_detect", function(ctx)
    return (not (ctx.target_inputs.species["ZOMBIE"]) and
        (ctx.target_inputs.species["INSECT"] or
        ctx.target_inputs.species["INSECT_FLYING"] or
        ctx.target_inputs.species["SPIDER"] or
        ctx.target_inputs.species["CENTIPEDE"]))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_4_range", function(ctx)
    return ((2 + ((ctx.character_inputs.traits["WEREWOLF_HYBRID_FORM_TRAITS"] and 1 or 0) * 2)) + ((ctx.character_inputs.traits["VAMPIRE_WOLF_FORM_TRAITS"] and 1 or 0) * 4))
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_4_detect", function(ctx)
    return ctx.target_inputs.species["MIGO"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_SMELL_NEARBY_ENEMIES_0", condition = "ALWAYS",
    load_character_inputs = { traits = { "VAMPIRE_WOLF_FORM_TRAITS", "WEREWOLF_HYBRID_FORM_TRAITS" } },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_0_range",
        condition_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_0_detect",
        target_inputs = {
            npc = true,
            species = { "FERAL", "ZOMBIE" }
        },
        descriptions = {
            { id = "moving_creature", text = content.text("You smell the scent of a human.") }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_1_range",
        condition_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_1_detect",
        target_inputs = {
            species = { "ZOMBIE" }
        },
        descriptions = {
            { id = "moving_creature", text = content.text("You smell something long-dead.") }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_2_range",
        condition_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_2_detect",
        target_inputs = {
            species = { "AMPHIBIAN", "BIRD", "MAMMAL", "REPTILE", "ZOMBIE" }
        },
        descriptions = {
            { id = "moving_creature", text = content.text("You smell a wild animal.") }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_3_range",
        condition_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_3_detect",
        target_inputs = {
            species = { "CENTIPEDE", "INSECT", "INSECT_FLYING", "SPIDER", "ZOMBIE" }
        },
        descriptions = {
            { id = "moving_creature", text = content.text("You smell the dull smell of a mutated bug.") }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_4_range",
        condition_handler = "inline_vision_inline_ench_werewolf_smell_nearby_enemies_0_4_detect",
        target_inputs = {
            species = { "MIGO" }
        },
        descriptions = {
            { id = "moving_creature", text = content.text("You smell something strange.") }
        }
    }))

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_0_range", function(ctx)
    return math.min((((10 + (progression.werewolf_tier_three(ctx) * 0.2)) + (progression.werewolf_tier_four(ctx) * 0.3)) + (progression.werewolf_tier_five(ctx) * 0.4)), 35)
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_0_detect", function(ctx)
    return (ctx.target_inputs.species["ARVORE"] or
        ctx.target_inputs.species["CHANGELING"] or
        ctx.target_inputs.species["CHANGELING_NOBLE"] or
        ctx.target_inputs.species["IERDE"] or
        ctx.target_inputs.species["HOMULLUS"] or
        ctx.target_inputs.species["SALAMANDER"] or
        ctx.target_inputs.species["SYLPH"] or
        ctx.target_inputs.species["UNDINE"])
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_1_range", function(ctx)
    return math.min((((10 + (progression.werewolf_tier_three(ctx) * 0.2)) + (progression.werewolf_tier_four(ctx) * 0.3)) + (progression.werewolf_tier_five(ctx) * 0.4)), 35)
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_1_detect", function(ctx)
    return (ctx.target_inputs.species["PLANT"] or
        ctx.target_inputs.species["MIGO"] or
        ctx.target_inputs.species["FUNGUS"])
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_2_range", function(ctx)
    return math.min((((10 + (progression.werewolf_tier_three(ctx) * 0.3)) + (progression.werewolf_tier_four(ctx) * 0.45)) + (progression.werewolf_tier_five(ctx) * 0.6)), 50)
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_2_detect", function(ctx)
    return (ctx.target_inputs.species["NETHER"] or
        ctx.target_inputs.species["nether_player_hate"] or
        ctx.target_inputs.species["HORROR"] or
        ctx.target_inputs.species["ABOMINATION"])
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_3_range", function(ctx)
    return math.min((((10 + (progression.werewolf_tier_three(ctx) * 0.3)) + (progression.werewolf_tier_four(ctx) * 0.45)) + (progression.werewolf_tier_five(ctx) * 0.6)), 50)
end)

ccb.runtime.handler("inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_3_detect", function(ctx)
    return (ctx.target_inputs.species["VAMPIRE"] or
        ctx.target_inputs.species["RENFIELD"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_SENSE_SPIRITS_AND_ALIENS_ACTIVE_0", condition = "ALWAYS",
    load_character_inputs = {
        traits = {
            "WEREWOLF_BATTLE_FURY",
            "WEREWOLF_CLOSE_TEAR_IN_REALITY",
            "WEREWOLF_MANA_BONUS_AFTER_KILL",
            "WEREWOLF_MOON_ARMOR",
            "WEREWOLF_PARTIAL_SHIFT",
            "WEREWOLF_SILVER_CLAWS",
            "WEREWOLF_STRENGTH_BONUS",
            "WEREWOLF_SUMMON_FOG",
            "WEREWOLF_SUMMON_SHADOW_PACK",
            "WEREWOLF_SUPER_FAST_REGENERATION",
            "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
            "WEREWOLF_WALK_THROUGH_WALLS"
        }
    },
    native_modifier_order = true,
}
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_0_range",
        condition_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_0_detect",
        target_inputs = {
            species = {
                "ARVORE",
                "CHANGELING",
                "CHANGELING_NOBLE",
                "HOMULLUS",
                "IERDE",
                "SALAMANDER",
                "SYLPH",
                "UNDINE"
            }
        },
        descriptions = {
            { id = "fae_sense", text = content.text("You sense a creature of Faerie.") }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_1_range",
        condition_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_1_detect",
        target_inputs = {
            species = { "FUNGUS", "MIGO", "PLANT" }
        },
        descriptions = {
            { id = "alien_being_sense", text = content.text("You sense an alien being.") }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_2_range",
        condition_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_2_detect",
        target_inputs = {
            species = { "ABOMINATION", "HORROR", "NETHER", "nether_player_hate" }
        },
        descriptions = {
            { id = "nether_creature_sense", text = content.text("You sense an otherworldly horror.") }
        }
    })
    :vision({
        distance_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_3_range",
        condition_handler = "inline_vision_inline_ench_werewolf_sense_spirits_and_aliens_active_0_3_detect",
        target_inputs = {
            species = { "RENFIELD", "VAMPIRE" }
        },
        descriptions = {
            {
                id = "vampire_sense",
                text = content.text("You sense one of the blood-drinkers or their minions.")
            }
        }
    }))
