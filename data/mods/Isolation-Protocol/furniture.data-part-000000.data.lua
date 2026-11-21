local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_elevator_control_iso",
    name = ccb.content.text("elevator controls"),
    description = ccb.content.text("This is the control face for an elevator.  You could press the appropriate button to take you to your choice of floor."),
    symbol = "6",
    color = "light_blue",
    move_cost = 0,
    coverage = 50,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "NOITEM", "INDOORS" },
    examine_handler = "examine_t_elevator_control_iso",
}
