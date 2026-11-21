local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_popeye",
    name = ccb.content.text("Of Sailors and Spinach"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You spent several years on the high sea and now your muscles visibly swell and clench when you eat raw spinach."),
    active = true,
    on_activate = "spinach_consumption",
    flags = { "PERK" },
}
