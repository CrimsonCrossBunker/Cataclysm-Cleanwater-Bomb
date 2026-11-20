local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "i_activity_text",
    width = 11,
    text_align = "right",
    style = "text",
    clauses = {
        {
            id = "none",
            text = ccb.content.text("None       "),
            color = "light_gray",
            when = reading.compare("activity_level", "==", 0),
        },
        {
            id = "light",
            text = ccb.content.text("Light      "),
            color = "yellow",
            when = reading.compare("activity_level", "==", 1),
        },
        {
            id = "moderate",
            text = ccb.content.text("Moderate   "),
            color = "yellow",
            when = reading.compare("activity_level", "==", 2),
        },
        {
            id = "brisk",
            text = ccb.content.text("Brisk      "),
            color = "light_red",
            when = reading.compare("activity_level", "==", 3),
        },
        {
            id = "active",
            text = ccb.content.text("Active     "),
            color = "light_red",
            when = reading.compare("activity_level", "==", 4),
        },
        {
            id = "extreme",
            text = ccb.content.text("Extreme    "),
            color = "red",
            when = reading.compare("activity_level", ">=", 5),
        },
    },
}
