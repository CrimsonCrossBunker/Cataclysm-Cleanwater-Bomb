local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_recycler",
    name = ccb.content.text("Recycler"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Even with no one around you feel obligated to clean up the streets.  You find full cans of soda in the weirdest places."),
    active = true,
    activation_setup_only = true,
    on_activate = "can_finder_on",
    on_deactivate = "can_finder_off",
    on_process = "can_hunting",
    cooldown = 24000,
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_second_wind",
    name = ccb.content.text("Second Wind"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Anyone can pause and catch their breath but you're extremely good at doing so.  You can regenerate one-third of your stamina over ten seconds, once every fifteen minutes.  Being hit will interrupt the regeneration."),
    active = true,
    activation_message = "",
    on_activate = "perk_second_wind",
    flags = { "PERK" },
}
