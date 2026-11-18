local ccb = require("ccb")
local content = ccb.content

-- Hidden effect, used to prevent the initial use of a glamour that's not supposed to be used with other glamours from removing itself
content.add(content.EffectType {
    id = "effect_changeling_using_glamour_removes_checker",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_changeling_gain_dreamdross_from_dreams",
    name = ccb.content.text("Harvested Dreams"),
    description = ccb.content.text("Your dreams were harvested by a changeling for dreamdross, and cannot be harvested for a time after."),
    rating = "mixed",
}
    :enchantment("INLINE_ENCH_effect_changeling_gain_dreamdross_from_dreams_0"))

-- Hidden effect, used to determine if a mutation is active
content.add(content.EffectType {
    id = "effect_changeling_active_banquet_of_dreams",
    name = "",
    description = "",
})

-- Hidden effect, used if a target has had empowered Banquet of Dreams used on them
content.add(content.EffectType {
    id = "effect_changeling_banquet_of_dreams_damage",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_changeling_stop_nether_conditions",
    name = ccb.content.text("Dancer in the Endless Dark"),
    description = ccb.content.text("You are immune to several deleterious otherworldly conditions."),
    remove_message = ccb.content.text("Your protection against otherworldly threats fades away."),
    rating = "good",
}
    :flag("IMPERIAL_ROAD_TRAVELER")
    :blocks_effect("taint")
    :blocks_effect("tindrift")
    :blocks_effect("darkness")
    :blocks_effect("amigara")
    :blocks_effect("teleglow")
    :blocks_effect("attention")
    :blocks_effect("evil"))

content.add(content.EffectType {
    id = "effect_changeling_spring_reduce_scent",
    name = ccb.content.text("Scent of Fresh Flowers"),
    description = ccb.content.text("A sweet scent fills the air."),
    remove_message = ccb.content.text("The scent of flowers fades away."),
}
    :enchantment("INLINE_ENCH_effect_changeling_spring_reduce_scent_0"))

content.add(content.EffectType {
    id = "effect_changeling_spring_prevent_bad_conditions",
    name = ccb.content.text("Spring Cleansing"),
    description = ccb.content.text("You feel like you've just come outside after a long winter."),
    apply_message = ccb.content.text("You feel refreshed."),
    remove_message = ccb.content.text("The refreshing feeling fades away."),
    maximum_duration_turns = 43200,
}
    :removes_effect("poison")
    :removes_effect("badpoison")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_effect("venom_blind")
    :removes_effect("venom_pain")
    :removes_effect("paralyzepoison")
    :removes_effect("pre_common_cold")
    :removes_effect("common_cold")
    :removes_effect("pre_flu")
    :removes_effect("flu"))

