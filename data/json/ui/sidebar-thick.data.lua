local ccb = require("ccb")

ccb.content.define_widget {
    id = "thick_rs_column",
    style = "layout",
    label = ccb.content.text("stacked"),
    arrange = "rows",
    widgets = {
        "ll_limbs_layout",
        "ll_movement_layout",
        "ll_stats_layout",
        "all_weariness_layout",
        "ll_needs_layout",
        "wind_temp_layout",
        "power_desc",
    },
}

ccb.content.define_widget {
    id = "thick_rs_column_sa",
    style = "layout",
    label = ccb.content.text("stacked"),
    arrange = "rows",
    widgets = {
        "ll_limbs_sa_layout",
        "ll_movement_layout",
        "ll_stats_layout",
        "all_weariness_layout",
        "ll_needs_sa_layout",
        "wind_temp_layout",
        "power_desc",
    },
}

ccb.content.define_widget {
    id = "thick_rs_column_2",
    style = "layout",
    label = ccb.content.text("stacked"),
    arrange = "rows",
    widgets = { "all_location_info_rows_layout", "rad_badge_desc" },
}

ccb.content.define_widget {
    id = "thick_side_by_side",
    style = "layout",
    label = ccb.content.text("Body + Details"),
    arrange = "minimum_columns",
    widgets = { "thick_body_graph", "thick_rs_column" },
}

ccb.content.define_widget {
    id = "thick_side_by_side_sa",
    style = "layout",
    label = ccb.content.text("Body + Details (num)"),
    arrange = "minimum_columns",
    widgets = { "thick_body_graph", "thick_rs_column_sa" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "thick_side_by_side_2",
    style = "layout",
    label = ccb.content.text("Location Info"),
    arrange = "minimum_columns",
    widgets = { "overmap_full_width", "thick_rs_column_2" },
}

ccb.content.define_widget {
    id = "thick_body_graph",
    label = ccb.content.text("Body Graph"),
    variable = "body_graph",
    style = "text",
    width = 13,
    height = 13,
    flags = { "W_LABEL_NONE", "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "my_labels_sidebar",
    style = "sidebar",
    label = ccb.content.text("thick"),
    separator = ": ",
    padding = 2,
    width = 66,
    widgets = {
        "thick_side_by_side",
        "thick_side_by_side_sa",
        "thick_side_by_side_2",
        "vehicle_acf_label_layout_columns",
        "oxygen_layout",
        "sundial_label_layout",
        "compass_all_layout",
    },
}
