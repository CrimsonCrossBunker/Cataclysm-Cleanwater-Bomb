local ccb = require("ccb")
local content = ccb.content

-- Hidden--does nothing in base XE, used for DDotD interactions
content.upsert_effect_type(content.EffectType {
    id = "effect_vampire_immune_to_classic_zombification",
    name = "",
    description = "",
})

content.upsert_effect_type(content.EffectType {
    id = "effect_hedge_protect_the_mind",
    name = ccb.content.text("Ordered Mind"),
    description = ccb.content.text("Your mind is set in order, walled and guarded."),
    rating = "good",
}
    :flag("MAGICAL_MIND_PROTECTION"))

content.upsert_effect_type(content.EffectType {
    id = "natures_commune",
    name = ccb.content.text("Commune with Nature"),
    description = ccb.content.text("You are in tune with the natural world, drawing strength from it and calming natural animals."),
    apply_message = ccb.content.text("You can feel the lifeblood of nature all around, welcoming you as kin."),
    remove_message = ccb.content.text("Your communion with nature fades."),
    rating = "good",
    maximum_duration_turns = 21600,
    duration_add_percent = 5,
}
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 50 })
    :modifier("health_modifier", "minimum", { base = 1 })
    :modifier("health_modifier", "chance_numerator", { base = 100 })
    :modifier("health", "tick", { base = 60 }))

content.upsert_effect_type(content.EffectType {
    id = "effect_flame_immunity",
    name = ccb.content.text("Flame Immunity"),
    description = ccb.content.text("You are immune to heat and fire."),
    rating = "good",
    show_in_info = true,
}
    :removes_effect("onfire")
    :removes_effect("blisters")
    :enchantment("INLINE_ENCH_effect_flame_immunity_0"))

content.add(content.EffectType {
    id = "ozmas_peace",
    name = ccb.content.text("A desolation called Peace"),
    description = "Ubi solitudinem faciunt, pacem appelant",
    apply_message = ccb.content.text("A deep and abiding calm settles upon you."),
    remove_message = ccb.content.text("The Pax is no more."),
    maximum_duration_turns = 1800,
    maximum_intensity = 5,
    intensity_duration_turns = 5,
}
    :modifier("hit", "amount", { base = -20 })
    :modifier("bash", "amount", { base = -20 })
    :miss_message(ccb.content.text("Peace be upon thee, whether you want it or not."), 1))

content.add(content.EffectType {
    id = "curevamp",
    maximum_duration_turns = 259200,
}
    :removes_effect("vampire_virus"))

