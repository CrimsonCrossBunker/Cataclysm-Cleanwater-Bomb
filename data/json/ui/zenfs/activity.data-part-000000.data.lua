local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_activity_desc",
    label = ccb.content.text("Activity"),
    style = "text",
    width = 10,
    text_align = "right",
    clauses = {
        {
            id = "none",
            text = ccb.content.text("Negligible", "activity description"),
            color = "dark_gray",
            when = reading.compare("activity_level", "==", 0),
        },
        {
            id = "light",
            text = ccb.content.text("Light", "activity description"),
            color = "green",
            when = reading.compare("activity_level", "==", 1),
        },
        {
            id = "moderate",
            text = ccb.content.text("Moderate", "activity description"),
            color = "light_green",
            when = reading.compare("activity_level", "==", 2),
        },
        {
            id = "brisk",
            text = ccb.content.text("Brisk", "activity description"),
            color = "yellow",
            when = reading.compare("activity_level", "==", 3),
        },
        {
            id = "active",
            text = ccb.content.text("Intense", "activity description"),
            color = "light_red",
            when = reading.compare("activity_level", "==", 4),
        },
        {
            id = "extreme",
            text = ccb.content.text("Extreme", "activity description"),
            color = "red",
            when = reading.compare("activity_level", "==", 5),
        },
    },
}
