local ccb = require("ccb")

ccb.content.define_widget {
    id = "health_num",
    label = ccb.content.text("Health"),
    variable = "health",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "daily_health_num",
    label = ccb.content.text("Daily health"),
    variable = "daily_health",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "health_desc",
    label = ccb.content.text("Health"),
    style = "text",
    copy_from = "health_desc_template",
}
