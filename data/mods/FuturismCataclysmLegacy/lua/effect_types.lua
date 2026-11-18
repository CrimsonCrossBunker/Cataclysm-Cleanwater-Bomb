local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "fcl_cureall",
    maximum_duration_turns = 10,
}
    :removes_effect("bite")
    :removes_effect("bleed")
    :removes_effect("redcells_anemia")
    :removes_effect("hypovolemia")
    :removes_effect("shakes")
    :removes_effect("stunned")
    :removes_effect("winded")
    :removes_effect("winded_leg")
    :removes_effect("winded_arm")
    :removes_effect("hypocalcemia")
    :removes_effect("anemia")
    :removes_effect("scurvy")
    :modifier("hurt", "amount", { base = -10 })
    :modifier("health_modifier", "minimum", { base = 25 })
    :modifier("health", "minimum", { base = 100 }))

content.add(content.EffectType {
    id = "fcl_generic_speed_bonus",
    name = ccb.content.text("Movement Optimization (1)"),
    description = ccb.content.text("You move with machine-guided precision."),
    rating = "good",
    maximum_intensity = 4,
    intensity_add_value = 1,
    intensity_decay_tick = 500,
    show_in_info = true,
}
    :name(ccb.content.text("Movement Optimization (2)"))
    :name(ccb.content.text("Movement Optimization (3)"))
    :name(ccb.content.text("Movement Optimization (4)"))
    :modifier("dexterity", "amount", { base = 0.5, per_intensity = 0.5 })
    :modifier("speed", "amount", { base = 10, per_intensity = 10 }))
