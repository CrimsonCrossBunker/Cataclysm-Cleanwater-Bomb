local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_nether_attunement_power_surge",
    name = ccb.content.text("Power Surge"),
    description = ccb.content.text("You are filled with power!"),
    apply_message = "",
    remove_message = "",
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_biokin_physical",
    name = ccb.content.text("Enhanced Prowess"),
    description = ccb.content.text("You are enhancing your physical prowess."),
    apply_message = "",
    remove_message = ccb.content.text("The surge of power fades away."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 100,
}
    :removes_effect("venom_weaken")
    :enchantment("INLINE_ENCH_effect_biokin_physical_0")
    :enchantment("INLINE_ENCH_effect_biokin_physical_1"))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_biokin_overcome_pain",
    name = "",
    description = "",
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_biokin_pkill_1",
    name = ccb.content.text("Overcoming Minor Pain"),
    description = ccb.content.text("Your powers are slightly lessening the pain you feel."),
    apply_message = "",
    remove_message = ccb.content.text("Your wounds ache once again."),
    rating = "good",
    maximum_duration_turns = 900,
    maximum_intensity = 100,
    duration_add_percent = 10,
    intensity_duration_turns = 9,
}
    :decay_message(ccb.content.text("The pain you've been keeping away is starting to creep back in."), "bad")
    :modifier("painkiller", "tick", { base = 12 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "maximum_value", { base = 15 }))

content.add(content.EffectType {
    id = "effect_biokin_pkill_2",
    name = ccb.content.text("Overcoming Pain"),
    description = ccb.content.text("Your powers are lessening the pain you feel."),
    apply_message = "",
    remove_message = ccb.content.text("Your wounds ache once again."),
    rating = "good",
    maximum_duration_turns = 1200,
    maximum_intensity = 100,
    duration_add_percent = 10,
    intensity_duration_turns = 12,
}
    :decay_message(ccb.content.text("The pain you've been keeping away is starting to creep back in."), "bad")
    :modifier("painkiller", "tick", { base = 10 })
    :modifier("painkiller", "minimum", { base = 2 })
    :modifier("painkiller", "maximum_value", { base = 30 }))

content.add(content.EffectType {
    id = "effect_biokin_pkill_3",
    name = ccb.content.text("Overcoming Pain"),
    description = ccb.content.text("Your powers are lessening the pain you feel."),
    apply_message = "",
    remove_message = ccb.content.text("Your wounds ache once again."),
    rating = "good",
    maximum_duration_turns = 1500,
    maximum_intensity = 100,
    duration_add_percent = 10,
    intensity_duration_turns = 15,
}
    :decay_message(ccb.content.text("The pain you've been keeping away is starting to creep back in."), "bad")
    :modifier("painkiller", "tick", { base = 10 })
    :modifier("painkiller", "minimum", { base = 3 })
    :modifier("painkiller", "maximum_value", { base = 50 }))

content.add(content.EffectType {
    id = "effect_biokin_pkill_4",
    name = ccb.content.text("Overcoming Major Pain"),
    description = ccb.content.text("Your powers are greatly lessening the pain you feel."),
    apply_message = "",
    remove_message = ccb.content.text("Your wounds ache once again."),
    rating = "good",
    maximum_duration_turns = 1800,
    maximum_intensity = 100,
    duration_add_percent = 10,
    intensity_duration_turns = 18,
}
    :decay_message(ccb.content.text("The pain you've been keeping away is starting to creep back in."), "bad")
    :modifier("painkiller", "tick", { base = 8 })
    :modifier("painkiller", "minimum", { base = 4 })
    :modifier("painkiller", "maximum_value", { base = 75 }))

content.add(content.EffectType {
    id = "effect_biokin_pkill_5",
    name = ccb.content.text("Overcoming Major Pain"),
    description = ccb.content.text("Your powers are greatly lessening the pain you feel."),
    apply_message = "",
    remove_message = ccb.content.text("Your wounds ache once again."),
    rating = "good",
    maximum_duration_turns = 2400,
    maximum_intensity = 100,
    duration_add_percent = 10,
    intensity_duration_turns = 21,
}
    :decay_message(ccb.content.text("The pain you've been keeping away is starting to creep back in."), "bad")
    :modifier("painkiller", "tick", { base = 8 })
    :modifier("painkiller", "minimum", { base = 5 })
    :modifier("painkiller", "maximum_value", { base = 100 }))

content.add(content.EffectType {
    id = "effect_biokin_pkill_6",
    name = ccb.content.text("Overcoming Extreme Pain"),
    description = ccb.content.text("Your powers are enormously lessening the pain you feel."),
    apply_message = "",
    remove_message = ccb.content.text("Your wounds ache once again."),
    rating = "good",
    maximum_duration_turns = 2700,
    maximum_intensity = 100,
    duration_add_percent = 10,
    intensity_duration_turns = 24,
}
    :decay_message(ccb.content.text("The pain you've been keeping away is starting to creep back in."), "bad")
    :modifier("painkiller", "tick", { base = 6 })
    :modifier("painkiller", "minimum", { base = 6 })
    :modifier("painkiller", "maximum_value", { base = 130 }))

