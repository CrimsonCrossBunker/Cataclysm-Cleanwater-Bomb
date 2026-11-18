local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "blind",
    name = ccb.content.text("Blind"),
    description = ccb.content.text("Range of Sight: 0.  You cannot see anything."),
    apply_message = ccb.content.text("You're blinded!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("BLIND")
    :removes_effect("glare")
    :removes_effect("snow_glare")
    :removes_effect("darkness")
    :removes_effect("dust_storm_blind"))
