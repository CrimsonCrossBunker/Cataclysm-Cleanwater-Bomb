local ccb = require("ccb")

ccb.content.define_widget {
    id = "morale_num",
    label = ccb.content.text("Morale"),
    variable = "morale_level",
    style = "number",
}

-- Uses display::morale_face_color
ccb.content.define_widget {
    id = "mood_desc_label",
    label = ccb.content.text("Mood"),
    style = "text",
    variable = "mood_text",
}

ccb.content.define_widget {
    id = "mood_desc_no_label",
    copy_from = "mood_desc_label",
    flags = { "W_LABEL_NONE" },
}
