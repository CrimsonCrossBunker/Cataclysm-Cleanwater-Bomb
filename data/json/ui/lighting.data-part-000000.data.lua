local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "lighting_desc",
    label = ccb.content.text("Lighting"),
    style = "text",
    clauses = {
        {
            id = "bright",
            text = ccb.content.text("bright"),
            color = "yellow",
            when = reading.compare("fine_detail_vision_mod", "<=", 1),
        },
        {
            id = "cloudy",
            text = ccb.content.text("cloudy"),
            color = "white",
            when = reading.compare("fine_detail_vision_mod", "==", 2),
        },
        {
            id = "shady",
            text = ccb.content.text("shady"),
            color = "light_gray",
            when = reading.compare("fine_detail_vision_mod", "==", 3),
        },
        {
            id = "dark",
            text = ccb.content.text("dark"),
            color = "dark_gray",
            when = reading.compare("fine_detail_vision_mod", "==", 4),
        },
        {
            id = "very dark",
            text = ccb.content.text("very dark"),
            color = "black_white",
            when = reading.compare("fine_detail_vision_mod", ">=", 5),
        },
    },
}
