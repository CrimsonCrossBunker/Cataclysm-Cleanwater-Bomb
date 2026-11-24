local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_sundial_desc_no_label",
    style = "text",
    variable = "sundial_text",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_sun_bar",
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("Sky"),
    widgets = { "zenfs_sundial_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_sun_bar_42",
    copy_from = "zenfs_sun_bar",
    width = 42,
}

ccb.content.define_widget {
    id = "zenfs_sun_bar_43",
    copy_from = "zenfs_sun_bar",
    width = 43,
}

ccb.content.define_widget {
    id = "zenfs_sun_bar_51",
    copy_from = "zenfs_sun_bar",
    width = 51,
}

ccb.content.define_widget {
    id = "zenfs_moon_phase_text",
    style = "text",
    text_align = "right",
    clauses = {
        {
            id = "new_moon",
            text = ccb.content.text("New moon  "),
            color = "white",
            when = reading.compare("moon_phase", "==", 0),
        },
        {
            id = "waxing_crescent",
            text = ccb.content.text("Wax.crescent"),
            color = "white",
            when = reading.compare("moon_phase", "==", 1),
        },
        {
            id = "half_moon",
            text = ccb.content.text("Half moon  "),
            color = "white",
            when = reading.compare("moon_phase", "==", 2),
        },
        {
            id = "waxing_gibbous",
            text = ccb.content.text("Wax.gibbous "),
            color = "white",
            when = reading.compare("moon_phase", "==", 3),
        },
        {
            id = "full_moon",
            text = ccb.content.text("Full moon  "),
            color = "white",
            when = reading.compare("moon_phase", "==", 4),
        },
        {
            id = "waning_gibbous",
            text = ccb.content.text("Wan.gibbous "),
            color = "white",
            when = reading.compare("moon_phase", "==", 5),
        },
        {
            id = "half_moon",
            text = ccb.content.text("Half moon  "),
            color = "white",
            when = reading.compare("moon_phase", "==", 6),
        },
        {
            id = "waning_crescent",
            text = ccb.content.text("Wan.crescent"),
            color = "white",
            when = reading.compare("moon_phase", "==", 7),
        },
        {
            id = "dark_moon",
            text = ccb.content.text("Dark moon  "),
            color = "white",
            when = reading.compare("moon_phase", "==", 8),
        },
    },
}

ccb.content.define_widget {
    id = "zenfs_moon_phase_text_right",
    style = "text",
    text_align = "right",
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
