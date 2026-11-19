local ccb = require("ccb")

ccb.content.define_widget {
    id = "thick_rs_column_cleaner",
    style = "layout",
    label = ccb.content.text("stacked"),
    arrange = "rows",
    widgets = {
        "ll_limbs_layout",
        "spacer",
        "ll_stats_layout",
        "sound_mood_focus_layout",
        "spacer",
        "stamina_speed_layout_full",
        "weary_rest_layout",
        "needs_layout_cleaner",
    },
}

ccb.content.define_widget {
    id = "thick_rs_column_more_graphs",
    style = "layout",
    label = ccb.content.text("stacked"),
    arrange = "rows",
    widgets = { "ll_limbs_layout", "spacer", "more_graphs_layout" },
}

ccb.content.define_widget {
    id = "thick_rs_column_cleaner_2",
    style = "layout",
    label = ccb.content.text("Status displays"),
    description = ccb.content.text("All sorts of <color_yellow>bars</color> and <color_yellow>numbers</color> about the player's status, 'not too little, not too much'."),
    arrange = "rows",
    widgets = {
        "ll_stats_layout",
        "sound_mood_focus_layout",
        "spacer",
        "stamina_speed_layout_full",
        "weary_rest_layout",
        "needs_layout_cleaner",
    },
}

ccb.content.define_widget {
    id = "more_graphs_layout",
    style = "layout",
    label = ccb.content.text("Extra body graphs"),
    arrange = "columns",
    description = ccb.content.text("Three <color_yellow>small body graphs</color> for status, encumbrance and temperature."),
    widgets = { "more_body_graph_status", "more_body_graph_temp", "more_body_graph_encumb" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "more_body_graph_status",
    style = "layout",
    arrange = "rows",
    widgets = { "more_body_graph_status_text", "structured_body_graph_status_layout" },
}

ccb.content.define_widget {
    id = "more_body_graph_temp",
    style = "layout",
    arrange = "rows",
    widgets = { "more_body_graph_temp_text", "structured_body_graph_temp_layout" },
}

ccb.content.define_widget {
    id = "more_body_graph_encumb",
    style = "layout",
    arrange = "rows",
    widgets = { "more_body_graph_encumb_text", "structured_body_graph_encumb_layout" },
}

ccb.content.define_widget {
    id = "spacer",
    style = "text",
    text = "",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "more_body_graph_status_text",
    style = "text",
    text = ccb.content.text(" Status"),
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "more_body_graph_temp_text",
    style = "text",
    text = ccb.content.text("Temperature"),
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "more_body_graph_encumb_text",
    style = "text",
    text = ccb.content.text("Encumbrance"),
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "stamina_speed_layout_full",
    style = "layout",
    arrange = "columns",
    widgets = { "stamina_graph", "speed_num" },
}

ccb.content.define_widget {
    id = "weary_rest_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "weariness_desc", "sleepiness_desc_label" },
}

ccb.content.define_widget {
    id = "needs_layout_cleaner",
    style = "layout",
    label = ccb.content.text("Needs"),
    arrange = "rows",
    widgets = { "pain_heat_layout", "thirst_hunger_label" },
}

ccb.content.define_widget {
    id = "pain_heat_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "pain_desc_label", "body_temp_desc_label" },
}

ccb.content.define_widget {
    id = "thirst_hunger_label",
    style = "layout",
    arrange = "columns",
    widgets = { "thirst_desc_label", "hunger_desc_label" },
}

ccb.content.define_widget {
    id = "thick_side_by_side_cleaner",
    style = "layout",
    label = ccb.content.text("Body + Details"),
    arrange = "minimum_columns",
    description = ccb.content.text("A large <color_yellow>health display</color> and details about the <color_yellow>player's status</color>, with the principle of 'not too little, not too much'."),
    widgets = { "thick_body_graph", "thick_rs_column_cleaner" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "thick_side_by_side_more_graphs",
    style = "layout",
    label = ccb.content.text("Body + More Graphs"),
    description = ccb.content.text("A large <color_yellow>health display</color> and health bars, as well as three <color_yellow>small body graphs</color> for status, encumbrance and temperature."),
    arrange = "minimum_columns",
    widgets = { "thick_body_graph", "thick_rs_column_more_graphs" },
}

ccb.content.define_widget {
    id = "my_labels_sidebar_cleaner",
    style = "sidebar",
    label = ccb.content.text("thick-cleaner"),
    description = ccb.content.text("An alternate thick sidebar. Restart required if using the extra body graphs."),
    separator = ": ",
    padding = 2,
    width = 66,
    widgets = {
        "thick_side_by_side_cleaner",
        "more_graphs_layout",
        "thick_side_by_side_more_graphs",
        "thick_rs_column_cleaner_2",
        "separator",
        "thick_side_by_side_2",
        "lcla_weapon_layout",
        "structured_style_ma_buffs_layout",
        "separator_disabled",
        "structured_mana_layout",
        "vehicle_acf_label_layout_columns",
        "oxygen_layout",
        "sundial_label_layout",
        "separator_disabled",
        "compass_all_layout",
    },
}
