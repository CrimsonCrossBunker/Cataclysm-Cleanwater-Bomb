local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_bionicpower_label",
    style = "text",
    text = ccb.content.text("Power"),
    width = 5,
    clauses = {
        { id = "label_invisible", text = "     ", color = "c_black", when = reading.compare("power_max", "<=", 0) },
        {
            id = "label_visible",
            text = ccb.content.text("Power"),
            color = "c_light_gray",
            when = reading.compare("power_max", ">", 0),
        },
    },
    flags = { "W_LABEL_NONE" },
    padding = 0,
}
