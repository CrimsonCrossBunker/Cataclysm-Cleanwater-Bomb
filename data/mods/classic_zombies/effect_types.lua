local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_zombie_pile_on",
    name = ccb.content.text("Piled On"),
    description = ccb.content.text("Zombies are piling on top of you!"),
    rating = "bad",
    maximum_intensity = 8,
    intensity_add_value = 1,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.1 })
    :limb_score("lift", { multiplier = 0.9, per_intensity = -0.05 })
    :limb_score("grip", { multiplier = 0.8, per_intensity = -0.1 })
    :limb_score("move_speed", { multiplier = 0.5 })
    :limb_score("footing", { multiplier = 0.75, per_intensity = -0.1 })
    :limb_score("balance", { multiplier = 0.8, per_intensity = -0.1 })
    :limb_score("breathing", { multiplier = 0.8, per_intensity = -0.1 }))
