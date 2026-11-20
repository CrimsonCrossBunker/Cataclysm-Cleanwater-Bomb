local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_bionic_salvaged",
    name = ccb.content.text("Already deployed"),
    description = ccb.content.text("This bionic needs to be reset to its factory state."),
    price_modifier = 0.8,
    item_prefix = ccb.content.text("salvaged"),
}
