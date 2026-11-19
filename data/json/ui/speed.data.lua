local ccb = require("ccb")

ccb.content.define_widget {
    id = "speed_num",
    label = ccb.content.text("Speed"),
    variable = "speed",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}
