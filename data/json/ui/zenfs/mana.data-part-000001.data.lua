local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_mana_label_M",
    style = "text",
    width = 1,
    clauses = {
        { id = "label_invisible", text = " ", color = "c_black", when = reading.compare("mana_max", "<=", 0) },
        {
            id = "label_visible",
            text = ccb.content.text("M"),
            color = "c_light_gray",
            when = reading.compare("mana_max", ">", 0),
        },
    },
    flags = { "W_LABEL_NONE" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_mana_label_4",
    style = "text",
    width = 4,
    clauses = {
        { id = "label_invisible", text = "    ", color = "c_black", when = reading.compare("mana_max", "<=", 0) },
        {
            id = "label_visible",
            text = ccb.content.text("Mana"),
            color = "c_light_gray",
            when = reading.compare("mana_max", ">", 0),
        },
    },
    flags = { "W_LABEL_NONE" },
    padding = 0,
}
