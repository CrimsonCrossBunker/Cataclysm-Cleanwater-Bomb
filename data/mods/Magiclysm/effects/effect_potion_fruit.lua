local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_pfruit_heal",
    name = ccb.content.text("Restore Flesh and Bone"),
    description = ccb.content.text("Thanks to that apple, your wounds are slowly healing."),
    apply_message = ccb.content.text("Your flesh and bones start to knit together before your eyes."),
    remove_message = ccb.content.text("Your regeneration slows down."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_pfruit_heal_0"))

content.add(content.EffectType {
    id = "effect_pfruit_cure",
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
    id = "effect_pfruit_attack_speed",
    name = ccb.content.text("Quick Blows"),
    description = ccb.content.text("Thanks to that pear, you can attack faster."),
    apply_message = ccb.content.text("You arms speed up."),
    remove_message = ccb.content.text("Your muscle's twitch as the pear's magic fades."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_pfruit_attack_speed_0"))

content.add(content.EffectType {
    id = "effect_pfruit_thorns",
    name = ccb.content.text("Blackberry Thorns"),
    description = ccb.content.text("Anyone who attacks you will regret it."),
    apply_message = ccb.content.text("Long thorns grow through your skin, clothes, and armor."),
    remove_message = ccb.content.text("The thorns vanish without a trace, leaving your gear unharmed."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("enchant_pfruit_thorns"))

content.add(content.EffectType {
    id = "effect_pfruit_keep_warm",
    name = ccb.content.text("Summer's Heat"),
    description = ccb.content.text("The magic of those strawberries is keeping you warm."),
    apply_message = ccb.content.text("You feel a pleasant warmth."),
    remove_message = ccb.content.text("You shiver as a cool breeze hits your skin."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_effect_pfruit_keep_warm_0"))

content.add(content.EffectType {
    id = "effect_pfruit_purge",
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
    id = "effect_pfruit_dodge",
    name = ccb.content.text("Flexible"),
    description = ccb.content.text("Your range of motion is greatly increased."),
    apply_message = ccb.content.text("You arms are as bendy as rubber."),
    remove_message = ccb.content.text("Your limbs creak as they lose their flexibility."),
    rating = "good",
    show_intensity = false,
}
    :flag("DOWNED_RECOVERY")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_pfruit_dodge_0")
    :limb_score("reaction", { multiplier = 2.0 })
    :limb_score("block", { multiplier = 1.2 })
    :limb_score("crawl", { multiplier = 1.5 }))

content.add(content.EffectType {
    id = "effect_pfruit_nightvision",
    name = ccb.content.text("Wintergreen Vision"),
    description = ccb.content.text("You can see in the dark."),
    apply_message = ccb.content.text("The night doesn't seem so dark anymore."),
    remove_message = ccb.content.text("The darkness of the night rushes in again."),
    rating = "good",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("night_vis", { multiplier = 6 }))

content.add(content.EffectType {
    id = "effect_pfruit_nobleed",
    name = ccb.content.text("Stopped Bleeding"),
    description = ccb.content.text("Your blood is all being held within your body."),
    apply_message = ccb.content.text("Your wounds tingle."),
    remove_message = ccb.content.text("You feel a prickle as your wounds ache."),
    rating = "good",
    show_intensity = false,
}
    :flag("BLEED_IMMUNE")
    :removes_effect("bleed"))

content.add(content.EffectType {
    id = "effect_pfruit_vision",
    name = ccb.content.text("Good Vision"),
    description = ccb.content.text("The magic of those apricots is helping you see better."),
    apply_message = ccb.content.text("You can pick out even minute details."),
    remove_message = ccb.content.text("Distant objects loose their magical clarity."),
    rating = "good",
    show_intensity = false,
}
    :flag("GLARE_RESIST")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_pfruit_vision_0")
    :limb_score("vision", { multiplier = 1.25 }))

content.add(content.EffectType {
    id = "effect_pfruit_eat_poison",
    name = ccb.content.text("Poison-Eater"),
    description = ccb.content.text("You can eat toxic or spoiled food without penalty.  You still should not eat zombie meat."),
    apply_message = ccb.content.text("Your sense of taste dulls."),
    remove_message = ccb.content.text("Something in your mouth tastes foul."),
    rating = "good",
    show_intensity = false,
}
    :flag("IMMUNE_SPOIL")
    :vitamin("mutant_toxin", {
        rates = { { minimum = -1, maximum = -1 } },
        absorption = { 0.5 },
        tick_turns = { 1 },
    }))

content.add(content.EffectType {
    id = "effect_pfruit_no_drunk",
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
