local ccb = require("ccb")

-- Exists here to prevent errors with Defense Mode stuff.
ccb.content.define_scenario {
    id = "defense_mode_fortified",
    name = "Fortified",
    points = 0,
    description = "",
    locations = { "sloc_bar" },
    start_name = "",
}
