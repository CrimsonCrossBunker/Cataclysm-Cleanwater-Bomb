local ccb = require("ccb")

ccb.content.define_widget {
    id = "places_compass_block_danger",
    style = "layout",
    label = ccb.content.text("6_compass danger"),
    arrange = "minimum_columns",
    width = 58,
    widgets = { "spacebar_separator_2", "places_compass_block_danger_tmp" },
}

ccb.content.define_widget {
    id = "places_compass_block_danger_tmp",
    style = "layout",
    label = ccb.content.text("movement"),
    arrange = "rows",
    width = 56,
    widgets = { "places_koordinates_block", "compass_block_danger" },
}

ccb.content.define_widget {
    id = "separator_tmp",
    style = "layout",
    label = ccb.content.text("compass"),
    arrange = "minimum_columns",
    width = 58,
    widgets = { "spacebar_separator_4", "spacebar_separator_42" },
}

ccb.content.define_widget {
    id = "places_koordinates_block",
    style = "layout",
    label = ccb.content.text("movement"),
    arrange = "minimum_columns",
    width = 56,
    widgets = { "place_desc", "overmap_location_desc" },
}

ccb.content.define_widget {
    id = "compass_block_danger",
    style = "layout",
    label = ccb.content.text("movement"),
    arrange = "minimum_columns",
    width = 56,
    widgets = { "spacebar_compass_all_danger_layout", "compass_legend" },
}

ccb.content.define_widget {
    id = "compass_legend",
    label = ccb.content.text("Compass"),
    style = "layout",
    width = 28,
    arrange = "rows",
    widgets = { "compass_legend_text" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "spacebar_compass_all_danger_layout",
    label = ccb.content.text("Compass"),
    style = "layout",
    arrange = "rows",
    widgets = { "compass_top_danger_layout", "compass_middle_danger_layout", "compass_bottom_danger_layout" },
}
