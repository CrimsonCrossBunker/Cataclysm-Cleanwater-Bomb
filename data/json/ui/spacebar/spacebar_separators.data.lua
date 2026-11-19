local ccb = require("ccb")

-- NO_I18N
ccb.content.define_widget {
    id = "spacebar_separator_2",
    style = "text",
    text = ccb.content.text_without_extraction("x"),
    width = 2,
    height = 1,
    colors = { "c_black" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "spacebar_separator_4",
    style = "text",
    text = ccb.content.text_without_extraction("x"),
    width = 4,
    height = 1,
    colors = { "c_black" },
}
