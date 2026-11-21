local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_unopenable_grip",
    name = ccb.content.text("Unopenable Grip"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("After having things you held in your hands stolen countless times, your grip became strong enough to keep anything in your hands as long as you will it.  Activate to toggle the ability to drop your held item."),
    categories = { "perk" },
    active = true,
    activation_setup_only = false,
    on_activate = "unopenable_grip",
    flags = { "PERK" },
}
