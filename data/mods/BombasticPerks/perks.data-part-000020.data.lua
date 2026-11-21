local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_radio_infusion",
    name = ccb.content.text("Radioactive Infusion"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You somehow learned to focus on an item to make it emit radiation forever.  You still have trouble understanding how this could ever be useful, but maybe you might find a use for it.  Activate to use."),
    active = true,
    activation_setup_only = false,
    on_activate = "radio_infusion",
    flags = { "PERK" },
}
