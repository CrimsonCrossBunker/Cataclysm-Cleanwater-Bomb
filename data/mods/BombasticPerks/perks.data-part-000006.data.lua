local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_safety_squint",
    name = ccb.content.text("The Safety Squint"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("They told it to you as a joke, but you always knew it was real and now you've figured out how to do it.  With the proper squinting technique, you can safely weld without any external protection, though you won't be able to see much of your surroundings.  Activate to toggle."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You squint your eyes just right."),
    on_activate = "safety_squint_on",
    on_deactivate = "safety_squint_off",
    flags = { "PERK" },
}
