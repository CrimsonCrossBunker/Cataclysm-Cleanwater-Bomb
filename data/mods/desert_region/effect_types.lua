local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "dust_storm_blind",
    name = ccb.content.text("Dust"),
    description = ccb.content.text("Range of Sight: 0.  You cannot see anything."),
    apply_message = ccb.content.text("The dust blinds you!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    maximum_duration_turns = 600,
    show_in_info = true,
}
    :flag("BLIND")
    :removes_effect("glare")
    :removes_effect("snow_glare")
    :removes_effect("darkness")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = 3 })
    :miss_message(ccb.content.text("The dust irritates your eyes."), 1))

content.add(content.EffectType {
    id = "dust_storm_dust",
    name = ccb.content.text("Dust", "inhaled"),
    description = ccb.content.text("You've inhaled a lungful of fine dust."),
    apply_message = ccb.content.text("You inhale a lungful of fine dust."),
    rating = "bad",
    harmful_cough = true,
    maximum_duration_turns = 600,
    show_in_info = true,
}
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("cough", "chance_numerator", { base = 10 })
    :miss_message(ccb.content.text("Your lungs burn from the dust."), 1))
