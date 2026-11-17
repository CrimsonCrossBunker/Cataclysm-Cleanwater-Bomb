local content = require("ccb").content

-- goblin_fruit_effects.json
content.add(content.Enchantment { id = "ench_goblin_fruit_thorns", has = "HELD", condition = "ALWAYS" }
    :hit_me({ id = "goblin_fruit_aura_thorns", self = false, trigger_once_in = 4 }))

-- armor.json
content.add(content.Enchantment { id = "ench_climate_control_marzanna", has = "WORN", condition = "ALWAYS", name = content.text("Charm of Spring"), description = content.text("You are wearing equipment that helps handle harsh climates and protects from damaging cold.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 20 })
    :incoming_damage("cold", { add = -15 }))

content.add(content.Enchantment { id = "ench_climate_periapta_feline", has = "WORN", condition = "ALWAYS" }
    :mutation("CLAWS_RETRACT"))

content.add(content.Enchantment { id = "ench_climate_periapta_lupine", has = "WORN", condition = "ALWAYS" }
    :mutation("FANGS"))

content.add(content.Enchantment { id = "ench_climate_periapta_cephalopod", has = "WORN", condition = "ALWAYS" }
    :mutation("INK_GLANDS"))

content.add(content.Enchantment { id = "ench_climate_periapta_butterfly", has = "WORN", condition = "ALWAYS" }
    :mutation("WINGS_BUTTERFLY"))

content.add(content.Enchantment { id = "ench_climate_periapta_plant", has = "WORN", condition = "ALWAYS" }
    :mutation("BARK"))

content.add(content.Enchantment { id = "ench_climate_periapta_scorpion", has = "WORN", condition = "ALWAYS" }
    :mutation("TAIL_STING"))

content.add(content.Enchantment { id = "ench_climate_periapta_spider", has = "WORN", condition = "ALWAYS" }
    :mutation("WEB_WALKER"))

content.add(content.Enchantment { id = "BERSERKING" }
    :hit_you({ id = "increase_berserking", self = true, trigger_once_in = 14 }))

content.add(content.Enchantment { id = "ench_verdant_helmet", has = "WORN", condition = "ALWAYS" }
    :effect("effect_enhanced_vision_flag", 1)
    :effect("effect_glare_resist_flag", 1))

content.add(content.Enchantment { id = "ench_verdant_body", has = "WORN", condition = "ALWAYS" }
    :value("REGEN_MANA", { multiply = 0.15 })
    :effect("effect_no_scent_flag", 1))

content.add(content.Enchantment { id = "ench_verdant_gauntlets", has = "WORN", condition = "ALWAYS" }
    :value("CASTING_TIME_MULTIPLIER", { multiply = -0.15 })
    :effect("effect_subtle_spell_flag", 1))

content.add(content.Enchantment { id = "ench_verdant_legs", has = "WORN", condition = "ALWAYS" }
    :value("FOOTSTEP_NOISE", { multiply = -0.6 })
    :effect("effect_steady_flag", 1)
    :effect("effect_sludge_immune_flag", 1))

content.add(content.Enchantment { id = "ench_verdant_boots", has = "WORN", condition = "ALWAYS" }
    :value("REGEN_STAMINA", { multiply = 0.25 }))

content.add(content.Enchantment { id = "ench_verdant_cloak", has = "WORN", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 25 })
    :value("CLIMATE_CONTROL_CHILL", { add = 10 })
    :value("BONUS_DODGE", { add = 1 }))

content.add(content.Enchantment { id = "ench_sevenoclock_coat", has = "WORN" }
    :value("SLEEPY", { add = 9999 }))

-- cbms.json
content.add(content.Enchantment { id = "ENCH_DATA_SHUNT_BP", condition = "ALWAYS" }
    :bodypart_change("data_shunt", ""))

-- misc.json
content.add(content.Enchantment { id = "ench_inventor_gaming_rig", condition = "ACTIVE" }
    :effect("effect_hedge_no_nightmares", 1))

-- spell.json
content.add(content.Enchantment { id = "enchant_selkie_fog_cloak", has = "HELD", emitter = "emit_obscuring_fog", condition = "ALWAYS" })

-- weapon.json
content.add(content.Enchantment { id = "ENCHANTMENT_VAMPIRISM", has = "WIELD" }
    :hit_you({ id = "xedra_weak_healing", self = true, trigger_once_in = 15 }))

-- changeling.json
content.add(content.Enchantment { id = "thunder_rush", condition = "ACTIVE" }
    :value("FOOTSTEP_NOISE", { multiply = 1.5 })
    :value("SPEED", { add = 10 }))

-- arvore_mutation_spells.json
content.add(content.Enchantment { id = "arvore_resist_chill", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 40 }))

content.add(content.Enchantment { id = "arvore_ignore_chill", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 150 }))

content.add(content.Enchantment { id = "ench_arvore_thorns_mut", condition = "ALWAYS" }
    :hit_me({ id = "spell_arvore_thorns_mut_counter", self = false, trigger_once_in = 3 }))

-- ierde_mutation_spells.json
content.add(content.Enchantment { id = "ench_ierde_no_mind_problems", has = "HELD", condition = "ALWAYS" }
    :effect("effect_ierde_no_mind_problems", 1))

content.add(content.Enchantment { id = "ench_ierde_stone_form", has = "HELD", condition = "ALWAYS" }
    :value("ATTACK_SPEED", { multiply = 2 })
    :value("MOVE_COST", { multiply = 1 })
    :value("BONUS_DODGE", { multiply = -1 })
    :value("FOOTSTEP_NOISE", { multiply = 4 })
    :value("WEIGHT", { multiply = 5 })
    :skill("dodge", { multiply = -1 })
    :incoming_damage("bash", { multiply = -0.5 })
    :incoming_damage("cut", { multiply = -0.66 }))

