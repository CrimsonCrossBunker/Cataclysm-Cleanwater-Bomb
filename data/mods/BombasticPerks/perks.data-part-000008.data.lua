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

ccb.content.define_mutation {
    id = "perk_troubleseeker",
    name = "Trouble Seeker",
    description = "As if the apocalypse itself wasn't enough, you are constantly looking for some trouble.  Zombies somehow sometimes sense your presence and approach you.  Fortunately, they always appear at a good distance from you.  Activate to toggle.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    cooldown = 20000,
    flags = { "PERK" },
    on_activate = "w16b_mut_activate_bombasticperks_ad215ed3fc3d",
    on_deactivate = "w16b_mut_deactivate_bombasticperks_8c184449b0e1",
    on_process = "w16b_mut_process_bombasticperks_d1deb6f5758f",
}
