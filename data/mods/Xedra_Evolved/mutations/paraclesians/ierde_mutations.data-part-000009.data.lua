local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_STONE_MEDITATIONS",
    name = ccb.content.text("Stone Meditations"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Ierde meditates on the nature of stone and removes themselves from the highs and lows of mortal emotions."),
    categories = { "IERDE" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 5000,
    activation_message = ccb.content.text("Your feelings calcify."),
    on_activate = "ierde_full_morale_neutralization",
}
