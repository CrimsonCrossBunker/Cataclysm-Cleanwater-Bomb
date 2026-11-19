local ccb = require("ccb")

ccb.content.define_widget {
    id = "environment_conditions_block",
    style = "layout",
    label = ccb.content.text("1_environment block"),
    arrange = "minimum_columns",
    width = 58,
    widgets = { "spacebar_separator_2", "environment_conditions_block_2", "spacebar_overmap_14x6_layout" },
}

ccb.content.define_widget {
    id = "environment_conditions_block_2",
    style = "layout",
    label = ccb.content.text("environment block"),
    arrange = "minimum_columns",
    width = 36,
    widgets = { "time_&_weather_layout" },
}

ccb.content.define_widget {
    id = "time_&_weather_layout",
    label = ccb.content.text("time"),
    style = "layout",
    arrange = "rows",
    width = 28,
    widgets = {
        "date_desc_label",
        "time_desc_label",
        "moon_phase_desc",
        "weather_desc",
        "lighting_desc",
        "env_temp_desc",
    },
}
