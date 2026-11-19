local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_wall_control",
    copy_from = "t_concrete",
    name = ccb.content.text("wall controls"),
    description = ccb.content.text("Wall controls."),
    examine_handler = "examine_retractable_furniture",
}