-- salamander_mutation_spells.json
content.add(content.Enchantment { id = "ench_salamander_wings_flame", condition = "ACTIVE" }
    :value("LUMINATION", { add = 150 })
    :bodypart_change("salamander_wing_r", "")
    :bodypart_change("salamander_wing_l", ""))

content.add(content.Enchantment { id = "ench_salamander_reduced_move", condition = "ALWAYS" }
    :value("MOVE_COST", { multiply = -0.1 })
    :value("ATTACK_SPEED", { multiply = -0.1 }))

-- undine_mutation_spells.json
content.add(content.Enchantment { id = "undine_resist_acid", condition = "ALWAYS" }
    :incoming_damage("acid", { multiply = -0.25 }))

content.add(content.Enchantment { id = "undine_resist_fire", condition = "ALWAYS" }
    :incoming_damage("heat", { multiply = -0.5 }))

content.add(content.Enchantment { id = "ench_undine_water_body", has = "HELD", condition = "ALWAYS" }
    :incoming_damage("bash", { multiply = -0.1 })
    :incoming_damage("cut", { multiply = -0.2 })
    :incoming_damage("bullet", { multiply = -0.5 }))

content.add(content.Enchantment { id = "ench_undine_water_form_no_attack", has = "HELD", condition = "ALWAYS" }
    :value("MELEE_DAMAGE", { multiply = -1.0 })
    :value("RANGE", { multiply = -1.0 })
    :value("RANGED_DAMAGE", { multiply = -1.0 }))

content.add(content.Enchantment { id = "ench_undine_water_form_armor", has = "HELD", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = -20 })
    :incoming_damage("bash", { multiply = -0.4 })
    :incoming_damage("stab", { multiply = -0.8 })
    :incoming_damage("cut", { multiply = -0.6 })
    :incoming_damage("bullet", { multiply = -1.0 })
    :incoming_damage("cold", { multiply = 2 }))

-- temporary.json
content.add(content.Enchantment { id = "ench_giant_growth_size_bonuses", condition = "ALWAYS" }
    :value("MAX_HP", { multiply = 0.4 })
    :value("STRENGTH", { add = 6 }))

-- vampire_trait_eocs.json
content.add(content.Enchantment { id = "ench_vampire_no_gorge_issues", has = "HELD", condition = "ALWAYS" }
    :effect("effect_vampire_no_gorge_issues", 1))

-- npc_vampiresacrifice_chat.json
content.add(content.Enchantment { id = "sacrificial_marked", condition = "ALWAYS", name = content.text("Absolute best friend"), description = content.text("This person considers you their absolute best friend, the best person in the entire world.") }
    :hit_me({ id = "sacrificial_marked" }))

-- spells.json
content.add(content.Enchantment { id = "ench_arvore_tree_reduce_thirst", condition = "ALWAYS" }
    :every(180, { id = "arvore_reduce_thirst_spell" }))

-- integrated_armor_spells.json
content.add(content.Enchantment { id = "coal_skin_enchantment", condition = "ALWAYS", name = content.text("Salamander"), description = content.text("Your Fire Elemental abilities grant you good resistance to temperature conditions and heat damage.  Also your body emits streams of heat into anyone who attack you.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 15 })
    :value("CLIMATE_CONTROL_CHILL", { add = 10 })
    :incoming_damage("heat", { multiply = -0.2 })
    :hit_me({ id = "integrated_coal_skin_burnback", trigger_message = content.text("Flames and heat flash out from where you've been hit."), npc_trigger_message = content.text("%1$s's body jets fire and heat out from the wound.") }))

content.add(content.Enchantment { id = "flame_skin_enchantment", condition = "ALWAYS", name = content.text("Salamonstrous"), description = content.text("Your Fire Elemental abilities grant you good resistance to temperature conditions and heat damage.  Also your body emits streams of heat into anyone who attack you.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 45 })
    :value("CLIMATE_CONTROL_CHILL", { add = 10 })
    :incoming_damage("heat", { multiply = -0.5 })
    :hit_me({ id = "integrated_coal_skin_burnback", trigger_message = content.text("Flames and heat flash out from where you've been hit."), npc_trigger_message = content.text("%1$s's body jets fire and heat out from the wound.") }))

content.add(content.Enchantment { id = "cloud_skin_enchantment", condition = "ALWAYS", name = content.text("cloud skin"), description = content.text("Your cloud skin grant you good resistance to temperature conditions.  Also your hands emit a small amount of electricity, increasing your damage in melee.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 })
    :value("CLIMATE_CONTROL_CHILL", { add = 30 })
    :melee_damage("electric", { add = 4 }))

content.add(content.Enchantment { id = "storm_skin_enchantment", condition = "ALWAYS", name = content.text("storm skin"), description = content.text("Your storm skin grant you good resistance to temperature conditions.  Also your hands emit a moderate amount of electricity, increasing your damage in melee.") }
    :value("DEXTERITY", { add = 2 })
    :value("CLIMATE_CONTROL_HEAT", { add = 20 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 })
    :melee_damage("electric", { add = 12 }))

content.add(content.Enchantment { id = "ench_primal_form_protection", condition = "ALWAYS" }
    :incoming_damage("bash", { multiply = -0.25 })
    :incoming_damage("cut", { multiply = -0.1 }))
