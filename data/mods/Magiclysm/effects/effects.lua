local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "mana_fatigue",
    name = ccb.content.text("Mana Fatigue"),
    description = ccb.content.text("You are exhausted from channeling a lot of mana."),
    apply_message = ccb.content.text("Channeling so much mana is making you tired"),
    remove_message = ccb.content.text("The burden of mana fatigue has faded"),
    rating = "bad",
}
    :modifier("sleepiness", "amount", { base = 1 })
    :modifier("sleepiness", "minimum", { base = 1 }))

content.add(content.EffectType {
    id = "mutagen_black_dragon",
    name = ccb.content.text("Black Dragon Mutation"),
    description = ccb.content.text("You consumed black dragon mutagen."),
    blood_analysis_description = ccb.content.text("Black Dragon Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Black Dragon Transformation"))
    :name(ccb.content.text("Black Dragon Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of black dragon mutagen."))
    :description(ccb.content.text("You consumed a life-changing amount of black dragon mutagen."))
    :resist_trait("THRESH_DRAGON_BLACK")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_manatouched",
    name = ccb.content.text("Mana Mutation"),
    description = ccb.content.text("You consumed concentrated mana."),
    blood_analysis_description = ccb.content.text("Concentrated Mana Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Mana Transformation"))
    :name(ccb.content.text("Mana Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of concentrated mana."))
    :description(ccb.content.text("You consumed a life-changing amount of concentrated mana."))
    :resist_trait("THRESH_MANA")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "enchant_windrun",
    name = ccb.content.text("Windrunning"),
    description = ccb.content.text("You are bolstered and pushed along by the power of the wind."),
    apply_message = ccb.content.text("You are bolstered and pushed along by the power of the wind."),
    remove_message = ccb.content.text("The wind at your back dies down."),
    rating = "good",
    maximum_duration_turns = 1200,
}
    :enchantment("INLINE_ENCH_enchant_windrun_0")
    :modifier("stamina", "minimum", { base = 10 }))

content.add(content.EffectType {
    id = "enchant_windrun_monster",
    name = ccb.content.text("Windrunning"),
    description = ccb.content.text("You are bolstered and pushed along by the power of the wind."),
    apply_message = ccb.content.text("You are bolstered and pushed along by the power of the wind."),
    remove_message = ccb.content.text("The wind at your back dies down."),
    rating = "good",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_enchant_windrun_monster_0")
    :modifier("stamina", "minimum", { base = 10 }))

content.add(content.EffectType {
    id = "dark_sight",
    name = ccb.content.text("Dark Sight"),
    description = ccb.content.text("You can see in the dark."),
    apply_message = ccb.content.text("Your sight adjusts to the darkness."),
    remove_message = ccb.content.text("The darkness loses its shape."),
    rating = "good",
    maximum_duration_turns = 40000,
}
    :enchantment("INLINE_ENCH_dark_sight_0")
    :enchantment("INLINE_ENCH_dark_sight_1"))

content.add(content.EffectType {
    id = "effect_ethereal_grasp",
    name = ccb.content.text("Ethereal Hold"),
    description = ccb.content.text("Ghostly arms are trying to hold you in place!"),
    apply_message = ccb.content.text("Ethereal arms shoot out of the ground and grab onto you!"),
    remove_message = ccb.content.text("The ghostly arms fade away."),
    maximum_intensity = 4,
    rating = "bad",
    maximum_duration_turns = 200,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_0")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_1")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_2")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_3")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_4"))

content.add(content.EffectType {
    id = "effect_ethereal_grasp_monster",
    name = ccb.content.text("Ethereal Hold"),
    description = ccb.content.text("Ghostly arms are trying to hold you in place!"),
    apply_message = ccb.content.text("Ethereal arms shoot out of the ground and grab onto you!"),
    remove_message = ccb.content.text("The ghostly arms fade away."),
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_monster_0")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_monster_1")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_monster_2")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_monster_3")
    :enchantment("INLINE_ENCH_effect_ethereal_grasp_monster_4"))

content.add(content.EffectType {
    id = "bless",
    name = ccb.content.text("Blessed"),
    description = ccb.content.text("You are filled with energy that improves everything you do."),
    apply_message = ccb.content.text("You are filled with energy that improves everything you do!"),
    remove_message = ccb.content.text("Your energy fades."),
    rating = "good",
    maximum_duration_turns = 1200,
}
    :removes_effect("effect_technomancer_arete")
    :enchantment("INLINE_ENCH_bless_0"))

content.add(content.EffectType {
    id = "bio_boost",
    name = ccb.content.text("Grotesque Enhancement"),
    description = ccb.content.text("Your body ripples with writhing alien muscles, your limbs lengthen, and your eyes glow with a faint green."),
    apply_message = ccb.content.text("Your body ripples with writhing alien muscles, your limbs lengthen, and your eyes glow with a faint green."),
    remove_message = ccb.content.text("Your body rapidly returns to normal."),
    rating = "good",
    maximum_duration_turns = 2400,
    maximum_intensity = 4,
}
    :enchantment("INLINE_ENCH_bio_boost_0"))

content.add(content.EffectType {
    id = "entangled",
    name = ccb.content.text("Vegetative Grasp"),
    description = ccb.content.text("Roots and vines entangle your foes."),
    apply_message = ccb.content.text("Roots and vines burst from the ground and entangle you!"),
    remove_message = ccb.content.text("The roots and vines wither up and die."),
    maximum_intensity = 4,
    show_in_info = true,
    rating = "bad",
    maximum_duration_turns = 400,
}
    :flag("EFFECT_IMPEDING")
    :enchantment("INLINE_ENCH_entangled_0")
    :enchantment("INLINE_ENCH_entangled_1")
    :enchantment("INLINE_ENCH_entangled_2")
    :enchantment("INLINE_ENCH_entangled_3")
    :enchantment("INLINE_ENCH_entangled_4"))

content.add(content.EffectType {
    id = "entangled_monster",
    name = ccb.content.text("Vegetative Grasp"),
    description = ccb.content.text("Roots and vines entangle your foes."),
    apply_message = ccb.content.text("Roots and vines burst from the ground and entangle you!"),
    remove_message = ccb.content.text("The roots and vines wither up and die."),
    maximum_intensity = 4,
    intensity_add_value = 1,
    show_in_info = true,
    rating = "bad",
    maximum_duration_turns = 400,
}
    :flag("EFFECT_IMPEDING")
    :enchantment("INLINE_ENCH_entangled_monster_0")
    :enchantment("INLINE_ENCH_entangled_monster_1")
    :enchantment("INLINE_ENCH_entangled_monster_2")
    :enchantment("INLINE_ENCH_entangled_monster_3"))

content.add(content.EffectType {
    id = "root_impale",
    name = ccb.content.text("Root Impale"),
    description = ccb.content.text("Roots and vines entangle your foes."),
    apply_message = ccb.content.text("Roots rip out from the ground and impale your enemies!"),
    remove_message = ccb.content.text("The roots wither up and die."),
    maximum_intensity = 4,
    intensity_add_value = 1,
    rating = "bad",
    maximum_duration_turns = 400,
}
    :enchantment("INLINE_ENCH_root_impale_0"))

