local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_AURA_OF_VINES",
    name = ccb.content.text("Entanglement of Vines"),
    points = 2,
    description = ccb.content.text("Your heartvines have grown enough that you can extend numerous vines around you.  These vines will retaliate against attackers, defend you, assist you in casting magicks if your hands are full, allow you to descend buildings by grasping handholds, and alert you to nearby dangers."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 3,
    activation_message = ccb.content.text("A multitude of vines burst from your flesh!"),
    on_activate = "toggle_trait_form",
    on_deactivate = "toggle_trait_form",
}
