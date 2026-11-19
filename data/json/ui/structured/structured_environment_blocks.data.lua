local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_time_moon_layout",
    label = ccb.content.text("Date/Time/Moon"),
    description = ccb.content.text("Shows date, time, and moon phase."),
    style = "layout",
    arrange = "columns",
    separator = ": ",
    widgets = { "date_desc_no_label", "structured_time_layout", "moon_phase_graph" },
}

ccb.content.define_widget {
    id = "structured_weather_layout",
    style = "layout",
    label = ccb.content.text("Weather"),
    description = ccb.content.text("Shows weather, light and wind."),
    arrange = "columns",
    widgets = { "weather_desc_no_label", "structured_lighting_layout", "structured_wind_layout" },
}

ccb.content.define_widget {
    id = "structured_place_sound_layout",
    style = "layout",
    label = ccb.content.text("Place/Sound"),
    description = ccb.content.text("Shows the current location and sound emitted."),
    arrange = "columns",
    separator = ": ",
    widgets = { "structured_place_layout", "structured_sound_layout" },
}

ccb.content.define_widget {
    id = "structured_time_layout",
    style = "layout",
    arrange = "rows",
    width = 10,
    widgets = { "sundial_time_desc_no_label" },
}

ccb.content.define_widget {
    id = "structured_lighting_layout",
    style = "layout",
    arrange = "rows",
    width = 10,
    widgets = { "lighting_desc_no_label" },
}

ccb.content.define_widget {
    id = "structured_wind_layout",
    style = "layout",
    arrange = "rows",
    width = 18,
    widgets = { "wind_desc_no_label" },
}

ccb.content.define_widget {
    id = "structured_place_layout",
    style = "layout",
    arrange = "rows",
    width = 26,
    widgets = { "structured_place_desc" },
}

ccb.content.define_widget {
    id = "structured_sound_layout",
    style = "layout",
    arrange = "rows",
    width = 10,
    widgets = { "sound_num" },
}

ccb.content.define_widget {
    id = "structured_place_desc",
    copy_from = "place_desc",
    flags = { "W_LABEL_NONE" },
}
