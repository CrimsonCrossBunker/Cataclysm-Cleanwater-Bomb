local ccb = require("ccb")

ccb.content.define_widget {
    id = "weather_desc",
    label = ccb.content.text("Weather"),
    style = "text",
    variable = "weather_text",
}

ccb.content.define_widget {
    id = "weather_desc_no_label",
    copy_from = "weather_desc",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "snow_depth_desc",
    label = ccb.content.text("Snow"),
    style = "text",
    variable = "snow_depth_text",
}