content.add(content.EffectType {
    id = "haste_vampire",
    name = ccb.content.text("Blood Haste"),
    description = ccb.content.text("Stolen blood is boosting your speed enormously."),
    apply_message = "",
    remove_message = ccb.content.text("You return to your normal speed."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_haste_vampire_0")
    :modifier("dexterity", "amount", { base = 4 })
    :modifier("speed", "amount", { base = 250 }))

-- Hidden effect_lets you run on water using Zephyr
content.add(content.EffectType {
    id = "haste_vampire_water_running",
    name = "",
    description = "",
}
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

content.add(content.EffectType {
    id = "effect_vampire_resilience_flesh_of_marble",
    name = ccb.content.text("Flesh of Marble"),
    description = ccb.content.text("You are invincible."),
    remove_message = ccb.content.text("Your undead flesh blunts the attack."),
    rating = "good",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_vampire_resilience_flesh_of_marble_0"))

content.add(content.EffectType {
    id = "buoyant",
    name = ccb.content.text("Buoyant"),
    description = ccb.content.text("You are more buoyant than before.  This will make swimming much easier."),
    apply_message = ccb.content.text("You feel more buoyant!"),
    remove_message = ccb.content.text("You feel less buoyant."),
    rating = "good",
    maximum_duration_turns = 28800,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("swim", { multiplier = 2 }))

content.add(content.EffectType {
    id = "acidic_mist",
    name = ccb.content.text("Acidic mist"),
    description = ccb.content.text("The mist is burning you!"),
    apply_message = ccb.content.text("The mist is burning you!"),
    rating = "bad",
    maximum_duration_turns = 30,
    maximum_intensity = 5,
    intensity_duration_turns = 5,
    show_in_info = true,
}
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 1, per_intensity = 1 })
    :modifier("hurt", "chance_denominator", { base = 10 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 1, per_intensity = 1 })
    :modifier("pain", "chance_denominator", { base = 10 }))

content.add(content.EffectType {
    id = "effect_wild_hunt_illumination",
    name = ccb.content.text("Witchfire"),
    description = ccb.content.text("You are surrounded by an eldritch glow."),
    apply_message = "",
    remove_message = ccb.content.text("The glow around you fades."),
}
    :enchantment("INLINE_ENCH_effect_wild_hunt_illumination_0")
    :modifier("dodge", "amount", { base = -2 }))

content.add(content.EffectType {
    id = "effect_reduced_healing",
    name = ccb.content.text("Painful Wounds"),
    description = ccb.content.text("Your wounds ache."),
    apply_message = ccb.content.text("The cut begins to burn!"),
    remove_message = ccb.content.text("The ache from your wounds finally fades."),
}
    :enchantment("INLINE_ENCH_effect_reduced_healing_0")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 5 })
    :modifier("pain", "maximum_value", { base = 15 })
    :modifier("pain", "tick", { base = 60 }))

content.add(content.EffectType {
    id = "wild_hunt_dazed",
    name = ccb.content.text("Dazed"),
    description = ccb.content.text("You're visibly shaken up, and are having a hard time focusing on what's going on around you."),
    rating = "bad",
    maximum_intensity = 10,
    maximum_duration_turns = 600,
    intensity_add_value = 2,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { per_intensity = -5 })
    :limb_score("balance", { multiplier = 0.65 })
    :limb_score("reaction", { multiplier = 0.5 })
    :limb_score("vision", { multiplier = 0.85 }))

content.add(content.EffectType {
    id = "vamp_blood_weave",
    apply_message = ccb.content.text("Your wound closes up and covers over instantly."),
    rating = "good",
}
    :removes_effect("infected")
    :removes_effect("bite")
    :removes_effect("bleed"))

content.add(content.EffectType {
    id = "xtr_str_aspirin",
    blood_analysis_description = ccb.content.text("Strange Painkiller"),
    maximum_duration_turns = 240,
    rating = "good",
}
    :modifier("painkiller", "tick", { base = 42 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "maximum_value", { base = 15 })
    :modifier("hurt", "tick", { base = 42 })
    :modifier("hurt", "minimum", { base = -1 })
    :modifier("hurt", "maximum", { base = -5 }))

content.add(content.EffectType {
    id = "blood_spiders",
    apply_memorial_log = "Caught blood spiders.",
    remove_memorial_log = "Eradicated the spiders in their blood.",
    name = ccb.content.text("Blood Spiders"),
    description = ccb.content.text("You have contracted an interdimensional disease, specifically Blood Spiders.  Symptoms can be alleviated by medication (antiparasitic)."),
    apply_message = ccb.content.text("Your veins itch…"),
    blood_analysis_description = ccb.content.text("Unknown Hemolytic Parasite"),
    rating = "bad",
}
    :resist_trait("PARAIMMUNE")
    :resist_trait("ACIDBLOOD")
    :modifier("thirst", "tick", { base = 580 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("sleepiness", "tick", { base = 300 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("strength", "amount", { base = -2, resisted_base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -1 })
    :modifier("pain", "maximum_value", { base = 30 })
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 3, resisted_base = 9 })
    :modifier("health", "amount", { base = -2, resisted_base = -12 }))

content.add(content.EffectType {
    id = "curesome",
}
    :removes_effect("common_cold")
    :removes_effect("flu")
    :modifier("painkiller", "minimum", { base = 5 }))

-- Should make the player have better perception with a worse dex but should be offset if taken with consumables that grant altered_physics.
content.add(content.EffectType {
    id = "faewild",
    name = ccb.content.text("glamoured"),
    description = ccb.content.text("The world is beautiful and breathtaking but maybe also terrifying."),
    apply_message = ccb.content.text("The colors brighten and your vision sharpens."),
    remove_message = ccb.content.text("The world becomes a duller place."),
    blood_analysis_description = ccb.content.text("Cross-dimensional narcotic, unexpected physics encountered"),
    rating = "mixed",
    maximum_duration_turns = 1800,
}
    :flag("HUNGER_DISRUPTION")
    :flag("TRUE_SEEING")
    :modifier("perception", "amount", { base = 6 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("speed", "amount", { base = -5 }))

-- Should make the player have better perception with a worse dex but should be offset if taken with consumables that grant altered_physics.
content.add(content.EffectType {
    id = "elf-addled",
    name = ccb.content.text("ælfadl"),
    description = ccb.content.text("The world was much more beautiful when you were closer to the Underhill."),
    apply_message = ccb.content.text("The world becomes a duller place.  Do you even care if you live or die if it is in this place?"),
    remove_message = ccb.content.text("The colors brighten and your vision sharpens."),
    blood_analysis_description = ccb.content.text("Anemia of the soul."),
    rating = "bad",
    maximum_duration_turns = 86400,
}
    :flag("HUNGER_DISRUPTION")
    :flag("TRUE_SEEING")
    :modifier("perception", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -5 }))

-- Should improve your dex but worsen your mood.  Also should resist Hallucinating when on this.
content.add(content.EffectType {
    id = "relative_physics",
    name = ccb.content.text("Angled"),
    description = ccb.content.text("Your vision suddenly feels as if it shifted down and to the left."),
    apply_message = ccb.content.text("You feel the universe vibrating."),
    remove_message = ccb.content.text("The hum in your bones subsides."),
    blood_analysis_description = ccb.content.text("Anomalous Readings"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Canted"))
    :name(ccb.content.text("Mirrored"))
    :description(ccb.content.text("You are viewing the world as if from an orchestra pit."))
    :description(ccb.content.text("You feel your body moves mirrored to the thoughts in your head."))
    :decay_message(ccb.content.text("Your body accepts your presence once more."), "good")
    :decay_message(ccb.content.text("A mirror cracks in the distance."), "good")
    :modifier("dexterity", "amount", { base = 1, per_intensity = 1 })
    :modifier("health_modifier", "minimum", { base = -1, per_intensity = -1 })
    :modifier("health_modifier", "minimum_value", { per_intensity = -50 })
    :modifier("health_modifier", "chance_numerator", { base = 900, per_intensity = -200 }))

content.add(content.EffectType {
    id = "foxfire_imbibed",
    name = ccb.content.text("Foxfire"),
    description = ccb.content.text("Your body is dimly covered in ephemeral flames."),
    rating = "bad",
    maximum_intensity = 3,
}
    :name(ccb.content.text("Balefire"))
    :name(ccb.content.text("St. Elmo's Fire"))
    :description(ccb.content.text("The flames sometimes obstruct your vision, yet you feel no pain from them."))
    :description(ccb.content.text("You body shines like a lit beacon."))
    :resist_trait("POISRESIST")
    :resist_trait("VOMITSTOMACH")
    :enchantment("INLINE_ENCH_foxfire_imbibed_0")
    :modifier("perception", "amount", { base = -1, per_intensity = -1 })
    :modifier("dexterity", "amount", { base = -1, per_intensity = -1 })
    :miss_message(ccb.content.text("The flames distract you."), 1))

content.add(content.EffectType {
    id = "minoan_orchid_effect",
    name = ccb.content.text("Minoan Joy"),
    description = ccb.content.text("The effect of the opioids in your system are increased."),
    rating = "neutral",
    maximum_intensity = 6,
}
    :name(ccb.content.text("Minoan Delight"))
    :name(ccb.content.text("Minoan Elation"))
    :name(ccb.content.text("Minoan Euphoria"))
    :name(ccb.content.text("Minoan Rapture"))
    :name(ccb.content.text("Minoan Ecstasy"))
    :description(ccb.content.text("As you consume more opioids your mood increases even more."))
    :description(ccb.content.text("The combination of these drugs is clearly dangerously euphoric."))
    :description(ccb.content.text("Your body is pairing endorphins and dopamine across every pathway."))
    :description(ccb.content.text("Are you dead?  Is this heaven?"))
    :description(ccb.content.text("…………………………………………………………………")))

content.add(content.EffectType {
    id = "effect_monster_shadow_damage_reduction",
    name = ccb.content.text("Shadow Damage Reduction"),
    description = ccb.content.text("You are flatter and less real in ways that makes you less susceptible to damage."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_shadow_damage_reduction_0"))

-- Tracks inventors creative sparks
content.add(content.EffectType {
    id = "creativity",
    name = ccb.content.text("One Amazing Idea"),
    description = ccb.content.text("You have an incredibly amazing idea.  You think you should <color_yellow>research</color> it."),
    apply_message = ccb.content.text("A great idea has illuminated your mind, it's probably a good time to pick up your laptop and do some calculations."),
    maximum_intensity = 3,
    rating = "good",
}
    :name(ccb.content.text("Several Inspired Tangents"))
    :name(ccb.content.text("Brimming with Creativity"))
    :description(ccb.content.text("You've got a few theories you'd like to explore.  Grab a laptop, a cup of coffee, and <color_yellow>research</color> it like a proper scientist."))
    :description(ccb.content.text("Your brain can't hold any more brilliance.  To the <color_yellow>research</color> table!")))

-- Prevents you from learning new alchemy recipes.
content.add(content.EffectType {
    id = "mental_exhaustion",
    name = ccb.content.text("Mental Exhaustion"),
    description = ccb.content.text("You have recently realized a new alchemical recipe and your thoughts are scattered."),
    remove_message = ccb.content.text("Your mind feels normal enough that you could focus on new alchemy ideas once again."),
    maximum_intensity = 1,
    rating = "bad",
})

content.add(content.EffectType {
    id = "dreamer_eff",
    name = ccb.content.text("Matter Twist"),
    description = ccb.content.text("Sometimes the world nearby twists.  Was it you?"),
    maximum_intensity = 5,
    rating = "good",
}
    :name(ccb.content.text("Matter Deformation"))
    :name(ccb.content.text("Dimensional Shift"))
    :name(ccb.content.text("Dimensional Chasm"))
    :name(ccb.content.text("Reality Gateway"))
    :description(ccb.content.text("Sometimes you hear an odd noise, like a whisper."))
    :description(ccb.content.text("You feel someone's presences.  They are wondering."))
    :description(ccb.content.text("Random voices jump into your head from time to time.  Most of them are friendly."))
    :description(ccb.content.text("You clearly feel the otherworldly presence.  They are ready to help you.")))

content.add(content.EffectType {
    id = "night_sight",
    name = ccb.content.text("Night Sight"),
    description = ccb.content.text("You can see in the dark."),
    apply_message = ccb.content.text("Your sight adjusts to the darkness."),
    remove_message = ccb.content.text("The darkness loses its shape and your eyes return to their usual hue."),
    rating = "good",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("CRAFT_IN_DARKNESS")
    :flag("READ_IN_DARKNESS")
    :limb_score("night_vis", { multiplier = 10 }))

content.add(content.EffectType {
    id = "effect_dread_weight",
    name = ccb.content.text("Existential Dread"),
    description = ccb.content.text("Is there any point to forward movement?"),
    apply_message = ccb.content.text("The air around you chills as existence loses its appeal!"),
    remove_message = ccb.content.text("The weight is lifted from your mind and the air warms."),
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -40, per_intensity = -10 }))

-- Should reduce and reverse the effects of vampire_virus.
content.add(content.EffectType {
    id = "blood_treatment",
    blood_analysis_description = ccb.content.text("Heightened levels of organosulfur compounds, mercury, and silver."),
    rating = "good",
    maximum_duration_turns = 8640000,
    duration_add_percent = 25,
}
    :blocks_effect("vampire_virus"))

-- The PC has consumed more human blood than usual.  Will slow them down some but gives them more blood vitamin to cast with or to go without consuming blood for longer.
content.add(content.EffectType {
    id = "blood_quenched",
    name = ccb.content.text("Flush"),
    blood_analysis_description = ccb.content.text("Patient has had extensive battlefield blood transfusions.  Serious risk of bloodborne infections."),
    rating = "mixed",
    maximum_intensity = 100,
}
    :name(ccb.content.text("Engorged"))
    :name(ccb.content.text("Tick-like"))
    :blocks_optional_effect("vampire_virus_hunger")
    :modifier("speed", "amount", { base = -10, per_intensity = -20 })
    :modifier("dexterity", "amount", { base = -1, per_intensity = -1 })
    :modifier("dodge", "amount", { base = -1, per_intensity = -1 }))

-- Intensity 1 is a standard dosage of the drug.  Further intensities reflect taking pills while the first dose hasn't worn off.  It is not wise to do so.
content.add(content.EffectType {
    id = "cheval_overdose",
    name = ccb.content.text("Energized"),
    blood_analysis_description = ccb.content.text("Patient has dangerous levels of multiple chemicals in their blood.  Sedation and restraint suggested."),
    maximum_intensity = 4,
}
    :name(ccb.content.text("Enflamed"))
    :name(ccb.content.text("Arrhythmic"))
    :name(ccb.content.text("Tachycardiac"))
    :decay_message(ccb.content.text("These magickal trucker pills have worn off and you feel rough.  It might be best to go ahead and sleep through the hangover as best you can."), "bad")
    :decay_message(ccb.content.text("Aside from any leftover pain and damage that was done to your body by overdosing your feeling pretty good now."), "good")
    :decay_message(ccb.content.text("Your heartbeat slows into a somewhat normal rhythm but your skin is still on fire."), "good")
    :decay_message(ccb.content.text("The pain in your chest subsides but your heart is still beating in a concerning fashion."), "good")
    :modifier("speed", "amount", { base = 10 })
    :modifier("strength", "amount", { base = 1 })
    :modifier("stimulant", "amount", { base = 1 })
    :modifier("stimulant", "tick", { base = 500 })
    :modifier("stimulant", "maximum_value", { base = 50, per_intensity = 400 })
    :modifier("hurt", "chance_numerator", { base = 1 })
    :modifier("hurt", "tick", { base = 15000, per_intensity = -4925 })
    :modifier("pain", "amount", { per_intensity = 10 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "tick", { base = 400, per_intensity = -100 })
    :modifier("hurt", "amount", { base = 1, per_intensity = 1 })
    :modifier("perspiration", "amount", { per_intensity = 6 })
    :modifier("perspiration", "minimum", { per_intensity = 1 })
    :modifier("perspiration", "chance_numerator", { per_intensity = 2 })
    :modifier("perspiration", "tick", { per_intensity = 150 })
    :modifier("pain", "minimum", { per_intensity = 1 })
    :apply_message(ccb.content.text("These magickal trucker pills have kicked in and you feel great!"), "good")
    :apply_message(ccb.content.text("You shouldn't have taken this many pills.  Your skin flushes and your nerves feel like they are on fire."), "bad")
    :apply_message(ccb.content.text("Your heartbeat doesn't feel normal.  Why on earth did you take more of these pills?"), "bad")
    :apply_message(ccb.content.text("This might just be it, the big one.  With no hospital available you're just going to have to ride it straight through Hell."), "bad"))

content.add(content.EffectType {
    id = "cheval_withdrawal",
    blood_analysis_description = ccb.content.text("Patient has multiple byproducts in blood stream suggesting extended drug binge."),
    rating = "bad",
}
    :modifier("speed", "amount", { base = -15 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("stimulant", "amount", { base = -1 })
    :modifier("stimulant", "tick", { base = 500 })
    :modifier("stimulant", "maximum_value", { base = -50 }))

-- Lighter scaling to factor the two hallucination effects the player will receive at intensity 3 and 4.
content.add(content.EffectType {
    id = "drank_fae_blood_hallucination",
    name = ccb.content.text("Altered vision"),
    blood_analysis_description = ccb.content.text("Unknown Hallucinogens."),
    maximum_intensity = 4,
}
    :name(ccb.content.text("Distorted vision"))
    :name(ccb.content.text("Hallucination"))
    :name(ccb.content.text("Severe hallucination"))
    :decay_message(ccb.content.text("Your vision is normal again."), "good")
    :decay_message(ccb.content.text("Your vision is almost back to normal."), "good")
    :decay_message(ccb.content.text("You stopped seeing things, but your vision still twists and deforms what you see."), "good")
    :decay_message(ccb.content.text("Your ability to differentiate what is real and what isn't is a little better now."), "good")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :apply_message(ccb.content.text("Your vision twists a little after drinking that Fae blood."), "mixed")
    :apply_message(ccb.content.text("Your vision starts distorting a little more as you drink the Fae blood."), "mixed")
    :apply_message(ccb.content.text("Your vision starts seeing things that aren't there as you drink the Fae blood."), "mixed")
    :apply_message(ccb.content.text("Drinking that much Fae blood has left your vision almost unable to differentiate between reality and illusion."), "bad")
    :limb_score("reaction", { multiplier = 0.8, per_intensity = -0.05 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.05 }))

-- Should happen if you consume blood treatments after gaining Vampire4 trait.
content.add(content.EffectType {
    id = "poisoned_blood",
    name = ccb.content.text("Poisoned blood"),
    description = ccb.content.text("You have poisoned your own blood!"),
    blood_analysis_description = ccb.content.text("Poison"),
    rating = "bad",
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    show_in_info = true,
}
    :modifier("perception", "amount", { base = -2, resisted_base = -1 })
    :modifier("dexterity", "amount", { base = -1, resisted_base = -1 })
    :modifier("strength", "amount", { base = -2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 150, resisted_base = 900 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 150, resisted_base = 2700 })
    :miss_message(ccb.content.text("You feel bad inside."), 1))

-- Should happen if you consume blood treatments after gaining Vampire5 trait.
content.add(content.EffectType {
    id = "poisoned_blood2",
    death_message = ccb.content.text("Your blood turns to acid and melts through your body."),
    death_event = "dies_from_bleeding",
    rating = "bad",
    maximum_duration_turns = 86400,
    duration_add_percent = 25,
}
    :death_chance({ numerator = 1, denominator = 1, resisted_numerator = 1, resisted_denominator = 1 }))

content.add(content.EffectType {
    id = "arion_blood_drank",
    name = ccb.content.text("Drank blood"),
    description = ccb.content.text("The hungry Arion has drunk blood and is now visibly regenerating."),
    rating = "good",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_feed_the_black_horse",
    name = ccb.content.text("Feed Arion"),
    description = ccb.content.text("It's time to feed Arion.  If you do not there will be consequences."),
    rating = "bad",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_fed_the_black_horse",
    name = ccb.content.text("Fed Arion"),
    description = ccb.content.text("You have fed Arion and it shall not devolve for a while."),
    rating = "good",
    show_in_info = true,
})

-- Each stage is intended to last 5.3 days.  I'm not sure if I've got the decay ticks correct on this.
content.add(content.EffectType {
    id = "vampire_virus",
    apply_memorial_log = "Contracted a bloodborne pathogen out of legend.",
    remove_memorial_log = "Rid themselves of a horrific curse of the blood.",
    death_message = ccb.content.text("You succumb to your deadly necrotic condition."),
    name = ccb.content.text("Wan"),
    description = ccb.content.text("Your complexion is wan and spent."),
    blood_analysis_description = ccb.content.text("Unknown RNA virus is rewriting sampled blood cells."),
    maximum_intensity = 3,
}
    :name(ccb.content.text("Reddened Eyes"))
    :name(ccb.content.text("Bloodthirst"))
    :description(ccb.content.text("Your skin is pale and your eyes are thoroughly bloodshot."))
    :description(ccb.content.text("Your skin is pale and your eyes have turned dark red.  You feel a constant hunger, like the food you eat is no longer nourishing you."))
    :flag("HEMOVORE")
    :flag("NO_THORNWITCHERY")
    :resist_effect("blood_treatment")
    :blocks_effect("cold")
    :blocks_effect("flu")
    :resist_trait("ACIDBLOOD")
    :resist_trait("BLOOD_OF_SAINTS")
    :modifier("speed", "amount", { base = -5, per_intensity = 15 })
    :modifier("strength", "amount", { per_intensity = 1.5 })
    :modifier("dodge", "amount", { per_intensity = 1.5 })
    :apply_message(ccb.content.text("You feel the blood rushing from the wound and then a pressure that reminds you of backwash as a liquid that feels heavier than normal blood is forced through the wound into your body."), "bad")
    :apply_message(ccb.content.text("Your iris slowly turns red from the outside in."), "bad")
    :apply_message(ccb.content.text("There is an emptiness in your stomach and soul that can no longer be filled with mortal joys."), "bad"))

content.add(content.EffectType {
    id = "vampire_virus_ascendant",
    apply_memorial_log = "Willingly left their humanity behind.",
    death_message = ccb.content.text("You succumb to your deadly necrotic condition."),
    name = ccb.content.text("Terminal Porphyria"),
    description = ccb.content.text("Your skin is deathly white and will redden and burn when exposed to the sun."),
    apply_message = ccb.content.text("You've chosen to embrace this illness and enhance your curse."),
    blood_analysis_description = ccb.content.text("Blood sample contains numerous unidentified mutations and numerous blood sources.  Original host blood unidentifiable in the mix."),
    maximum_intensity = 1,
    rating = "bad",
}
    :resist_effect("blood_treatment")
    :resist_effect("blood_quenched")
    :resist_trait("ACIDBLOOD")
    :modifier("speed", "amount", { base = 20 })
    :modifier("strength", "amount", { base = 2 })
    :modifier("dodge", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "vampire_virus_post_mortal",
    apply_memorial_log = "Terrorized the remnants of humanity til there were none left.",
    remove_memorial_log = "Found a miracle in a world full of the dead.",
    death_message = ccb.content.text("You succumb to your deadly necrotic condition."),
    name = ccb.content.text("Homo sapiens homovorus"),
    description = ccb.content.text("Your skin is deathly white, your eyes are solid red except for a huge pupil, the only food you can consume is human blood, and if sunlight hits you that part of your body instantly burns."),
    apply_message = ccb.content.text("Becoming a monster is a matter of degrees until one day it isn't and you can no longer remember why morality seemed important."),
    blood_analysis_description = ccb.content.text("Blood sample contains numerous unidentified mutations and numerous blood sources.  Original host blood unidentifiable in the mix."),
    maximum_intensity = 1,
    rating = "bad",
}
    :resist_effect("blood_treatment")
    :resist_effect("blood_quenched")
    :resist_trait("ACIDBLOOD")
    :modifier("speed", "amount", { base = 40 })
    :modifier("strength", "amount", { base = 4 })
    :modifier("dodge", "amount", { base = 4 }))

-- This is the starving effect when the vampire hasn't consumed enough human blood.  Should take several days of not consuming blood even if not using any powers.
content.add(content.EffectType {
    id = "withering",
    name = ccb.content.text("Sallow"),
    description = ccb.content.text("The absence of raw blood from your diet has left you wan, pale and uncomfortable."),
    apply_message = ccb.content.text("Most of your thoughts now revolve around blood, how good it tastes and where you might find it."),
    remove_message = ccb.content.text("Your blood lust is slaked."),
    blood_analysis_description = ccb.content.text("Severe Progressive Anemic Autophagy"),
    maximum_intensity = 4,
    rating = "bad",
}
    :name(ccb.content.text("Hypomia"))
    :name(ccb.content.text("Corpse-like"))
    :name(ccb.content.text("Eternal Slumber"))
    :description(ccb.content.text("Your body is weakened and your need to feed is a constant pain in your chest."))
    :description(ccb.content.text("Severe blood deficiency has left you looking emaciated no matter what your weight is."))
    :description(ccb.content.text("One day blood may spill on your lips and wake you from your slumber, but until then you are a corpse."))
    :decay_message(ccb.content.text("You've almost consumed enough blood to feel normal again."), "good")
    :decay_message(ccb.content.text("More blood and you'll start to feel even better."), "good")
    :modifier("strength", "amount", { base = -1, per_intensity = -2 })
    :modifier("stamina", "minimum", { base = -100 })
    :modifier("stamina", "maximum", { base = -200, per_intensity = -500 })
    :modifier("stamina", "chance_numerator", { base = 9000, per_intensity = -300 })
    :modifier("sleepiness", "minimum", { base = 10 })
    :modifier("sleepiness", "maximum", { base = 20, per_intensity = 20 })
    :modifier("sleepiness", "chance_numerator", { base = 9000, per_intensity = -300 })
    :modifier("health", "minimum", { base = -1, per_intensity = -1 })
    :modifier("health", "chance_numerator", { base = 9000, per_intensity = -1000 })
    :modifier("health_modifier", "minimum", { base = -1, per_intensity = -1 })
    :modifier("health_modifier", "minimum_value", { per_intensity = -50 })
    :modifier("health_modifier", "chance_numerator", { base = 9000, per_intensity = -200 })
    :death_chance({ numerator = -1, denominator = 1, resisted_numerator = -1, resisted_denominator = 1 })
    :death_chance({ numerator = -1, denominator = 1, resisted_numerator = -1, resisted_denominator = 1 })
    :death_chance({ numerator = -1, denominator = 1, resisted_numerator = -1, resisted_denominator = 1 })
    :death_chance({ numerator = 1, denominator = 100, resisted_numerator = 1, resisted_denominator = 2000000 }))

-- Hidden effect, prevents the vampire from gaining blood if they're interrupted.
content.add(content.EffectType {
    id = "effect_vampire_blood_drinking",
    name = "",
    description = "",
})

-- Hidden effect, keeps the target immobilized while blood is being drunk.
content.add(content.EffectType {
    id = "effect_vampire_blood_drinking_target",
    name = ccb.content.text("Vampire's Kiss"),
    description = ccb.content.text("You are having your blood drunk by a vampire and are still in a swoon."),
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE"))

-- Hidden effect, faking a monster target having lost blood volume.
content.add(content.EffectType {
    id = "effect_vampire_drunk_from_in_combat",
    name = "",
    description = "",
    intensity_add_value = 1,
    maximum_intensity = 12,
    intensity_decay_step = -1,
    intensity_decay_tick = 172800,
}
    :death_chance({ numerator = 1, denominator = 2000000 })
    :death_chance({ numerator = 1, denominator = 1000000 })
    :death_chance({ numerator = 1, denominator = 500000 })
    :death_chance({ numerator = 1, denominator = 200000 })
    :death_chance({ numerator = 1, denominator = 100000 })
    :death_chance({ numerator = 1, denominator = 50000 })
    :death_chance({ numerator = 1, denominator = 5000 })
    :death_chance({ numerator = 1, denominator = 1000 })
    :death_chance({ numerator = 1, denominator = 500 })
    :death_chance({ numerator = 1, denominator = 100 })
    :death_chance({ numerator = 1, denominator = 50 })
    :death_chance({ numerator = 1, denominator = 10 }))

-- Hidden--provides blood every ~60 seconds until 1 below the blood_quenched level
content.add(content.EffectType {
    id = "effect_dhampir_slow_blood_gain",
    name = "",
    description = "",
}
    :removes_effect("withering")
    :vitamin("human_blood_vitamin", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 60 },
    }))

-- Hidden--provides blood every ~120 seconds until 1 below the blood_quenched level
content.add(content.EffectType {
    id = "effect_dhampir_slow_blood_gain_with_weakness",
    name = "",
    description = "",
}
    :removes_effect("withering")
    :vitamin("human_blood_vitamin", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 120 },
    }))

-- Hidden--removes blood every ~60 seconds until 1 below the blood_quenched level
content.add(content.EffectType {
    id = "effect_dhampir_slow_blood_loss",
    name = "",
    description = "",
}
    :vitamin("human_blood_vitamin", {
        rates = { { minimum = -1, maximum = -1 } },
        tick_turns = { 30, 90 },
    }))

-- Hidden--prevents gaining blood when using The Blood is the Life
content.add(content.EffectType {
    id = "effect_dhampir_the_blood_is_the_life",
    name = "",
    description = "",
}
    :flag("HUNGER_DISRUPTION"))

-- Hidden--cosmetic to make dhampirs with Corpselike Pallor more pale
content.add(content.EffectType {
    id = "effect_dhampir_corpselike_pallor_pale",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_dhampir_corpselike_pallor_pale_0"))

-- Hidden, but provides effect for when a mad inventor has gadgets in inventory.
content.add(content.EffectType {
    id = "effect_weird_equipment",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_dhampir_empowered_blood_indicator",
    name = ccb.content.text("Empowered Blood"),
    description = ccb.content.text("Your blood hums with power, allowing you to access more of your vampiric abilities."),
})

content.add(content.EffectType {
    id = "effect_dhampir_enervated_blood",
    name = ccb.content.text("Enervated Blood"),
    description = ccb.content.text("You have used up much of the power in your blood, and are slightly listless as a result.  In addition, some of your vampiric powers will not function as well, or at all, until the power returns to your blood."),
}
    :removes_effect("withering")
    :enchantment("INLINE_ENCH_effect_dhampir_enervated_blood_0"))

-- Hidden--tied to a conditional enchantment
content.add(content.EffectType {
    id = "effect_dhampir_fall_one_story",
    name = "",
    description = "",
}
    :flag("ONE_STORY_FALL"))

-- Hidden--tied to a conditional enchantment
content.add(content.EffectType {
    id = "effect_dhampir_resist_disease_poison_infection",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_dhampir_resist_disease_poison_infection_0")
    :enchantment("INLINE_ENCH_effect_dhampir_resist_disease_poison_infection_1")
    :enchantment("INLINE_ENCH_effect_dhampir_resist_disease_poison_infection_2"))

content.add(content.EffectType {
    id = "effect_dhampir_water_weakness_pain",
    name = ccb.content.text("Pain in Water"),
    description = ccb.content.text("The running water burns you!"),
    rating = "bad",
}
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "maximum_value", { base = 25 })
    :modifier("pain", "chance_numerator", { base = 5 })
    :modifier("pain", "tick", { base = 5 }))

-- Still distracting but not as bad as for vampires
content.add(content.EffectType {
    id = "effect_dhampir_bloodlust_cravings",
    name = ccb.content.text("Blood Craving"),
    description = ccb.content.text("Your thoughts keep going back to the taste of warm, fresh blood."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("breathing", { multiplier = 0.9, per_intensity = -0.08 })
    :limb_score("reaction", { multiplier = 0.9, per_intensity = -0.07 })
    :limb_score("footing", { multiplier = 0.9, per_intensity = -0.1 }))

content.add(content.EffectType {
    id = "eyegleam",
    name = ccb.content.text("Eye Gleam"),
    description = ccb.content.text("You can see in the dark."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_eyegleam_0")
    :enchantment("INLINE_ENCH_eyegleam_1"))

content.add(content.EffectType {
    id = "eyegleam_craft_in_darkness",
    rating = "good",
}
    :flag("CRAFT_IN_DARKNESS")
    :flag("READ_IN_DARKNESS"))

content.add(content.EffectType {
    id = "effect_vampiric_strength",
    name = ccb.content.text("Vigor Mortis"),
    description = ccb.content.text("You have the strength of the damned."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_vampiric_strength_0")
    :enchantment("INLINE_ENCH_effect_vampiric_strength_1"))

content.add(content.EffectType {
    id = "effect_vampire_unholy_devastation",
    name = "",
    description = "",
    maximum_intensity = 20,
    intensity_add_value = 1,
}
    :enchantment("INLINE_ENCH_effect_vampire_unholy_devastation_0"))

content.add(content.EffectType {
    id = "effect_vampiric_resilience",
    name = ccb.content.text("Sanguine Resilience"),
    description = ccb.content.text("You have the fortitude of the grave."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_vampiric_resilience_0"))

-- Hidden effect, grants dhampirs and vampires bonus health when at positive blood
content.add(content.EffectType {
    id = "effect_vampire_health_bonus",
    name = "",
    description = "",
}
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 3 })
    :modifier("health", "tick", { base = 3600 }))

-- Hidden effect, boost cardio when using Unholy Endurance and possessing the Incarnadine Relentlessness refinement.
content.add(content.EffectType {
    id = "effect_vampire_stamina_for_blood_cardio_bonus",
    name = "",
    description = "",
    intensity_add_value = 1,
    maximum_intensity = 5,
    maximum_duration_turns = 1200,
}
    :enchantment("INLINE_ENCH_effect_vampire_stamina_for_blood_cardio_bonus_0"))

content.add(content.EffectType {
    id = "blood_weave",
    name = ccb.content.text("Blood Weave"),
    description = ccb.content.text("Immunity to bleeding and bites, increased stamina regeneration, increased hunger and thirst gain."),
    remove_message = ccb.content.text("The tension running through your flesh fades."),
    rating = "good",
    maximum_duration_turns = 300,
}
    :flag("BLEED_IMMUNE")
    :blocks_effect("bleed")
    :blocks_effect("bite")
    :modifier("hunger", "minimum", { base = 1 })
    :modifier("hunger", "chance_numerator", { base = 12 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "chance_numerator", { base = 12 })
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 4 })
    :modifier("stamina", "minimum", { base = 40 })
    :modifier("stamina", "chance_numerator", { base = 2 }))

content.add(content.EffectType {
    id = "effect_vampire_drank_blood_power_boost",
    name = ccb.content.text("Carmine Vitality"),
    description = ccb.content.text("You can still taste the warm blood on your lips.  You feel amazing."),
    rating = "good",
    maximum_duration_turns = 3600,
}
    :enchantment("INLINE_ENCH_effect_vampire_drank_blood_power_boost_0")
    :enchantment("INLINE_ENCH_effect_vampire_drank_blood_power_boost_1"))

content.add(content.EffectType {
    id = "effect_vampiric_dodge",
    name = ccb.content.text("Flow Like Blood"),
    description = ccb.content.text("You can move so quickly you might even be able to dodge bullets."),
    rating = "good",
}
    :flag("HARDTOHIT")
    :blocks_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_vampiric_dodge_0"))

content.add(content.EffectType {
    id = "effect_vampiric_stealth_bonus",
    name = ccb.content.text("Cloak of Shadows"),
    description = ccb.content.text("You are clouding nearby minds and are harder to spot in dim light or darkness."),
}
    :enchantment("INLINE_ENCH_effect_vampiric_stealth_bonus_0"))

-- Hidden effect, used to prevent spamming fear gaze repeatedly.
content.add(content.EffectType {
    id = "effect_vampire_fear_gazed",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_vampire_feign_death",
    name = ccb.content.text("Corpse's Countenance"),
    description = ccb.content.text("Nothing here but a corpse."),
    remove_message = ccb.content.text("You end your imitation of death."),
    rating = "mixed",
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE")
    :flag("NO_BODY_HEAT")
    :enchantment("INLINE_ENCH_effect_vampire_feign_death_0")
    :enchantment("INLINE_ENCH_effect_vampire_feign_death_1")
    :enchantment("INLINE_ENCH_effect_vampire_feign_death_2"))

content.add(content.EffectType {
    id = "effect_vampire_feign_death_ended",
    name = ccb.content.text("Feigned Death"),
    description = ccb.content.text("You've been caught, and they know you aren't dead"),
    rating = "bad",
}
    :removes_effect("effect_vampire_feign_death"))

content.add(content.EffectType {
    id = "effect_vampire_hypnotism",
    name = ccb.content.text("Mesmerized"),
    description = ccb.content.text("You just can't seem to move or think."),
    remove_message = ccb.content.text("You snap out of your fugue."),
    rating = "bad",
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE")
    :flag("MUTE"))

-- Hidden effect, used to make sure only active blood gift research gains powers.
content.add(content.EffectType {
    id = "effect_vampire_studying_blood_gifts",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_vampire_recently_learned_blood_gifts",
    name = ccb.content.text("Learned blood gift"),
    description = ccb.content.text("You recently discovered a gift of the blood.  Until you've experimented with it and tested your new powers, further research will be fruitless."),
    remove_message = ccb.content.text("You're sure you could try to learn a new blood gift now."),
    rating = "bad",
})

-- Hidden effect, used to make sure bat form can fly.
content.add(content.EffectType {
    id = "effect_vampire_bat_form_levitation",
    name = "",
    description = "",
}
    :flag("LEVITATION")
    :flag("CLIMB_FLYING"))

-- Hidden effect, used to make sure mist form doesn't drop items.
content.add(content.EffectType {
    id = "effect_vampire_mist_form",
    name = "",
    description = "",
}
    :flag("ETHEREAL")
    :flag("INVISIBLE")
    :enchantment("INLINE_ENCH_effect_vampire_mist_form_0"))

content.add(content.EffectType {
    id = "eater_lump_pool",
    name = ccb.content.text("Dream Gorging"),
    description = ccb.content.text("You ate a whole dreamdross ingot.  It is too much for your body, but for a while you are much <color_green>stronger</color>, and <color_green>recover from traumas</color> faster."),
    apply_message = ccb.content.text("A huge warm wave moves from your stomach through your body."),
    remove_message = ccb.content.text("The warm feeling fades away."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_eater_lump_pool_0"))

-- Must limit the player's sight to 2-3 tiles (maybe real blind would be cool, but I don't really think it's a good idea (and also I don't know how it interacts with melee (and also the effect is pretty weak for total blindness))), but it's hardcoded atm
content.add(content.EffectType {
    id = "blind_rage",
    name = ccb.content.text("Blind Rage"),
    description = ccb.content.text("Perfect hatred"),
    apply_message = ccb.content.text("AAAAARGH!!"),
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("strength", "amount", { base = 6 })
    :modifier("dexterity", "amount", { base = 6 })
    :modifier("perception", "amount", { base = -8 })
    :limb_score("vision", { multiplier = 0.1 })
    :limb_score("night_vis", { multiplier = 0.1 }))

-- +0.2x smamina regen for each level
content.add(content.EffectType {
    id = "spell_stamina_eff",
    name = ccb.content.text("Circulatory"),
    description = ccb.content.text("You can't run out of <color_green>breath</color>."),
    apply_message = ccb.content.text("You feel a deep energy in your muscles, exuberant and coiled."),
    remove_message = ccb.content.text("The energy in your body fades away."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_spell_stamina_eff_0"))

-- +1 dodge initially, +1 each 6 levels
content.add(content.EffectType {
    id = "effect_dodge",
    name = ccb.content.text("Dodge"),
    description = ccb.content.text("<color_green>Shun</color> their attacks."),
    apply_message = ccb.content.text("Your reaction speed is increased."),
    remove_message = ccb.content.text("Your reaction speed turns back to normal."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_dodge_0"))

-- +1 armor for each lvl
content.add(content.EffectType {
    id = "effect_endurance",
    name = ccb.content.text("Endurance"),
    description = ccb.content.text("Take the blows.  <color_red>Don't let the world kill you</color>.  Your skin can stop a few attacks."),
    apply_message = ccb.content.text("Your sense of touch is blunted for a bit, but your skin feels more dense."),
    remove_message = ccb.content.text("The sturdy feeling is gone."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_endurance_0"))

-- +2 atk speed for each level, +1 dodge each 10 levels, +5% melee damage every level
content.add(content.EffectType {
    id = "spell_melee_damage",
    name = ccb.content.text("Physical Instrument"),
    description = ccb.content.text("Your body is a tool of destruction.  <color_red>Use it effectively</color>.  Your attacks are faster and deadlier, and your dodging ability is better."),
    apply_message = ccb.content.text("You can feel a bubbling energy in your muscles."),
    remove_message = ccb.content.text("The feelings in your muscles subside."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_spell_melee_damage_0"))

-- +5 speed for each level
content.add(content.EffectType {
    id = "spell_speed_eff",
    name = ccb.content.text("Rush"),
    description = ccb.content.text("A burst of <color_green>speed</color>."),
    apply_message = ccb.content.text("You feel your legs are much longer now."),
    remove_message = ccb.content.text("Your body shrinks back into its normal space."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_spell_speed_eff_0"))

-- todo: doesn't do anything, because monster do not have u_spell_level('spell_weak'); solution: store u_spell_level('spell_weak') as monster variable, and use variable in calculations instead
content.add(content.EffectType {
    id = "effect_weakening",
    name = ccb.content.text("Weakness"),
    description = ccb.content.text("Your body is weakened."),
    rating = "bad",
    show_intensity = false,
    maximum_intensity = 2,
    intensity_add_value = 1,
}
    :enchantment("INLINE_ENCH_effect_weakening_0"))

content.add(content.EffectType {
    id = "spell_unbreakable_eff",
    name = "",
    description = "",
    apply_message = ccb.content.text("You are the only who can control your body now."),
    remove_message = ccb.content.text("External forces apply to your body again."),
    rating = "good",
}
    :blocks_effect("grabbed")
    :enchantment("INLINE_ENCH_spell_unbreakable_eff_0"))

content.add(content.EffectType {
    id = "mutagen_earthkin",
    name = ccb.content.text("Ierde Mutation"),
    description = ccb.content.text("You consumed Ierde destiny draught."),
    blood_analysis_description = ccb.content.text("Anomalous silicon content in blood sample"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Ierde Transformation"))
    :name(ccb.content.text("Ierde Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of Ierde destiny draught."))
    :description(ccb.content.text("You consumed a life-changing amount of Ierde destiny draught."))
    :resist_trait("THRESH_IERDE")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "wicked_quick_hands",
    name = ccb.content.text("Wicked Quick Hands"),
    description = ccb.content.text("Your hands move wicked quick!"),
    apply_message = ccb.content.text("Your reflexes are heightened!"),
    remove_message = ccb.content.text("Your reflexes return to normal."),
    rating = "good",
}
    :removes_effect("terrible_strength")
    :modifier("dexterity", "amount", { base = 4 }))

content.add(content.EffectType {
    id = "terrible_strength",
    name = ccb.content.text("Terrible Strength"),
    description = ccb.content.text("You have a terrible strength!"),
    apply_message = ccb.content.text("You feel strong!"),
    remove_message = ccb.content.text("Your strength deflates."),
    rating = "good",
}
    :removes_effect("wicked_quick_hands")
    :modifier("strength", "amount", { base = 4 }))

-- Just to make karma arms drop a proper liquid when damaged
content.add(content.EffectType {
    id = "bleed_karma",
    name = "",
    description = "",
    show_intensity = false,
    show_in_info = false,
}
    :enchantment("INLINE_ENCH_bleed_karma_0"))

content.add(content.EffectType {
    id = "effect_evil_eye",
    name = ccb.content.text("Evil Eye"),
    description = ccb.content.text("Something is definitely wrong."),
    rating = "bad",
    show_in_info = true,
    maximum_intensity = 5,
    show_intensity = false,
}
    :immune_character_flag("EVIL_EYE_IMMUNE")
    :immune_character_flag("EVIL_EYE_IMMUNE_MONSTER")
    :modifier("hit", "amount", { base = -2, per_intensity = -0.5 })
    :modifier("dodge", "amount", { base = -2, per_intensity = -0.5 })
    :modifier("perception", "amount", { base = -2, per_intensity = -0.6 })
    :modifier("health", "chance_numerator", { base = 20, per_intensity = -3 })
    :modifier("health", "tick", { base = 30, per_intensity = -5 })
    :modifier("sleepiness", "tick", { base = 30, per_intensity = -5 })
    :modifier("sleepiness", "chance_numerator", { base = 20, per_intensity = -3 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("strength", "amount", { per_intensity = -1 })
    :modifier("dexterity", "amount", { per_intensity = -1 }))

content.add(content.EffectType {
    id = "effect_sylph_underground_timer",
    name = ccb.content.text("Underground in Dead Air"),
    description = ccb.content.text("You were not born to crawl beneath the dirt like a mole.  You need to get out to the open sky."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_salamander_wet_rate_limiter",
    name = "",
    description = "",
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_broke_fae_ban",
    name = ccb.content.text("Broken Ban"),
    description = ccb.content.text("You've broken one of the ancient laws that bind the fae and are suffering thereby."),
    rating = "bad",
    maximum_intensity = 10,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :enchantment("INLINE_ENCH_effect_broke_fae_ban_0")
    :modifier("perception", "amount", { base = -1, per_intensity = -0.6 })
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 50, per_intensity = -3 })
    :modifier("health", "tick", { base = 600, per_intensity = -30 })
    :modifier("vomiting", "chance_numerator", { base = 1000, per_intensity = -50 })
    :modifier("strength", "amount", { per_intensity = -1 })
    :modifier("dexterity", "amount", { per_intensity = -1 })
    :limb_score("balance", { multiplier = 0.9, per_intensity = -0.08 })
    :limb_score("breathing", { multiplier = 1.0, per_intensity = -0.08 })
    :limb_score("lift", { multiplier = 0.9, per_intensity = -0.08 })
    :limb_score("grip", { multiplier = 1.0, per_intensity = -0.08 })
    :limb_score("reaction", { multiplier = 0.9, per_intensity = -0.07 })
    :limb_score("block", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("vision", { multiplier = 1.0, per_intensity = -0.06 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_iron_tier_4",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron, the ancient bane of the fae.  It will cause you severe pain and damage until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to bubble and sear!"),
    remove_message = ccb.content.text("The burning from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 15 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 4 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = 250 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "tick", { base = 150 })
    :limb_score("balance", { multiplier = 0.5 })
    :limb_score("breathing", { multiplier = 0.5 })
    :limb_score("lift", { multiplier = 0.6 })
    :limb_score("grip", { multiplier = 0.6 })
    :limb_score("reaction", { multiplier = 0.7 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_steel_tier_4",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel, the closest material to iron, the ancient bane of the fae.  It will cause you severe pain and damage until removed."),
    apply_message = ccb.content.text("As the steel touches you, your skin begins to bubble and sear!"),
    remove_message = ccb.content.text("The burning from the steel finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 12 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 4 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = 125 })
    :modifier("pain", "tick", { base = 110 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "tick", { base = 300 })
    :limb_score("balance", { multiplier = 0.7 })
    :limb_score("breathing", { multiplier = 0.6 })
    :limb_score("lift", { multiplier = 0.7 })
    :limb_score("grip", { multiplier = 0.75 })
    :limb_score("reaction", { multiplier = 0.75 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_iron_tier_3",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron, the ancient bane of the fae.  It will cause you severe pain and discomfort until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to burn."),
    remove_message = ccb.content.text("The burning from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 10 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = 200 })
    :modifier("pain", "tick", { base = 90 })
    :limb_score("balance", { multiplier = 0.75 })
    :limb_score("breathing", { multiplier = 0.7 })
    :limb_score("lift", { multiplier = 0.8 })
    :limb_score("grip", { multiplier = 0.8 })
    :limb_score("reaction", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_steel_tier_3",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel, the closest material to iron, the ancient bane of the fae.  It will cause you severe pain and discomfort until removed."),
    apply_message = ccb.content.text("As the steel touches you, your skin begins to burn."),
    remove_message = ccb.content.text("The burning from the steel finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 8 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = 100 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("balance", { multiplier = 0.8 })
    :limb_score("breathing", { multiplier = 0.75 })
    :limb_score("lift", { multiplier = 0.9 })
    :limb_score("grip", { multiplier = 0.85 })
    :limb_score("reaction", { multiplier = 0.85 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_iron_tier_2",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron, the ancient bane of the fae.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to burn."),
    remove_message = ccb.content.text("The burning from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 3 })
    :modifier("pain", "maximum_value", { base = 100 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("balance", { multiplier = 0.9 })
    :limb_score("breathing", { multiplier = 0.85 })
    :limb_score("lift", { multiplier = 0.9 })
    :limb_score("grip", { multiplier = 0.9 })
    :limb_score("reaction", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_steel_tier_2",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel, the closest material to iron, the ancient bane of the fae.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the steel touches you, your skin begins to itch."),
    remove_message = ccb.content.text("The itching from the steel finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 6 })
    :modifier("pain", "maximum_value", { base = 50 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("breathing", { multiplier = 0.95 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_iron_tier_1",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron, the ancient bane of the fae.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to itch fiercely."),
    remove_message = ccb.content.text("The itch from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 5 })
    :modifier("pain", "maximum_value", { base = 35 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("balance", { multiplier = 0.9 })
    :limb_score("breathing", { multiplier = 0.85 })
    :limb_score("lift", { multiplier = 0.9 })
    :limb_score("grip", { multiplier = 0.9 })
    :limb_score("reaction", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "effect_xe_iron_intolerance_wearing_steel_tier_1",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the steel touches you, your skin begins to itch."),
    remove_message = ccb.content.text("The itching from the steel finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :removes_effect("effect_iron_allergy_wearing_iron")
    :removes_effect("effect_iron_allergy_wearing_steel")
    :modifier("pain", "amount", { base = 2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 10 })
    :modifier("pain", "maximum_value", { base = 15 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("breathing", { multiplier = 0.95 }))

content.add(content.EffectType {
    id = "effect_hungry_roots",
    name = ccb.content.text("Hungry Thirsty Roots"),
    description = ccb.content.text("Roots and vines clutch at you."),
    apply_message = ccb.content.text("Roots and vines entangle you!"),
    remove_message = ccb.content.text("The roots and vines wither up and die."),
    maximum_intensity = 4,
    intensity_add_value = 1,
    show_in_info = true,
}
    :flag("EFFECT_IMPEDING")
    :modifier("speed", "amount", { base = -30, per_intensity = -5 }))

content.add(content.EffectType {
    id = "arvore_verdant_infusion",
    name = ccb.content.text("Verdant Infusion"),
    description = ccb.content.text("You are filled with the vitality of nature."),
    apply_message = ccb.content.text("You can feel the power of nature flowing through you."),
    remove_message = ccb.content.text("The power of nature fades from you."),
    rating = "good",
    maximum_duration_turns = 43200,
}
    :modifier("strength", "amount", { base = 1 })
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 30 })
    :modifier("health_modifier", "minimum", { base = 1 })
    :modifier("health_modifier", "chance_numerator", { base = 80 })
    :modifier("health", "tick", { base = 30 })
    :modifier("healing", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_arvore_seedbearer_available",
    name = ccb.content.text("Seed-Bearer"),
    description = ccb.content.text("You can bring forth a fine bunch of seeds, ready for planting."),
})

-- Hidden effect, used as a cooldown
content.add(content.EffectType {
    id = "effect_arvore_seedbearer_cooldown",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "arvore_perennial_rebirth_cooldown",
    name = ccb.content.text("Reborn"),
    description = ccb.content.text("You were reborn and your soul and new body are still finding their balance."),
})

content.add(content.EffectType {
    id = "effect_arvore_poison_pollen",
    name = ccb.content.text("Night-Blooming Flower"),
    description = ccb.content.text("You are emitting a pollen that will weaken and disorient your enemies."),
    rating = "good",
}
    :removes_effect("effect_pollen_arvore_weaken")
    :enchantment("INLINE_ENCH_effect_arvore_poison_pollen_0"))

-- Hidden, but provides vitamins for being out in the sun
content.add(content.EffectType {
    id = "effect_arvore_vitamin_bonus",
    name = "",
    description = "",
}
    :vitamin("calcium", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 1200 },
    })
    :vitamin("vitC", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 1200 },
    })
    :vitamin("iron", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 1200 },
    }))

content.add(content.EffectType {
    id = "effect_pollen_arvore_weaken",
    name = ccb.content.text("Weakening Pollen"),
    description = ccb.content.text("The pollen makes it hard to breathe!"),
    rating = "bad",
    harmful_cough = true,
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_trait("ARVORE_POLLEN_IMMUNE")
    :modifier("speed", "amount", { base = -10 })
    :modifier("hit", "amount", { base = -2 })
    :modifier("dodge", "amount", { base = -2 })
    :miss_message(ccb.content.text("You cough out pollen."), 1)
    :limb_score("breathing", { multiplier = 0.6 }))

content.add(content.EffectType {
    id = "effect_arvore_attacked_a_triffid",
    name = ccb.content.text("Broken Green Pact"),
    description = ccb.content.text("You broke the pact of the green and have no more protection from the triffids' wrath."),
})

-- Hidden effect, used in Arvore spellcasting failure calculations
content.add(content.EffectType {
    id = "effect_arvore_is_day_in_the_sun_not_winter",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_ierde_slow_enemies",
    name = ccb.content.text("Lithic Rigidity "),
    description = ccb.content.text("It's very hard for you to move."),
    remove_message = ccb.content.text("It's easier for you to move again."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_ierde_slow_enemies_0"))

content.add(content.EffectType {
    id = "effect_ierde_rooted_in_place",
    name = ccb.content.text("The Root of the Mountain"),
    description = ccb.content.text("Drawing on the immobility of the mountain, you are resilient but rooted in place."),
}
    :flag("CANNOT_MOVE")
    :removes_effect("stunned")
    :removes_effect("dazed")
    :removes_effect("downed")
    :enchantment("INLINE_ENCH_effect_ierde_rooted_in_place_0"))

content.add(content.EffectType {
    id = "effect_ierde_buff_armor_allies",
    name = ccb.content.text("Skin of the Mountains"),
    description = ccb.content.text("Your skin is much harder than it appears."),
    apply_message = "",
    remove_message = ccb.content.text("The magicks reinforcing your skin vanish."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_ierde_buff_armor_allies_0"))

-- Empty to hide effect--it's linked to a mutation already
content.add(content.EffectType {
    id = "effect_ierde_limb_breaking_stopper",
    name = "",
    description = "",
}
    :removes_effect("disabled"))

-- Empty to hide effect--it's linked to a mutation already
content.add(content.EffectType {
    id = "effect_ierde_craft_in_darkness",
    name = "",
    description = "",
}
    :flag("CRAFT_IN_DARKNESS"))

-- Empty to hide effect--it's linked to a mutation already
content.add(content.EffectType {
    id = "effect_ierde_no_mind_problems",
    name = "",
    description = "",
}
    :removes_effect("hallu")
    :removes_effect("taint")
    :removes_effect("hallucinogenic_acid_heavy")
    :removes_effect("hallucinogenic_acid_light")
    :removes_effect("visuals"))

content.add(content.EffectType {
    id = "effect_ierde_earthen_shield",
    name = ccb.content.text("Impenetrable Earthen Shield"),
    description = ccb.content.text("You are protected by the living earth."),
    remove_message = ccb.content.text("Your earthen shield finally crumbles."),
}
    :enchantment("INLINE_ENCH_effect_ierde_earthen_shield_0"))

content.add(content.EffectType {
    id = "effect_ierde_sense_nearby_monsters",
    name = ccb.content.text("Earth-Sensing"),
    description = ccb.content.text("You are sensing the movements of nearby creatures upon the living earth."),
    apply_message = ccb.content.text("Nearby creatures' movements are revealed to you."),
    remove_message = ccb.content.text("Your earth-sense fades away."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_ierde_sense_nearby_monsters_0"))

content.add(content.EffectType {
    id = "effect_homullus_reduced_visibility_ally",
    name = ccb.content.text("Average Joe"),
    description = ccb.content.text("You're just this guy, you know?"),
    apply_message = "",
    remove_message = ccb.content.text("Nearby enemies twitch and start turning towards you."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_homullus_reduced_visibility_ally_0"))

content.add(content.EffectType {
    id = "effect_homullus_add_learning_focus",
    name = ccb.content.text("Scholar's Regard"),
    description = ccb.content.text("It's time for a study session"),
    apply_message = "",
    remove_message = ccb.content.text("You were just on the cusp of something as your enhanced focus fades."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_homullus_add_learning_focus_0"))

content.add(content.EffectType {
    id = "effect_homullus_prevented_death",
    name = ccb.content.text("Transferred Essence"),
    description = ccb.content.text("You have transferred your essence into a human, saving yourself at the expense of their being.  It will take some time until you can do this again."),
})

content.add(content.EffectType {
    id = "effect_salamander_levitation",
    name = ccb.content.text("Smoke-Walking"),
    description = ccb.content.text("You are walking through the air."),
    apply_message = "",
    remove_message = ccb.content.text("Your feet touch the ground once again."),
    rating = "good",
}
    :flag("LEVITATION"))

content.add(content.EffectType {
    id = "effect_salamander_fire_dot",
    name = ccb.content.text("Fire in the Marrow"),
    description = ccb.content.text("Your burning internal organs are making it more difficult to aim."),
    rating = "bad",
}
    :modifier("hit", "amount", { base = -3 }))

-- Hidden effect, used in Salamander spellcasting failure calculations
content.add(content.EffectType {
    id = "effect_salamander_is_near_a_fire",
    name = "",
    description = "",
})

-- Empty name and description to hide effect
content.add(content.EffectType {
    id = "effect_salamander_featherfall",
    name = "",
    description = "",
    rating = "good",
}
    :flag("FEATHER_FALL"))

-- Empty name and description to hide effect
content.add(content.EffectType {
    id = "effect_salamander_smoke_immunity",
    name = "",
    description = "",
    rating = "good",
}
    :removes_effect("smoke_eyes")
    :removes_effect("smoke_lungs")
    :removes_effect("teargas"))

-- Empty name and description to hide effect
content.add(content.EffectType {
    id = "effect_salamander_remove_stun",
    name = "",
    description = "",
    rating = "good",
}
    :removes_effect("stunned")
    :removes_effect("dazed")
    :removes_effect("downed"))

-- name and description hidden because it's explained in the mutation
content.add(content.EffectType {
    id = "effect_hidden_flame_immunity",
    name = "",
    description = "",
    rating = "good",
}
    :removes_effect("onfire")
    :removes_effect("blisters")
    :enchantment("INLINE_ENCH_effect_hidden_flame_immunity_0"))

content.add(content.EffectType {
    id = "effect_salamander_cure_conditions",
    name = ccb.content.text("Burning"),
    description = ccb.content.text("Your impurities are being seared away!"),
    rating = "mixed",
}
    :removes_effect("fungus")
    :removes_effect("dermatik")
    :removes_effect("bloodworms")
    :removes_effect("paincysts")
    :removes_effect("brainworms")
    :removes_effect("tapeworm")
    :removes_effect("blind")
    :removes_effect("poison")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_optional_effect("stung")
    :removes_effect("badpoison")
    :removes_effect("foodpoison")
    :removes_effect("paralyzepoison")
    :removes_effect("tetanus")
    :removes_effect("rat_bite_fever")
    :removes_effect("infected")
    :removes_effect("asthma")
    :removes_effect("common_cold")
    :removes_effect("flu")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 2 })
    :modifier("hurt", "tick", { base = 1 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 3 })
    :modifier("pain", "tick", { base = 1 }))

content.add(content.EffectType {
    id = "effect_salamander_rain_immunity",
    name = ccb.content.text("Steam Shell"),
    description = ccb.content.text("A thin barrier of heat around your body is protecting you from rain."),
    apply_message = "",
    remove_message = ccb.content.text("The thin shell of heat around your body dissipates."),
    rating = "good",
}
    :flag("RAIN_IMMUNE"))

-- Name and description empty to hide effect
content.add(content.EffectType {
    id = "effect_salamander_burning_damage",
    name = "",
    description = "",
    rating = "bad",
}
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 2 })
    :modifier("hurt", "tick", { base = 1 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 3 })
    :modifier("pain", "tick", { base = 1 }))

content.add(content.EffectType {
    id = "effect_salamander_berserk_stance",
    name = ccb.content.text("Wildfire Soul"),
    description = ccb.content.text("You are filled with transcendent flame."),
    apply_message = ccb.content.text("All of your weakness boils away in the heat of the flames!"),
    remove_message = ccb.content.text("As the heat leaves you, pain rushes in to take its place."),
    rating = "good",
}
    :flag("PAIN_IMMUNE")
    :modifier("strength", "amount", { base = 3 })
    :modifier("dexterity", "amount", { base = 3 })
    :modifier("speed", "amount", { base = 20 }))

content.add(content.EffectType {
    id = "effect_salamander_increase_speed",
    name = ccb.content.text("Inner Spark"),
    description = ccb.content.text("Your speed is magically increased."),
    apply_message = ccb.content.text("You are filled with burning vigor."),
    remove_message = ccb.content.text("Your movements gradually slow."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_salamander_increase_speed_0"))

content.add(content.EffectType {
    id = "effect_salamander_emit_heat",
    name = ccb.content.text("Burning Furnace"),
    description = ccb.content.text("You are throwing off a large amount of heat."),
    apply_message = ccb.content.text("The air around you heats up."),
    remove_message = ccb.content.text("The air around you cools down."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_salamander_emit_heat_0"))

content.add(content.EffectType {
    id = "effect_salamander_prevented_death",
    name = ccb.content.text("Arisen"),
    description = ccb.content.text("Like the phoenix, you have been reborn."),
})

content.add(content.EffectType {
    id = "effect_salamander_phoenix_healing",
    name = ccb.content.text("Phoenix's Rejuvenation"),
    description = ccb.content.text("Like the phoenix, the flames are renewing your flesh."),
    remove_message = ccb.content.text("The aftereffects of the phoenix fire finally fade."),
}
    :enchantment("INLINE_ENCH_effect_salamander_phoenix_healing_0"))

content.add(content.EffectType {
    id = "effect_lucid_dream",
    name = ccb.content.text("Lucid Dreaming"),
    description = ccb.content.text("While you may just be dreaming, you are still capable of affecting the world."),
    rating = "good",
    duration_add_percent = 0,
})

-- Deliberately vulnerable to electricity damage.
content.add(content.EffectType {
    id = "effect_salamander_smoke_form",
    name = ccb.content.text("Smoke Form"),
    description = ccb.content.text("You have transformed yourself into a cloud of smoke."),
    apply_message = ccb.content.text("Your body falls apart into billowing smoke!"),
    remove_message = ccb.content.text("You reconstruct yourself from the smoke."),
    rating = "good",
}
    :flag("INVISIBLE")
    :flag("CLIMB_NO_LADDER")
    :flag("LEVITATION")
    :flag("DEAF")
    :flag("FEATHER_FALL")
    :flag("NO_SCENT")
    :flag("NO_SPELLCASTING")
    :flag("STAB_IMMUNE")
    :flag("CUT_IMMUNE")
    :flag("BULLET_IMMUNE")
    :flag("BASH_IMMUNE")
    :flag("ACID_IMMUNE")
    :flag("BIO_IMMUNE")
    :flag("INHALED_TOXIN_IMMUNE")
    :flag("SUFFOCATION_IMMUNE")
    :removes_effect("smoke_eyes")
    :removes_effect("smoke_lungs")
    :removes_effect("teargas")
    :enchantment("INLINE_ENCH_effect_salamander_smoke_form_0")
    :enchantment("INLINE_ENCH_effect_salamander_smoke_form_1"))

content.add(content.EffectType {
    id = "effect_sylph_levitation",
    name = ccb.content.text("Wind-Walking"),
    description = ccb.content.text("You are walking on the winds."),
    apply_message = "",
    remove_message = ccb.content.text("Your feet touch the ground once again."),
    rating = "good",
}
    :flag("LEVITATION"))

content.add(content.EffectType {
    id = "effect_sylph_bonus_melee_range",
    name = ccb.content.text("Breeze-Cutting Blows"),
    description = ccb.content.text("Your strikes cut the air and carry on to your foes."),
    apply_message = "",
    remove_message = ccb.content.text("Your blows no longer split the air itself."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_sylph_bonus_melee_range_0"))

-- Hidden, paired with the previous effect sometimes but not always.
content.add(content.EffectType {
    id = "effect_sylph_climb_flying",
    name = "",
    description = "",
}
    :flag("CLIMB_FLYING"))

content.add(content.EffectType {
    id = "effect_sylph_hindering_wind",
    name = ccb.content.text("Hindering Winds"),
    description = ccb.content.text("The winds are swirling around you and slowing you down!"),
    apply_message = ccb.content.text("A wind swirls up around you, slowing you."),
    remove_message = ccb.content.text("The wind around you dies down."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_sylph_hindering_wind_0")
    :modifier("dodge", "amount", { base = -2 }))

content.add(content.EffectType {
    id = "effect_sylph_increase_ally_speed",
    name = ccb.content.text("Favonian Murmuration"),
    description = ccb.content.text("You steps are buoyed up by the winds."),
    apply_message = "",
    remove_message = ccb.content.text("The winds around you die down."),
    rating = "good",
}
    :flag("STEADY")
    :enchantment("INLINE_ENCH_effect_sylph_increase_ally_speed_0"))

content.add(content.EffectType {
    id = "effect_sylph_cloud_body",
    name = ccb.content.text("Body of Clouds"),
    description = ccb.content.text("You are mist and cloud and wind."),
    apply_message = "",
    remove_message = ccb.content.text("Your body regains its solidity."),
    rating = "good",
}
    :flag("ETHEREAL")
    :flag("INVISIBLE")
    :flag("LEVITATION")
    :flag("CLIMB_FLYING")
    :flag("DISTRIBUTED_DAMAGE")
    :flag("INHALED_TOXIN_IMMUNE")
    :flag("MYCUS_IMMUNE")
    :enchantment("INLINE_ENCH_effect_sylph_cloud_body_0"))

-- Empty since the mutation explains what the effect is and does
content.add(content.EffectType {
    id = "effect_sylph_cannot_be_slowed",
    name = "",
    description = "",
    rating = "good",
}
    :removes_effect("grabbed")
    :removes_effect("slippery_terrain")
    :removes_effect("sap")
    :removes_effect("slimed")
    :removes_effect("webbed"))

content.add(content.EffectType {
    id = "effect_undine_escape_grabs",
    name = ccb.content.text("Flow Like Water"),
    description = ccb.content.text("Your movements are inhumanly fluid."),
    rating = "good",
    maximum_duration_turns = 60,
    duration_add_percent = 1,
}
    :flag("DOWNED_RECOVERY")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("ONE_STORY_FALL")
    :removes_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_undine_escape_grabs_0")
    :limb_score("reaction", { multiplier = 2.0 })
    :limb_score("block", { multiplier = 1.2 })
    :limb_score("crawl", { multiplier = 1.5 }))

content.add(content.EffectType {
    id = "effect_undine_acid_resist_ally",
    name = ccb.content.text("Caustic Cloak"),
    description = ccb.content.text("You are surrounded by a thin shell of acidic mist."),
    apply_message = "",
    remove_message = ccb.content.text("The acidic mist around you dissipates."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_undine_acid_resist_ally_0"))

content.add(content.EffectType {
    id = "effect_undine_spell_slow",
    name = ccb.content.text("Slowed by the Current"),
    description = ccb.content.text("Currents of aetherial water are hindering your movements."),
    apply_message = ccb.content.text("You feel like you're wading through a rushing river!"),
    remove_message = ccb.content.text("The drag on your movements is gone."),
    rating = "bad",
    show_in_info = true,
}
    :modifier("speed", "amount", { base = -25 }))

content.add(content.EffectType {
    id = "effect_paraclesian_dodge_bonus_1",
    name = ccb.content.text("Enhanced Dodging"),
    description = ccb.content.text("Like the whistling wind or the supple willow, you can easily move when danger beckons.  The spell has greatly reduced effect if not outside (if Sylph) or not on natural terrain (if Arvore)."),
    apply_message = "",
    remove_message = ccb.content.text("Your enhanced dodging ability fades away."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_paraclesian_dodge_bonus_1_0")
    :enchantment("INLINE_ENCH_effect_paraclesian_dodge_bonus_1_1"))

content.add(content.EffectType {
    id = "effect_paraclesian_dodge_bonus_2",
    name = ccb.content.text("Enhanced Dodging"),
    description = ccb.content.text("Like the whistling wind or the supple willow, you can easily move when danger beckons.  The spell has greatly reduced effect if not outside (if Sylph) or not on natural terrain (if Arvore)."),
    apply_message = "",
    remove_message = ccb.content.text("Your enhanced dodging ability fades away."),
    rating = "good",
}
    :flag("UNCANNY_DODGE")
    :enchantment("INLINE_ENCH_effect_paraclesian_dodge_bonus_2_0")
    :enchantment("INLINE_ENCH_effect_paraclesian_dodge_bonus_2_1"))

content.add(content.EffectType {
    id = "effect_paraclesian_dodge_bonus_3",
    name = ccb.content.text("Enhanced Dodging"),
    description = ccb.content.text("Like the whistling wind or the supple willow, you can easily move when danger beckons.  The spell has greatly reduced effect if not outside (if Sylph) or not on natural terrain (if Arvore)."),
    apply_message = "",
    remove_message = ccb.content.text("Your enhanced dodging ability fades away."),
    rating = "good",
}
    :flag("UNCANNY_DODGE")
    :flag("HARDTOHIT")
    :enchantment("INLINE_ENCH_effect_paraclesian_dodge_bonus_3_0")
    :enchantment("INLINE_ENCH_effect_paraclesian_dodge_bonus_3_1"))

-- Empty name and description to hide effect.  This is just a tracker to make learning gossamer recipes take time.
content.add(content.EffectType {
    id = "effect_paraclesian_learned_gossamer",
    name = "",
    description = "",
    rating = "mixed",
})

-- Empty name and description to hide effect
content.add(content.EffectType {
    id = "effect_paraclesian_cannot_use_computers_flag",
    name = "",
    description = "",
}
    :flag("CANNOT_USE_COMPUTERS"))

content.add(content.EffectType {
    id = "effect_paraclesian_see_fae",
    name = ccb.content.text("Wyrd Sight"),
    description = ccb.content.text("You can sense nearby creatures that come from under the hill."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_paraclesian_see_fae_0"))

content.add(content.EffectType {
    id = "effect_sense_vampire",
    name = ccb.content.text("Sense the Night Hunters"),
    description = ccb.content.text("You can sense nearby vampires."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_sense_vampire_0"))

-- Hidden effect, used to check that you're still researching.
content.add(content.EffectType {
    id = "effect_xe_deciphering_hedge_tome",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_hedge_nether_eye_paste",
    name = ccb.content.text("Blood-and-Ash Paste"),
    description = ccb.content.text("You rubbed the paste of blood and herbs and ashes on your eyes.  It stings.  A lot."),
    rating = "mixed",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_hedge_nether_eye_paste_0")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 60 })
    :modifier("pain", "tick", { base = 180 })
    :limb_score("vision", { multiplier = 0.6 }))

-- Empty to hide effect
content.add(content.EffectType {
    id = "effect_hedge_cure_cold_or_flu",
    name = "",
    description = "",
}
    :removes_effect("common_cold")
    :removes_effect("pre_common_cold")
    :removes_effect("flu")
    :removes_effect("pre_flu"))

content.add(content.EffectType {
    id = "effect_hedge_ward_off_rain",
    name = ccb.content.text("To Keep Off the Rain and the Damp"),
    description = ccb.content.text("Thanks to the words of the charm you spoke, you won't get wet in the rain."),
}
    :flag("RAIN_IMMUNE"))

-- Empty to hide effect
content.add(content.EffectType {
    id = "effect_hedge_magic_no_evil_eye",
    name = "",
    description = "",
}
    :removes_effect("effect_evil_eye"))

-- Empty to hide effect, used a tracker if you're wearing a kamea of protection
content.add(content.EffectType {
    id = "effect_hedge_magic_kamea_of_protection",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_hedge_magic_luck_spell",
    name = ccb.content.text("Step of Gad"),
    description = ccb.content.text("Your foot seems to keep finding just the right place to step."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_hedge_magic_luck_spell_0"))

-- This prevents you from attacking, if you are an animal.  An EoC removes it if the animal is attacked
content.add(content.EffectType {
    id = "effect_hedge_prevent_wild_animal_attacks",
    name = "",
    description = "",
    rating = "bad",
}
    :flag("CANNOT_ATTACK"))

-- Empty to hide effect
content.add(content.EffectType {
    id = "effect_hedge_no_nightmares",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_hedge_increase_healing_rate",
    name = ccb.content.text("Convalescence"),
    description = ccb.content.text("Your wounds are healing more quickly, as long as you don't do too much to upset the charm."),
}
    :enchantment("INLINE_ENCH_effect_hedge_increase_healing_rate_0"))

content.add(content.EffectType {
    id = "effect_hedge_increase_bandaging_rate",
    name = ccb.content.text("Halt the Scarlet Flow"),
    description = ccb.content.text("Blood easily stops flowing under your touch."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_hedge_increase_bandaging_rate_0"))

content.add(content.EffectType {
    id = "effect_hedge_extinguish_fire_spell_self_resistance",
    name = ccb.content.text("Mantle of the Malakhim"),
    description = ccb.content.text("You are protected from heat and smoke."),
    remove_message = ccb.content.text("Your charm of protection fades away."),
}
    :flag("HEATPROOF")
    :removes_effect("blisters")
    :removes_effect("smoke_eyes")
    :removes_effect("smoke_lungs")
    :enchantment("INLINE_ENCH_effect_hedge_extinguish_fire_spell_self_resistance_0"))

content.add(content.EffectType {
    id = "effect_hedge_walk_on_water",
    name = ccb.content.text("Walk Across the Flowing Waters"),
    description = ccb.content.text("The waters are bearing you up."),
    rating = "good",
}
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

content.add(content.EffectType {
    id = "effect_hedge_astral_projection",
    name = ccb.content.text("Etheric Form"),
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
    :flag("NO_SPELLCASTING")
    :enchantment("INLINE_ENCH_effect_hedge_astral_projection_0"))

content.add(content.EffectType {
    id = "effect_skinchanged_penalties",
    name = ccb.content.text("Skinchanged Mind"),
    description = ccb.content.text("You're starting to get used to being an animal.  Even enjoy it."),
    maximum_intensity = 20,
}
    :enchantment("INLINE_ENCH_effect_skinchanged_penalties_0"))

content.add(content.EffectType {
    id = "effect_skinchanged_animalistic_mind",
    name = ccb.content.text("Animalistic Mind"),
    description = ccb.content.text("Hunt.  Kill.  Feed.  Sleep."),
}
    :flag("CANNIBAL")
    :flag("PRED4")
    :flag("PSYCHOPATH")
    :flag("STRICT_HUMANITARIAN"))

-- The above description replicates a magic square and should not be translated
content.add(content.EffectType {
    id = "effect_hedge_walk_on_water_magic_square",
    name = ccb.content.text("Water-Walking"),
    description = ccb.content.text("NAHARIAMA\nA  Q\nH      E\nA Q\nR\nI\nA      Q\nM     QA\nA"),
    remove_message = ccb.content.text("Your water-walking charm has faded."),
    maximum_duration_turns = 1800,
    maximum_intensity = 30,
    intensity_duration_turns = 60,
}
    :decay_message(ccb.content.text("Your water-walking charm is about to fade."), "bad")
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

-- The above description replicates a magic square and should not be translated
content.add(content.EffectType {
    id = "effect_hedge_breathe_water_magic_square",
    name = ccb.content.text("Water-Breathing"),
    description = ccb.content.text("BURNAHEU\nULORIPTE\nROMILAPH\nNRITILIA\nAILITIRN\nHPALIMOR\nETPIROLU\nUEHANRUB"),
    remove_message = ccb.content.text("Your water-breathing charm has faded."),
    maximum_duration_turns = 7200,
    maximum_intensity = 120,
    intensity_duration_turns = 60,
}
    :decay_message(ccb.content.text("Your water-breathing charm is about to fade."), "bad")
    :flag("ITEM_WATERPROOFING")
    :flag("GILLS")
    :flag("EYE_MEMBRANE"))

-- The above description replicates a magic square and should not be translated
content.add(content.EffectType {
    id = "effect_invisibility_magic_square",
    name = ccb.content.text("Invisibility"),
    description = ccb.content.text("TALAC\nA   A\nL   L\nA   A\nCALAT"),
    remove_message = ccb.content.text("Your invisibility charm has faded."),
    maximum_duration_turns = 4620,
    maximum_intensity = 77,
    intensity_duration_turns = 60,
}
    :decay_message(ccb.content.text("Your invisibility charm is about to fade."), "bad")
    :flag("INVISIBLE"))

content.add(content.EffectType {
    id = "mutagen_plantkin",
    name = ccb.content.text("Arvore Mutation"),
    description = ccb.content.text("You consumed Arvore destiny draught."),
    blood_analysis_description = ccb.content.text("Anomalous chlorophyll content in blood sample"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Arvore Transformation"))
    :name(ccb.content.text("Arvore Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of Arvore destiny draught."))
    :description(ccb.content.text("You consumed a life-changing amount of Arvore destiny draught."))
    :resist_trait("THRESH_ARVORE")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_alchemical_plantkin",
    name = ccb.content.text("Arvore Stolen Power Mutation"),
    description = ccb.content.text("You consumed Arvore alchemical draught."),
    blood_analysis_description = ccb.content.text("Anomalous chlorophyll content in blood sample"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Arvore Stolen Power Transformation"))
    :name(ccb.content.text("Arvore Stolen Power Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of Arvore alchemical draught."))
    :description(ccb.content.text("You consumed a life-changing amount of Arvore alchemical draught."))
    :resist_trait("THRESH_ARVORE")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_waterkin",
    name = ccb.content.text("Undine Mutation"),
    description = ccb.content.text("You consumed Undine destiny draught."),
    blood_analysis_description = ccb.content.text("Excessive water content in blood sample"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Undine Transformation"))
    :name(ccb.content.text("Undine Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of Undine destiny draught."))
    :description(ccb.content.text("You consumed a life-changing amount of Undine destiny draught."))
    :resist_trait("THRESH_UNDINE")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_flamekin",
    name = ccb.content.text("Salamander Mutation"),
    description = ccb.content.text("You consumed Salamander destiny draught."),
    blood_analysis_description = ccb.content.text("Blood sample displays unnatural heat generation"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Salamander Transformation"))
    :name(ccb.content.text("Salamander Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of Salamander destiny draught."))
    :description(ccb.content.text("You consumed a life-changing amount of Salamander destiny draught."))
    :resist_trait("THRESH_SALAMANDER")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_dollkin",
    name = ccb.content.text("Homullus Mutation"),
    description = ccb.content.text("You consumed Homullus destiny draught."),
    blood_analysis_description = ccb.content.text("Inert elements providing some functions of blood"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Homullus Transformation"))
    :name(ccb.content.text("Homullus Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of Homullus destiny draught."))
    :description(ccb.content.text("You consumed a life-changing amount of Homullus destiny draught."))
    :resist_trait("THRESH_HOMULLUS")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_airkin",
    name = ccb.content.text("Sylph Mutation"),
    description = ccb.content.text("You consumed Sylph destiny draught."),
    blood_analysis_description = ccb.content.text("Dangerous levels of oxygen and nitrogen in blood sample"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Sylph Transformation"))
    :name(ccb.content.text("Sylph Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of Sylph destiny draught."))
    :description(ccb.content.text("You consumed a life-changing amount of Sylph destiny draught."))
    :resist_trait("THRESH_SYLPH")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_fair_folk_noble",
    name = "Fair Folk Mutation",
    description = "You are gaining Fair Folk powers.  This should only be visible for a moment.",
    maximum_intensity = 3,
})

content.add(content.EffectType {
    id = "mutagen_fair_folk_commoner_brownie",
    name = "Fair Folk Mutation",
    description = "You are gaining Fair Folk powers.  This should only be visible for a moment.",
    maximum_intensity = 3,
})

content.add(content.EffectType {
    id = "mutagen_fair_folk_commoner_pooka",
    name = "Fair Folk Mutation",
    description = "You are gaining Fair Folk powers.  This should only be visible for a moment.",
    maximum_intensity = 3,
})

content.add(content.EffectType {
    id = "mutagen_fair_folk_commoner_selkie",
    name = "Fair Folk Mutation",
    description = "You are gaining Fair Folk powers.  This should only be visible for a moment.",
    maximum_intensity = 3,
})

content.add(content.EffectType {
    id = "mutagen_fair_folk_commoner_trow",
    name = "Fair Folk Mutation",
    description = "You are gaining Fair Folk powers.  This should only be visible for a moment.",
    maximum_intensity = 3,
})

content.add(content.EffectType {
    id = "mutagen_lilin",
    name = "Lilin Mutation",
    description = "You are gaining Lilin powers.  This should only be visible for a moment.",
    maximum_intensity = 3,
})

-- Hidden effect, used to distinguish magical quick weather change from the weather returning to normal
content.add(content.EffectType {
    id = "effect_extracting_dreamsparks",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_changeling_invisibility",
    name = ccb.content.text("Hidden from Mortal Eyes"),
    description = ccb.content.text("They could have sworn you were there a moment ago."),
    rating = "good",
}
    :flag("INVISIBLE")
    :flag("NO_SCENT"))

content.add(content.EffectType {
    id = "effect_changeling_noble_burning_weapon",
    name = ccb.content.text("Fires of Bealtaine"),
    description = ccb.content.text("Your weapon is burning with white-gold fire."),
    remove_message = ccb.content.text("The flames on your weapon go out."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_changeling_noble_burning_weapon_0"))

content.add(content.EffectType {
    id = "effect_changeling_noble_movement_buffs",
    name = ccb.content.text("Deeds of Lughnasadh"),
    description = ccb.content.text("You would have definitely won the contests."),
    remove_message = ccb.content.text("Your athletic prowess fades."),
    rating = "good",
}
    :flag("CLIMB_NO_LADDER")
    :flag("FEATHER_FALL")
    :enchantment("INLINE_ENCH_effect_changeling_noble_movement_buffs_0"))

content.add(content.EffectType {
    id = "effect_changeling_temporary_psychopath",
    name = ccb.content.text("Arbiter Mundi"),
    description = ccb.content.text("Yours is the right to rule."),
    rating = "mixed",
}
    :flag("PSYCHOPATH"))

content.add(content.EffectType {
    id = "effect_changeling_noble_movement_buffs_ally",
    name = ccb.content.text("Deeds of Lughnasadh"),
    description = ccb.content.text("You would have definitely won the contests."),
    remove_message = ccb.content.text("Your athletic prowess fades."),
    rating = "good",
}
    :flag("CLIMB_NO_LADDER")
    :flag("FEATHER_FALL")
    :enchantment("INLINE_ENCH_effect_changeling_noble_movement_buffs_ally_0"))

content.add(content.EffectType {
    id = "effect_changeling_noble_broken_right_of_passage",
    name = ccb.content.text("Broken Right of Passage"),
    description = ccb.content.text("You are no longer protected by the contracts of eld."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_brownie_attacked_someone",
    name = ccb.content.text("Conspicuous"),
    description = ccb.content.text("People can definitely see you now."),
    rating = "bad",
})

-- Hidden effect, used for pooka advancement
content.add(content.EffectType {
    id = "effect_pooka_outdoors_tracker",
    name = "",
    description = "",
    rating = "good",
    maximum_intensity = 24,
    intensity_decay_step = 1,
    intensity_decay_tick = 3600,
})

-- Hidden effect, used as a counter
content.add(content.EffectType {
    id = "effect_changeling_advancement_selkie_stand_in_rain_counter",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_selkie_fog_cloak",
    name = ccb.content.text("Cloak of Fog"),
    description = ccb.content.text("The fog shields you from sight."),
    apply_message = "",
    remove_message = ccb.content.text("The fog begins to dissipate."),
    rating = "good",
    maximum_duration_turns = 1800,
}
    :enchantment("enchant_selkie_fog_cloak"))

-- Hidden effect, used to distinguish magical quick weather change from the weather returning to normal
content.add(content.EffectType {
    id = "effect_controlling_weather",
    name = "",
    description = "",
})

-- Hidden effect, used to track magical summoned fog
content.add(content.EffectType {
    id = "effect_controlling_weather_fog",
    name = "",
    description = "",
})

-- Hidden effect, used to track magical summoned rain
content.add(content.EffectType {
    id = "effect_controlling_weather_rains",
    name = "",
    description = "",
})

-- Hidden effect, used to track magical summoned rainstorms
content.add(content.EffectType {
    id = "effect_controlling_weather_rainstorm",
    name = "",
    description = "",
})

-- Hidden effect, used to track magical summoned lightning storms
content.add(content.EffectType {
    id = "effect_controlling_weather_lightningstorm",
    name = "",
    description = "",
})

-- Hidden effect, used to give you no metabolism or sleep gain while mining
content.add(content.EffectType {
    id = "effect_trow_no_eating_or_sleep",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_trow_no_eating_or_sleep_0"))

content.add(content.EffectType {
    id = "called_daffodil",
    name = ccb.content.text("Called the daffodil"),
    description = ccb.content.text("You recently called some daffodils.  You need to wait a day before you can call more."),
})

content.add(content.EffectType {
    id = "effect_dream_drainer_speed",
    name = ccb.content.text("Accelerated"),
    description = ccb.content.text("A burst of speed."),
    apply_message = ccb.content.text("You feel your legs are much longer now."),
    remove_message = ccb.content.text("Your body shrinks back into its normal space."),
    maximum_duration_turns = 25,
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_dream_drainer_speed_0"))

content.add(content.EffectType {
    id = "effect_dream_drainer_armor",
    name = ccb.content.text("Armored"),
    description = "The bug is shielded.  This is a bug if you have it.",
    maximum_duration_turns = 25,
    rating = "bad",
    show_intensity = false,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_dream_drainer_armor_0"))

content.add(content.EffectType {
    id = "effect_moon_withdrawal",
    name = ccb.content.text("Moon-starved"),
    description = "Weakens the Luna-attuned revenant if they are out of the moonlight.  This is a bug if you have it.",
    maximum_duration_turns = 11,
    rating = "bad",
    show_intensity = false,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_moon_withdrawal_0"))

-- Empty to hide effect--it's linked to a mutation already
content.add(content.EffectType {
    id = "effect_vampire_no_gorge_issues",
    name = "",
    description = "",
}
    :removes_effect("blood_quenched"))

-- Hidden effect.  Makes Blind the Sun protect against the sun.
content.add(content.EffectType {
    id = "vampire_blind_the_sun",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "last_breath_mist_cooldown",
    name = ccb.content.text("Recovering from the last breath's mist"),
    description = ccb.content.text("Triggering your abilities that way has taken their toll on you.  You cannot save yourself from death that way another time yet."),
})

content.add(content.EffectType {
    id = "effect_lilin_resist_infections",
    name = ccb.content.text("Make Thy Plagues Wonderful"),
    description = ccb.content.text("You are immune to minor diseases and any infections you have are recovering more easily."),
}
    :flag("PAUSE_INFECTIONS")
    :flag("INFECTION_RECOVERY")
    :removes_effect("common_cold")
    :removes_effect("pre_common_cold")
    :removes_effect("flu")
    :removes_effect("pre_flu"))

-- Hidden effect, used as a blocker
content.add(content.EffectType {
    id = "effect_lilin_attack_warning_cooldown",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_lilin_health_effects_of_draining",
    name = "",
    description = "",
    rating = "bad",
}
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 2 }))

-- Hidden effect, prevents you from being vampirized
content.add(content.EffectType {
    id = "effect_lilin_vampire_immune",
    name = "",
    description = "",
}
    :removes_effect("vampire_virus"))

-- Hidden effect, prevents you from gaining more lilin powers too quickly
content.add(content.EffectType {
    id = "effect_gained_lilin_power",
    name = "",
    description = "",
})

-- Hidden effect, tracking whether you have EOC_LILIN_TEMPORARY_GLORIOUS active.
content.add(content.EffectType {
    id = "effect_lilin_temporary_glorious",
    name = "",
    description = "",
})

-- Hidden effect, allows you to get away after turning into an owl.
content.add(content.EffectType {
    id = "lilit_prevent_death_escape",
    name = "",
    description = "",
}
    :removes_effect("grabbed")
    :removes_effect("downed")
    :enchantment("INLINE_ENCH_lilit_prevent_death_escape_0"))

-- Hidden effect, used to prevent Their Worm Shall Not Die from activating multiple times back to back
content.add(content.EffectType {
    id = "lilit_prevent_death_cooldown",
    name = "",
    description = "",
})

-- Hidden effects, tracking whether you have LILIN_BONUS_HEALING_ACTIVE active.
content.add(content.EffectType {
    id = "effect_lilin_bonus_healing_active",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_lilin_ruach_drain_side_effects",
    name = ccb.content.text("Ruach-drained"),
    description = ccb.content.text("A lilit has drained away some of your life-force."),
    maximum_intensity = 14,
    intensity_decay_step = -1,
    intensity_decay_tick = 259200,
    show_in_info = true,
})

-- Increases in intensity once per day
content.add(content.EffectType {
    id = "effect_lilin_no_ruach",
    -- TRANSLATORS: Biblical Hebrew for 'famine' or 'starvation'
    name = ccb.content.text("Ra'ab"),
    description = ccb.content.text("You are out of ruach and gradually weakening."),
    rating = "bad",
    maximum_intensity = 28,
    intensity_decay_step = 1,
    intensity_decay_tick = 86400,
    show_intensity = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("PSYCHOPATH")
    :enchantment("INLINE_ENCH_effect_lilin_no_ruach_0")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "maximum_value", { base = 10, per_intensity = 5 })
    :modifier("pain", "chance_numerator", { base = 45, per_intensity = -1 })
    :modifier("pain", "tick", { base = 300, per_intensity = -6 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "maximum", { base = 2 })
    :modifier("health", "chance_numerator", { base = 45, per_intensity = -1 })
    :modifier("health", "tick", { base = 600, per_intensity = -12 })
    :limb_score("balance", { multiplier = 0.96, per_intensity = -0.035 })
    :limb_score("breathing", { multiplier = 1.0, per_intensity = -0.035 })
    :limb_score("lift", { multiplier = 0.96, per_intensity = -0.035 })
    :limb_score("grip", { multiplier = 0.96, per_intensity = -0.035 })
    :limb_score("reaction", { multiplier = 0.95, per_intensity = -0.035 })
    :limb_score("block", { multiplier = 1.0, per_intensity = -0.035 })
    :limb_score("vision", { multiplier = 1.0, per_intensity = -0.035 }))

content.add(content.EffectType {
    id = "effect_lilin_attribute_bonuses",
    name = ccb.content.text("Might of the Nephilim"),
    description = ccb.content.text("You are enhancing your physical abilities."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_lilin_attribute_bonuses_0")
    :enchantment("INLINE_ENCH_effect_lilin_attribute_bonuses_1")
    :enchantment("INLINE_ENCH_effect_lilin_attribute_bonuses_2"))

content.add(content.EffectType {
    id = "effect_lilin_speed_boost",
    name = ccb.content.text("Reaping the Whirlwind"),
    description = ccb.content.text("You are moving incredibly quickly."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_lilin_speed_boost_0")
    :enchantment("INLINE_ENCH_effect_lilin_speed_boost_1"))

content.add(content.EffectType {
    id = "effect_lilin_silent_at_night",
    name = ccb.content.text("Silent in Darkness"),
    description = ccb.content.text("Your movements make as little noise as the shadows of the night."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_lilin_silent_at_night_0"))

content.add(content.EffectType {
    id = "effect_lilin_steady_speed",
    name = ccb.content.text("Enduring Through All Generations"),
    description = ccb.content.text("You will endure all obstacles without faltering."),
    rating = "good",
}
    :flag("STEADY"))

content.add(content.EffectType {
    id = "effect_lilin_limb_score_bonuses_at_night",
    name = ccb.content.text("The Night Hunter"),
    description = ccb.content.text("Now they will know why they fear the night."),
    rating = "good",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("balance", { multiplier = 1.1 })
    :limb_score("breathing", { multiplier = 1.3 })
    :limb_score("lift", { multiplier = 1.1 })
    :limb_score("grip", { multiplier = 1.15 })
    :limb_score("reaction", { multiplier = 1.2 })
    :limb_score("block", { multiplier = 1.1 })
    :limb_score("vision", { multiplier = 1.35 }))

content.add(content.EffectType {
    id = "effect_lilin_incremental_speed_boost",
    name = ccb.content.text("The Treasures of Darkness"),
    description = ccb.content.text("Having spent a long time in the shadows, you are now quicker than usual."),
    rating = "good",
    show_intensity = false,
    maximum_intensity = 10,
}
    :modifier("speed", "amount", { base = 3, per_intensity = 3 }))

content.add(content.EffectType {
    id = "effect_lilin_lose_incremental_speed_boost",
    name = "",
    description = "",
}
    :removes_effect("effect_lilin_incremental_speed_boost"))

content.add(content.EffectType {
    id = "effect_lilin_allowed_ruach_drain",
    name = ccb.content.text("Willingly drained"),
    description = ccb.content.text("This follower allowed you to take some of their ruach, and they won't respond kindly to being drained more this soon."),
})

content.add(content.EffectType {
    id = "effect_sleep_shield_check",
    name = ccb.content.text("Promises of undisrupted sleep"),
    description = ccb.content.text("I wish you a good night."),
    apply_message = ccb.content.text("You could swear that this man wished you a good night."),
    remove_message = "",
    rating = "good",
    maximum_duration_turns = 3,
    show_intensity = false,
    maximum_intensity = 1,
})

content.add(content.EffectType {
    id = "effect_sleep_shield",
    name = ccb.content.text("Undisrupted sleep"),
    description = ccb.content.text("Sleep well.  Nothing but you can disrupt your sleep."),
    apply_message = ccb.content.text("As you fall asleep, you feel safer than you ever were."),
    remove_message = ccb.content.text("As you wake up, the feeling of safety quickly fades away."),
    rating = "good",
    maximum_duration_turns = 259200,
    show_intensity = false,
    maximum_intensity = 1,
}
    :flag("INVISIBLE")
    :flag("NO_SCENT")
    :flag("PAIN_IMMUNE")
    :flag("BLIND")
    :flag("DEAF")
    :flag("LEVITATION")
    :removes_effect("grabbed")
    :removes_effect("bleed")
    :enchantment("INLINE_ENCH_effect_sleep_shield_0"))

content.add(content.EffectType {
    id = "effect_lilin_mesmerize_tracker",
    name = ccb.content.text("Mesmerized"),
    description = ccb.content.text("You are in a daze."),
    apply_message = "",
    remove_message = ccb.content.text("You snap out of your trance."),
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_lilin_aoe_daze",
    name = ccb.content.text("Disoriented"),
    description = ccb.content.text("A loud noise fueled by a curse has sent you reeling."),
    rating = "bad",
    maximum_duration_turns = 300,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_lilin_aoe_daze_0")
    :modifier("hit", "amount", { base = -1 })
    :modifier("dodge", "amount", { base = -2 }))

content.add(content.EffectType {
    id = "effect_lilin_supernatural_disease",
    name = ccb.content.text("Miasma"),
    description = ccb.content.text("You are infected by a supernatural disease."),
    rating = "bad",
    maximum_duration_turns = 18000,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_lilin_supernatural_disease_0")
    :modifier("hit", "amount", { base = -1 })
    :modifier("dodge", "amount", { base = -2 })
    :limb_score("balance", { multiplier = 0.8 })
    :limb_score("breathing", { multiplier = 0.75 })
    :limb_score("lift", { multiplier = 0.75 })
    :limb_score("grip", { multiplier = 0.6 })
    :limb_score("reaction", { multiplier = 0.85 })
    :limb_score("block", { multiplier = 0.8 })
    :limb_score("vision", { multiplier = 0.85 }))

content.add(content.EffectType {
    id = "effect_lilin_supernatural_disease_focused",
    name = ccb.content.text("Devouring Plague"),
    description = ccb.content.text("You are infected by a supernatural disease."),
    rating = "bad",
    maximum_duration_turns = 300,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_lilin_supernatural_disease_focused_0")
    :modifier("hit", "amount", { base = -2 })
    :modifier("dodge", "amount", { base = -4 })
    :limb_score("balance", { multiplier = 0.6 })
    :limb_score("breathing", { multiplier = 0.5 })
    :limb_score("lift", { multiplier = 0.65 })
    :limb_score("grip", { multiplier = 0.6 })
    :limb_score("reaction", { multiplier = 0.65 })
    :limb_score("block", { multiplier = 0.5 })
    :limb_score("vision", { multiplier = 0.55 }))

-- Allows owl form lilin with the appropriate traits to fly through walls and avoid attacks
content.add(content.EffectType {
    id = "effect_lilin_owl_form_pass_through_walls",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_lilin_owl_form_pass_through_walls_0")
    :enchantment("INLINE_ENCH_effect_lilin_owl_form_pass_through_walls_1"))

content.add(content.EffectType {
    id = "effect_chronomancy_field",
    name = ccb.content.text("Chronomancy Field"),
    description = ccb.content.text("You have engaged some of your temporal abilities and any kills you make while this is active will grant you insight."),
    apply_message = ccb.content.text("You gain an increased awareness of the 4th dimension and how it interacts with the universe."),
    remove_message = ccb.content.text("Your awareness of the 4th dimension fades."),
    rating = "good",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_xedra_time_freeze",
    name = ccb.content.text("Frozen in Time"),
    description = ccb.content.text("You are completely frozen in time."),
    remove_message = ccb.content.text("Everything is suddenly different."),
    rating = "neutral",
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE")
    :flag("CANNOT_TAKE_DAMAGE")
    :flag("CANNOT_CHANGE_TEMPERATURE")
    :flag("FREEZE_EFFECTS")
    :flag("CANNOT_GAIN_EFFECTS")
    :immune_character_flag("DIMENSIONAL_ANCHOR")
    :immune_character_flag("STABILIZED_TIMELINE")
    :enchantment("INLINE_ENCH_effect_xedra_time_freeze_0"))

content.add(content.EffectType {
    id = "effect_xedra_eater_stabilize_reality",
    name = ccb.content.text("Stabilized Reality"),
    description = ccb.content.text("You are anchored in normal reality."),
    remove_message = ccb.content.text("You feel much more vulnerable."),
    rating = "good",
    show_in_info = true,
}
    :flag("DIMENSIONAL_ANCHOR")
    :flag("STABILIZED_TIMELINE"))

content.add(content.EffectType {
    id = "effect_xedra_dreamer_generate_accelerated_time",
    name = ccb.content.text("Accelerated Time Emission"),
    description = ccb.content.text("You continuously generate fields of short-lived accelerated time."),
    rating = "good",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_xedra_dreamer_generate_accelerated_time_0"))

content.add(content.EffectType {
    id = "effect_xedra_dreamer_accelerated_time",
    name = ccb.content.text("Time Accelerated"),
    description = ccb.content.text("Your local time is far accelerated to the baseline, allowing you to act much quicker."),
    remove_message = ccb.content.text("Everything seems much quicker."),
    rating = "good",
    maximum_intensity = 1,
    maximum_duration_turns = 2,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_xedra_dreamer_accelerated_time_0"))

content.add(content.EffectType {
    id = "effect_xedra_eater_erosion",
    name = ccb.content.text("Erosion"),
    description = ccb.content.text("You maintain a field of unstable time around you.  When you attack targets in melee they will degrade over time."),
    remove_message = ccb.content.text("Your field of unstable time fades."),
    rating = "good",
    maximum_intensity = 1,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_xedra_eater_erosion_0"))

content.add(content.EffectType {
    id = "effect_xedra_chronomancer_chronal_accel",
    name = ccb.content.text("Chronal Acceleration"),
    description = ccb.content.text("You are accelerating your relative progression of time compared to the universal baseline."),
    apply_message = ccb.content.text("The world slows down around you."),
    remove_message = ccb.content.text("The world speeds up again."),
    rating = "good",
    maximum_intensity = 1,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_xedra_chronomancer_chronal_accel_0"))

content.add(content.EffectType {
    id = "effect_xedra_chronomancer_destabilizing_strikes",
    name = ccb.content.text("Destabilizing Strikes"),
    description = ccb.content.text("You maintain a field of destabilized time around you.  Your attacks cause your targets to erode over time."),
    apply_message = ccb.content.text("Your hands turn gray as the air around them starts to flicker."),
    remove_message = ccb.content.text("Your field of destabilized time fades."),
    rating = "good",
    maximum_intensity = 1,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_xedra_chronomancer_destabilizing_strikes_0")
    :enchantment("INLINE_ENCH_effect_xedra_chronomancer_destabilizing_strikes_1"))

content.add(content.EffectType {
    id = "effect_xedra_chronomancer_stabilize_timeline",
    name = ccb.content.text("Stabilized Timeline"),
    description = ccb.content.text("You are protected from adverse changes in your personal timestream."),
    apply_message = ccb.content.text("You may not look any different, but you can tell that you're completely protected from harmful time magic."),
    remove_message = ccb.content.text("You feel more vulnerable to manipulated time."),
    rating = "good",
    maximum_intensity = 1,
    show_in_info = true,
}
    :flag("STABILIZED_TIMELINE")
    :enchantment("INLINE_ENCH_effect_xedra_chronomancer_stabilize_timeline_0"))

content.add(content.EffectType {
    id = "effect_xedra_chronomancer_reverse_entropy",
    name = ccb.content.text("Reversed Entropy"),
    description = ccb.content.text("Your equipment is slowly losing its damage, repairing itself to its original, ideal form."),
    apply_message = ccb.content.text("Your equipment obtains a gray tint and appears ever so slightly more whole."),
    remove_message = ccb.content.text("Your equipment loses its gray tint."),
    rating = "good",
    maximum_intensity = 1,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_xedra_chronomancer_reverse_entropy_0"))

content.add(content.EffectType {
    id = "effect_xedra_rewrite_wound_causality",
    name = ccb.content.text("Rewriting Wound Causality"),
    description = ccb.content.text("Your injuries are disappearing in a harmless paradox."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_xedra_rewrite_wound_causality_0"))

content.add(content.EffectType {
    id = "effect_xedra_rewrite_equipment_causality",
    name = ccb.content.text("Rewriting Equipment Causality"),
    description = ccb.content.text("The equipments' faults are disappearing in a harmless paradox."),
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_xedra_time_loop",
    name = ccb.content.text("Time Looped"),
    description = ccb.content.text("Every few seconds every change to your person reverts."),
    rating = "good",
    show_in_info = true,
}
    :flag("CANNOT_CHANGE_TEMPERATURE")
    :flag("FREEZE_EFFECTS")
    :flag("CANNOT_GAIN_EFFECTS")
    :enchantment("INLINE_ENCH_effect_xedra_time_loop_0"))

content.add(content.EffectType {
    id = "effect_xedra_chronomancer_stable_timeloop",
    name = ccb.content.text("Stable Time Loop"),
    description = ccb.content.text("You are prepared to revert yourself to a prior point in time."),
    rating = "good",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_xedra_monster_erosion",
    name = ccb.content.text("Eroding Time"),
    description = ccb.content.text("This creature destabilizes time around it, eroding everything it touches."),
    rating = "good",
    maximum_intensity = 1,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_xedra_monster_erosion_0"))

-- Required to make Boann banish monsters.  Without it, she will aim the banish at herself every time.
content.add(content.EffectType {
    id = "boann_retaliation_mark",
    name = "",
    description = "",
    show_in_info = false,
})

-- Hidden, reveals invisible monsters
content.add(content.EffectType {
    id = "effect_xe_reveal_invisibility",
    name = "",
    description = "",
    show_in_info = false,
}
    :flag("SUPPRESS_INVISIBILITY"))

-- Hidden effect, carries the flags so that vampires who blot out the sun with their powers don't burn in sunlight.
content.add(content.EffectType {
    id = "effect_vampire_albino",
    name = "",
    description = "",
}
    :flag("ALBINO"))

-- Hidden effect, carries the flags so that vampires who blot out the sun with their powers don't burn in sunlight.
content.add(content.EffectType {
    id = "effect_vampire_burn_under_sunlight",
    name = "",
    description = "",
}
    :flag("SUNBURN")
    :flag("ALBINO"))

-- Hidden effect, carries the flags so that vampires who blot out the sun with their powers don't burn in sunlight.
content.add(content.EffectType {
    id = "effect_vampire_burn_to_death_in_sunlight",
    name = "",
    description = "",
}
    :flag("SUNBURN")
    :flag("SUNBURN_SUPERNATURAL"))

-- Checks if you have every single vampiric power when trying to learn new ones.
content.add(content.EffectType {
    id = "effect_vampire_all_gift_check",
    name = "",
    description = "",
    show_in_info = false,
})

-- Hidden effect, used to make sure only active weakness reshuffling does something.
content.add(content.EffectType {
    id = "effect_vampire_reshuffling_weaknesses",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_vampire_recently_reshuffled_weaknesses",
    name = ccb.content.text("Reshuffled Weaknesses"),
    description = ccb.content.text("You recently reshuffled your vampiric weaknesses.  Until your blood stabilizes, further attempts will be fruitless."),
    remove_message = ccb.content.text("Your blood has stabilized enough to let you try to reshuffle your weaknesses again, should they prove too much to bear."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "vampire_need_living_blood",
    name = ccb.content.text("Thirst for Living Blood"),
    description = ccb.content.text("Cold blood is not enough.  You need some warm blood straight from the vein, you need it NOW!"),
    apply_message = ccb.content.text("You want to sink your fangs in someone's neck and drink their blood."),
    maximum_intensity = 5,
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("perception", "amount", { base = -1, per_intensity = -0.5 })
    :modifier("dexterity", "amount", { base = -1, per_intensity = -0.5 })
    :modifier("intelligence", "amount", { base = -1.5, per_intensity = -0.75 })
    :miss_message(ccb.content.text("Your thirst distract you."), 1)
    :limb_score("manip", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("block", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("vision", { multiplier = 1.0, per_intensity = -0.05 })
    :limb_score("reaction", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("move_speed", { multiplier = 1.0, per_intensity = -0.05 })
    :limb_score("balance", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("footing", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("swim", { multiplier = 1.0, per_intensity = -0.1 }))

-- No sleepiness incrementation, as the EOC took care of that.
content.add(content.EffectType {
    id = "effect_earth_sleeper_penalty",
    name = ccb.content.text("Disrupted Rest"),
    description = ccb.content.text("You have slept away from the earth, leaving you fatigued and weakened for an entire day."),
    rating = "bad",
}
    :modifier("strength", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("perception", "amount", { base = -2 })
    :modifier("intelligence", "amount", { base = -2 }))

content.add(content.EffectType {
    id = "effect_holy_place_burn",
    name = ccb.content.text("Rebuked by holiness"),
    description = ccb.content.text("The sanctity of this place is killing you."),
    rating = "bad",
    main_parts_only = true,
    show_in_info = false,
}
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "tick", { base = 10 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "tick", { base = 10 })
    :miss_message(ccb.content.text("You feel rejected by this place."), 2))

content.add(content.EffectType {
    id = "effect_xe_holy_burnt_carrying_holy",
    name = ccb.content.text("Unworthy of the holy"),
    description = ccb.content.text("You are wearing a holy symbol.  It will cause you severe pain until you take it off."),
    apply_message = ccb.content.text("You wince in pain as you put on the holy symbol."),
    remove_message = ccb.content.text("The pain subsides as you take off the holy symbol."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("pain", "amount", { base = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "maximum_value", { base = 100 }))

content.add(content.EffectType {
    id = "effect_vast_water_burn",
    name = ccb.content.text("Melted by the vast waters"),
    description = ccb.content.text("You are dissolving in the vast waters."),
    rating = "bad",
    main_parts_only = true,
    show_in_info = false,
}
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "tick", { base = 10 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "tick", { base = 10 })
    :miss_message(ccb.content.text("You are melting from your proximity to water."), 2))

content.add(content.EffectType {
    id = "effect_slain_by_the_sun",
    name = ccb.content.text("Slain by the Sun"),
    description = ccb.content.text("The sun is burning you like a dry leaf in a wildfire."),
    rating = "bad",
})

-- Hidden effect, prevents the sun fire anathema EoC from firing new copies on every step.
content.add(content.EffectType {
    id = "effect_slain_by_the_sun_limiter",
    name = "",
    description = "",
})

-- Hidden effect, gives a few hours before the player burns from the sun due to that weakness.
content.add(content.EffectType {
    id = "effect_sun_burn_grace_period",
    name = "",
    description = "",
    maximum_duration_turns = 86400,
})

-- Hidden effect, ensuring that blood cravings are canceled by drinking blood.
content.add(content.EffectType {
    id = "effect_drank_blood_recently",
    name = "",
    description = "",
    maximum_duration_turns = 86400,
}
    :removes_effect("blood_craving")
    :blocks_effect("blood_craving"))

-- The description is intended to illustrate the ongoing craving.
content.add(content.EffectType {
    id = "blood_craving",
    name = ccb.content.text("Blood Craving"),
    description = ccb.content.text("Need blood must have blood blood right now DRINK BLOOD NOW!"),
    apply_message = ccb.content.text("You are wracked with pain as your craving hits you.  You can only think about getting some of that delicious blood you so desperately need."),
    remove_message = ccb.content.text("Your craving calms down."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "maximum", { base = 100 })
    :modifier("pain", "tick", { base = 1000 })
    :modifier("strength", "amount", { base = -3 })
    :modifier("dexterity", "amount", { base = -3 })
    :modifier("perception", "amount", { base = -3 })
    :modifier("intelligence", "amount", { base = -6 })
    :miss_message(ccb.content.text("Your craving distract you."), 1)
    :limb_score("manip", { multiplier = 0.7, per_intensity = -0.1 })
    :limb_score("block", { multiplier = 0.7, per_intensity = -0.1 })
    :limb_score("vision", { multiplier = 0.7, per_intensity = -0.05 })
    :limb_score("reaction", { multiplier = 0.7, per_intensity = -0.1 })
    :limb_score("move_speed", { multiplier = 0.7, per_intensity = -0.05 })
    :limb_score("balance", { multiplier = 0.7, per_intensity = -0.1 })
    :limb_score("footing", { multiplier = 0.7, per_intensity = -0.1 })
    :limb_score("swim", { multiplier = 0.7, per_intensity = -0.1 }))

content.add(content.EffectType {
    id = "vampire_attacked_vampire_or_renfield",
    name = ccb.content.text("Broken Vampire's Truce"),
    description = ccb.content.text("Your actions against the vampires and their servants have drawn their ire."),
})

-- As per the vampire power, but includes the fire vulnerability as it is a multiplier, not an absolute.  It also includes the effects of flow like blood.
content.add(content.EffectType {
    id = "effect_anathema_resilience",
    name = "",
    description = "",
}
    :blocks_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_anathema_resilience_0")
    :enchantment("INLINE_ENCH_effect_anathema_resilience_1")
    :enchantment("INLINE_ENCH_effect_anathema_resilience_2")
    :modifier("dodge", "amount", { base = 15 }))

-- From 60 speed to a tier 5's base speed.
-- This isn't a vampire power, just them taking you a little more seriously as you managed to injure them.
content.add(content.EffectType {
    id = "effect_anathema_battle_started",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_anathema_battle_started_0"))

-- From a tier 5's base speed to a total of 653 speed, and ensures it can hit players benefitting from flow like blood.
content.add(content.EffectType {
    id = "effect_anathema_final_form",
    name = ccb.content.text("Hasted by shadows"),
    description = ccb.content.text("The Anathema is much quicker now thanks to vampiric abilities."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_anathema_final_form_0")
    :modifier("hit", "amount", { base = 50 })
    :modifier("dodge", "amount", { base = 20 }))

-- Counts as +1 tier 1 trait per intensity for the purposes of calculating powers.  Intended for the player to never manage to get to the max intensity, as this would take thousands of slain vampires.
content.add(content.EffectType {
    id = "effect_player_anathema_potency_boost",
    name = ccb.content.text("Apex Vampire's Potency"),
    description = ccb.content.text("All the vampire blood you drank has empowered you."),
    maximum_intensity = 1000,
})

-- This tracks if the player recently drank vampire blood.  This is used for the Apex's Thirst weakness.
content.add(content.EffectType {
    id = "effect_recent_vampire_drink",
    name = "",
    description = "",
    maximum_duration_turns = 432000,
})

-- This tracks how long the player went without vampire blood.  This is used for the Apex's Thirst weakness.
content.add(content.EffectType {
    id = "effect_anathema_need_vampire_blood",
    name = ccb.content.text("Apex's Thirst"),
    description = ccb.content.text("Your blood is consuming itself in its thirst for the blood of vampires."),
    apply_message = ccb.content.text("You feel a gnawing thirst for the blood of vampires.  Better find some, before your blood devours itself."),
    remove_message = ccb.content.text("Your thirst for vampire blood calms down."),
    maximum_intensity = 100,
    rating = "bad",
})

-- When the required check will exist, this power will depend on darkness to work, not on not being under the sun.
content.add(content.EffectType {
    id = "effect_vampire_invisible_in_dark",
    name = ccb.content.text("Shrouded by the Shadowed Path"),
    description = ccb.content.text("Until the shadows you gathered fade or the sun shines upon you, you cannot be seen."),
    apply_message = ccb.content.text("The shadows you gathered meld with you, hiding you from sight."),
    remove_message = ccb.content.text("The shadows aren't hiding you anymore."),
    rating = "good",
}
    :flag("INVISIBLE"))

-- This revoves the invisibility power when the vampire stands under the sun.
content.add(content.EffectType {
    id = "effect_vampire_lose_invisible_in_dark",
    name = "",
    description = "",
}
    :removes_effect("effect_vampire_invisible_in_dark"))

-- Removes all illnesses, parasites and poisons no matter if they are magical or mundane.  No effect on the vampire cure.
content.add(content.EffectType {
    id = "effect_vampire_no_illness",
    name = "",
    description = "",
}
    :removes_effect("venom_blind")
    :removes_effect("formication")
    :removes_effect("migo_atmosphere")
    :removes_effect("nausea")
    :removes_effect("fungus")
    :removes_effect("dermatik")
    :removes_effect("bloodworms")
    :removes_effect("paincysts")
    :removes_effect("brainworms")
    :removes_effect("tapeworm")
    :removes_effect("poison")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_optional_effect("stung")
    :removes_effect("badpoison")
    :removes_effect("foodpoison")
    :removes_effect("paralyzepoison")
    :removes_effect("tetanus")
    :removes_effect("rat_bite_fever")
    :removes_effect("infected")
    :removes_effect("common_cold")
    :removes_effect("flu")
    :removes_effect("pre_flu")
    :removes_effect("pre_common_cold")
    :removes_effect("blood_spiders")
    :removes_effect("visuals")
    :removes_effect("xe_hydrating_gout_incubation")
    :removes_effect("xe_hydrating_gout"))

content.add(content.EffectType {
    id = "effect_anathema_mind_chaos",
    name = ccb.content.text("Blood-Muddled Mind"),
    description = ccb.content.text("Your mind reels from all the vampire blood you drank."),
    rating = "bad",
    maximum_intensity = 5,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("intelligence", "amount", { base = -4, per_intensity = -2 })
    :limb_score("reaction", { multiplier = 0.8, per_intensity = -0.1 }))

-- Required for an incubation period
content.add(content.EffectType {
    id = "xe_hydrating_gout_incubation",
    name = ccb.content.text("Imminent Hydrating Gout"),
    description = ccb.content.text("You are about to suffer from the hydrating gout.  This disease causes the spontaneous generation of water inside the body, and becomes more virulent the more hydrated the afflicted is."),
    apply_message = ccb.content.text("You have a bad feeling about drinking more water."),
    blood_analysis_description = ccb.content.text("Unknown water-producing pathogen."),
    rating = "bad",
}
    :immune_character_flag("NO_THIRST"))

content.add(content.EffectType {
    id = "xe_hydrating_gout",
    apply_memorial_log = "Caught a supernatural illness.",
    remove_memorial_log = "Got over the hydrating gout.",
    name = ccb.content.text("Hydrating Gout"),
    description = ccb.content.text("You are suffering from the peculiar illness known as hydrating gout.  This disease causes the spontaneous generation of water inside the body, and becomes more virulent the more hydrated the afflicted is."),
    apply_message = ccb.content.text("You feel you're going to drown in your own body water."),
    remove_message = ccb.content.text("You no longer fear the absence of thirst."),
    blood_analysis_description = ccb.content.text("Unknown water-producing pathogen."),
    rating = "bad",
}
    :immune_character_flag("NO_THIRST"))

content.add(content.EffectType {
    id = "effect_bloodthorn_druid_upgrade_ready",
    name = ccb.content.text("Twitching Heartvines"),
    description = ccb.content.text("You can occasionally feel your heartvines twitch beneath your skin.  They are ready to grow.  Seek out the unspoiled wilderness and allow them to flourish."),
    apply_message = ccb.content.text("As the vampire dies you feel your heartvines stir, invigorated by the creature's blood.  You must seek out the wilderness and meditate there to allow your heartvine to grow."),
    remove_message = ccb.content.text("Your heartvines cease their movements."),
})

-- Hidden effect to make sure you're actually researching
content.add(content.EffectType {
    id = "effect_bloodthorn_druid_upgrade_active",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_bloodthorne_druid_gain_strength_dexterity_buff",
    name = ccb.content.text("Verdurous Prowess"),
    description = ccb.content.text("Your physical capabilities are increased."),
    apply_message = ccb.content.text("You feel a surge of power and a sense of unity with the wild."),
    remove_message = ccb.content.text("Your wilderness-enhanced prowess fades away."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_bloodthorne_druid_gain_strength_dexterity_buff_0"))

content.add(content.EffectType {
    id = "effect_bloodthorne_druid_prevent_vampirism",
    name = ccb.content.text("Sapshield"),
    description = ccb.content.text("You are protected against the vampires' curse."),
    show_in_info = true,
})

content.add(content.EffectType {
    id = "effect_bloodthorne_druid_prevent_vampirism_active",
    name = ccb.content.text("Blooming Sapshield"),
    description = ccb.content.text("You are protected against the vampires' curse."),
    remove_message = ccb.content.text("Your sapshield fades away."),
    show_in_info = true,
}
    :removes_effect("vampire_virus"))

-- Ideally there would be some way to require a roll before the vampire can break out but that's currently impossible so it's just duration-based for now.
content.add(content.EffectType {
    id = "effect_bloodthorne_druid_thorn_prison",
    name = ccb.content.text("Henge of Iron Thorns"),
    description = ccb.content.text("You are imprisoned in a thick tangle of thorns."),
    show_in_info = true,
    maximum_intensity = 300,
}
    :flag("CANNOT_MOVE"))

content.add(content.EffectType {
    id = "effect_werewolf_gain_more_powers",
    name = ccb.content.text("Gifts of the Moon"),
    description = ccb.content.text("You can unlock a new Lunar Gift.  Do so at night under the moon."),
    apply_message = ccb.content.text("You are ready for a new gift of the moon."),
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_xe_werewolf_illuminate_target",
    name = ccb.content.text("Moon's Cold Glow"),
    description = ccb.content.text("You are glowing slightly."),
    apply_message = ccb.content.text("A glow springs up around you!"),
    remove_message = ccb.content.text("The faint glow around you fades away."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_xe_werewolf_illuminate_target_0")
    :enchantment("INLINE_ENCH_effect_xe_werewolf_illuminate_target_1")
    :modifier("dodge", "amount", { base = -1 }))

-- This is necessary because the ACTIVE condition can't be included with or/and statements
content.add(content.EffectType {
    id = "effect_xe_werewolf_primal_strength_human_form",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_xe_werewolf_primal_strength_human_form_0"))

-- Hidden effect, flags only apply in wolf form
content.add(content.EffectType {
    id = "effect_xe_werewolf_climb_in_wolf_form",
    name = "",
    description = "",
}
    :flag("CLIMB_NO_LADDER")
    :flag("ONE_STORY_FALL"))

-- Hidden effect, part of an activatable trait
content.add(content.EffectType {
    id = "effect_xe_werewolf_camouflage_as_wolf",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_xe_werewolf_camouflage_as_wolf_0")
    :enchantment("INLINE_ENCH_effect_xe_werewolf_camouflage_as_wolf_1"))

-- Hidden effect, part of an activatable trait
content.add(content.EffectType {
    id = "effect_xe_werewolf_redhanded_rage",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_xe_werewolf_redhanded_rage_0"))

-- Hidden effect, used to make sure werewolves don't drink their items when Ghostwalking.
content.add(content.EffectType {
    id = "effect_xe_werewolf_walk_through_walls",
    name = "",
    description = "",
}
    :flag("ETHEREAL")
    :flag("INVISIBLE")
    :enchantment("INLINE_ENCH_effect_xe_werewolf_walk_through_walls_0"))

content.add(content.EffectType {
    id = "effect_xe_werewolf_summon_shadow_pack_limiter",
    name = ccb.content.text("Summoned the Shadow Pack"),
    description = ccb.content.text("You called on the aid of ancestral werewolves and must wait before seeking their aid again."),
})

content.add(content.EffectType {
    id = "effect_follower_summoned_dross",
    name = ccb.content.text("Recently created dreamdross"),
    description = ccb.content.text("This person has recently gave you dreamdross.  It will take some time before they gather an usable amount of dross again."),
})

-- Used to target a slightly different winning screen upon exiting the mortal realms as a Lord in Boann's court.
content.add(content.EffectType {
    id = "march_baron",
    name = ccb.content.text("March Baron"),
})

content.add(content.EffectType {
    id = "effect_oxygen_jelly_long",
    name = ccb.content.text("Long-release Oxyjelly"),
    description = ccb.content.text("The Oxyjelly you used is keeping you from drowning."),
    remove_message = ccb.content.text("Your Oxyjelly has ran out."),
    maximum_duration_turns = 7200,
    maximum_intensity = 120,
    intensity_duration_turns = 60,
}
    :decay_message(ccb.content.text("Your Oxyjelly is running out."), "bad")
    :flag("GILLS")
    :flag("EYE_MEMBRANE"))

content.add(content.EffectType {
    id = "effect_bio_inventor_calorie_storage",
    name = ccb.content.text("Orbiting Calories"),
    description = ccb.content.text("Your calories are stored through the most efficient storage ever conceived."),
    remove_message = ccb.content.text("Your orbiting calories dissipate as the bionic powers down."),
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_burned_books",
    name = ccb.content.text("Informed by your Buddy"),
    description = ccb.content.text("Slightly obstructive strands of information wander through your mind.  You might find a use for some of them."),
    apply_message = ccb.content.text("Incendiary information fills your mind!"),
    remove_message = ccb.content.text("The false knowledge fully exits your mind."),
    maximum_intensity = 10,
    rating = "mixed",
}
    :name(ccb.content.text("Fiercely Informed by your Buddy"))
    :name(ccb.content.text("Over-Informed by your Buddy"))
    :name(ccb.content.text("Saturated memory"))
    :name(ccb.content.text("Expanded-Expended Memory"))
    :name(ccb.content.text("Engorged Memory"))
    :name(ccb.content.text("Simulated Smarts"))
    :name(ccb.content.text("Overflowing with Information"))
    :name(ccb.content.text("False Knower"))
    :name(ccb.content.text("The Burner and the Buddy"))
    :description(ccb.content.text("You know more things, despite your impression of learning more slowly than before."))
    :description(ccb.content.text("No matter what book you burn, your buddy rewards you with fleeting, false knowledge."))
    :description(ccb.content.text("New knowledge is harder to acquire, but you hold much more of it."))
    :description(ccb.content.text("With each new book burned, your mind both expands and tightens."))
    :description(ccb.content.text("Like an overstuffed room, your memory is filled enough that it has little room for new things."))
    :description(ccb.content.text("The amount of trivia you know will hopefully counterbalance your impaired ability to gain knowledge."))
    :description(ccb.content.text("You know so many things now, a shame you struggle to learn more without your buddy helping you."))
    :description(ccb.content.text("You struggle to remember what you did minutes ago, but you hold more knowledge in your head than an entire library holds in its books."))
    :description(ccb.content.text("No new knowledge can enter your mind, but this is no matter for your buddy keeps it filled to the brim with information."))
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message(ccb.content.text("You know less things than before, but you find it easier to learn."), "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message(ccb.content.text("You forgot many things, but you regained your ability to learn."), "mixed"))

content.add(content.EffectType {
    id = "effect_withering_healing_down",
    name = ccb.content.text("Withered"),
    description = ccb.content.text("You feel strangely enervated."),
    rating = "bad",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_withering_healing_down_0"))
