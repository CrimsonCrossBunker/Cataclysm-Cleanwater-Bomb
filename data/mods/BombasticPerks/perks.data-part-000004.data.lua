local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_grit_your_teeth",
    name = ccb.content.text("Grit Your Teeth"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("When you have to you can wipe the blood off your chin, grit your teeth, and get it done.  Use to reduce your pain by 30 or half (whichever is greater) for 3 minutes.\n\nThe cooldown on this perk scales based on your pain at the time you used it."),
    active = true,
    activation_setup_only = false,
    on_activate = "perk_grit_your_teeth",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_slippery_escape",
    name = ccb.content.text("Slippery Escape"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your joints are flexible enough that you can twist out of nearly anything when given a mind, though that doesn't make it hurt any less.  At the cost of some pain, you can twist out of enemy grabs."),
    active = true,
    activation_setup_only = false,
    activation_message = ccb.content.text("You twist out of the grab with a wrench!"),
    on_activate = "perk_slippery_escape",
    flags = { "PERK" },
}
