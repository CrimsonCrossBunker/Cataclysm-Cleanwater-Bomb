local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "i_moon_phase_text",
    width = 5,
    style = "symbol",
    clauses = {
        { id = "new_moon", symbol = "⎛   ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 0) },
        { id = "waxing_crescent1", symbol = "⎛  ", color = "c_light_gray", when = reading.compare("moon_phase", "==", 1) },
        { id = "waxing_crescent2", symbol = "▊⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 1) },
        { id = "half_moon1", symbol = "⎛ ▐", color = "c_light_gray", when = reading.compare("moon_phase", "==", 2) },
        { id = "half_moon2", symbol = "⡡⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 2) },
        { id = "waxing_gibbous1", symbol = "⎛", color = "c_light_gray", when = reading.compare("moon_phase", "==", 3) },
        { id = "waxing_gibbous2", symbol = "▎⢁⡡⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 4) },
        { id = "full_moon", symbol = "⎛⡐⢁⡡⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 4) },
        { id = "waning_gibbous1", symbol = "⎛⡐⢁", color = "c_black_white", when = reading.compare("moon_phase", "==", 5) },
        { id = "waning_gibbous2", symbol = "▎⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 5) },
        { id = "half_moon1", symbol = "⎛⡐", color = "c_black_white", when = reading.compare("moon_phase", "==", 6) },
        { id = "half_moon2", symbol = "▌ ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 6) },
        { id = "waning_crescent1", symbol = "⎛", color = "c_black_white", when = reading.compare("moon_phase", "==", 7) },
        { id = "waning_crescent2", symbol = "▎  ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 7) },
        { id = "dark_moon", symbol = "⎛   ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 8) },
    },
}

ccb.content.define_widget {
    id = "w_moon_phase",
    width = 7,
    style = "layout",
    arrange = "minimum_columns",
    clauses = {
        { id = "hide", when = predicate.conversation_state("daylight"), widgets = { "l_space" } },
        {
            id = "show",
            when = predicate.negate(predicate.conversation_state("daylight")),
            widgets = { "l_moon_phase_left", "i_moon_phase_text", "l_moon_phase_right" },
        },
    },
}
