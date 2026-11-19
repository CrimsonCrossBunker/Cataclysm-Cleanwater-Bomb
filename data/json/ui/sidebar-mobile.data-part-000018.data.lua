local ccb = require("ccb")

ccb.content.define_widget {
    id = "l_date",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Date:"),
}

ccb.content.define_widget {
    id = "l_time",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Time:"),
}

ccb.content.define_widget {
    id = "l_place",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("Place:"),
}

ccb.content.define_widget {
    id = "l_sky",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("  Sky:"),
}

ccb.content.define_widget {
    id = "l_wind",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Wind:"),
}

ccb.content.define_widget {
    id = "l_light",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("Light:"),
}

ccb.content.define_widget {
    id = "l_sound",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("Sound:"),
}

ccb.content.define_widget {
    id = "l_temp",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Temp:"),
}

ccb.content.define_widget {
    id = "i_place_text",
    width = 23,
    style = "text",
    variable = "place_text",
    colors = { "c_white" },
}