content.add(content.EffectType {
    id = "effect_biokin_breathe_skin",
    name = ccb.content.text("Oxygen Absorption"),
    description = ccb.content.text("You can absorb oxygen through your skin."),
    remove_message = ccb.content.text("You take an involuntary breath."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("GILLS")
    :flag("SUFFOCATION_IMMUNE"))

content.add(content.EffectType {
    id = "effect_biokin_reflex",
    name = ccb.content.text("Heightened Reflexes"),
    description = ccb.content.text("You are enhancing your speed and senses."),
    apply_message = "",
    remove_message = ccb.content.text("The world speeds up again."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 39,
}
    :removes_effect("blind")
    :removes_effect("deaf")
    :enchantment("INLINE_ENCH_effect_biokin_reflex_0"))

content.add(content.EffectType {
    id = "effect_biokin_armor_skin",
    name = ccb.content.text("Hardened Skin"),
    description = ccb.content.text("Your skin is more resilient thanks to psionic energy."),
    apply_message = "",
    remove_message = ccb.content.text("The slight itching and waxiness in your skin fades away."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 62,
}
    :flag("TOUGH_FEET")
    :blocks_effect("bleed")
    :blocks_effect("hypovolemia")
    :blocks_effect("dermatik")
    :enchantment("INLINE_ENCH_effect_biokin_armor_skin_0"))

content.add(content.EffectType {
    id = "effect_biokin_climate_control",
    name = ccb.content.text("Climate Controlled"),
    description = ccb.content.text("You are better at dealing with extremes of heat and cold."),
    apply_message = "",
    remove_message = ccb.content.text("The temperature feels uncomfortable again."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 128,
}
    :decay_message(ccb.content.text("The temperature is really starting to get to you."), "bad")
    :decay_message(ccb.content.text("Your adaptation to extreme temperatures is fading."), "bad")
    :flag("BARKY")
    :enchantment("INLINE_ENCH_effect_biokin_climate_control_0"))

content.add(content.EffectType {
    id = "effect_biokin_enhance_mobility",
    name = ccb.content.text("Enhanced Mobility"),
    description = ccb.content.text("You find it much easier to move in encumbering gear."),
    apply_message = "",
    remove_message = ccb.content.text("Your gear suddenly seems to weigh you down."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_biokin_enhance_mobility_0"))

content.add(content.EffectType {
    id = "effect_biokin_hammerhand",
    name = ccb.content.text("Hammerhand"),
    description = ccb.content.text("Your bare hands substitute for several common tools."),
    apply_message = "",
    remove_message = ccb.content.text("You're no longer capable of hammering in a nail with your thumb."),
    rating = "good",
    maximum_duration_turns = 604800,
})

-- Gills here because they're holding their breath
content.add(content.EffectType {
    id = "effect_biokin_sealed",
    name = ccb.content.text("Sealed System"),
    description = ccb.content.text("You are protected from the dangers of the world."),
    apply_message = "",
    remove_message = ccb.content.text("You let out your breath in a rush."),
    rating = "good",
    maximum_duration_turns = 480,
    maximum_intensity = 50,
    duration_add_percent = 10,
    intensity_duration_turns = 9,
}
    :decay_message(ccb.content.text("You need to take a new breath, and soon!"), "bad")
    :decay_message(ccb.content.text("Your lungs are straining with the effort of holding your breath."), "bad")
    :flag("NO_SCENT")
    :flag("ELECTRIC_IMMUNE")
    :flag("RAD_RESIST")
    :flag("GILLS")
    :flag("WALK_UNDERWATER")
    :flag("INHALED_TOXIN_IMMUNE")
    :removes_effect("bleed")
    :blocks_effect("smoke_eyes")
    :blocks_effect("teargas")
    :blocks_effect("boomered")
    :blocks_effect("fetid_goop")
    :blocks_effect("spores")
    :blocks_effect("dermatik"))

content.add(content.EffectType {
    id = "effect_biokin_metabolism_enhance",
    name = ccb.content.text("Hyperenhanced Metabolism"),
    description = ccb.content.text("Your metabolism is far more efficient than before."),
    apply_message = "",
    remove_message = ccb.content.text("Your stomach rumbles."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_biokin_metabolism_enhance_0"))

content.add(content.EffectType {
    id = "effect_biokin_combat_dance",
    name = ccb.content.text("Combat Dance"),
    description = ccb.content.text("You are a dynamo of death."),
    apply_message = "",
    remove_message = ccb.content.text("Your movements return to normal."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 25,
}
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_0")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_1")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_2")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_3")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_4")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_5")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_6")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_7")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_8")
    :enchantment("INLINE_ENCH_effect_biokin_combat_dance_9"))

-- Hidden, part of Heightened Senses
content.add(content.EffectType {
    id = "effect_biokin_combat_dance_no_stun_or_daze",
    name = "",
    description = "",
}
    :removes_effect("stunned")
    :removes_effect("dazed"))

content.add(content.EffectType {
    id = "effect_biokin_guided_evolution_backfire",
    name = ccb.content.text("Evolving Backfire"),
    description = ccb.content.text("Your biology is running out of control.  Perhaps extensively drawing on the netherium was a bad idea."),
    apply_message = ccb.content.text("Netherium energy surges through your cells, changing them in an unknowable way.  Something is about to change."),
    remove_message = "",
    rating = "bad",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_biokin_guided_evolution",
    name = ccb.content.text("Guided Evolution"),
    description = ccb.content.text("Whenever you mutate, you may pick the resulting mutation from a selection of options."),
    apply_message = "",
    remove_message = ccb.content.text("You are no longer controlling your evolution."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_biokin_guided_evolution_0"))

content.add(content.EffectType {
    id = "effect_biokin_perfected_motion",
    name = ccb.content.text("Perfected Motion"),
    description = ccb.content.text("You feel like you can outrun a locomotive."),
    apply_message = "",
    remove_message = ccb.content.text("The world returns to normal speed."),
    rating = "good",
    maximum_duration_turns = 60,
    maximum_intensity = 18,
    duration_add_percent = 10,
    intensity_duration_turns = 3,
}
    :decay_message(ccb.content.text("Your movements are slower and slower now."), "bad")
    :decay_message(ccb.content.text("The world begins speeding up around you."), "bad")
    :flag("HARDTOHIT")
    :flag("UNCANNY_DODGE")
    :flag("WATERWALKING")
    :flag("ITEM_WATERPROOFING")
    :removes_effect("slippery_terrain")
    :removes_effect("effect_biokin_hurricane_blows")
    :enchantment("INLINE_ENCH_effect_biokin_perfected_motion_0")
    :enchantment("INLINE_ENCH_effect_biokin_perfected_motion_1")
    :enchantment("INLINE_ENCH_effect_biokin_perfected_motion_2")
    :enchantment("INLINE_ENCH_effect_biokin_perfected_motion_3"))

content.add(content.EffectType {
    id = "effect_biokin_hurricane_blows",
    name = ccb.content.text("Hurricane Blows"),
    description = ccb.content.text("You can attack faster than thought."),
    apply_message = "",
    rating = "good",
    maximum_duration_turns = 1,
}
    :removes_effect("slippery_terrain")
    :removes_effect("effect_biokin_perfected_motion")
    :enchantment("INLINE_ENCH_effect_biokin_hurricane_blows_0"))

-- applies the addition effects from Hurricane Blows for two rounds to make sure they work properly.
content.add(content.EffectType {
    id = "effect_biokin_hurricane_blows_2",
    name = "",
    description = "",
    apply_message = "",
    rating = "good",
    maximum_duration_turns = 2,
}
    :flag("NO_PSIONICS")
    :enchantment("INLINE_ENCH_effect_biokin_hurricane_blows_2_0")
    :enchantment("INLINE_ENCH_effect_biokin_hurricane_blows_2_1"))

content.add(content.EffectType {
    id = "effect_biokin_vitaminosis",
    name = ccb.content.text("Vitaminosis"),
    description = ccb.content.text("You are steadily converting calories into vitamins."),
    apply_message = "",
    remove_message = "",
    rating = "good",
    maximum_duration_turns = 604800,
})

-- Hidden, part of a passive trait
content.add(content.EffectType {
    id = "effect_clair_passive_sense_protection",
    name = "",
    description = "",
}
    :flag("GLARE_RESIST")
    :flag("IMMUNE_HEARING_DAMAGE"))

content.add(content.EffectType {
    id = "effect_clair_craft_in_darkness",
    name = "",
    description = "",
}
    :flag("CRAFT_IN_DARKNESS"))

content.add(content.EffectType {
    id = "effect_clair_better_senses",
    name = ccb.content.text("Heightened Senses"),
    description = ccb.content.text("You are enhancing your mundane senses."),
    apply_message = "",
    remove_message = ccb.content.text("Your enhanced senses fade away."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_clair_better_senses_0")
    :enchantment("INLINE_ENCH_effect_clair_better_senses_1")
    :enchantment("INLINE_ENCH_effect_clair_better_senses_2")
    :enchantment("INLINE_ENCH_effect_clair_better_senses_3")
    :enchantment("INLINE_ENCH_effect_clair_better_senses_4")
    :enchantment("INLINE_ENCH_effect_clair_better_senses_5"))

-- Hidden, part of Heightened Senses
content.add(content.EffectType {
    id = "effect_clair_better_senses_eye_membrane",
    name = "",
    description = "",
}
    :flag("EYE_MEMBRANE"))

-- Hidden, part of Heightened Senses
content.add(content.EffectType {
    id = "effect_clair_better_senses_see_sleep",
    name = "",
    description = "",
}
    :flag("SEESLEEP"))

-- Hidden, part of Heightened Senses
content.add(content.EffectType {
    id = "effect_clair_better_senses_safecracking",
    name = "",
    description = "",
}
    :flag("SAFECRACK_NO_TOOL"))

content.add(content.EffectType {
    id = "effect_clair_better_senses_pain",
    name = ccb.content.text("Sensory Pain"),
    description = ccb.content.text("Your senses are overwhelmed!"),
    apply_message = ccb.content.text("Your senses are overwhelmed!"),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_clair_better_senses_pain_0")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 4 })
    :modifier("pain", "maximum_value", { base = 20 })
    :modifier("pain", "tick", { base = 5 }))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_clair_night_eyes",
    name = ccb.content.text("Night Eyes"),
    description = ccb.content.text("You can sense your surroundings in the dark."),
    apply_message = "",
    remove_message = ccb.content.text("The darkness hides your surroundings again."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_clair_night_eyes_0")
    :enchantment("INLINE_ENCH_effect_clair_night_eyes_1"))

content.add(content.EffectType {
    id = "effect_clair_speed_reader",
    name = ccb.content.text("Speed Reader"),
    description = ccb.content.text("You are absorbing knowledge from books like a sponge absorbs water."),
    apply_message = "",
    remove_message = "",
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_clair_speed_reader_0"))

content.add(content.EffectType {
    id = "effect_clair_premonition",
    name = ccb.content.text("Premonition"),
    description = ccb.content.text("You are preternaturally aware of nearby movement and possible dangers."),
    apply_message = "",
    remove_message = ccb.content.text("Your preternatural awareness fades."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 58,
}
    :enchantment("INLINE_ENCH_effect_clair_premonition_0"))

content.add(content.EffectType {
    id = "effect_clair_see_auras",
    name = ccb.content.text("Aura Sight"),
    description = ccb.content.text("Swirling colors are visible around others, revealing their emotions."),
    apply_message = "",
    remove_message = ccb.content.text("The colors fade away."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_clair_see_auras_0"))

content.add(content.EffectType {
    id = "effect_clair_weak_point",
    name = ccb.content.text("Weaknesses Discerned"),
    description = ccb.content.text("Your vulnerabilities have been laid open."),
    apply_message = ccb.content.text("You suddenly feel terribly vulnerable."),
    remove_message = ccb.content.text("You no longer feel so exposed."),
    rating = "bad",
    maximum_duration_turns = 60,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_clair_weak_point_0"))

content.add(content.EffectType {
    id = "effect_clair_ranged_enhance",
    name = ccb.content.text("Dead Aim"),
    description = ccb.content.text("Your powers make aiming much easier for you."),
    apply_message = "",
    remove_message = ccb.content.text("The world lurches as apparent distances snap back into place."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_clair_ranged_enhance_0")
    :enchantment("INLINE_ENCH_effect_clair_ranged_enhance_1"))

content.add(content.EffectType {
    id = "effect_clair_sense_rads_self",
    name = ccb.content.text("Sensing Radiation"),
    description = ccb.content.text("You can detect environmental radiation."),
    apply_message = "",
    remove_message = ccb.content.text("Your radiation sense is gone."),
    rating = "good",
    maximum_duration_turns = 21600,
    maximum_intensity = 198,
    duration_add_percent = 10,
    intensity_duration_turns = 109,
}
    :decay_message(ccb.content.text("The ambient glow of radiation is almost invisible now."), "bad")
    :decay_message(ccb.content.text("Your ability to sense radiation is fading."), "bad")
    :enchantment("enchant_clair_sense_rads"))

content.add(content.EffectType {
    id = "effect_clair_sense_hostile_creatures",
    name = ccb.content.text("Sense Hostility"),
    description = ccb.content.text("You will know when there's something out there that means you harm."),
    apply_message = "",
    remove_message = ccb.content.text("The sense of dangerous creatures fades away, but you know the danger remains."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_clair_sense_hostile_creatures_0"))

content.add(content.EffectType {
    id = "effect_clair_dodge",
    name = ccb.content.text("Anticipating Attack"),
    description = ccb.content.text("You can see your enemies' attacks in advance."),
    apply_message = "",
    remove_message = ccb.content.text("The fore-images of your enemies fade away."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 38,
}
    :flag("HARDTOHIT")
    :blocks_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_clair_dodge_0"))

content.add(content.EffectType {
    id = "effect_clair_craft_bonus",
    name = ccb.content.text("Intuitive Artistry"),
    description = ccb.content.text("You just know what you need to do next.  It's harder for you to pay attention to anything else due to the shifting futures, however, and you will lose awareness of the outside world entirely when making something."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("MYOPIC")
    :flag("CRAFT_IN_DARKNESS")
    :enchantment("INLINE_ENCH_effect_clair_craft_bonus_0"))

-- Hidden effect, blinds you while crafting.
content.add(content.EffectType {
    id = "effect_clair_craft_bonus_blindness",
    name = "",
    description = "",
}
    :flag("BLIND"))

content.add(content.EffectType {
    id = "effect_clair_perfect_shot",
    name = ccb.content.text("One Perfect Shot"),
    description = ccb.content.text("Do it.  Take the shot."),
    rating = "good",
    maximum_duration_turns = 10,
}
    :enchantment("INLINE_ENCH_effect_clair_perfect_shot_0"))

content.add(content.EffectType {
    id = "effect_clair_clear_sight",
    name = ccb.content.text("Truesight"),
    description = ccb.content.text("Your powers allow you to see the true shape of reality."),
    apply_message = "",
    remove_message = ccb.content.text("The world seems wrapped in gauze compared to before."),
    rating = "good",
    maximum_duration_turns = 604800,
    show_in_info = true,
}
    :flag("TRUE_SEEING")
    :removes_effect("dazed")
    :removes_effect("stunned")
    :removes_effect("psi_stunned")
    :removes_effect("darkness")
    :removes_effect("visuals")
    :removes_effect("hallu")
    :removes_effect("blind")
    :removes_effect("hallucination_attacks")
    :removes_effect("deaf")
    :removes_effect("weed_high")
    :removes_effect("high")
    :removes_effect("drunk")
    :removes_effect("no_sight")
    :removes_effect("glare")
    :removes_effect("snow_glare")
    :removes_effect("venom_blind"))

content.add(content.EffectType {
    id = "effect_clair_astral_projection",
    name = ccb.content.text("Astrally Projecting"),
    description = ccb.content.text("Your spirit wanders the world."),
    apply_message = "",
    remove_message = "",
    rating = "good",
}
    :flag("ETHEREAL")
    :flag("INVISIBLE")
    :flag("FEATHER_FALL")
    :flag("CLIMB_FLYING")
    :flag("LEVITATION")
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING")
    :flag("NO_PSIONICS")
    :removes_effect("effect_biokin_perfected_motion")
    :enchantment("INLINE_ENCH_effect_clair_astral_projection_0")
    :modifier("stamina", "minimum", { base = -50 })
    :modifier("stamina", "chance_numerator", { base = 1 }))

content.add(content.EffectType {
    id = "effect_clair_group_tactics_other",
    name = ccb.content.text("Prescient Tactics"),
    description = ccb.content.text("You're being informed of the best way to fight."),
    apply_message = "",
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 3,
    intensity_decay_step = -1,
    intensity_decay_tick = 2,
    intensity_decay_removes = true,
}
    :enchantment("INLINE_ENCH_effect_clair_group_tactics_other_0")
    :modifier("dodge", "amount", { base = 4 }))

content.add(content.EffectType {
    id = "effect_clair_group_tactics_self",
    name = ccb.content.text("Prescient Tactics"),
    description = ccb.content.text("You're calling out tactics to your followers.  It's much harder to concentrate on your own defense."),
    apply_message = "",
    remove_message = ccb.content.text("As the visions fade, you stop calling out orders."),
    rating = "good",
    maximum_duration_turns = 1800,
}
    :enchantment("ench_clair_group_tactics")
    :modifier("dodge", "amount", { base = -6 })
    :modifier("hit", "amount", { base = -5 }))

content.add(content.EffectType {
    id = "effect_clair_omniscence",
    name = ccb.content.text("Omniscience"),
    description = ccb.content.text("You can see forever."),
    apply_message = "",
    remove_message = ccb.content.text("Your senses snap back to your physical body."),
    rating = "good",
}
    :flag("SUPER_CLAIRVOYANCE"))

content.add(content.EffectType {
    id = "effect_electrokin_see_electricity",
    name = ccb.content.text("Spark Sight"),
    description = ccb.content.text("Your powers reveal electrical creatures and robots to you."),
    apply_message = "",
    remove_message = ccb.content.text("You can no longer sense the flow of current."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 83,
}
    :enchantment("INLINE_ENCH_effect_electrokin_see_electricity_0"))

content.add(content.EffectType {
    id = "effect_electrokin_zap_enemies",
    name = ccb.content.text("Electrical Discharge"),
    description = ccb.content.text("Your body is filled with electrical currents."),
    apply_message = "",
    remove_message = ccb.content.text("The tingling on your skin fades."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 49,
}
    :flag("EMP_IMMUNE")
    :enchantment("enchant_electrokin_zap_enemies"))

content.add(content.EffectType {
    id = "effect_electrokin_melee_attacks",
    name = ccb.content.text("Voltaic Strikes"),
    description = ccb.content.text("Your melee attacks unleash electrical blasts."),
    apply_message = "",
    remove_message = ccb.content.text("Your hands no longer spark with electricity."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 73,
}
    :enchantment("enchant_electrokin_electric_strikes"))

content.add(content.EffectType {
    id = "effect_electrokin_hacking_interface",
    name = ccb.content.text("Hacking Interface"),
    description = ccb.content.text("You have constructed an electrical interface to hack nearby devices."),
    apply_message = "",
    remove_message = ccb.content.text("You can no longer manipulate the circuitry of nearby devices."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_electrokin_personal_battery",
    name = ccb.content.text("Electron Overflow"),
    description = ccb.content.text("You are generating a wireless aura of electrical power."),
    apply_message = "",
    remove_message = ccb.content.text("You stop the flow of electricity to your devices."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_electrokin_paralysis",
    name = ccb.content.text("Neural Spasms"),
    description = ccb.content.text("Your muscles are twitching and won't obey you!"),
    remove_message = ccb.content.text("Your spasms stop."),
    rating = "bad",
    show_in_info = true,
}
    :flag("CANNOT_MOVE")
    :flag("CANNOT_ATTACK")
    :flag("NO_PSIONICS")
    :flag("NO_SPELLCASTING"))

content.add(content.EffectType {
    id = "effect_electrokin_reduce_pain",
    name = ccb.content.text("Pain Suppression"),
    description = ccb.content.text("When it hurts, it won't hurt as much."),
    apply_message = "",
    remove_message = ccb.content.text("Your nerves burn for a moment as a surge of pain hits them."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_electrokin_reduce_pain_0"))

content.add(content.EffectType {
    id = "effect_electrokinetic_pain_immune",
    name = ccb.content.text("Analgesic Block"),
    description = ccb.content.text("You can't feel anything.  That means everything is fine, right?  Everything is fine."),
    apply_message = "",
    remove_message = ccb.content.text("All of your pain rushes back in!"),
    rating = "good",
    maximum_duration_turns = 1800,
    maximum_intensity = 48,
    duration_add_percent = 10,
    intensity_duration_turns = 39,
}
    :decay_message(ccb.content.text("Your wounds are starting to ache."), "bad")
    :decay_message(ccb.content.text("Your wounds sting a bit."), "bad")
    :flag("PAIN_IMMUNE")
    :removes_effect("effect_electrokinetic_speed_boost"))

content.add(content.EffectType {
    id = "effect_electrokinetic_speed_boost",
    name = ccb.content.text("Neuro-Accelerated"),
    description = ccb.content.text("You are enhancing your nervous system."),
    apply_message = "",
    remove_message = ccb.content.text("Your reactions return to baseline."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 61,
}
    :removes_effect("effect_electrokinetic_pain_immune")
    :enchantment("INLINE_ENCH_effect_electrokinetic_speed_boost_0"))

content.add(content.EffectType {
    id = "effect_electrokinetic_lightning_aura",
    name = ccb.content.text("Galvanic Aura"),
    description = ccb.content.text("Anyone nearby risks being blasted by lightning."),
    apply_message = "",
    remove_message = ccb.content.text("The thrum in the air around you dissipates."),
    rating = "good",
    maximum_duration_turns = 600,
    maximum_intensity = 36,
    duration_add_percent = 10,
    intensity_duration_turns = 17,
}
    :decay_message(ccb.content.text("The crackling aura around you is fading quickly."), "bad")
    :decay_message(ccb.content.text("The lightning blasts are growing less powerful."), "bad")
    :flag("EMP_IMMUNE")
    :flag("ELECTRIC_IMMUNE"))

content.add(content.EffectType {
    id = "effect_electrokinetic_lightning_aura_aftershock",
    name = ccb.content.text("Galvanic Aftershock"),
    description = ccb.content.text("You still remain immune to the effects of electricity, if only briefly."),
    apply_message = "",
    remove_message = "",
    rating = "good",
    maximum_duration_turns = 5,
    maximum_intensity = 1,
    duration_add_percent = 0,
}
    :flag("EMP_IMMUNE")
    :flag("ELECTRIC_IMMUNE"))

content.add(content.EffectType {
    id = "effect_photokin_light_local",
    name = ccb.content.text("Candle's Light"),
    description = ccb.content.text("The air above your hand glows faintly."),
    apply_message = ccb.content.text("A faint light springs up over your hand."),
    remove_message = ccb.content.text("The glow above your hand fades."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_photokin_light_local_0"))

content.add(content.EffectType {
    id = "effect_photokin_enemy_light",
    name = ccb.content.text("Illuminated"),
    description = ccb.content.text("The air around you is glowing."),
    apply_message = ccb.content.text("You are outlined in light."),
    remove_message = ccb.content.text("The glow around you fades."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_photokin_enemy_light_0")
    :modifier("dodge", "amount", { base = -1 }))

content.add(content.EffectType {
    id = "effect_photokin_dodge",
    name = ccb.content.text("Trick of the Light"),
    description = ccb.content.text("You are surrounded by shifting illusions, and your enemies struggle to see where your true form is."),
    apply_message = "",
    remove_message = ccb.content.text("The illusions around you suddenly vanish!"),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 38,
}
    :flag("UNCANNY_DODGE")
    :flag("HARDTOHIT")
    :blocks_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_photokin_dodge_0")
    :modifier("dodge", "amount", { base = 6 }))

content.add(content.EffectType {
    id = "effect_photokin_camouflage",
    name = ccb.content.text("Chameleoflage"),
    description = ccb.content.text("You bending nearby light to make yourself more difficult to spot."),
    apply_message = "",
    remove_message = ccb.content.text("You stop bending light around your location."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_photokin_camouflage_0"))

content.add(content.EffectType {
    id = "effect_photokin_light_barrier",
    name = ccb.content.text("Lucent Barrier"),
    description = ccb.content.text("You are protected from extremes of light and radiation."),
    apply_message = "",
    remove_message = ccb.content.text("The surrounding air shimmers once more as your light barrier fades."),
    rating = "good",
}
    :flag("PHOTOKIN_CHAR_IMMUNE")
    :flag("NO_RADIATION")
    :flag("GLARE_RESIST")
    :enchantment("INLINE_ENCH_effect_photokin_light_barrier_0"))

content.add(content.EffectType {
    id = "effect_photokin_hide_ugly",
    name = ccb.content.text("Mirror-Mask"),
    description = ccb.content.text("You're just another survivor.  There's definitely nothing odd about you at all."),
    remove_message = ccb.content.text("The illusions around you fall away."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_photokin_hide_ugly_0"))

content.add(content.EffectType {
    id = "effect_photokinetic_radio",
    name = ccb.content.text("Radio Transception"),
    description = ccb.content.text("You can interpret and transmit radio waves."),
    apply_message = "",
    remove_message = ccb.content.text("You stop paying attention to the radio waves around you."),
    rating = "good",
    maximum_duration_turns = 604800,
})

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_photokin_sterilization",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_photokin_invisibility",
    name = ccb.content.text("Invisibility"),
    description = ccb.content.text("Nothing can see you."),
    apply_message = "",
    remove_message = ccb.content.text("The obscuring veil of light fades, revealing your presence."),
    maximum_duration_turns = 604800,
    maximum_intensity = 177,
}
    :flag("INVISIBLE"))

content.add(content.EffectType {
    id = "effect_photokin_arms",
    name = ccb.content.text("refraction of arms"),
    description = ccb.content.text("Your arms refract light to create the illusion of having multiple arms and their wielded items."),
    apply_message = "",
    remove_message = ccb.content.text("The light around your arms returns to normal."),
    rating = "good",
    show_in_info = true,
    maximum_duration_turns = 2700,
    maximum_intensity = 297,
    duration_add_percent = 10,
    intensity_duration_turns = 9,
}
    :decay_message(ccb.content.text("Your illusionary arms are obviously translucent."), "bad")
    :decay_message(ccb.content.text("Your illusionary arms are losing some of their solid appearance."), "bad")
    :modifier("hit", "amount", { base = 4 }))

content.add(content.EffectType {
    id = "effect_photokin_blind",
    name = ccb.content.text("Blind"),
    description = ccb.content.text("Range of Sight: 0.  You cannot see anything."),
    apply_message = ccb.content.text("You are blinded!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    show_in_info = true,
    maximum_duration_turns = 259200,
}
    :flag("BLIND")
    :immune_character_flag("PHOTOKINETIC"))

content.add(content.EffectType {
    id = "effect_photokin_blinding_glare",
    name = ccb.content.text("Blinding Radiance"),
    description = ccb.content.text("You are glowing like the sun."),
    apply_message = "",
    remove_message = ccb.content.text("The last light finally dies."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 46,
}
    :enchantment("enchant_photokin_blinding_glare")
    :modifier("dodge", "amount", { base = 4 }))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_photokin_light_army",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_pyrokinetic_flash",
    name = ccb.content.text("Blind"),
    description = ccb.content.text("Range of Sight: 0.  You cannot see anything."),
    apply_message = ccb.content.text("You're blinded!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    maximum_duration_turns = 900,
    show_in_info = true,
}
    :flag("BLIND")
    :removes_effect("glare")
    :removes_effect("snow_glare")
    :removes_effect("darkness"))

content.add(content.EffectType {
    id = "effect_psi_post_cauterize",
    name = ccb.content.text("Cauterized"),
    description = ccb.content.text("You used your powers to cauterize a wound here.  Whether it worked or not, it still stings terribly."),
    rating = "bad",
    maximum_intensity = 5,
}
    :modifier("pain", "maximum_value", { base = 30 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 6, per_intensity = -1 })
    :modifier("pain", "tick", { base = 120, per_intensity = -10 }))

content.add(content.EffectType {
    id = "effect_pyrokinetic_fire_tool",
    name = ccb.content.text("Banked Flames"),
    description = ccb.content.text("A flame is burning over one of your palms."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_pyrokinetic_cloak",
    name = ccb.content.text("Cloak of Warmth"),
    description = ccb.content.text("The air around you has its temperature controlled."),
    apply_message = "",
    remove_message = ccb.content.text("A cool breeze hits your skin."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 77,
}
    :flag("BARKY")
    :enchantment("enchant_pyrokin_cloak"))

content.add(content.EffectType {
    id = "effect_pyrokinetic_torch_weld",
    name = ccb.content.text("Incandescent Lance"),
    description = ccb.content.text("A thin beam of searing plasma extends from one finger."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_pyrokinetic_aura",
    name = ccb.content.text("Blazing Aura"),
    description = ccb.content.text("You are surrounded by flames."),
    apply_message = "",
    remove_message = ccb.content.text("The flames surrounding you gutter out."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 31,
}
    :flag("RAIN_IMMUNE")
    :flag("SNOWWALKING")
    :removes_effect("effect_pyrokinetic_aura_damage")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_0")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_1")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_2")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_3")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_4")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_5")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_6")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_7")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_8")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_9")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_10")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_11")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_aura_12"))

content.add(content.EffectType {
    id = "effect_pyrokinetic_aura_damage",
    name = ccb.content.text("Burning Air"),
    description = ccb.content.text("The air is intolerably hot."),
    apply_message = "",
    remove_message = ccb.content.text("The air cools down."),
    maximum_duration_turns = 2,
    maximum_intensity = 12,
}
    :immune_character_flag("FIREY")
    :immune_character_flag("HEAT_IMMUNE")
    :modifier("hurt", "minimum", { base = 1, per_intensity = 0.2 })
    :modifier("hurt", "maximum", { base = 3, per_intensity = 0.4 })
    :modifier("hurt", "chance_numerator", { base = 2 }))

content.add(content.EffectType {
    id = "effect_pyrokinetic_flame_immunity",
    name = ccb.content.text("Flame Immunity"),
    description = ccb.content.text("You are completely immune to fire."),
    apply_message = "",
    remove_message = ccb.content.text("You are once again vulnerable to fire."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 95,
}
    :flag("HEAT_IMMUNE")
    :blocks_effect("blisters")
    :enchantment("INLINE_ENCH_effect_pyrokinetic_flame_immunity_0"))

content.add(content.EffectType {
    id = "effect_telekinetic_momentum",
    name = ccb.content.text("Altered Momentum"),
    description = ccb.content.text("Your powers are affecting movement around you; dangerous objects are slowed and your own speed is increased."),
    apply_message = "",
    remove_message = ccb.content.text("Nearby movement returns to normal."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 41,
}
    :flag("MUSCLE_VEH_BOOST")
    :enchantment("INLINE_ENCH_effect_telekinetic_momentum_0")
    :enchantment("INLINE_ENCH_effect_telekinetic_momentum_1")
    :enchantment("INLINE_ENCH_effect_telekinetic_momentum_2"))

content.add(content.EffectType {
    id = "effect_telekinetic_water_walking",
    name = ccb.content.text("Water-Walking"),
    description = ccb.content.text("You can walk over liquids without sinking into them."),
    apply_message = "",
    remove_message = ccb.content.text("Your feet are firm on the ground."),
}
    :flag("WATERWALKING")
    :flag("ITEM_WATERPROOFING")
    :flag("SLUDGEPROOF"))

content.add(content.EffectType {
    id = "effect_telekinetic_lifting_field",
    name = ccb.content.text("Lifting Field"),
    description = ccb.content.text("You can hover a single item nearby, at the ready."),
    apply_message = "",
    remove_message = ccb.content.text("Your lifting field dissipates."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_telekinetic_strength",
    name = ccb.content.text("Telekinetic Strength"),
    description = ccb.content.text("You are greatly enhancing your ability to lift and break things."),
    apply_message = "",
    remove_message = ccb.content.text("The force supporting your muscles suddenly vanishes."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_telekinetic_strength_0"))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_telekinetic_vehicle_lift",
    name = "",
    description = "",
    rating = "good",
    maximum_duration_turns = 604800,
})

-- The logic is that this works the reverse of the way mundane physics does--the wider the area of the force applied against it, the weaker it is.
content.add(content.EffectType {
    id = "effect_telekinetic_armor",
    name = ccb.content.text("Inertial Barrier"),
    description = ccb.content.text("A barrier of telekinetic force is protecting you."),
    apply_message = "",
    remove_message = ccb.content.text("The barrier of force around you falls apart."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 112,
}
    :flag("TELEKIN_SHIELD")
    :enchantment("INLINE_ENCH_effect_telekinetic_armor_0")
    :enchantment("INLINE_ENCH_effect_telekinetic_armor_1"))

content.add(content.EffectType {
    id = "effect_telekinetic_levitation",
    name = ccb.content.text("Levitation"),
    description = ccb.content.text("You are floating in defiance of gravity."),
    apply_message = "",
    remove_message = ccb.content.text("Your feet touch the ground once again."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :decay_message(ccb.content.text("You are sinking despite your best efforts."), "bad")
    :decay_message(ccb.content.text("You wobble briefly downward before recovering."), "bad")
    :flag("LEVITATION")
    :flag("CLIMB_FLYING")
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

content.add(content.EffectType {
    id = "effect_telepathic_learning_bonus",
    name = ccb.content.text("Trance State"),
    description = ccb.content.text("You are in a focused mental state, increasing the ease of learning."),
    apply_message = "",
    remove_message = ccb.content.text("You shake your head as you become aware of the outside world again."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 100,
}
    :decay_message(ccb.content.text("Your enhanced concentration is fading like a dream."), "bad")
    :decay_message(ccb.content.text("The outside world is impinging itself on your awareness."), "bad")
    :flag("MYOPIC")
    :enchantment("INLINE_ENCH_effect_telepathic_learning_bonus_0"))

content.add(content.EffectType {
    id = "effect_telepath_mesmerize_tracker",
    name = ccb.content.text("Mesmerized"),
    description = ccb.content.text("You are in a daze."),
    apply_message = "",
    remove_message = ccb.content.text("You snap out of your trance."),
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_telepathic_morale",
    name = ccb.content.text("Stabilized Mood"),
    description = ccb.content.text("You are editing out your most negative thoughts.  When you think about it, is the Cataclysm really the worst thing that could have happened?"),
    apply_message = "",
    remove_message = ccb.content.text("You let your thoughts return to their normal flow."),
    rating = "good",
    maximum_duration_turns = 604800,
})

-- A tracker effect to prevent the target's morale or fear from being modified more than once in a period of time
content.add(content.EffectType {
    id = "effect_telepath_mood_stabilization_attitude_modified",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_telepathic_primal_terror",
    name = ccb.content.text("Terrorized"),
    description = ccb.content.text("You are overcome with overwhelming dread."),
    apply_message = ccb.content.text("Your heart races as a sudden feeling of dread grips you."),
    remove_message = ccb.content.text("The heart-freezing terror fades as suddenly as it began."),
    rating = "bad",
    show_in_info = true,
}
    :immune_character_flag("TEEPSHIELD")
    :immune_character_flag("TEEP_IMMUNE")
    :modifier("speed", "amount", { base = -30 })
    :modifier("dodge", "amount", { base = -2 })
    :modifier("hit", "amount", { base = -2 })
    :modifier("bash", "amount", { base = -8 }))

-- A tracker effect to prevent the target's morale or fear from being modified more than once in a period of time
content.add(content.EffectType {
    id = "effect_telepath_primal_terror_attitude_modified",
    name = "",
    description = "",
})

-- Ideally this would directly increase Perception and the Dodge, Melee, and Marksmanship skills, in some proportion to the target's current skill vs. the highest skill among the group.  The below is currently what is possible.
content.add(content.EffectType {
    id = "effect_telepath_network_effect",
    name = ccb.content.text("Telepathic Network"),
    description = ccb.content.text("You are in constant communication with your allies, looking out for each other in combat."),
    apply_message = "",
    remove_message = ccb.content.text("Silence fills your mind."),
    rating = "good",
    maximum_duration_turns = 600,
    maximum_intensity = 59,
    duration_add_percent = 10,
    intensity_duration_turns = 10,
}
    :decay_message(ccb.content.text("The inner voices of your allies are only a whisper now."), "bad")
    :decay_message(ccb.content.text("The inner voices of your allies begin to fade."), "bad")
    :flag("UNCANNY_DODGE")
    :enchantment("INLINE_ENCH_effect_telepath_network_effect_0")
    :enchantment("INLINE_ENCH_effect_telepath_network_effect_1"))

content.add(content.EffectType {
    id = "effect_teleport_ephemeral_walk",
    name = ccb.content.text("Ephemeral Walk"),
    description = ccb.content.text("You exist slightly outside of baseline reality, allowing you to effortlessly walk through solid matter."),
    remove_message = ccb.content.text("The surrounding matter feels real again."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_teleport_ephemeral_walk_0"))

content.add(content.EffectType {
    id = "effect_teleport_reactive_displacement",
    name = ccb.content.text("Reactive Displacement"),
    description = ccb.content.text("You will automatically teleport enemies that strike you away from yourself."),
    remove_message = ccb.content.text("The surrounding matter feels real again."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_teleport_reactive_displacement_0"))

content.add(content.EffectType {
    id = "effect_teleport_loci_establishment",
    name = ccb.content.text("Loci Establishment"),
    description = ccb.content.text("You are concentrating on your locus.  You can teleport there at will with the [Ψ]Loci Technique."),
    remove_message = ccb.content.text("You've forgotten your locus!"),
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_teleport_slow",
    name = ccb.content.text("Stutterstepping"),
    description = ccb.content.text("Your steps aren't taking you as far as your eyes tell you they should."),
    apply_message = ccb.content.text("The air ripples and you stumble."),
    remove_message = ccb.content.text("Your eyes and your legs agree with each other again."),
    rating = "bad",
    maximum_duration_turns = 3000,
    duration_add_percent = 5,
    show_in_info = true,
}
    :immune_character_flag("DIMENSIONAL_ANCHOR")
    :immune_character_flag("TELESTOP")
    :immune_character_flag("TELEPORT_IMMUNE")
    :enchantment("INLINE_ENCH_effect_teleport_slow_0"))

content.add(content.EffectType {
    id = "effect_teleport_stride",
    name = ccb.content.text("Extended Stride"),
    description = ccb.content.text("Every step takes you further than your eyes tell you it should."),
    apply_message = "",
    remove_message = ccb.content.text("Your steps are normal once again."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("MUSCLE_VEH_BOOST")
    :enchantment("INLINE_ENCH_effect_teleport_stride_0")
    :enchantment("INLINE_ENCH_effect_teleport_stride_1"))

content.add(content.EffectType {
    id = "effect_teleport_warped_strikes",
    name = ccb.content.text("Warped Strikes"),
    description = ccb.content.text("Your melee attacks extend much further than would normally be possible."),
    apply_message = "",
    remove_message = ccb.content.text("Your reach goes back to normal."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("MUSCLE_VEH_BOOST")
    :enchantment("INLINE_ENCH_effect_teleport_warped_strikes_0"))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_teleporter_attuning_to_area",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_teleport_warper_combat",
    name = ccb.content.text("Flickerflash Stance"),
    description = ccb.content.text("Through constant teleports and warping of space, your combat prowess is increased."),
    apply_message = "",
    remove_message = ccb.content.text("Your constant teleporting slows to a stop."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_teleport_warper_combat_0"))

content.add(content.EffectType {
    id = "effect_vitakin_slow_bleeding",
    name = ccb.content.text("Coagulation"),
    description = ccb.content.text("You bleed less than normal."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_vitakin_slow_bleeding_0"))

content.add(content.EffectType {
    id = "effect_vita_health",
    name = ccb.content.text("Healthy Glow"),
    description = ccb.content.text("You feel amazing."),
    apply_message = "",
    remove_message = ccb.content.text("The surge of vitality leaves you in a rush."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 97,
}
    :removes_effect("asthma")
    :blocks_effect("scurvy")
    :blocks_effect("redcells_anemia")
    :blocks_effect("anemia")
    :blocks_effect("toxin_buildup")
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 15 })
    :modifier("health", "tick", { base = 600 })
    :modifier("health_modifier", "minimum", { base = 1 })
    :modifier("health_modifier", "chance_numerator", { base = 10 })
    :modifier("health_modifier", "tick", { base = 600 })
    :modifier("healing", "amount", { base = 2 }))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_vita_concentrated_healing",
    name = "",
    description = "",
    apply_message = "",
    remove_message = "",
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_vita_concentrated_healing_penalty",
    name = "",
    description = "",
    apply_message = "",
    remove_message = "",
    rating = "bad",
    maximum_duration_turns = 604800,
}
    :modifier("healing", "amount", { base = 0.01 }))

content.add(content.EffectType {
    id = "effect_vita_concentrated_healing_bonus",
    name = ccb.content.text("Leukocyte Accumulation"),
    description = ccb.content.text("Your %s is receiving the bulk of your body's healing resources."),
    apply_message = "",
    remove_message = ccb.content.text("You stop concentrating your healing."),
    rating = "good",
    part_descriptions = true,
    maximum_intensity = 500,
    show_intensity = false,
    maximum_duration_turns = 604800,
}
    :flag("PAUSE_BODYPART_INFECTION")
    :modifier("healing", "amount", { base = 20, per_intensity = 6 })
    :modifier("healing_head", "amount", { base = 100 })
    :modifier("healing_torso", "amount", { base = 100 }))

content.add(content.EffectType {
    id = "effect_vita_cure_disease",
    name = ccb.content.text("Immunostimulated"),
    description = ccb.content.text("You are not going to get sick.  You absolutely refuse.  And if you do, you're going to get better."),
    apply_message = "",
    remove_message = ccb.content.text("You cough once."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_vita_increase_hp",
    name = ccb.content.text("Augmented Durability"),
    description = ccb.content.text("You are more resilient against damage."),
    apply_message = "",
    remove_message = ccb.content.text("The feeling of resilience fades away."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_vita_increase_hp_0"))

content.add(content.EffectType {
    id = "effect_vitakin_healing_trance",
    name = ccb.content.text("Revitalizing Meditation"),
    description = ccb.content.text("Thanks to your meditations you are healing much more quickly"),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_vitakin_healing_trance_0"))

content.add(content.EffectType {
    id = "effect_vitakin_purge_rads",
    name = ccb.content.text("Radiation Purge"),
    description = ccb.content.text("You are using your powers to cleanse yourself of radiation."),
    rating = "good",
}
    :modifier("radiation", "minimum", { base = -1 })
    :modifier("radiation", "chance_numerator", { base = 1 })
    :modifier("radiation", "tick", { base = 60 }))

content.add(content.EffectType {
    id = "effect_vitakin_purge_rads_sideeffects",
    name = ccb.content.text("Radiation Purge Side Effects"),
    description = ccb.content.text("You are using your powers to cleanse yourself of radiation, but there are some side effects."),
    rating = "bad",
    maximum_intensity = 10,
}
    :modifier("strength", "amount", { per_intensity = -1 })
    :modifier("dexterity", "amount", { per_intensity = -1 })
    :modifier("perception", "amount", { per_intensity = -0.7 })
    :modifier("stamina", "amount", { base = -2000, per_intensity = -1500 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 10, per_intensity = -1 })
    :modifier("pain", "tick", { base = 60 })
    :modifier("health", "minimum", { per_intensity = -1 })
    :modifier("health", "chance_numerator", { base = 1000, per_intensity = -135 })
    :modifier("health", "tick", { base = 60 })
    :modifier("sleepiness", "minimum", { per_intensity = 0.6 })
    :modifier("sleepiness", "chance_numerator", { base = 500, per_intensity = -65 })
    :modifier("sleepiness", "tick", { base = 60 })
    :modifier("vomiting", "chance_numerator", { base = 1000, per_intensity = -150 })
    :modifier("vomiting", "tick", { base = 60 }))

content.add(content.EffectType {
    id = "effect_vitakin_no_need_for_sleep",
    name = ccb.content.text("Selective Autosomnia"),
    description = ccb.content.text("Parts of your brain are sleeping while other parts remain awake."),
    apply_message = "",
    remove_message = ccb.content.text("You yawn involuntarily."),
}
    :enchantment("INLINE_ENCH_effect_vitakin_no_need_for_sleep_0")
    :modifier("sleepiness", "minimum", { base = -1 })
    :modifier("sleepiness", "chance_numerator", { base = 1 })
    :modifier("sleepiness", "tick", { base = 60 }))

content.add(content.EffectType {
    id = "effect_vita_super_heal",
    name = ccb.content.text("Anabolic Rejuvenation"),
    description = ccb.content.text("You are healing extraordinarily quickly."),
    apply_message = "",
    remove_message = ccb.content.text("Your body aches as your preternatural healing slows to a stop."),
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_vita_degenerating_touch",
    name = ccb.content.text("Degenerating"),
    description = ccb.content.text("You flesh is withering and decaying!"),
    rating = "bad",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_vita_degenerating_touch_0")
    :modifier("dodge", "amount", { base = -3 })
    :modifier("hit", "amount", { base = -3 }))

content.add(content.EffectType {
    id = "effect_vita_super_heal_return_from_death",
    description = ccb.content.text("You are healing extraordinarily quickly."),
    apply_message = "",
    remove_message = ccb.content.text("Your body aches as your preternatural healing slows to a stop."),
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_vita_super_heal_pain_allayed",
    name = ccb.content.text("Overflowing Vitality"),
    description = ccb.content.text("The energy of your accelerated resuscitation is preventing you from feeling the pain you obviously should be, for the moment."),
    rating = "good",
    maximum_duration_turns = 300,
    maximum_intensity = 10,
    intensity_duration_turns = 30,
}
    :enchantment("INLINE_ENCH_effect_vita_super_heal_pain_allayed_0"))

content.add(content.EffectType {
    id = "effect_vita_return_from_death",
    name = ccb.content.text("Accelerated Resuscitation"),
    description = ccb.content.text("If you suffer potentially-fatal damage, your powers will attempt to save you."),
    rating = "good",
    maximum_duration_turns = 604800,
})

-- Hidden effect, prevents pre-common cold from becoming a cold
content.add(content.EffectType {
    id = "effect_vita_health_common_cold_protection",
    name = "",
    description = "",
    rating = "good",
    maximum_duration_turns = 864000,
}
    :removes_effect("pre_common_cold")
    :removes_effect("common_cold"))

-- Hidden effect, prevents pre-flu from becoming the flu
content.add(content.EffectType {
    id = "effect_vita_health_flu_protection",
    name = "",
    description = "",
    rating = "good",
    maximum_duration_turns = 864000,
}
    :removes_effect("pre_flu")
    :removes_effect("flu"))

-- Hidden effect, prevents viral conjunctivitis from becoming conjunctivitis
content.add(content.EffectType {
    id = "effect_vita_health_conjunctivitis_viral_protection",
    name = "",
    description = "",
    rating = "good",
    maximum_duration_turns = 864000,
}
    :removes_effect("pre_conjunctivitis_viral")
    :removes_effect("conjunctivitis_viral"))

-- Hidden effect, prevents bacterial conjunctivitis from becoming conjunctivitis
content.add(content.EffectType {
    id = "effect_vita_health_conjunctivitis_bacterial_protection",
    name = "",
    description = "",
    rating = "good",
    maximum_duration_turns = 864000,
}
    :removes_effect("pre_conjunctivitis_bacterial")
    :removes_effect("conjunctivitis_bacterial"))

content.add(content.EffectType {
    id = "effect_psi_intense_concentration",
    name = ccb.content.text("Intense Concentration"),
    description = ccb.content.text("It's taking a lot of concentration to maintain your powers."),
    apply_message = "",
    remove_message = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("dodge", "amount", { base = -1 })
    :limb_score("breathing", { multiplier = 0.95 })
    :limb_score("reaction", { multiplier = 0.97 }))

content.add(content.EffectType {
    id = "effect_biokin_flexibility",
    name = ccb.content.text("Flexibility"),
    description = ccb.content.text("You are enhancing your range of motion."),
    apply_message = "",
    remove_message = ccb.content.text("Your joints creak as your limbs lose their flexibility."),
    rating = "good",
    maximum_duration_turns = 60,
    duration_add_percent = 1,
}
    :flag("DOWNED_RECOVERY")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :removes_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_biokin_flexibility_0")
    :limb_score("reaction", { multiplier = 2.0 })
    :limb_score("block", { multiplier = 1.2 })
    :limb_score("crawl", { multiplier = 1.5 }))

content.add(content.EffectType {
    id = "effect_telekinetic_slowfall",
    name = ccb.content.text("Slowfall"),
    description = ccb.content.text("The ground isn't as eager to receive you."),
    apply_message = "",
    remove_message = ccb.content.text("You suddenly feel much heavier."),
    maximum_duration_turns = 60,
    duration_add_percent = 10,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("ONE_STORY_FALL")
    :enchantment("INLINE_ENCH_effect_telekinetic_slowfall_0")
    :limb_score("swim", { multiplier = 3.0 }))

content.add(content.EffectType {
    id = "effect_telekinetic_aegis",
    name = ccb.content.text("Aegis"),
    description = ccb.content.text("You are nearly invincible."),
    apply_message = "",
    remove_message = ccb.content.text("The air loses its structure and you are vulnerable once again."),
    rating = "good",
    maximum_duration_turns = 20,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("EFFECT_IMPEDING")
    :removes_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_telekinetic_aegis_0")
    :limb_score("lift", { multiplier = 0.51 })
    :limb_score("grip", { multiplier = 0.25 }))

content.upsert_effect_type(content.EffectType {
    id = "effect_telepath_sense_minds",
    name = ccb.content.text("Sensing Minds"),
    description = ccb.content.text("You are looking out for other minds."),
    apply_message = "",
    remove_message = ccb.content.text("Your awareness of other minds fades away."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 50,
}
    :enchantment("INLINE_ENCH_effect_telepath_sense_minds_0"))

content.upsert_effect_type(content.EffectType {
    id = "telepathic_ignorance",
    name = ccb.content.text("Ignorance"),
    description = ccb.content.text("You're positive that no one is there."),
    apply_message = "",
    remove_message = ccb.content.text("Wait a minute, there *is* someone there!"),
    rating = "bad",
    show_in_info = true,
})

-- hidden effect so the monster knows who to ignore
content.upsert_effect_type(content.EffectType {
    id = "telepathic_ignorance_self",
    name = "",
    description = "",
    rating = "good",
    maximum_duration_turns = 1800,
})

content.upsert_effect_type(content.EffectType {
    id = "effect_telepathic_psi_armor",
    name = ccb.content.text("Telepathic Shield"),
    description = ccb.content.text("Your mind is warded against telepathic attack or detection."),
    apply_message = "",
    remove_message = ccb.content.text("Your thoughts are once again unguarded."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 17,
}
    :flag("TEEPSHIELD")
    :removes_effect("taint")
    :removes_effect("tindrift")
    :removes_effect("hallu")
    :removes_effect("hallucination_attacks")
    :removes_effect("visuals")
    :removes_effect("fearparalyze")
    :removes_effect("amigara")
    :removes_effect("psi_stunned")
    :removes_effect("telepathic_ignorance"))

content.add(content.EffectType {
    id = "effect_vitakin_hurt",
    name = ccb.content.text("Enervating Touch"),
    description = "This reduces monsters' regeneration.  It's a bug if you have it.",
    rating = "bad",
    maximum_duration_turns = 18000,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_vitakin_hurt_0")
    :modifier("hit", "amount", { base = -1 }))
