local ccb = require("ccb")

ccb.content.define_mutation {
    id = "iso_trait_balthazar_uplink",
    name = ccb.content.text("Balthazar Uplink"),
    points = 0,
    description = ccb.content.text("A foreign segment within your mind, it feels like handful of blades floating on the edge of your unconscious.  You could talk to Balthazar if you focused on it."),
    active = true,
    activation_setup_only = false,
    enchantments = { "iso_ench_balthazar_control" },
    on_activate = "talk_balthazar",
    starting_trait = false,
    purifiable = false,
    valid = false,
}
