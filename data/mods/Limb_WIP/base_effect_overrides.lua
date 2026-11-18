local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "no_power_tank_treads",
    name = ccb.content.text("Low Power (Tank Treads)"),
    description = ccb.content.text("You're low on power.  Your tank treads are operating in emergency mode and have limited function."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -10 })
    :limb_score("block", { multiplier = 0.9 })
    :limb_score("swim", { multiplier = 0.2 })
    :limb_score("move_speed", { multiplier = 0.2 }))
