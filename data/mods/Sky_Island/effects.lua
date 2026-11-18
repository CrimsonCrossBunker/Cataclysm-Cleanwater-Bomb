local ccb = require("ccb")
local content = ccb.content

-- The expedition controls intensity. Lower intensity means more severe penalties.
content.add(content.EffectType {
    id = "warpsickness",
    name = ccb.content.text("Warp Disintegration!"),
    description = ccb.content.text("You're going to die.  And if you weren't busy leaking blood out of every pore, you'd find a better way to emphasize just how badly you're dying.  Your only hope is to return home immediately."),
    rating = "mixed",
    maximum_intensity = 6,
}
    :name(ccb.content.text("Warp Necrosis"))
    :name(ccb.content.text("Warp Debilitation"))
    :name(ccb.content.text("Warp Sickness"))
    :name(ccb.content.text("Warp Nausea"))
    :name(ccb.content.text("Warp Stability"))
    :description(ccb.content.text("The very fabric of your being is unraveling!  You're in dire straits.  You need to get back to your sanctuary island NOW!"))
    :description(ccb.content.text("You've stayed earthside WAY too long!  Your body barely responds and your senses are slush.  The world itself feels barbed and frayed, and the very air is like breathing fiberglass.  If you want to survive, you need to warp home as soon as possible."))
    :description(ccb.content.text("You've stayed earthside too long.  Your body aches and your senses are dulling.  Every step feels like you're walking through thick mud and breathing hot tar.  You should warp home as soon as you can, or this is only going to get worse."))
    :description(ccb.content.text("You've overstayed your time earthside.  It's getting hard to concentrate, there's a painful ringing in your ears, and your muscles sting and jolt.  Every action feels delayed.  You need to warp home to refresh yourself, or this is going to get worse.  Probably within just a few hours."))
    :description(ccb.content.text("You're fresh from your stay at your sanctuary island.  The intangible miasma of terra firma currently has no effect on you, and you feel fine.  This should last for several hours.  Stay too long, however, and you'll gradually begin to suffer ever-worsening debilitating effects."))
    :decay_message(ccb.content.text("There are no words to describe how much trouble you're in.  Your body is crumbling to wet paste and your blood is twisting into a viny tangle.  All you know is pain.  You're not just dying, you're dying horribly.  Your only hope is escape to your sanctuary, but oblivion is only moments away."), "bad")
    :decay_message(ccb.content.text("You taste blood and your eyes sink back into their sockets.  You've stayed out too long.  Your warp sickness is about to consume you entirely and you're falling apart at the seams.  Get home NOW!"), "bad")
    :decay_message(ccb.content.text("The ravages of the world intensify.  Everything hurts and existence is a surreal wash of pain.  Your warp sickness is unbearable.  You need to get home as soon as possible."), "bad")
    :decay_message(ccb.content.text("The bile suddenly rises in your throat and your fingers feel like they're peeling themselves open.  Your warp sickness is getting worse.  You should get home soon."), "bad")
    :decay_message(ccb.content.text("The whole world shimmers in front of your eyes.  Everything feels slow and sticky.  Warp sickness is setting in.  You should focus on getting home."), "bad")
    :modifier("strength", "amount", { base = -10, per_intensity = 2 })
    :modifier("dexterity", "amount", { base = -10, per_intensity = 2 })
    :modifier("perception", "amount", { base = -10, per_intensity = 2 })
    :modifier("intelligence", "amount", { base = -10, per_intensity = 2 }))

-- Warp sickness at its strongest starts damaging the character over time.
content.add(content.EffectType {
    id = "warpdisintegration",
    name = ccb.content.text("Disintegrating!"),
    description = ccb.content.text("Prolonged warp is destroying you.  You're coming apart."),
    apply_message = ccb.content.text("You're being unmade!"),
    remove_message = ccb.content.text("The rending of the warp has finally abated.  You feel like you exist again."),
    rating = "bad",
    maximum_intensity = 1,
    show_intensity = false,
}
    :modifier("pain", "amount", { base = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "maximum_value", { base = 100 })
    :modifier("hurt", "amount", { base = 5 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 1 })
    :modifier("hurt", "tick", { base = 20 }))

-- Invisibility fades on its own after the grace period set on arrival.
content.add(content.EffectType {
    id = "warpcloak",
    name = ccb.content.text("Warpcloaked"),
    description = ccb.content.text("You are invisible for a very brief time.  Now's your chance to get to cover.  You're also incorporeal enough to not take fall damage, but hopefully that won't be relevant."),
    remove_message = ccb.content.text("You fully materialize.  You're not invisible anymore!"),
    maximum_intensity = 2,
    intensity_duration_turns = 10,
}
    :decay_message(ccb.content.text("Your warpcloak is about to fade away."), "bad")
    :flag("INVISIBLE")
    :flag("FEATHER_FALL"))

content.add(content.EffectType {
    id = "effect_warped_waterwalking",
    name = ccb.content.text("Warped Waterwalking"),
    description = ccb.content.text("You can walk on the surface of the water"),
    remove_message = ccb.content.text("You can no longer walk on the water."),
    rating = "good",
}
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

-- Suppresses separate waterwalking messages during warpcloak.
content.add(content.EffectType {
    id = "effect_warped_waterwalking_hidden",
    name = "",
    description = "",
    rating = "good",
}
    :flag("ITEM_WATERPROOFING")
    :flag("WATERWALKING"))

content.add(content.EffectType {
    id = "effect_warped_flight",
    name = "",
    description = "",
    rating = "good",
}
    :flag("LEVITATION")
    :flag("CLIMB_FLYING"))

content.add(content.EffectType {
    id = "effect_warped_phasing",
    name = "",
    description = "",
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_warped_phasing_0"))

content.add(content.EffectType {
    id = "effect_warped_super_clairvoyance",
    name = ccb.content.text("Warped Omniscience"),
    description = ccb.content.text("Nothing escapes your sight."),
    apply_message = ccb.content.text("Your vision expands until you see everything."),
    remove_message = ccb.content.text("Your sight returns to normal."),
    rating = "good",
    show_intensity = false,
}
    :flag("SUPER_CLAIRVOYANCE"))

content.add(content.EffectType {
    id = "effect_island_radblock",
    name = "",
    description = "",
    rating = "good",
}
    :flag("NO_RADIATION"))

content.add(content.EffectType {
    id = "effect_island_steady",
    name = "",
    description = "",
}
    :flag("STEADY"))

content.add(content.EffectType {
    id = "effect_sky_island_momentary_flight",
    name = "",
    description = "",
}
    :flag("LEVITATION"))

content.add(content.EffectType {
    id = "challenge_mode_speed_reduction",
    name = ccb.content.text("Slow Dimension"),
    description = ccb.content.text("You are moving slower than usual in this dimension"),
    rating = "bad",
    show_intensity = false,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_challenge_mode_speed_reduction_0"))

content.add(content.EffectType {
    id = "effect_sky_island_merchant_attraction",
    name = ccb.content.text("Aura of Lucre"),
    description = ccb.content.text("You're in the money and anyone who looks at you knows it.  There'll definitely be someone waiting to relieve you of it when you next return to your island."),
})