content.add(content.EffectType {
    id = "effect_changeling_spring_protective_plant_armor",
    name = ccb.content.text("Viridian Cuirass"),
    description = ccb.content.text("You are covered in a set of living bark armor."),
    apply_message = ccb.content.text("Bark and leaves quickly grow over your skin."),
    remove_message = ccb.content.text("The bark armor cracks and falls away."),
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_spring_protective_plant_armor_0")
    :enchantment("INLINE_ENCH_effect_changeling_spring_protective_plant_armor_1"))

content.add(content.EffectType {
    id = "effect_changeling_spring_enchanted_butterfly_wings",
    name = ccb.content.text("Wings of Gossamer"),
    description = ccb.content.text("You have a pair of gossamer wings sprouting from your back."),
    apply_message = ccb.content.text("A pair of coruscating gossamer wings sprout from your back!"),
    remove_message = ccb.content.text("Your gossamer wings turn to flower petals and blow away."),
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_spring_enchanted_butterfly_wings_0")
    :enchantment("INLINE_ENCH_effect_changeling_spring_enchanted_butterfly_wings_1"))

content.add(content.EffectType {
    id = "effect_changeling_spring_healing_increase_while_outside",
    name = ccb.content.text("New Growth"),
    description = ccb.content.text("You are drawing on the energy of life to increase your healing rate."),
    apply_message = "",
    remove_message = ccb.content.text("The warmth fades away."),
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_spring_healing_increase_while_outside_0")
    :enchantment("INLINE_ENCH_effect_changeling_spring_healing_increase_while_outside_1"))

-- Once permanent damage is possible, this glamour should let you recover from it.
content.add(content.EffectType {
    id = "effect_changeling_spring_turn_target_into_tree",
    name = ccb.content.text("Branch of Yggdrasil"),
    description = ccb.content.text("You are in the form of a tree."),
}
    :flag("DEAF")
    :flag("BLIND")
    :flag("SEESLEEP")
    :flag("NO_SCENT")
    :flag("NO_SPELLCASTING")
    :flag("NO_FEY_MAGIC")
    :flag("IMMUNE_HEARING_DAMAGE")
    :flag("CANNOT_MOVE")
    :flag("CANNOT_ATTACK")
    :flag("SUFFOCATION_IMMUNE")
    :flag("CANNOT_CONSUME_DRUGS")
    :flag("PAUSE_INFECTIONS")
    :flag("CANOT_GAIN_WEARINESS")
    :enchantment("INLINE_ENCH_effect_changeling_spring_turn_target_into_tree_0"))

-- Used to de-tree the target when they're healed
content.add(content.EffectType {
    id = "effect_changeling_spring_turn_target_into_tracker",
    name = "",
    description = "",
    maximum_intensity = 300,
    intensity_add_value = 1,
})

-- Used to remain as a tree to heal esoteric conditions
content.add(content.EffectType {
    id = "effect_changeling_spring_turn_target_one_more_day",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_changeling_spring_charm_control_target",
    name = ccb.content.text("Ishtar's Folly"),
    description = ccb.content.text("Your devotion is stronger than adamant."),
    maximum_duration_turns = 3600,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_changeling_spring_charm_control_target_0"))

content.add(content.EffectType {
    id = "effect_changeling_summer_light",
    name = ccb.content.text("Bonefire's Light"),
    description = ccb.content.text("A wisp of flickering insubstantial fire hovers near your shoulder."),
    apply_message = "",
    remove_message = ccb.content.text("The wisp winks out."),
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_light_0"))

content.add(content.EffectType {
    id = "effect_changeling_summer_sun_glasses",
    name = ccb.content.text("Shading Your Eyes"),
    description = ccb.content.text("Nearby lights don't seem quite as bright now."),
    apply_message = "",
    remove_message = ccb.content.text("You blink as nearby lights grow brighter."),
    maximum_duration_turns = 43200,
}
    :flag("GLARE_RESIST"))

content.add(content.EffectType {
    id = "effect_changeling_summer_protect_from_hot_weather",
    name = ccb.content.text("Gift of Warm Blood"),
    description = ccb.content.text("The essence of summer protects you from excessive heat."),
    apply_message = "",
    remove_message = ccb.content.text("Your blood loses its glamoured warmth."),
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_protect_from_hot_weather_0")
    :enchantment("INLINE_ENCH_effect_changeling_summer_protect_from_hot_weather_1"))

content.add(content.EffectType {
    id = "effect_changeling_fire_melee_damage",
    name = ccb.content.text("Burning Solar Grasp"),
    description = ccb.content.text("Ethereal flames flicker around your hands"),
    apply_message = "",
    remove_message = ccb.content.text("The flames gutter out."),
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_fire_melee_damage_0")
    :enchantment("INLINE_ENCH_effect_changeling_fire_melee_damage_1")
    :enchantment("INLINE_ENCH_effect_changeling_fire_melee_damage_2"))

content.add(content.EffectType {
    id = "effect_changeling_summer_absorb_strength",
    name = ccb.content.text("Hand of Lugh"),
    description = ccb.content.text("Your strength has been absorbed."),
    show_in_info = true,
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_absorb_strength_0")
    :enchantment("INLINE_ENCH_effect_changeling_summer_absorb_strength_1"))

content.add(content.EffectType {
    id = "effect_changeling_summer_absorb_strength_self",
    name = ccb.content.text("Hand of Lugh"),
    description = ccb.content.text("Your strength is empowered by that of your enemies."),
    remove_message = ccb.content.text("Your borrowed strength drains away."),
    show_in_info = true,
    rating = "good",
    maximum_duration_turns = 7200,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_changeling_summer_absorb_strength_self_0")
    :limb_score("lift", { multiplier = 1.1 })
    :limb_score("block", { multiplier = 1.1 })
    :limb_score("grip", { multiplier = 1.1 }))

content.add(content.EffectType {
    id = "effect_changeling_summer_slow_and_sweat_debuff",
    name = ccb.content.text("Sun-struck"),
    description = ccb.content.text("You need to sit down in the shade."),
    show_in_info = true,
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_slow_and_sweat_debuff_0")
    :enchantment("INLINE_ENCH_effect_changeling_summer_slow_and_sweat_debuff_1"))

content.add(content.EffectType {
    id = "effect_changeling_summer_run_for_long_periods",
    name = ccb.content.text("Outracing the Sun"),
    description = ccb.content.text("You are filled with burning energy."),
    apply_message = ccb.content.text("You are filled with burning energy."),
    remove_message = ccb.content.text("The burning energy filling your muscles dissipates."),
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_run_for_long_periods_0"))

content.add(content.EffectType {
    id = "effect_changeling_summer_bonus_stamina_near_enemies",
    name = ccb.content.text("A Fire in the Blood"),
    description = ccb.content.text("The light of the summer sun gives you strength to fight."),
    apply_message = ccb.content.text("You're fired up and ready for battle."),
    remove_message = ccb.content.text("The energy of the sun leaves you."),
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_bonus_stamina_near_enemies_0"))

content.add(content.EffectType {
    id = "effect_changeling_summer_stay_awake_in_sunlight",
    name = ccb.content.text("Invigorating Sunlight"),
    description = ccb.content.text("The warmth and energy of the sun washes your tiredness away."),
    remove_message = ccb.content.text("The sensation of the sun's warmth fades away."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_stay_awake_in_sunlight_0"))

content.add(content.EffectType {
    id = "effect_changeling_summer_ring_of_flames",
    name = ccb.content.text("Summer Champion"),
    description = ccb.content.text("You stand in the ring of flames, facing your foe.  Woe to the vanquished."),
    rating = "good",
}
    :blocks_effect("blisters")
    :enchantment("INLINE_ENCH_effect_changeling_summer_ring_of_flames_0"))

-- Limiter so the avatar_moves EoC for Ring of Champions doesn't immediately break due to removal of fields taking 1 round to occur
content.add(content.EffectType {
    id = "effect_changeling_summer_ring_of_flames_limiter",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_changeling_summer_ring_of_flames_enemy",
    name = ccb.content.text("Enemy Champion"),
    description = ccb.content.text("You are the target of Ring of Champions.  Your death will end the glamour."),
    rating = "good",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_changeling_summer_combat_prowess_powerful_buff",
    name = ccb.content.text("Ríastrad"),
    description = ccb.content.text("Your foes shall fall."),
    remove_message = ccb.content.text("Your body twist back into place as the Ríastrad fades from you."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_combat_prowess_powerful_buff_0"))

content.add(content.EffectType {
    id = "effect_changeling_summer_powerful_sunlight",
    name = ccb.content.text("Helios's Wrath"),
    description = ccb.content.text("You blaze with the pure light of the summer sun."),
    apply_message = "",
    remove_message = ccb.content.text("The blinding light fades away."),
    show_in_info = true,
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_summer_powerful_sunlight_0"))

content.add(content.EffectType {
    id = "effect_changeling_autumn_detect_magic_user",
    name = ccb.content.text("Witch's Warning"),
    description = ccb.content.text("You can sense nearby uses of magick."),
    apply_message = "",
    remove_message = ccb.content.text("Your awareness of sorcerers fades away."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_changeling_autumn_detect_magic_user_0"))

content.add(content.EffectType {
    id = "effect_changeling_autumn_touch_of_frailty_character",
    name = ccb.content.text("Touch of Frailty"),
    description = ccb.content.text("A glamour is prematurely aging you."),
    apply_message = "",
    remove_message = ccb.content.text("Your vigor returns."),
    show_in_info = true,
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_autumn_touch_of_frailty_character_0"))

content.add(content.EffectType {
    id = "effect_changeling_autumn_touch_of_frailty_monster",
    name = ccb.content.text("Touch of Frailty"),
    description = ccb.content.text("A glamour is prematurely aging you."),
    apply_message = "",
    remove_message = ccb.content.text("Your vigor returns."),
    show_in_info = true,
    maximum_duration_turns = 43200,
}
    :modifier("hit", "amount", { base = -1 })
    :modifier("dodge", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -5 }))

-- Tracker to prevent spell from being re-used back to back
content.add(content.EffectType {
    id = "effect_changeling_autumn_scare_animals",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_changeling_autumn_scare_humans",
    name = ccb.content.text("Scarecrow's Mien"),
    description = ccb.content.text("Now they shall know fear."),
    remove_message = ccb.content.text("The terrifying illusions fade away."),
}
    :enchantment("INLINE_ENCH_effect_changeling_autumn_scare_humans_0"))

content.add(content.EffectType {
    id = "effect_changeling_autumn_protection_from_ranged",
    name = ccb.content.text("Swirl of Autumn Leaves"),
    description = ccb.content.text("A chill wind is whirling around you."),
    apply_message = "",
    remove_message = ccb.content.text("The autumn leaves fall to the ground."),
    show_in_info = true,
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_autumn_protection_from_ranged_0")
    :enchantment("INLINE_ENCH_effect_changeling_autumn_protection_from_ranged_1"))

content.add(content.EffectType {
    id = "effect_changeling_autumn_stop_supernatural_healing",
    name = ccb.content.text("Malediction of the Recalcitrant Wound"),
    description = ccb.content.text("Your skin itches."),
    remove_message = ccb.content.text("The itching of your skin fades."),
    show_in_info = true,
}
    :flag("BLOCK_SUPERNATURAL_HEALING")
    :enchantment("INLINE_ENCH_effect_changeling_autumn_stop_supernatural_healing_0"))

content.add(content.EffectType {
    id = "effect_changeling_autumn_freeze_in_place_target",
    name = ccb.content.text("Baleful Gaze"),
    description = ccb.content.text("You cannot move!"),
    remove_message = ccb.content.text("You can move again."),
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE"))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_changeling_autumn_freeze_in_place_self",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_changeling_autumn_wither_with_time_character",
    name = ccb.content.text("Time Fells the Mightiest Warrior"),
    description = ccb.content.text("A glamour has reduced your martial skill to almost nothing."),
    apply_message = "",
    remove_message = ccb.content.text("Your vigor returns."),
    show_in_info = true,
    maximum_duration_turns = 43200,
}
    :enchantment("INLINE_ENCH_effect_changeling_autumn_wither_with_time_character_0"))

content.add(content.EffectType {
    id = "effect_changeling_autumn_wither_with_time_monster",
    name = ccb.content.text("Time Fells the Mightiest Warrior"),
    description = ccb.content.text("A glamour has reduced your martial skill to almost nothing."),
    apply_message = "",
    remove_message = ccb.content.text("Your vigor returns."),
    show_in_info = true,
    maximum_duration_turns = 43200,
}
    :modifier("hit", "amount", { base = -10 })
    :modifier("dodge", "amount", { base = -10 }))

content.add(content.EffectType {
    id = "effect_changeling_winter_freeze_target_in_place_not_winter",
    name = ccb.content.text("Grip of Winter"),
    description = ccb.content.text("Ice coats your lower limbs, freezing you in place."),
    apply_message = "",
    remove_message = ccb.content.text("You can move again."),
    show_in_info = true,
    maximum_duration_turns = 1200,
}
    :flag("CANNOT_MOVE"))

content.add(content.EffectType {
    id = "effect_changeling_winter_freeze_target_in_place_during_winter",
    name = ccb.content.text("Grip of Winter"),
    description = ccb.content.text("Ice coats your lower limbs, freezing you in place."),
    apply_message = "",
    remove_message = ccb.content.text("The chill around your feet fades away."),
    show_in_info = true,
    maximum_duration_turns = 1200,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE"))

content.add(content.EffectType {
    id = "effect_changeling_winter_walk_in_silence",
    name = ccb.content.text("Snow-Fox's Stride"),
    description = ccb.content.text("With a light step, you can walk across even new-fallen snow at full speed."),
    apply_message = "",
    remove_message = ccb.content.text("You sink into the snow with a soft crunch."),
    maximum_duration_turns = 43200,
}
    :flag("SNOWWALKING"))

content.add(content.EffectType {
    id = "effect_changeling_winter_walk_on_water",
    name = ccb.content.text("Path of Rime"),
    description = ccb.content.text("Each step you take leaves a tracing of frost on the ground, and liquids freeze at your touch."),
    apply_message = "",
    remove_message = ccb.content.text("The chill around your feet fades away."),
    maximum_duration_turns = 43200,
}
    :flag("WATERWALKING")
    :flag("ITEM_WATERPROOFING")
    :flag("SLUDGEPROOF"))

content.add(content.EffectType {
    id = "effect_changeling_winter_feign_death",
    name = ccb.content.text("Stillness of the Tomb"),
    description = ccb.content.text("You do not move, or breathe, or think, or live.  For now."),
    apply_message = "",
    remove_message = ccb.content.text("Life returns to your limbs."),
    show_in_info = true,
    maximum_duration_turns = 21600,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_changeling_winter_feign_death_0")
    :limb_score("lift", { multiplier = 0.2 })
    :limb_score("block", { multiplier = 0.0 })
    :limb_score("swim", { multiplier = 0.0 })
    :limb_score("manip", { multiplier = 0.1 })
    :limb_score("grip", { multiplier = 0.1 }))

content.add(content.EffectType {
    id = "effect_changeling_winter_feign_death_limiter",
    name = ccb.content.text("Definitely Alive"),
    description = ccb.content.text("You can fool them once, but you can't fool them twice."),
    maximum_duration_turns = 60,
}
    :blocks_effect("effect_changeling_winter_feign_death"))

content.add(content.EffectType {
    id = "effect_changeling_winter_stop_bleeding",
    name = ccb.content.text("Veins of Ice"),
    description = ccb.content.text("You can fool them once, but you can't fool them twice."),
    apply_message = ccb.content.text("You feel a cold chill in your bones."),
    remove_message = ccb.content.text("The chill in your bones fades away."),
}
    :flag("BLEED_IMMUNE"))

content.add(content.EffectType {
    id = "effect_changeling_winter_silence",
    name = ccb.content.text("Frozen Tongue"),
    description = ccb.content.text("Your tongue feels like solid ice."),
    remove_message = ccb.content.text("The icy feeling on your tongue vanishes."),
    show_in_info = true,
}
    :flag("MUTE"))

content.add(content.EffectType {
    id = "effect_changeling_winter_frozen_breath",
    name = ccb.content.text("Chilled"),
    description = ccb.content.text("Your movements are slowed."),
    apply_message = "",
    remove_message = ccb.content.text("The bone-deep chill fades away."),
    show_in_info = true,
    maximum_duration_turns = 1200,
}
    :enchantment("INLINE_ENCH_effect_changeling_winter_frozen_breath_0")
    :modifier("hit", "amount", { base = -1 }))

content.add(content.EffectType {
    id = "effect_changeling_winter_neutralize_morale",
    name = ccb.content.text("Frozen Heart"),
    description = ccb.content.text("All emotions are frozen out."),
}
    :flag("NUMB")
    :flag("PSYCHOPATH"))

-- flags can't be conditional so here we are
content.add(content.EffectType {
    id = "effect_changeling_winter_see_craft_darkness",
    name = ccb.content.text("By Moon or By Starlight"),
    description = ccb.content.text("You are at home in the dark."),
}
    :enchantment("INLINE_ENCH_effect_changeling_winter_see_craft_darkness_0")
    :enchantment("INLINE_ENCH_effect_changeling_winter_see_craft_darkness_1"))

content.add(content.EffectType {
    id = "effect_changeling_winter_see_craft_darkness_actual",
    name = "",
    description = "",
}
    :flag("CRAFT_IN_DARKNESS")
    :flag("READ_IN_DARKNESS"))

content.add(content.EffectType {
    id = "effect_changeling_winter_cut_off_fey_nature",
    name = ccb.content.text("The Soul of Iron"),
    description = ccb.content.text("Your fey powers are cut off, like they're trapped behind a wall of glass."),
    remove_message = ccb.content.text("The glass wall cutting off your fey powers shatters into glittering shards."),
    rating = "mixed",
}
    :flag("NO_FEY_MAGIC")
    :removes_effect("effect_xe_iron_intolerance_wearing_steel_tier_1")
    :removes_effect("effect_xe_iron_intolerance_wearing_steel_tier_2")
    :removes_effect("effect_xe_iron_intolerance_wearing_steel_tier_3")
    :removes_effect("effect_xe_iron_intolerance_wearing_steel_tier_4")
    :removes_effect("effect_xe_iron_intolerance_wearing_iron_tier_1")
    :removes_effect("effect_xe_iron_intolerance_wearing_iron_tier_2")
    :removes_effect("effect_xe_iron_intolerance_wearing_iron_tier_3")
    :removes_effect("effect_xe_iron_intolerance_wearing_iron_tier_4"))
