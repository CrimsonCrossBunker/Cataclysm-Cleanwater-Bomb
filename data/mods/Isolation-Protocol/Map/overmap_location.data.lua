local ccb = require("ccb")

ccb.content.define_start_location {
    id = "iso_entry_setpiece",
    name = ccb.content.text("Entrance Lobby"),
    targets = { "iso_first_elevator" },
}