content.add(content.EffectType {
    id = "effect_obfuscating_aura",
    name = ccb.content.text("Obfuscating Aura"),
    description = ccb.content.text("Light is distorting around you and making it easier for you to avoid attacks."),
    apply_message = ccb.content.text("The edges of your vision ripple slightly."),
    remove_message = ccb.content.text("The aura of light distortion around you vanishes."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :enchantment("INLINE_ENCH_effect_obfuscating_aura_0"))

content.add(content.EffectType {
    id = "effect_shape_of_dust",
    name = ccb.content.text("Shape of Dust"),
    description = ccb.content.text("Clouds of dust around you are hiding you from your enemies."),
    apply_message = ccb.content.text("Dust springs up and hides your presence."),
    remove_message = ccb.content.text("The clouds of dust around you die down"),
    rating = "good",
    maximum_duration_turns = 2400,
}
    :flag("INVISIBLE")
    :enchantment("ench_shape_of_dust"))

content.add(content.EffectType {
    id = "effect_acid_res_aura",
    name = ccb.content.text("Acid Resist Aura"),
    description = ccb.content.text("You are protected from acid damage."),
    apply_message = ccb.content.text("Your body tingles."),
    remove_message = ccb.content.text("The tingling fades."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :enchantment("INLINE_ENCH_effect_acid_res_aura_0"))

content.add(content.EffectType {
    id = "effect_acid_res_aura_greater",
    name = ccb.content.text("Greater Acid Resist Aura"),
    description = ccb.content.text("You are greatly protected from acid damage."),
    apply_message = ccb.content.text("Your body tingles."),
    remove_message = ccb.content.text("The tingling fades."),
    rating = "good",
    maximum_duration_turns = 7200,
}
    :enchantment("INLINE_ENCH_effect_acid_res_aura_greater_0"))

content.add(content.EffectType {
    id = "effect_thorns_electric",
    name = ccb.content.text("Aura of Repelling Arc"),
    description = ccb.content.text("Anyone who attacks you will be electrified."),
    apply_message = ccb.content.text("The air around you sparks with electricity."),
    remove_message = ccb.content.text("The air around you loses its charge."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :enchantment("INLINE_ENCH_effect_thorns_electric_0"))

content.add(content.EffectType {
    id = "bio_acidburn",
    name = ccb.content.text("Acidic burn"),
    description = ccb.content.text("Burned with acid"),
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -20, per_intensity = -10 }))

content.add(content.EffectType {
    id = "magic_slowed",
    name = ccb.content.text("Slowed"),
    description = ccb.content.text("Your speed is magically inhibited."),
    apply_message = ccb.content.text("Everyone else suddenly seems to speed up!"),
    remove_message = ccb.content.text("You return to your normal speed."),
    rating = "bad",
    show_in_info = true,
    maximum_duration_turns = 480,
}
    :removes_effect("haste")
    :enchantment("INLINE_ENCH_magic_slowed_0"))

content.add(content.EffectType {
    id = "synaptic_stim",
    name = ccb.content.text("Synaptic Stimulation"),
    description = ccb.content.text("Your mental processing is increased."),
    apply_message = ccb.content.text("Your mind accelerates."),
    remove_message = ccb.content.text("Your mind returns to normal speed."),
    rating = "good",
    show_in_info = true,
    maximum_duration_turns = 7200,
}
    :modifier("dexterity", "amount", { base = 4 })
    :modifier("intelligence", "amount", { base = 4 })
    :modifier("speed", "amount", { base = 30 }))

content.add(content.EffectType {
    id = "ogres_strength",
    name = ccb.content.text("Strength of Arm"),
    description = ccb.content.text("Your strength is greatly increased."),
    apply_message = ccb.content.text("You feel strong!"),
    remove_message = ccb.content.text("Your strength deflates."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :removes_effect("eagles_sight")
    :removes_effect("cats_grace")
    :removes_effect("foxs_cunning")
    :removes_effect("effect_technomancer_arete")
    :removes_effect("bless")
    :enchantment("INLINE_ENCH_ogres_strength_0"))

content.add(content.EffectType {
    id = "safe_shoppers",
    name = ccb.content.text("Safe Shopping Experience"),
    description = ccb.content.text("Magical Store Security"),
    apply_message = ccb.content.text("You feel very seen!"),
    remove_message = ccb.content.text("You no longer feel like somebody's watching you."),
    rating = "good",
    maximum_duration_turns = 3600,
}
    :removes_effect("invisibility"))

content.add(content.EffectType {
    id = "eagles_sight",
    name = ccb.content.text("Keenness of Sight"),
    description = ccb.content.text("All of your senses are sharpened."),
    apply_message = ccb.content.text("You notice small details!"),
    remove_message = ccb.content.text("Your vision returns to normal."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :removes_effect("ogres_strength")
    :removes_effect("cats_grace")
    :removes_effect("foxs_cunning")
    :removes_effect("effect_technomancer_arete")
    :removes_effect("bless")
    :enchantment("INLINE_ENCH_eagles_sight_0"))

content.add(content.EffectType {
    id = "cats_grace",
    name = ccb.content.text("Steadiness of Hand"),
    description = ccb.content.text("You have greatly heightened reflexes."),
    apply_message = ccb.content.text("Your reflexes are heightened!"),
    remove_message = ccb.content.text("Your reflexes return to normal."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :removes_effect("ogres_strength")
    :removes_effect("eagles_sight")
    :removes_effect("foxs_cunning")
    :removes_effect("effect_technomancer_arete")
    :removes_effect("bless")
    :enchantment("INLINE_ENCH_cats_grace_0"))

content.add(content.EffectType {
    id = "foxs_cunning",
    name = ccb.content.text("Clarity of Thought"),
    description = ccb.content.text("You increased clarity of thought."),
    apply_message = ccb.content.text("Your intelligence is heightened!"),
    remove_message = ccb.content.text("Your intelligence returns to normal."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :removes_effect("ogres_strength")
    :removes_effect("eagles_sight")
    :removes_effect("cats_grace")
    :removes_effect("effect_technomancer_arete")
    :removes_effect("bless")
    :enchantment("INLINE_ENCH_foxs_cunning_0"))

content.add(content.EffectType {
    id = "debug_full_protection",
    name = ccb.content.text("Debug Full Protection"),
    description = ccb.content.text("You can not be harmed by anything."),
    apply_message = ccb.content.text("Your skin tingle with the power of the Devs!"),
    remove_message = ccb.content.text("Your skin stops tingling, your life is empty and meaningless again."),
    rating = "good",
}
    :flag("ELECTRIC_IMMUNE")
    :flag("BIO_IMMUNE")
    :flag("BASH_IMMUNE")
    :flag("CUT_IMMUNE")
    :flag("ACID_IMMUNE")
    :flag("STAB_IMMUNE")
    :flag("HEAT_IMMUNE")
    :flag("COLD_IMMUNE"))

content.add(content.EffectType {
    id = "feather_fall",
    name = ccb.content.text("Pluma"),
    description = ccb.content.text("You are light as a feather and fall like one."),
    apply_message = ccb.content.text("Your body feels light as a feather."),
    remove_message = ccb.content.text("The earth pulls you down hard."),
    rating = "good",
}
    :flag("FEATHER_FALL"))

content.add(content.EffectType {
    id = "eff_frightful_presence",
    name = ccb.content.text("Scared"),
    description = ccb.content.text("Your knees are shaking, your heart beats fast, and your stomach rebels."),
    apply_message = ccb.content.text("You are afraid!"),
    remove_message = ccb.content.text("Your fear dissipates."),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Frightened"))
    :name(ccb.content.text("Terrified"))
    :modifier("stimulant", "amount", { base = 12, per_intensity = 12, resisted_base = 6, resisted_per_intensity = 6 })
    :modifier("vomiting", "chance_numerator", { base = 50, per_intensity = -15, resisted_base = 100, resisted_per_intensity = -5 })
    :modifier("speed", "amount", { base = -2, per_intensity = -4, resisted_base = -1, resisted_per_intensity = -1 })
    :modifier("stimulant", "maximum_value", { base = 30 }))

content.add(content.EffectType {
    id = "effect_catoblepas_gaze",
    name = ccb.content.text("Rotting Gaze"),
    description = ccb.content.text("You flesh is rotting off!"),
    apply_message = ccb.content.text("Searing pain fills your body."),
    rating = "bad",
    maximum_intensity = 3,
}
    :modifier("hurt", "minimum", { base = 1, per_intensity = 1 })
    :modifier("hurt", "maximum", { base = 3, per_intensity = 3 })
    :modifier("hurt", "chance_numerator", { base = 2 }))

content.add(content.EffectType {
    id = "effect_catoblepas_gaze_monster",
    name = ccb.content.text("Rotting Gaze"),
    description = ccb.content.text("You flesh is rotting off!"),
    apply_message = ccb.content.text("Searing pain fills your body."),
    rating = "bad",
    maximum_intensity = 3,
}
    :modifier("hurt", "minimum", { base = 4, per_intensity = 3 })
    :modifier("hurt", "maximum", { base = 9, per_intensity = 6 })
    :modifier("hurt", "chance_numerator", { base = 2 }))

content.add(content.EffectType {
    id = "biomancer_visceral_side_effects",
    name = ccb.content.text("Visceral Overexertion"),
    description = ccb.content.text("You feel sickened from overtaxing your body, having extended your influence over such a wide area."),
    rating = "bad",
    maximum_duration_turns = 60,
}
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("sleepiness", "chance_numerator", { base = 5 })
    :modifier("health", "minimum", { base = -3 })
    :modifier("health", "chance_numerator", { base = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 4 })
    :modifier("vomiting", "chance_numerator", { base = 20 }))

content.add(content.EffectType {
    id = "effect_biomancer_aura_caustic",
    name = ccb.content.text("Caustic Aura"),
    description = ccb.content.text("An aura of thin acid, swirling around your body ready to corrode your enemies when struck or while striking."),
    rating = "good",
    maximum_duration_turns = 86400,
}
    :enchantment("ench_aura_caustic"))

content.add(content.EffectType {
    id = "bio_weave",
    name = ccb.content.text("Coagulant Weave"),
    description = ccb.content.text("Immunity to bleeding and bites, increased stamina regeneration, increased hunger and thirst gain."),
    remove_message = ccb.content.text("The tension running through your flesh fades."),
    rating = "good",
    maximum_duration_turns = 3600,
}
    :blocks_effect("bleed")
    :blocks_effect("bite")
    :enchantment("INLINE_ENCH_bio_weave_0")
    :modifier("hunger", "minimum", { base = 1 })
    :modifier("hunger", "chance_numerator", { base = 12 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "chance_numerator", { base = 12 })
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 4 })
    :modifier("stamina", "minimum", { base = 40 })
    :modifier("stamina", "chance_numerator", { base = 2 }))

-- Basically just paralyze poison set to work in a manner useful for spells.
content.add(content.EffectType {
    id = "biomancer_dart_venom",
    name = ccb.content.text("Biomantic Venom"),
    description = ccb.content.text("You feel sluggish and weak, from magically-induced poisoning."),
    rating = "bad",
    maximum_intensity = 20,
    intensity_duration_turns = 30,
}
    :modifier("strength", "amount", { base = -1, per_intensity = -0.07 })
    :modifier("dexterity", "amount", { base = -0.17, per_intensity = -0.17 })
    :modifier("speed", "amount", { base = -3, per_intensity = -3 }))

content.add(content.EffectType {
    id = "tornskin_pain",
    name = ccb.content.text("Sharp Thorns"),
    description = ccb.content.text("Thorns are whirling around you, regularly causing cuts into you."),
    apply_message = ccb.content.text("Thorns in the wind begin slicing into you!"),
    remove_message = ccb.content.text("The thorns fall to the ground."),
    rating = "bad",
    maximum_duration_turns = 12,
}
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 6 })
    :modifier("speed", "amount", { base = -1 }))

content.add(content.EffectType {
    id = "neuro_boost",
    name = ccb.content.text("Mental Boost"),
    description = ccb.content.text("Your mind is working incredibly fast and your body struggles to keep up."),
    rating = "bad",
    maximum_duration_turns = 40,
}
    :modifier("speed", "amount", { base = 20 }))

content.add(content.EffectType {
    id = "vault_atmosphere",
    name = ccb.content.text("Vault Air"),
    description = ccb.content.text("You feel at home."),
    apply_message = ccb.content.text("This smells like home."),
    remove_message = ccb.content.text("Time to go."),
    rating = "bad",
    maximum_duration_turns = 172800,
}
    :flag("DIMENSIONAL_ANCHOR"))

content.add(content.EffectType {
    id = "effect_earthshaper_petrifying_touch",
    name = ccb.content.text("Petrified"),
    description = ccb.content.text("You are made of stone.  Fortunately it's temporary."),
    rating = "bad",
    maximum_duration_turns = 480,
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE")
    :removes_effect("haste")
    :removes_effect("enchant_windrun")
    :removes_effect("flask_speed_eff")
    :enchantment("INLINE_ENCH_effect_earthshaper_petrifying_touch_0"))

content.add(content.EffectType {
    id = "slow_freeze_effect",
    name = ccb.content.text("Slow Freeze"),
    description = ccb.content.text("The cold slows down your foes."),
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -25, per_intensity = -5 }))

-- slowdown for shaman attunement
content.add(content.EffectType {
    id = "mind_reading",
    name = "",
    description = "",
    maximum_intensity = 1,
    intensity_add_value = 1,
    maximum_duration_turns = 6,
}
    :modifier("speed", "amount", { base = -25 }))

content.add(content.EffectType {
    id = "cold_heart_effect",
    name = ccb.content.text("Cold Heart"),
    description = ccb.content.text("Full of chilled blood, the heart slows as it grows cold."),
    apply_message = ccb.content.text("You feel yourself getting slower, as ice seems to run through your veins."),
    remove_message = ccb.content.text("You feel yourself recovering your normal speed."),
    rating = "bad",
    maximum_intensity = 3,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -30, per_intensity = -30 }))

content.add(content.EffectType {
    id = "boreal_mage_slow_chilled",
    name = ccb.content.text("Chilled"),
    description = ccb.content.text("A frozen aura has chilled you to the bone."),
    apply_message = ccb.content.text("You feel yourself getting slower, as ice seems to run through your veins."),
    remove_message = ccb.content.text("The bone-deep chill fades away."),
    rating = "bad",
    show_in_info = true,
}
    :immune_character_flag("COLD_IMMUNE")
    :immune_character_flag("COLDPROOF")
    :modifier("speed", "amount", { base = -20 }))

content.add(content.EffectType {
    id = "overclocker_drive_effect",
    name = ccb.content.text("Overdrive"),
    description = ccb.content.text("Is it possible to dart aside and avoid a cannon ball?  Is it possible to grab an arrow in flight with one hand?"),
    apply_message = ccb.content.text("You feel yourself move faster than a bullet."),
    remove_message = ccb.content.text("You feel yourself returning to your normal speed."),
    rating = "good",
    maximum_duration_turns = 6000,
}
    :removes_effect("haste")
    :modifier("sleepiness", "amount", { base = 1 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("sleepiness", "tick", { base = 3 })
    :modifier("speed", "amount", { base = 300 })
    :modifier("perception", "amount", { base = -4 })
    :modifier("dexterity", "amount", { base = 8 }))

content.add(content.EffectType {
    id = "alkahest",
    name = ccb.content.text("Stepped on alkahest"),
    description = ccb.content.text("You're standing in alkahest!"),
    maximum_intensity = 5,
}
    :modifier("speed", "amount", { base = -20, per_intensity = -15 })
    :modifier("hurt", "amount", { base = 10, per_intensity = 5 }))

content.add(content.EffectType {
    id = "biomechanic",
    name = ccb.content.text("Biomechanism"),
    description = ccb.content.text("Hunt.  Let them feel."),
    remove_message = ccb.content.text("Your body returns to its normal state."),
    rating = "good",
    maximum_duration_turns = 1320,
    maximum_intensity = 25,
    intensity_add_value = 1,
}
    :modifier("perception", "amount", { base = 1, per_intensity = 0.4 })
    :modifier("dexterity", "amount", { base = 1, per_intensity = 0.4 })
    :modifier("strength", "amount", { base = 1, per_intensity = 0.4 })
    :modifier("intelligence", "amount", { base = 1, per_intensity = 0.4 })
    :modifier("stamina", "minimum", { base = 5, per_intensity = 5 }))

content.add(content.EffectType {
    id = "ice_energy",
    name = ccb.content.text("Ice erosion"),
    description = ccb.content.text("Ice crystals erode your body from all directions."),
    intensity_add_value = 1,
    maximum_intensity = 3,
}
    :modifier("speed", "amount", { base = -10, per_intensity = -15 })
    :modifier("hurt", "amount", { base = 1, per_intensity = 4 }))

content.add(content.EffectType {
    id = "eshaper_melee_damage",
    name = ccb.content.text("Heft"),
    description = ccb.content.text("Your body is heavy as the heaviest rocks.  Your attack speed is slowed down, but your melee damage increased drastically."),
    apply_message = ccb.content.text("You feel your body compress and harden."),
    remove_message = ccb.content.text("You no longer feel encumbered."),
    rating = "good",
    maximum_duration_turns = 14400,
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_eshaper_melee_damage_0"))

content.add(content.EffectType {
    id = "effect_technomancer_invisibility",
    name = ccb.content.text("Invisible"),
    description = ccb.content.text("You are invisible."),
    remove_message = ccb.content.text("Your invisibility fades."),
    rating = "good",
    maximum_duration_turns = 240,
}
    :flag("INVISIBLE"))

content.add(content.EffectType {
    id = "effect_technomancer_gain_electronics_computer",
    name = ccb.content.text("Machine Mind"),
    description = ccb.content.text("You have an intuitive understanding of computers."),
    remove_message = ccb.content.text("Your mind no longer easily grasps the flow of electrons."),
    rating = "good",
    maximum_duration_turns = 57600,
}
    :enchantment("INLINE_ENCH_effect_technomancer_gain_electronics_computer_0"))

content.add(content.EffectType {
    id = "effect_technomancer_pain_ignore",
    name = ccb.content.text("The Body Mechanical"),
    description = ccb.content.text("Your body functions through pain with mechanical efficiency."),
    remove_message = ccb.content.text("Pain suddenly hampers you again."),
    rating = "good",
    maximum_duration_turns = 100,
}
    :enchantment("INLINE_ENCH_effect_technomancer_pain_ignore_0"))

content.add(content.EffectType {
    id = "effect_technomancer_arete",
    name = ccb.content.text("Arete"),
    description = ccb.content.text("You are at the apex of possibility."),
    apply_message = "",
    remove_message = ccb.content.text("Your heightened capabilities fade away."),
    rating = "good",
    maximum_duration_turns = 72000,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :removes_effect("eagles_sight")
    :removes_effect("cats_grace")
    :removes_effect("foxs_cunning")
    :removes_effect("ogres_strength")
    :removes_effect("bless")
    :enchantment("INLINE_ENCH_effect_technomancer_arete_0")
    :enchantment("INLINE_ENCH_effect_technomancer_arete_1")
    :enchantment("INLINE_ENCH_effect_technomancer_arete_2")
    :enchantment("INLINE_ENCH_effect_technomancer_arete_3")
    :enchantment("INLINE_ENCH_effect_technomancer_arete_4")
    :limb_score("manip", { multiplier = 1.1 })
    :limb_score("block", { multiplier = 1.1 })
    :limb_score("vision", { multiplier = 1.1 })
    :limb_score("reaction", { multiplier = 1.1 })
    :limb_score("move_speed", { multiplier = 1.1 })
    :limb_score("balance", { multiplier = 1.1 })
    :limb_score("footing", { multiplier = 1.1 })
    :limb_score("swim", { multiplier = 1.1 }))

content.add(content.EffectType {
    id = "eshaper_crystal_wrap",
    name = ccb.content.text("Crystal Wrapping"),
    description = ccb.content.text("Thin layer of almost living crystals, that rapidly grows and moves on the body."),
    apply_message = ccb.content.text("You feel a light, purple material cover your body and clothes."),
    remove_message = ccb.content.text("The crystals crumble."),
    rating = "good",
    maximum_duration_turns = 14400,
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_eshaper_crystal_wrap_0"))

content.add(content.EffectType {
    id = "electric_eye",
    name = ccb.content.text("Electric Eye"),
    description = ccb.content.text("Enhance your sight with your powers.  It allows you to see creatures of the same energy around you, and some minor bonuses."),
    apply_message = ccb.content.text("Your sight is enhanced."),
    remove_message = ccb.content.text("Your sight turn back to usual state."),
    rating = "good",
    maximum_duration_turns = 57600,
    show_intensity = false,
}
    :enchantment("ELECTRIC_VISION")
    :enchantment("INLINE_ENCH_electric_eye_1"))

content.add(content.EffectType {
    id = "electric_waves",
    name = ccb.content.text("Electric Waves"),
    description = ccb.content.text("Your body will release a massive electric charges when you attack monsters."),
    apply_message = ccb.content.text("A powerful energy streams out of your hands."),
    remove_message = ccb.content.text("The energy streams calm down."),
    rating = "good",
    maximum_duration_turns = 14400,
    show_intensity = false,
}
    :enchantment("enchant_stormshaper_electric_waves"))

content.add(content.EffectType {
    id = "electric_arts",
    name = ccb.content.text("Electric Arts"),
    description = ccb.content.text("Make you less vulnerable to electric damage."),
    apply_message = ccb.content.text("You feel a small sparks under your skin.  They do not harm you."),
    remove_message = ccb.content.text("Sparks under your skin vanish."),
    rating = "good",
    maximum_duration_turns = 230400,
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_electric_arts_0"))

content.add(content.EffectType {
    id = "ice_age_eff",
    name = ccb.content.text("Glaciation"),
    description = ccb.content.text("You are frozen, your bones are fragile; cracking in the cold, and your muscles are cut by razor sharp ice."),
}
    :modifier("speed", "amount", { base = -75 }))

content.add(content.EffectType {
    id = "flower_fern_eff",
    name = ccb.content.text("Positivity"),
    description = ccb.content.text("Your feel yourself a bit better."),
    rating = "good",
}
    :modifier("perception", "amount", { base = 1 })
    :modifier("dexterity", "amount", { base = 1 })
    :modifier("strength", "amount", { base = 1 })
    :modifier("intelligence", "amount", { base = 1 }))

content.add(content.EffectType {
    id = "glowing_mushroom_eff",
    name = ccb.content.text("Lightness"),
    description = ccb.content.text("You feel yourself a bit lighter.  You doubt you can lose weight from this."),
}
    :modifier("speed", "amount", { base = 15 }))

content.add(content.EffectType {
    id = "flask_speed_eff",
    name = ccb.content.text("Velocitas"),
    description = ccb.content.text("Make you faster, and allow to hold this state for a while."),
    apply_message = ccb.content.text("You feel your legs can work much better than before"),
    remove_message = ccb.content.text("Your speed slows down."),
    rating = "good",
}
    :modifier("speed", "amount", { base = 40 })
    :modifier("stamina", "minimum", { base = 20 }))

-- i have no idea how health works now, so ill just copypaste the nature commune effect and stretch it.
content.add(content.EffectType {
    id = "flask_healing_eff",
    name = ccb.content.text("Sanatio"),
    description = ccb.content.text("Improve your organism's ability to heal himself."),
}
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 2880 })
    :modifier("health_modifier", "minimum", { base = 1 })
    :modifier("health_modifier", "chance_numerator", { base = 5760 }))

content.add(content.EffectType {
    id = "flask_stamina_eff",
    name = ccb.content.text("Constantia"),
    description = ccb.content.text("You can't get tired."),
    apply_message = ccb.content.text("You feel an energy in your muscles, jazzed up and full of vitality."),
    remove_message = ccb.content.text("The energy in your body fades away."),
}
    :modifier("stamina", "minimum", { base = 50 }))

content.add(content.EffectType {
    id = "flask_excitement",
    name = ccb.content.text("Motus"),
    description = ccb.content.text("Your reaction now is way better than before."),
    apply_message = ccb.content.text("You can feel the fly wings movement now."),
    remove_message = ccb.content.text("Your reflexes turn back to normal."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_flask_excitement_0"))

content.add(content.EffectType {
    id = "flask_resistance",
    name = ccb.content.text("Resistentia"),
    description = ccb.content.text("A thin layer of energy covers your body, and allows you to take more physical damage than before."),
    apply_message = ccb.content.text("Your touch sense are blunted for a bit, but your skin feels more dense."),
    remove_message = ccb.content.text("The sturdy feeling is gone."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_flask_resistance_0"))

content.add(content.EffectType {
    id = "flask_illumination",
    name = ccb.content.text("Illuminatio"),
    description = ccb.content.text("Your body emits a lot of light around you."),
    apply_message = ccb.content.text("Your skin glow like an old lantern.  You feel no discomfort for some reason."),
    remove_message = ccb.content.text("Your skin turn back to normal state."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_flask_illumination_0"))

content.add(content.EffectType {
    id = "flask_mana_regen",
    name = ccb.content.text("Recuperatio"),
    description = ccb.content.text("Increase the amount of ley-lines your body can process at once, making you restore your mana pool faster."),
    apply_message = ccb.content.text("You can feel the thinnest ley lines around you."),
    remove_message = ccb.content.text("The mana senses blunts."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_flask_mana_regen_0"))

content.add(content.EffectType {
    id = "flask_max_mana",
    name = ccb.content.text("Augere"),
    description = ccb.content.text("Increase the amount of mana you can operate."),
    apply_message = ccb.content.text("You feel a deep mana well inside your body."),
    remove_message = ccb.content.text("Your well feels empty now."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_flask_max_mana_0"))

content.add(content.EffectType {
    id = "flask_regeneration",
    name = ccb.content.text("Regeneration"),
    description = ccb.content.text("Slowly regenerate your damaged body."),
    apply_message = ccb.content.text("Your flesh and bones start to regenerate before your eyes."),
    remove_message = ccb.content.text("Your regeneration slows down."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_flask_regeneration_0"))

content.add(content.EffectType {
    id = "technomancer_cl_booster_effect",
    name = ccb.content.text("Technomancer boost"),
    description = ccb.content.text("Your technomancer spells are empowered."),
    remove_message = ccb.content.text("Your technomancer boost fades."),
    rating = "good",
    show_intensity = true,
    maximum_intensity = 25,
    intensity_add_value = 1,
})

content.add(content.EffectType {
    id = "biomancer_cl_booster_effect",
    name = ccb.content.text("Biomancer boost"),
    description = ccb.content.text("Your biomancer spells are empowered."),
    remove_message = ccb.content.text("Your biomancer boost fades."),
    rating = "good",
    show_intensity = true,
    maximum_intensity = 25,
    intensity_add_value = 1,
})

content.add(content.EffectType {
    id = "earthshaper_fortitude_of_stone",
    name = ccb.content.text("Stones' Fortitude"),
    description = ccb.content.text("You feel little hunger or thirst."),
    apply_message = "",
    remove_message = ccb.content.text("Your stomach suddenly rumbles as you feel a pang of hunger."),
    rating = "good",
    maximum_duration_turns = 86400,
}
    :enchantment("INLINE_ENCH_earthshaper_fortitude_of_stone_0"))

content.add(content.EffectType {
    id = "effect_tremorsense",
    name = ccb.content.text("Tremorsense"),
    description = ccb.content.text("You can feel them moving around you."),
    apply_message = "",
    remove_message = ccb.content.text("You can no longer discern the vibrations of the living earth."),
    rating = "good",
    maximum_duration_turns = 12000,
}
    :enchantment("INLINE_ENCH_effect_tremorsense_0"))

content.add(content.EffectType {
    id = "effect_sense_outsiders",
    name = ccb.content.text("Sense Outsider"),
    description = ccb.content.text("You can sense the presence of things that should not be."),
    apply_message = "",
    remove_message = ccb.content.text("Your awareness of outsiders fades."),
    rating = "good",
    maximum_duration_turns = 36000,
}
    :enchantment("INLINE_ENCH_effect_sense_outsiders_0"))

content.add(content.EffectType {
    id = "effect_animist_detect_wizards",
    name = ccb.content.text("Witchsight"),
    description = ccb.content.text("You can sense nearby magic-wielders."),
    apply_message = "",
    remove_message = ccb.content.text("Your awareness of the magically-inclined fades."),
    rating = "good",
    maximum_duration_turns = 27600,
}
    :enchantment("INLINE_ENCH_effect_animist_detect_wizards_0"))

content.add(content.EffectType {
    id = "effect_animist_see_invisibility",
    name = ccb.content.text("Seeing the Unseen"),
    description = ccb.content.text("You can detect nearby invisible creatures."),
    apply_message = "",
    remove_message = ccb.content.text("Your awareness of the invisible fades."),
    rating = "good",
    maximum_duration_turns = 19200,
}
    :flag("TRUE_SEEING"))

content.add(content.EffectType {
    id = "effect_animist_add_evasion",
    name = ccb.content.text("Guardian Spirit"),
    description = ccb.content.text("A protective spirit is looking out for you."),
    apply_message = "",
    remove_message = ccb.content.text("With a soft whisper, the guardian spirit returns from whence it came."),
    rating = "good",
    maximum_duration_turns = 19200,
}
    :enchantment("INLINE_ENCH_effect_animist_add_evasion_0"))

content.add(content.EffectType {
    id = "effect_animist_vocalize",
    name = ccb.content.text("The Inner Voice"),
    description = ccb.content.text("Your soul gives voice to your magical prowess."),
    apply_message = "",
    remove_message = ccb.content.text("Your soul no longer speaks directly."),
    rating = "good",
    maximum_duration_turns = 12000,
}
    :flag("SILENT_SPELL"))

content.add(content.EffectType {
    id = "effect_druid_anti_heat",
    name = ccb.content.text("Water's Cooling Touch"),
    description = ccb.content.text("Your skin feels like you just splashed cool water on it."),
    apply_message = "",
    remove_message = ccb.content.text("A warm breeze hits your skin."),
    rating = "good",
    maximum_duration_turns = 36000,
}
    :enchantment("INLINE_ENCH_effect_druid_anti_heat_0"))

content.add(content.EffectType {
    id = "effect_kelvinist_anti_cold",
    name = ccb.content.text("Cloak of Warmth"),
    description = ccb.content.text("The air around you is warmer thanks to your magic."),
    apply_message = "",
    remove_message = ccb.content.text("A cool breeze hits your skin."),
    rating = "good",
    maximum_duration_turns = 86400,
}
    :removes_effect("effect_kelvinist_anti_heat")
    :enchantment("INLINE_ENCH_effect_kelvinist_anti_cold_0"))

content.add(content.EffectType {
    id = "effect_kelvinist_anti_heat",
    name = ccb.content.text("Cloak of Chill"),
    description = ccb.content.text("The air around you is cooler thanks to your magic."),
    apply_message = "",
    remove_message = ccb.content.text("A warm breeze hits your skin."),
    rating = "good",
    maximum_duration_turns = 86400,
}
    :removes_effect("effect_kelvinist_anti_cold")
    :enchantment("INLINE_ENCH_effect_kelvinist_anti_heat_0"))

content.add(content.EffectType {
    id = "effect_kelvinist_frozen_heart",
    name = ccb.content.text("The Rime-Covered Heart"),
    description = ccb.content.text("All emotion is frozen out."),
    remove_message = ccb.content.text("You take a shuddering breath as emotion floods back into your heart."),
    rating = "mixed",
    maximum_duration_turns = 38400,
}
    :flag("NUMB")
    :flag("PSYCHOPATH"))

content.add(content.EffectType {
    id = "effect_kelvinist_flames_of_passion",
    name = ccb.content.text("Flames of Passion"),
    description = ccb.content.text("You burn with the intensity of your conviction."),
    apply_message = "",
    remove_message = ccb.content.text("The world seems dreary as your spell fades."),
    rating = "good",
    maximum_duration_turns = 39600,
}
    :enchantment("INLINE_ENCH_effect_kelvinist_flames_of_passion_0"))

content.add(content.EffectType {
    id = "effect_magus_slowfall",
    name = ccb.content.text("Slowfall"),
    description = ccb.content.text("You won't hit the ground nearly as hard anymore."),
    apply_message = "",
    remove_message = ccb.content.text("You can feel gravity take hold of you again."),
    rating = "good",
    maximum_duration_turns = 1200,
}
    :enchantment("INLINE_ENCH_effect_magus_slowfall_0"))

content.add(content.EffectType {
    id = "effect_magus_spiderclimb",
    name = ccb.content.text("Spider Climb"),
    description = ccb.content.text("You can quickly ascend sheer surfaces."),
    apply_message = "",
    remove_message = ccb.content.text("Your enhanced climbing ability vanishes."),
    rating = "good",
    maximum_duration_turns = 4800,
}
    :flag("CLIMB_NO_LADDER")
    :flag("WALL_CLING"))

content.add(content.EffectType {
    id = "effect_magus_ranged_increase",
    name = ccb.content.text("Arrowflight"),
    description = ccb.content.text("Your ranged weapons travel much further than physics claims they should."),
    apply_message = "",
    remove_message = ccb.content.text("Your weapons return to their normal range."),
    rating = "good",
    maximum_duration_turns = 23040,
}
    :enchantment("INLINE_ENCH_effect_magus_ranged_increase_0"))

content.add(content.EffectType {
    id = "effect_magus_faerie_fire",
    name = ccb.content.text("Faerie Fire"),
    description = ccb.content.text("You are glowing."),
    apply_message = "",
    remove_message = ccb.content.text("The glow around you fades."),
    rating = "bad",
    maximum_duration_turns = 1200,
}
    :enchantment("INLINE_ENCH_effect_magus_faerie_fire_0")
    :modifier("dodge", "amount", { base = -1 }))

-- Minor stamina regen to help with swimming.  If people want to cast this spell as a stamina buff, they're welcome to do it and deal with their froggy limbs.
content.add(content.EffectType {
    id = "effect_biomancer_swim_speed",
    name = ccb.content.text("Frog Limbs"),
    description = ccb.content.text("Your hands and feet have grown webbing, enabling faster swimming."),
    apply_message = "",
    remove_message = ccb.content.text("With an unpleasant twisting sensation your hands and feet return to normal."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :enchantment("INLINE_ENCH_effect_biomancer_swim_speed_0")
    :modifier("stamina", "minimum", { base = 10 }))

content.add(content.EffectType {
    id = "effect_biomancer_lashing_tentacles",
    name = ccb.content.text("Lashing Tentacles"),
    description = ccb.content.text("Two tentacles sprout from your shoulders, ready to attack your enemies."),
    apply_message = ccb.content.text("Your shoulders itch before two barbed tentacles erupt from them!"),
    remove_message = ccb.content.text("The tentacles recede back into your body."),
    rating = "good",
    maximum_duration_turns = 1200,
}
    :enchantment("INLINE_ENCH_effect_biomancer_lashing_tentacles_0"))

content.add(content.EffectType {
    id = "effect_biomancer_caustic_blood",
    name = ccb.content.text("Caustic Blood"),
    description = ccb.content.text("You have transformed your blood into acid."),
    apply_message = ccb.content.text("Your entire body burns for a moment."),
    remove_message = ccb.content.text("The faint burning sensation fades."),
    rating = "good",
    maximum_duration_turns = 55200,
}
    :enchantment("INLINE_ENCH_effect_biomancer_caustic_blood_0"))

content.add(content.EffectType {
    id = "effect_biomancer_remove_instability",
    name = ccb.content.text("Increased Stability"),
    description = ccb.content.text("You are defended against the possible effects of XE037 overexposure."),
    apply_message = ccb.content.text("You feel…strange."),
    remove_message = ccb.content.text("The strange feeling passes and you feel more like yourself."),
    rating = "good",
    maximum_duration_turns = 1800000,
    maximum_intensity = 2,
    show_intensity = false,
}
    :description(ccb.content.text("You are still defended against the effects of XE037 overexposure but now you feel awful!"))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_biomancer_remove_instability_0")
    :modifier("speed", "amount", { per_intensity = -25 })
    :modifier("strength", "amount", { per_intensity = -5 })
    :modifier("dexterity", "amount", { per_intensity = -5 })
    :modifier("intelligence", "amount", { per_intensity = -5 })
    :modifier("perception", "amount", { per_intensity = -5 })
    :limb_score("manip", { multiplier = 1, per_intensity = -0.3 })
    :limb_score("block", { multiplier = 1.0, per_intensity = -0.2 })
    :limb_score("vision", { multiplier = 1.0, per_intensity = -0.05 })
    :limb_score("reaction", { multiplier = 1, per_intensity = -0.3 })
    :limb_score("move_speed", { multiplier = 1.0, per_intensity = -0.05 })
    :limb_score("balance", { multiplier = 1, per_intensity = -0.2 })
    :limb_score("footing", { multiplier = 1, per_intensity = -0.3 })
    :limb_score("swim", { multiplier = 1.0, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "effect_biomancer_control_mutations",
    name = ccb.content.text("Morphogenic Mastery"),
    description = ccb.content.text("You are able to exert conscious control over any mutations to your body."),
    apply_message = ccb.content.text("You feel…strange."),
    remove_message = ccb.content.text("The strange feeling passes and you feel more like yourself."),
    rating = "good",
    maximum_duration_turns = 122400,
}
    :enchantment("INLINE_ENCH_effect_biomancer_control_mutations_0"))

content.add(content.EffectType {
    id = "effect_biomancer_carrion_feast",
    name = ccb.content.text("Carrion Feast"),
    description = ccb.content.text("You can eat rotten food without any trouble, if you can stand the taste."),
    apply_message = ccb.content.text("Your have a hunger for some overly-aged meat."),
    remove_message = ccb.content.text("You can't believe you even considered eating that!  Yuck!"),
    rating = "good",
    maximum_duration_turns = 1440,
    show_intensity = false,
}
    :flag("IMMUNE_SPOIL")
    :flag("PARAIMMUNE")
    :blocks_effect("foodpoison")
    :vitamin("mutant_toxin", {
        rates = { { minimum = -1, maximum = -1 } },
        absorption = { 0.5 },
        tick_turns = { 30 },
    }))

content.add(content.EffectType {
    id = "effect_classless_watch",
    name = ccb.content.text("Know the Day and the Hour"),
    description = ccb.content.text("You know exactly what time it is."),
    apply_message = "",
    remove_message = ccb.content.text("Your perfect sense of time fades away."),
    rating = "good",
    maximum_duration_turns = 345600,
}
    :flag("WATCH"))

content.add(content.EffectType {
    id = "effect_classless_magic_light",
    name = ccb.content.text("Orb of Light"),
    description = ccb.content.text("A softly-glowing orb is floating nearby."),
    apply_message = "",
    remove_message = ccb.content.text("The orb of light winks out."),
    rating = "good",
    maximum_duration_turns = 40000,
}
    :enchantment("INLINE_ENCH_effect_classless_magic_light_0"))

content.add(content.EffectType {
    id = "effect_classless_easy_sleep",
    name = ccb.content.text("Peaceful Rest"),
    description = ccb.content.text("You feel pretty sleepy."),
    apply_message = "",
    rating = "good",
    maximum_duration_turns = 3600,
}
    :enchantment("INLINE_ENCH_effect_classless_easy_sleep_0"))

content.add(content.EffectType {
    id = "effect_burning_trail",
    name = ccb.content.text("Burning Trail"),
    description = ccb.content.text("Fire trails in your wake."),
    apply_message = "",
    remove_message = ccb.content.text("The flames you leave behind die down."),
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_cloak_of_fog",
    name = ccb.content.text("Cloak of Fog"),
    description = ccb.content.text("The fog shields you from sight."),
    apply_message = "",
    remove_message = ccb.content.text("The fog begins to dissipate."),
    rating = "good",
    maximum_duration_turns = 1200,
}
    :enchantment("enchant_stormshaper_cloak_of_fog"))

content.add(content.EffectType {
    id = "effect_heart_of_hurricane",
    name = ccb.content.text("Heart of the Hurricane"),
    description = ccb.content.text("Barely-controlled winds rage around you."),
    remove_message = ccb.content.text("The wind around you dies down."),
    rating = "good",
    maximum_duration_turns = 3600,
}
    :enchantment("enchant_stormshaper_heart_of_hurricane"))

content.add(content.EffectType {
    id = "effect_stormshaper_loud_voice",
    name = ccb.content.text("Thundering Voice"),
    description = ccb.content.text("Every word you speak resounds like a crash of thunder."),
    apply_message = "",
    remove_message = ccb.content.text("Your voice returns to normal."),
    rating = "good",
    maximum_duration_turns = 35280,
}
    :flag("IMMUNE_HEARING_DAMAGE")
    :enchantment("INLINE_ENCH_effect_stormshaper_loud_voice_0"))

content.add(content.EffectType {
    id = "effect_biomancer_cure_disease_minor",
    name = "",
    description = "",
    rating = "good",
}
    :removes_effect("pre_common_cold")
    :removes_effect("common_cold")
    :removes_effect("pre_flu")
    :removes_effect("flu")
    :removes_effect("pre_conjunctivitis_viral")
    :removes_effect("conjunctivitis_viral")
    :removes_effect("pre_conjunctivitis_bacterial")
    :removes_effect("conjunctivitis_bacterial"))

content.add(content.EffectType {
    id = "effect_biomancer_hyper_regeneration",
    name = ccb.content.text("Corporeal Reconstitution"),
    description = ccb.content.text("You are healing unbelievably quickly."),
    remove_message = ccb.content.text("Your rapid regeneration slows and stops."),
    rating = "good",
    maximum_duration_turns = 520,
}
    :flag("MEND_ALL")
    :removes_effect("bleed")
    :enchantment("INLINE_ENCH_effect_biomancer_hyper_regeneration_0"))

content.add(content.EffectType {
    id = "effect_biomancer_disturbing",
    name = "",
    description = "",
    maximum_intensity = 100,
}
    :enchantment("INLINE_ENCH_effect_biomancer_disturbing_0"))

content.add(content.EffectType {
    id = "effect_biomancer_slow_bleeding_01",
    name = ccb.content.text("Halt Bleeding"),
    description = ccb.content.text("You bleed less than normal."),
    rating = "good",
    maximum_duration_turns = 25200,
}
    :enchantment("INLINE_ENCH_effect_biomancer_slow_bleeding_01_0"))

content.add(content.EffectType {
    id = "effect_biomancer_slow_bleeding_02",
    name = ccb.content.text("Halt Bleeding"),
    description = ccb.content.text("You bleed much less than normal."),
    rating = "good",
    maximum_duration_turns = 25200,
}
    :enchantment("INLINE_ENCH_effect_biomancer_slow_bleeding_02_0"))

content.add(content.EffectType {
    id = "effect_biomancer_slow_bleeding_03",
    name = ccb.content.text("Halt Bleeding"),
    description = ccb.content.text("You do not bleed.  At all."),
    rating = "good",
    maximum_duration_turns = 25200,
}
    :flag("BLEED_IMMUNE")
    :removes_effect("bleed"))

content.add(content.EffectType {
    id = "effect_biomancer_eat_tons_of_food",
    name = ccb.content.text("Gluttonous Consumption"),
    description = ccb.content.text("You feel like you could eat a horse."),
    rating = "good",
    maximum_duration_turns = 48960,
}
    :enchantment("INLINE_ENCH_effect_biomancer_eat_tons_of_food_0"))

content.add(content.EffectType {
    id = "effect_flesh_rending",
    name = ccb.content.text("Rending"),
    description = ccb.content.text("Your flesh is twisting itself apart!"),
    apply_message = ccb.content.text("Your flesh writhes where you were hit!"),
    rating = "bad",
    maximum_duration_turns = 10,
    show_in_info = true,
}
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 1 })
    :modifier("hurt", "chance_denominator", { base = 5 }))

content.add(content.EffectType {
    id = "effect_teleport_anchor",
    name = ccb.content.text("Teleport Anchor"),
    description = ccb.content.text("You're not going anywhere."),
    apply_message = ccb.content.text("Your body tingles."),
    rating = "bad",
}
    :flag("TELEPORT_LOCK"))

content.add(content.EffectType {
    id = "effect_spirit_walking",
    name = ccb.content.text("Spirit Walking"),
    description = ccb.content.text("You have shed your physical form."),
    rating = "good",
    maximum_duration_turns = 360,
    show_in_info = true,
}
    :flag("ETHEREAL")
    :flag("FEATHER_FALL")
    :flag("CLIMB_NO_LADDER")
    :flag("INVISIBLE")
    :flag("NO_SCENT")
    :flag("NO_SPELLCASTING")
    :flag("WATERWALKING")
    :flag("ITEM_WATERPROOFING")
    :enchantment("INLINE_ENCH_effect_spirit_walking_0"))

content.add(content.EffectType {
    id = "effect_magus_mageshield",
    name = ccb.content.text("Mageshield"),
    description = ccb.content.text("You are invincible."),
    remove_message = ccb.content.text("Your mageshield fades as the attack impacts it."),
    rating = "good",
    maximum_duration_turns = 55200,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_magus_mageshield_0"))

content.add(content.EffectType {
    id = "effect_magus_silence",
    name = ccb.content.text("Silence"),
    description = ccb.content.text("You are completely silent."),
    remove_message = ccb.content.text("Your footsteps make noise again."),
    rating = "mixed",
    maximum_duration_turns = 408,
    show_in_info = true,
}
    :flag("MUTE")
    :enchantment("INLINE_ENCH_effect_magus_silence_0"))

content.add(content.EffectType {
    id = "effect_magus_impact_sling_buff",
    name = "",
    description = "",
    remove_message = ccb.content.text("The energy vanishes from your sling."),
    rating = "good",
    maximum_duration_turns = 86400,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_magus_impact_sling_buff_0"))

content.add(content.EffectType {
    id = "effect_magus_cannot_move_attack_or_damage_target",
    name = ccb.content.text("Adamantine Gaol"),
    description = ccb.content.text("You are totally immobile and invulnerable."),
    remove_message = ccb.content.text("You can move again."),
    rating = "bad",
    maximum_duration_turns = 100,
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE")
    :flag("CANNOT_TAKE_DAMAGE"))

content.add(content.EffectType {
    id = "effect_druid_traverse_the_wilds",
    name = ccb.content.text("Traverse the Wilds"),
    description = ccb.content.text("Nature is speeding your passage."),
    remove_message = ccb.content.text("Nature no longer speeds your movements."),
    rating = "good",
    maximum_duration_turns = 57600,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_druid_traverse_the_wilds_0")
    :enchantment("INLINE_ENCH_effect_druid_traverse_the_wilds_1"))

content.add(content.EffectType {
    id = "effect_druid_water_walking",
    name = ccb.content.text("Water Strider's Walk"),
    description = ccb.content.text("You can walk on the surface of the water"),
    remove_message = ccb.content.text("You can no longer walk on the water."),
    rating = "good",
    maximum_duration_turns = 19200,
}
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

-- Hidden effect, used because LEVITATION flag does not work on mutations
content.add(content.EffectType {
    id = "effect_druid_shifter_raven_form_levitation",
    name = "",
    description = "",
}
    :flag("LEVITATION")
    :flag("CLIMB_FLYING"))

-- Hidden effect, used in an enchantment
content.add(content.EffectType {
    id = "effect_druid_shifter_fish_form_cant_move",
    name = "",
    description = "",
}
    :flag("CANNOT_MOVE"))

-- Hidden effect, used for multiple druid spells
content.add(content.EffectType {
    id = "effect_item_protection_water",
    name = "",
    description = "",
}
    :flag("ITEM_WATERPROOFING"))

-- Hidden effect, used so the ring of fire protection will stop you from being set on fire
content.add(content.EffectType {
    id = "effect_mring_fire_protection",
    name = "",
    description = "",
}
    :removes_effect("onfire"))

content.add(content.EffectType {
    id = "effect_ring_of_flight",
    name = ccb.content.text("Flying"),
    description = ccb.content.text("You're flying."),
    remove_message = ccb.content.text("Your magical flight ends."),
    rating = "good",
}
    :flag("CLIMB_FLYING")
    :flag("LEVITATION"))

-- Hidden effect, used as an attunement period for the ring of sustenance
content.add(content.EffectType {
    id = "effect_mring_sustenance",
    name = "",
    description = "",
    maximum_intensity = 50,
    intensity_decay_step = 1,
    intensity_decay_tick = 3600,
})

content.add(content.EffectType {
    id = "effect_bracers_of_the_blinding_strike",
    name = ccb.content.text("Blinding Strikes"),
    description = ccb.content.text("Your attacks come incredibly quickly."),
    apply_message = ccb.content.text("Your strikes speed up immensely."),
    remove_message = ccb.content.text("Your quick strikes slow to normal speed."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_bracers_of_the_blinding_strike_0"))

-- Self-explanatory
content.add(content.EffectType {
    id = "effect_plus_two_to_hit",
    name = "",
    description = "",
    rating = "good",
}
    :modifier("hit", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "archerybracers",
    name = "",
    description = "",
    rating = "good",
}
    :enchantment("INLINE_ENCH_archerybracers_0"))

content.add(content.EffectType {
    id = "effect_feral_druid_thornskin",
    name = ccb.content.text("Thornskin"),
    description = ccb.content.text("You are a feral druid with the Thornskin spell on."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_druid_thornskin_0"))

-- Hidden effect, makes the periapt of health block diseases and infection
content.add(content.EffectType {
    id = "effect_periapt_health",
    name = "",
    description = "",
}
    :removes_effect("nausea")
    :removes_effect("bite")
    :removes_effect("infected")
    :removes_effect("spores")
    :removes_effect("fungus")
    :removes_effect("dermatik")
    :removes_effect("pre_common_cold")
    :removes_effect("pre_flu")
    :removes_effect("common_cold")
    :removes_effect("flu")
    :removes_effect("tetanus")
    :removes_effect("asthma")
    :removes_effect("tapeworm")
    :removes_effect("brainworms")
    :removes_effect("bloodworms"))

-- Hidden effect, makes the periapt of proof against poison prevent poisons
content.add(content.EffectType {
    id = "effect_periapt_proof_against_poison",
    name = "",
    description = "",
}
    :removes_effect("poison")
    :removes_effect("badpoison")
    :removes_effect("tpollen")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_effect("venom_blind")
    :removes_effect("venom_pain")
    :removes_effect("foodpoison")
    :removes_effect("paralyzepoison"))

content.add(content.EffectType {
    id = "effect_feral_stormshaper_stormhammer",
    name = "Wielding Stormhammer",
    description = "You are a monster wielding a stormhammer, as this effect indicates.",
    show_in_info = true,
})

-- Longer internal cooldown for feral stormshaper hammer
content.add(content.EffectType {
    id = "effect_feral_stormshaper_stormhammer_cooldown",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_feral_technomancer_bless",
    name = ccb.content.text("Bless"),
    description = "You get bonuses to hit and dodge because monsters don't have stats.",
    show_in_info = true,
}
    :modifier("hit", "amount", { base = 2 })
    :modifier("dodge", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_feral_high_technomancer_mage_armor",
    name = ccb.content.text("Mage Armor"),
    description = "You are a monster wearing conjured armor, as this effect indicates.",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_high_technomancer_mage_armor_0"))

-- Duration tracker, empty to hide effect
content.add(content.EffectType {
    id = "effect_manatouched_mana_flash_active",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_manatouched_external_mana_luminance",
    name = ccb.content.text("Eldritch Glow"),
    description = ccb.content.text("The air around you shimmers in a multitude of colors."),
}
    :enchantment("INLINE_ENCH_effect_manatouched_external_mana_luminance_0"))

-- Self-explanatory
content.add(content.EffectType {
    id = "effect_will_o_wisp_draining_monsters",
    name = "",
    description = "",
    rating = "good",
    maximum_intensity = 25,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -1, per_intensity = -1 }))

content.add(content.EffectType {
    id = "effect_mana_overload",
    name = ccb.content.text("Mana Overload"),
    description = ccb.content.text("Your leylines are overloaded with a surfeit of mana.  It is much harder to control the mana flow."),
    apply_message = ccb.content.text("You feel a tingling sensation all along your leylines."),
    remove_message = ccb.content.text("Your leylines finally calm down."),
    maximum_intensity = 3,
}
    :enchantment("INLINE_ENCH_effect_mana_overload_0"))

content.add(content.EffectType {
    id = "effect_clay_golem_unhealing",
    name = ccb.content.text("Clay-Covered Wounds"),
    description = ccb.content.text("Bits of clay are stuck in your wounds and you can't seem to get them out."),
    apply_message = ccb.content.text("Some of the golem's clay remains behind after it hits you."),
    remove_message = ccb.content.text("The clay on your wounds finally flakes off."),
    rating = "bad",
    maximum_duration_turns = 172800,
    show_in_info = true,
}
    :flag("BLOCK_SUPERNATURAL_HEALING")
    :enchantment("INLINE_ENCH_effect_clay_golem_unhealing_0"))

-- Removes effects from spells Difficulty 6 or below.  No attumement effects removed.
content.add(content.EffectType {
    id = "effect_dispel_magic",
    name = ccb.content.text("Dispel Magic"),
    description = ccb.content.text("Enchantments are being stripped away from you."),
    apply_message = "",
    remove_message = ccb.content.text("You feel a sudden sense of loss."),
    maximum_duration_turns = 2,
}
    :removes_effect("enchant_windrun")
    :removes_effect("dark_sight")
    :removes_effect("effect_ethereal_grasp")
    :removes_effect("invisibility")
    :removes_effect("bless")
    :removes_effect("bio_boost")
    :removes_effect("entangled")
    :removes_effect("root_impale")
    :removes_effect("ogres_strength")
    :removes_effect("eagles_sight")
    :removes_effect("cats_grace")
    :removes_effect("foxs_cunning")
    :removes_effect("feather_fall")
    :removes_effect("bio_weave")
    :removes_effect("natures_commune")
    :removes_effect("electric_eye")
    :removes_effect("electric_waves")
    :removes_effect("electric_arts")
    :removes_effect("flower_fern_eff")
    :removes_effect("glowing_mushroom_eff")
    :removes_effect("flask_speed_eff")
    :removes_effect("flask_healing_eff")
    :removes_effect("flask_stamina_eff")
    :removes_effect("flask_excitement")
    :removes_effect("flask_resistance")
    :removes_effect("flask_illumination")
    :removes_effect("flask_mana_regen")
    :removes_effect("flask_max_mana")
    :removes_effect("flask_regeneration")
    :removes_effect("effect_animist_add_evasion")
    :removes_effect("earthshaper_fortitude_of_stone")
    :removes_effect("effect_tremorsense")
    :removes_effect("effect_sense_outsiders")
    :removes_effect("effect_animist_vocalize")
    :removes_effect("effect_animist_detect_wizards")
    :removes_effect("effect_kelvinist_anti_cold")
    :removes_effect("effect_kelvinist_anti_heat")
    :removes_effect("effect_magus_slowfall")
    :removes_effect("effect_magus_spiderclimb")
    :removes_effect("effect_magus_faerie_fire")
    :removes_effect("effect_biomancer_swim_speed")
    :removes_effect("effect_biomancer_carrion_feast")
    :removes_effect("effect_biomancer_slow_bleeding_01")
    :removes_effect("effect_biomancer_slow_bleeding_02")
    :removes_effect("effect_biomancer_slow_bleeding_03")
    :removes_effect("effect_biomancer_eat_tons_of_food")
    :removes_effect("effect_druid_anti_heat")
    :removes_effect("effect_druid_traverse_the_wilds")
    :removes_effect("effect_magus_mageshield")
    :removes_effect("effect_magus_silence")
    :removes_effect("effect_magus_ranged_increase")
    :removes_effect("magic_slowed")
    :removes_effect("effect_classless_watch")
    :removes_effect("effect_classless_magic_light")
    :removes_effect("effect_obfuscating_aura")
    :removes_effect("effect_shape_of_dust")
    :removes_effect("effect_acid_res_aura")
    :removes_effect("effect_acid_res_aura_greater")
    :removes_effect("effect_thorns_electric")
    :removes_effect("effect_stormshaper_loud_voice")
    :removes_effect("effect_technomancer_gain_electronics_computer")
    :removes_effect("effect_technomancer_pain_ignore")
    :removes_effect("effect_feral_stormshaper_stormhammer")
    :removes_effect("effect_feral_technomancer_mage_blade")
    :removes_effect("effect_feral_technomancer_mage_armor")
    :removes_effect("effect_feral_technomancer_bless")
    :removes_effect("enchant_windrun_monster")
    :removes_effect("effect_feral_animist_guardian_spirit")
    :removes_effect("effect_feral_animist_inner_voice")
    :removes_effect("effect_migo_nether_shield_monster")
    :removes_optional_effect("migo_fleshwarper_block_healing"))

-- Removes all effects from spells.
content.add(content.EffectType {
    id = "effect_disjunction",
    name = ccb.content.text("Disjunction"),
    description = ccb.content.text("All enchantments are being stripped away from you."),
    apply_message = "",
    remove_message = ccb.content.text("You feel a sudden acute sense of loss."),
    maximum_duration_turns = 2,
}
    :removes_effect("enchant_windrun")
    :removes_effect("effect_earthshaper_petrifying_touch")
    :removes_effect("dark_sight")
    :removes_effect("effect_ethereal_grasp")
    :removes_effect("invisibility")
    :removes_effect("bless")
    :removes_effect("bio_boost")
    :removes_effect("entangled")
    :removes_effect("root_impale")
    :removes_effect("ogres_strength")
    :removes_effect("eagles_sight")
    :removes_effect("cats_grace")
    :removes_effect("foxs_cunning")
    :removes_effect("feather_fall")
    :removes_effect("bio_weave")
    :removes_effect("natures_commune")
    :removes_effect("electric_eye")
    :removes_effect("electric_waves")
    :removes_effect("electric_arts")
    :removes_effect("flower_fern_eff")
    :removes_effect("glowing_mushroom_eff")
    :removes_effect("flask_speed_eff")
    :removes_effect("flask_healing_eff")
    :removes_effect("flask_stamina_eff")
    :removes_effect("flask_excitement")
    :removes_effect("flask_resistance")
    :removes_effect("flask_illumination")
    :removes_effect("flask_mana_regen")
    :removes_effect("flask_max_mana")
    :removes_effect("flask_regeneration")
    :removes_effect("earthshaper_fortitude_of_stone")
    :removes_effect("effect_tremorsense")
    :removes_effect("effect_sense_outsiders")
    :removes_effect("effect_kelvinist_anti_cold")
    :removes_effect("effect_kelvinist_anti_heat")
    :removes_effect("effect_magus_slowfall")
    :removes_effect("effect_magus_spiderclimb")
    :removes_effect("effect_magus_faerie_fire")
    :removes_effect("effect_biomancer_swim_speed")
    :removes_effect("effect_biomancer_carrion_feast")
    :removes_effect("effect_classless_watch")
    :removes_effect("effect_classless_magic_light")
    :removes_effect("effect_obfuscating_aura")
    :removes_effect("effect_shape_of_dust")
    :removes_effect("effect_acid_res_aura")
    :removes_effect("effect_acid_res_aura_greater")
    :removes_effect("effect_thorns_electric")
    :removes_effect("effect_animist_add_evasion")
    :removes_effect("effect_animist_vocalize")
    :removes_effect("effect_animist_detect_wizards")
    :removes_effect("effect_biomancer_slow_bleeding_01")
    :removes_effect("effect_biomancer_slow_bleeding_02")
    :removes_effect("effect_biomancer_slow_bleeding_03")
    :removes_effect("effect_biomancer_eat_tons_of_food")
    :removes_effect("effect_druid_anti_heat")
    :removes_effect("effect_druid_traverse_the_wilds")
    :removes_effect("effect_magus_mageshield")
    :removes_effect("effect_magus_silence")
    :removes_effect("effect_magus_ranged_increase")
    :removes_effect("effect_spirit_walking")
    :removes_effect("effect_stormshaper_loud_voice")
    :removes_effect("effect_technomancer_gain_electronics_computer")
    :removes_effect("effect_technomancer_pain_ignore")
    :removes_effect("magic_slowed")
    :removes_effect("haste")
    :removes_effect("synaptic_stim")
    :removes_effect("slow_freeze_effect")
    :removes_effect("neuro_boost")
    :removes_effect("cold_heart_effect")
    :removes_effect("overclocker_drive_effect")
    :removes_effect("biomechanic")
    :removes_effect("ice_energy")
    :removes_effect("ice_age_eff")
    :removes_effect("effect_biomancer_remove_instability")
    :removes_effect("effect_biomancer_hyper_regeneration")
    :removes_effect("effect_terra_armor")
    :removes_effect("gravity_mage_melee")
    :removes_effect("eff_storm_elemental_electric_melee")
    :removes_effect("effect_flame_immunity")
    :removes_effect("effect_burning_trail")
    :removes_effect("effect_ring_of_flight")
    :removes_effect("effect_feral_stormshaper_stormhammer")
    :removes_effect("effect_feral_technomancer_mage_blade")
    :removes_effect("effect_feral_technomancer_mage_armor")
    :removes_effect("effect_feral_technomancer_bless")
    :removes_effect("enchant_windrun_monster")
    :removes_effect("effect_feral_animist_guardian_spirit")
    :removes_effect("effect_feral_animist_inner_voice")
    :removes_effect("effect_migo_nether_shield_monster")
    :removes_effect("effect_feral_druid_thornskin")
    :removes_optional_effect("migo_fleshwarper_block_healing")
    :removes_effect("effect_clay_golem_unhealing"))

content.add(content.EffectType {
    id = "effect_thaumic_zombie_magical_disruption",
    name = ccb.content.text("Mana Blockage"),
    description = ccb.content.text("It's harder for you to draw on your mana than it should be."),
    maximum_duration_turns = 60,
})

content.add(content.EffectType {
    id = "effect_dust_reborn",
    name = ccb.content.text("Divided"),
    description = ccb.content.text("Your body was split before, which makes you really fragile, but allow you to accept more mana than before."),
    remove_message = ccb.content.text("Your body turns back to normal state."),
}
    :enchantment("INLINE_ENCH_effect_dust_reborn_0"))

content.add(content.EffectType {
    id = "golemancer_block",
    name = ccb.content.text("Golemancer's block"),
    description = ccb.content.text("Decrease any damage taken in the next 1 second."),
    rating = "good",
    show_intensity = false,
    show_in_info = false,
}
    :enchantment("INLINE_ENCH_golemancer_block_0"))

content.add(content.EffectType {
    id = "sun_mage_buff",
    name = ccb.content.text("Sol"),
    description = ccb.content.text("You feel your mana connected to the Sun, and it makes you better than ever."),
    remove_message = ccb.content.text("You don't feel Solar energy in your body anymore."),
    rating = "good",
    maximum_duration_turns = 600,
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_sun_mage_buff_0"))

content.add(content.EffectType {
    id = "freeze_aura",
    name = ccb.content.text("Freeze burn"),
    description = ccb.content.text("Your skin is frozen."),
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -25, per_intensity = -15 }))

content.add(content.EffectType {
    id = "void_mage_night_vision",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("night_vis", { multiplier = 20 }))

content.add(content.EffectType {
    id = "effect_magiclysm_craft_in_darkness",
    name = "",
    description = "",
}
    :flag("CRAFT_IN_DARKNESS"))

content.add(content.EffectType {
    id = "effect_vulcanist_no_smoke_or_blisters",
    name = "",
    description = "",
}
    :blocks_effect("smoke_eyes")
    :blocks_effect("smoke_lungs")
    :blocks_effect("blisters"))

content.add(content.EffectType {
    id = "withering_eff",
    name = ccb.content.text("Withering"),
    description = ccb.content.text("Consume their nature for your own purposes."),
    apply_message = ccb.content.text("You take a withering effect!"),
    rating = "good",
    maximum_intensity = 30,
    intensity_add_value = 1,
}
    :modifier("perception", "amount", { base = 0.1, per_intensity = 0.1 })
    :modifier("dexterity", "amount", { base = 0.2, per_intensity = 0.2 })
    :modifier("strength", "amount", { base = 0.2, per_intensity = 0.2 })
    :modifier("intelligence", "amount", { base = 0.1, per_intensity = 0.1 })
    :modifier("stamina", "minimum", { base = 1, per_intensity = 1 }))
