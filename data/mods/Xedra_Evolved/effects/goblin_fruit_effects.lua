local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_goblin_fruit_heal",
    name = ccb.content.text("Restore Flesh and Bone"),
    description = ccb.content.text("Your wounds are slowly healing."),
    apply_message = ccb.content.text("Your flesh and bones start to knit together before your eyes."),
    remove_message = ccb.content.text("Your regeneration slows down as the goblin fruit's magic fades."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_heal_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_cure",
    name = ccb.content.text("Ward off Miasma"),
    description = ccb.content.text("No illness is going to get you down now."),
    apply_message = ccb.content.text("You feel revitalized."),
    rating = "good",
    show_intensity = false,
}
    :removes_effect("scurvy")
    :removes_effect("redcells_anemia")
    :removes_effect("anemia")
    :removes_effect("toxin_buildup")
    :removes_effect("common_cold")
    :removes_effect("flu"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_speed",
    name = ccb.content.text("Quick Blows"),
    description = ccb.content.text("You can attack faster."),
    apply_message = ccb.content.text("You arms speed up."),
    remove_message = ccb.content.text("Your muscles twitch as the goblin fruit's magic fades."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_speed_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_thorns",
    name = ccb.content.text("Thorns"),
    description = ccb.content.text("Anyone who attacks you will regret it."),
    apply_message = ccb.content.text("Long thorns grow through your skin, clothes, and armor."),
    remove_message = ccb.content.text("The thorns vanish without a trace, leaving your gear unharmed."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("ench_goblin_fruit_thorns"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_keep_warm",
    name = ccb.content.text("Summer's Heat"),
    description = ccb.content.text("The magic of that goblin fruit is keeping you warm."),
    apply_message = ccb.content.text("You feel a pleasant warmth."),
    remove_message = ccb.content.text("You shiver as a cool breeze hits your skin."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_keep_warm_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_purge_blood",
    name = ccb.content.text("Ward off Toxins"),
    description = ccb.content.text("Your body will not be corrupted by these vile substances."),
    apply_message = ccb.content.text("You feel cleansed."),
    rating = "good",
    show_intensity = false,
}
    :removes_effect("poison")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_effect("badpoison")
    :removes_effect("foodpoison")
    :removes_effect("paralyzepoison")
    :removes_effect("bloodworms")
    :removes_effect("brainworms")
    :removes_effect("tapeworm"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_dodge",
    name = ccb.content.text("Flexible"),
    description = ccb.content.text("Your range of motion is greatly increased."),
    apply_message = ccb.content.text("You arms are as bendy as rubber."),
    remove_message = ccb.content.text("Your limbs creak as they lose their flexibility."),
    rating = "good",
    show_intensity = false,
}
    :flag("DOWNED_RECOVERY")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_goblin_fruit_dodge_0")
    :modifier("dodge", "amount", { base = 1 })
    :limb_score("reaction", { multiplier = 2.0 })
    :limb_score("block", { multiplier = 1.2 })
    :limb_score("crawl", { multiplier = 1.5 }))

content.add(content.EffectType {
    id = "effect_goblin_fruit_nightvision",
    name = ccb.content.text("Darkvision"),
    description = ccb.content.text("You can see in the dark."),
    apply_message = ccb.content.text("The night doesn't seem so dark anymore."),
    remove_message = ccb.content.text("The darkness of the night rushes in again."),
    rating = "good",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("CRAFT_IN_DARKNESS")
    :limb_score("night_vis", { multiplier = 6 }))

content.add(content.EffectType {
    id = "effect_goblin_fruit_shadow",
    name = ccb.content.text("Muffled"),
    description = ccb.content.text("Your movements are muffled."),
    apply_message = ccb.content.text("Your footsteps feel quieter."),
    remove_message = ccb.content.text("Your steps are normal once again."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_shadow_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_nobleed",
    name = ccb.content.text("Stopped Bleeding"),
    description = ccb.content.text("Your blood is all being contained within your body."),
    apply_message = ccb.content.text("Your wounds tingle."),
    remove_message = ccb.content.text("You feel a prickle as your wounds ache."),
    rating = "good",
    show_intensity = false,
}
    :flag("BLEED_IMMUNE")
    :removes_effect("bleed"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_perception",
    name = ccb.content.text("Good Vision"),
    description = ccb.content.text("The magic of that goblin fruit is helping you see better."),
    apply_message = ccb.content.text("You can pick out even minute details."),
    remove_message = ccb.content.text("Distant objects loose their magical clarity."),
    rating = "good",
    show_intensity = false,
}
    :flag("GLARE_RESIST")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_goblin_fruit_perception_0")
    :limb_score("vision", { multiplier = 1.25 }))

content.add(content.EffectType {
    id = "effect_goblin_fruit_no_drunk",
    name = ccb.content.text("Remove intoxicants"),
    description = ccb.content.text("You are being rapidly sobered up."),
    apply_message = ccb.content.text("Your head pounds, but you feel much more alert."),
    remove_message = ccb.content.text("."),
    rating = "mixed",
    show_intensity = false,
}
    :removes_effect("drunk")
    :removes_effect("meth")
    :removes_effect("high")
    :removes_effect("weed_high"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_eat_poison",
    name = ccb.content.text("Poison-Eater"),
    description = ccb.content.text("You can eat toxic or spoiled food without penalty.  You still should not eat zombie meat."),
    apply_message = ccb.content.text("Your sense of taste dulls."),
    remove_message = ccb.content.text("Something in your mouth tastes foul."),
    rating = "good",
    show_intensity = false,
}
    :flag("IMMUNE_SPOIL")
    :flag("PARAIMMUNE")
    :blocks_effect("foodpoison")
    :vitamin("mutant_toxin", {
        rates = { { minimum = -1, maximum = -1 } },
        absorption = { 0.5 },
        tick_turns = { 10 },
    }))

content.add(content.EffectType {
    id = "effect_goblin_fruit_featherfall",
    name = ccb.content.text("Feather Fall"),
    description = ccb.content.text("You can fall any distance without damage."),
    apply_message = ccb.content.text("You feel as light as air."),
    remove_message = ccb.content.text("Gravity reclaims its hold on you."),
    rating = "good",
    show_intensity = false,
}
    :flag("FEATHER_FALL"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_super_clairvoyance",
    name = ccb.content.text("Omniscience"),
    description = ccb.content.text("You can see forever."),
    apply_message = ccb.content.text("Your head pounds as you suddenly see in all directions simultaneously."),
    remove_message = ccb.content.text("Your senses snap back into your body."),
    rating = "good",
    show_intensity = false,
}
    :flag("SUPER_CLAIRVOYANCE"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_water_breathing",
    name = ccb.content.text("Return to the Sea"),
    description = ccb.content.text("You can breathe underwater."),
    apply_message = ccb.content.text("You feel an urge to take a swim."),
    remove_message = ccb.content.text("You need to take a breath of air, now!"),
    rating = "good",
    show_intensity = false,
}
    :flag("WALK_UNDERWATER")
    :flag("GILLS"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_stealth",
    name = ccb.content.text("Unnoticed"),
    description = ccb.content.text("You're beneath notice, unless they get too close of you."),
    apply_message = ccb.content.text("You find it hard to notice your own presence."),
    remove_message = ccb.content.text("You become noticeable again."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_stealth_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_combat_skill_boost",
    name = ccb.content.text("Violent reflection"),
    description = ccb.content.text("You are mirroring a version of yourself that is more skilled at violence."),
    apply_message = ccb.content.text("Your mind fills with violence and the knowledge to use it."),
    remove_message = ccb.content.text("Your level of violence returns to normal."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_combat_skill_boost_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_craft_skill_boost",
    name = ccb.content.text("Imitated skill"),
    description = ccb.content.text("You're imitating yourself, if you were better at making things."),
    apply_message = ccb.content.text("You start imitating a more skilled artisan."),
    remove_message = ccb.content.text("Your talent to imitate fades."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_craft_skill_boost_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_immovable",
    name = ccb.content.text("Immovable"),
    description = ccb.content.text("You cannot be moved against your will by mundane means."),
    apply_message = ccb.content.text("You feel fixed in place!"),
    remove_message = ccb.content.text("You stumble a little as your immovability ceases."),
    rating = "good",
}
    :removes_effect("stunned")
    :removes_effect("dazed")
    :removes_effect("downed")
    :enchantment("INLINE_ENCH_effect_goblin_fruit_immovable_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_dodge_instant",
    name = ccb.content.text("Untouchable"),
    description = ccb.content.text("For an instant, nothing can touch you."),
    apply_message = ccb.content.text("You start dodging everything that could touch you!"),
    remove_message = ccb.content.text("Your dodging abilities return to normal."),
    rating = "good",
}
    :flag("UNCANNY_DODGE")
    :removes_effect("grabbed")
    :enchantment("INLINE_ENCH_effect_goblin_fruit_dodge_instant_0")
    :modifier("dodge", "amount", { base = 100 }))

content.add(content.EffectType {
    id = "effect_goblin_fruit_focus_boost",
    name = ccb.content.text("Understanding"),
    description = ccb.content.text("As long as it lasts, you will have an easier time learning new things."),
    apply_message = ccb.content.text("Everything feels a little easier to understand now."),
    remove_message = ccb.content.text("Your mind returns to its regular level of understanding."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_focus_boost_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_heal_after_sleep",
    name = ccb.content.text("Eventual restful sleep"),
    description = "",
    maximum_intensity = 9999,
    rating = "good",
})

content.add(content.EffectType {
    id = "effect_goblin_fruit_teleport",
    name = ccb.content.text("Fractal teleportation"),
    description = ccb.content.text("Your position constantly changes."),
    apply_message = ccb.content.text("You feel your position grow uncertain."),
    remove_message = ccb.content.text("You stop teleporting all over the place."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_teleport_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_climb",
    name = ccb.content.text("Sticky climb"),
    description = ccb.content.text("You can climb walls without trouble."),
    apply_message = ccb.content.text("Your extremities become sticky."),
    remove_message = ccb.content.text("Your extremities stop being this sticky."),
}
    :flag("CLIMB_NO_LADDER")
    :flag("WALL_CLING"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_amplification_instant",
    name = ccb.content.text("Pressurized amplification"),
    description = ccb.content.text("Your muscles are filled with pressurized power!"),
    apply_message = ccb.content.text("Your muscles are filled with pressurized power!"),
    remove_message = ccb.content.text("The power leaves your muscles in an instant."),
    maximum_intensity = 10,
    intensity_add_value = 10,
    intensity_decay_step = -1,
    intensity_decay_tick = 6,
    rating = "good",
}
    :decay_message(ccb.content.text("The pressure inside your muscles grows!"), "good")
    :modifier("strength", "amount", { base = 10, per_intensity = -1 }))

content.add(content.EffectType {
    id = "goblin_fruit_carry_boost",
    name = ccb.content.text("Lightened load"),
    description = ccb.content.text("You find it easier to carry heavy charges."),
    apply_message = ccb.content.text("You feel lighter, as does everything you're carrying."),
    remove_message = ccb.content.text("The weight of your belongings return to normal."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_goblin_fruit_carry_boost_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_wild_travel_boost",
    name = ccb.content.text("A path through the forest"),
    description = ccb.content.text("You move a bit quicker through the wilds."),
    apply_message = ccb.content.text("Nearby vegetation becomes a little less daunting."),
    remove_message = ccb.content.text("Traversing vegetation stops being easier."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_wild_travel_boost_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_slowing_armor",
    name = ccb.content.text("The stone's endurance"),
    description = ccb.content.text("You are more resistant to damage but move more slowly."),
    apply_message = ccb.content.text("You stiffen, becoming slower but more resistant to anything."),
    remove_message = ccb.content.text("The stiffness quits your body."),
    rating = "mixed",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_slowing_armor_0")
    :modifier("speed", "amount", { base = -10 }))

content.add(content.EffectType {
    id = "effect_goblin_fruit_social_boost",
    name = ccb.content.text("Silver tongue"),
    description = ccb.content.text("You are better at convincing others to do what you want."),
    apply_message = ccb.content.text("You feel more persuasive."),
    remove_message = ccb.content.text("Your charisma returns to normal."),
    rating = "good",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_social_boost_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_altitude_speed",
    name = ccb.content.text("Gust of wind"),
    description = ccb.content.text("The winds are assisting your movements."),
    apply_message = ccb.content.text("You long for the skies as winds start blowing at you."),
    remove_message = ccb.content.text("The skies lose their heightened luster."),
    rating = "good",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_altitude_speed_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_cold_resist",
    name = ccb.content.text("Shelter from the cold"),
    description = ccb.content.text("You withstand the cold much better than most."),
    apply_message = ccb.content.text("You feel much more warm."),
    remove_message = ccb.content.text("The warm feeling fades."),
    rating = "good",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_cold_resist_0")
    :enchantment("INLINE_ENCH_effect_goblin_fruit_cold_resist_1"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_craft_speed_boost",
    name = ccb.content.text("Accelerated artistry"),
    description = ccb.content.text("You make things quicker, unless someone else is looking."),
    apply_message = ccb.content.text("You feel better at making things, but only if nobody is watching you."),
    remove_message = ccb.content.text("Your increased crafting quickness returns to normal."),
    rating = "good",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_goblin_fruit_craft_speed_boost_0"))

content.add(content.EffectType {
    id = "effect_goblin_fruit_cure_dreamless_cooldown",
    name = ccb.content.text("Cloudy fruit aftertaste"),
    description = ccb.content.text("You can still faintly taste that cloudy fruit.  Any cloudy fruit you might eat before the aftertaste ends won't have any effect."),
    show_in_info = true,
})
