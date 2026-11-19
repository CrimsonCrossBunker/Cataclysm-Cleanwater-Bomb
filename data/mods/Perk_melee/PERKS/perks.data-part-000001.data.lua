local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_ma_perk_menu",
    name = ccb.content.text("Practice Martial Arts"),
    points = 0,
    purifiable = false,
    description = ccb.content.text("Learn new martial arts techniques and perks."),
    active = true,
    on_activate = "martial_perks_open_menu",
}
