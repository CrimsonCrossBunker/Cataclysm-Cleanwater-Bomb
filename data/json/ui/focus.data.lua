local ccb = require("ccb")

ccb.content.define_widget {
    id = "focus_num",
    label = ccb.content.text("Focus"),
    variable = "focus",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}
