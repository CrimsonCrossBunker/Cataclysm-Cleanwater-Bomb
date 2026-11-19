local ccb = require("ccb")

ccb.content.define_widget {
    id = "overmap_full_width",
    label = ccb.content.text("Overmap"),
    variable = "overmap_text",
    style = "text",
    width = 0,
    height = 7,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "overmap_location_desc",
    label = ccb.content.text("Location"),
    variable = "overmap_loc_text",
    style = "text",
    flags = { "W_LABEL_NONE" },
}
