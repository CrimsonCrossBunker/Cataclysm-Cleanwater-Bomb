local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "moon_phase_desc",
    label = ccb.content.text("Moon"),
    style = "text",
    clauses = {
        { id = "new_moon", text = ccb.content.text("New moon"), color = "white", when = reading.compare("moon_phase", "==", 0) },
        {
            id = "waxing_crescent",
            text = ccb.content.text("Waxing crescent"),
            color = "white",
            when = reading.compare("moon_phase", "==", 1),
        },
        {
            id = "half_moon",
            text = ccb.content.text("Half moon"),
            color = "white",
            when = reading.compare("moon_phase", "==", 2),
        },
        {
            id = "waxing_gibbous",
            text = ccb.content.text("Waxing gibbous"),
            color = "white",
            when = reading.compare("moon_phase", "==", 3),
        },
        {
            id = "full_moon",
            text = ccb.content.text("Full moon"),
            color = "white",
            when = reading.compare("moon_phase", "==", 4),
        },
        {
            id = "waning_gibbous",
            text = ccb.content.text("Waning gibbous"),
            color = "white",
            when = reading.compare("moon_phase", "==", 5),
        },
        {
            id = "half_moon",
            text = ccb.content.text("Half moon"),
            color = "white",
            when = reading.compare("moon_phase", "==", 6),
        },
        {
            id = "waning_crescent",
            text = ccb.content.text("Waning crescent"),
            color = "white",
            when = reading.compare("moon_phase", "==", 7),
        },
        {
            id = "dark_moon",
            text = ccb.content.text("Dark moon"),
            color = "white",
            when = reading.compare("moon_phase", "==", 8),
        },
    },
}

ccb.content.define_widget {
    id = "moon_phase_graph",
    label = ccb.content.text("Moon"),
    style = "text",
    clauses = {
        { id = "new_moon", text = " -- ", color = "white", when = reading.compare("moon_phase", "==", 0) },
        { id = "waxing_crescent", text = "   ) ↑", color = "white", when = reading.compare("moon_phase", "==", 1) },
        { id = "half_moon", text = "  |) ↑", color = "white", when = reading.compare("moon_phase", "==", 2) },
        { id = "waxing_gibbous", text = " ||) ↑", color = "white", when = reading.compare("moon_phase", "==", 3) },
        { id = "full_moon", text = "(||)", color = "white", when = reading.compare("moon_phase", "==", 4) },
        { id = "waning_gibbous", text = "(||  ↓", color = "white", when = reading.compare("moon_phase", "==", 5) },
        { id = "half_moon", text = "(|   ↓", color = "white", when = reading.compare("moon_phase", "==", 6) },
        { id = "waning_crescent", text = "(    ↓", color = "white", when = reading.compare("moon_phase", "==", 7) },
        { id = "dark_moon", text = " -- ", color = "white", when = reading.compare("moon_phase", "==", 8) },
    },
}
