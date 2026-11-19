local ccb = require("ccb")

ccb.content.define_widget {
    id = "player_weariness_mood_block",
    style = "layout",
    label = ccb.content.text("3_weari_mood_block"),
    arrange = "minimum_columns",
    width = 58,
    widgets = { "spacebar_separator_2", "player_weariness_mood_block_tmp" },
}

ccb.content.define_widget {
    id = "player_weariness_mood_block_tmp",
    style = "layout",
    label = ccb.content.text("Mood/Focus/Weariness"),
    arrange = "minimum_columns",
    width = 56,
    widgets = { "spacebar_mood_focus_activity_layout", "spacebar_all_weariness_layout" },
}

ccb.content.define_widget {
    id = "spacebar_all_weariness_layout",
    style = "layout",
    label = ccb.content.text("Weariness"),
    label_align = "right",
    arrange = "rows",
    width = 28,
    widgets = { "weariness_desc", "spacebar_weariness_transition_graph", "weary_malus_desc" },
}

ccb.content.define_widget {
    id = "spacebar_weariness_transition_graph",
    label = ccb.content.text("Transition"),
    style = "graph",
    symbols = ".oO",
    width = 5,
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    variable = "weary_transition_level",
}

ccb.content.define_widget {
    id = "spacebar_mood_focus_activity_layout",
    style = "layout",
    label = ccb.content.text("Mood/Focus/Activity"),
    arrange = "rows",
    width = 28,
    widgets = { "mood_desc_label", "spacebar_focus_graph", "activity_desc" },
}

ccb.content.define_widget {
    id = "spacebar_focus_graph",
    label = ccb.content.text("Focus"),
    style = "graph",
    variable = "focus",
    symbols = ".oO",
    fill = "bucket",
    width = 5,
    colors = { "c_red", "c_yellow", "c_green" },
}
