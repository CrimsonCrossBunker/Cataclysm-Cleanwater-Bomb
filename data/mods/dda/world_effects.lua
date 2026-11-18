local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "LIXA_decompressed",
    name = ccb.content.text("In Decompressed Space"),
    description = ccb.content.text("For an instant, every inch of this infinite space is itself infinite, slowing you drastically."),
    apply_message = ccb.content.text("Space unfolds and extends around you!"),
    rating = "bad",
    maximum_intensity = 3,
    intensity_duration_turns = 2,
    show_in_info = true,
}
    :modifier("speed", "amount", { base = -33, per_intensity = -33 })
    :modifier("hit", "amount", { per_intensity = -1 })
    :modifier("dodge", "amount", { per_intensity = -1 })
    :miss_message(ccb.content.text("You cannot make any progress in all this vastness."), 4))

content.add(content.EffectType {
    id = "LIXA_unfolded_eff",
    name = ccb.content.text("Unfolded"),
    description = ccb.content.text("There is no longer an inside or outside of you.  It is all one side; flat, infinite, and everything you have ever been.  You wonder if you're having no trouble understanding it because your brain works better spread out like this."),
    maximum_intensity = 1,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("reaction", { multiplier = 0.0 }))

content.add(content.EffectType {
    id = "artifact_teleportitis_aura",
    name = ccb.content.text("Strange Pressure"),
    description = ccb.content.text("You feel a strange force pressing you inwards and inside-out"),
}
    :enchantment("INLINE_ENCH_artifact_teleportitis_aura_0"))

content.add(content.EffectType {
    id = "artifact_slow_aura",
    name = ccb.content.text("Temporal Distortion"),
    description = ccb.content.text("A slight temporal distortion appears to be centered around you"),
}
    :enchantment("INLINE_ENCH_artifact_slow_aura_0"))

content.add(content.EffectType {
    id = "martial_grapple",
    name = ccb.content.text("Grappled"),
    description = ccb.content.text("Held in a martial artist's grip.  The hold ends when its owner moves away, loses the use of both arms, becomes exhausted or the grip expires."),
    maximum_intensity = 1,
    show_in_info = true,
})

content.add(content.EffectType {
    id = "martial_grapple_hold_cooldown",
    name = ccb.content.text("Grip Recovery"),
    description = ccb.content.text("You need a moment before establishing another grappling grip."),
    maximum_intensity = 1,
})

content.add(content.EffectType {
    id = "martial_grapple_throw_cooldown",
    name = ccb.content.text("Throw Recovery"),
    description = ccb.content.text("You need to recover your balance before another throw, even if you change martial arts styles."),
    maximum_intensity = 1,
})

content.add(content.EffectType {
    id = "martial_grapple_drag_cooldown",
    name = ccb.content.text("Drag Recovery"),
    description = ccb.content.text("You need to reset your footing before dragging a grappled opponent again."),
    maximum_intensity = 1,
})
