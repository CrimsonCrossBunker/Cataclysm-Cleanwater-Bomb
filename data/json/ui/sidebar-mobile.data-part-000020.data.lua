local ccb = require("ccb")

ccb.content.define_widget {
    id = "i_sound_graph",
    width = 5,
    style = "graph",
    fill = "bucket",
    symbols = " ▎▍▌▊▉▉███",
    variable = "sound",
    colors = { "c_green", "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "w_date",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_date", "date_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_time",
    width = 15,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_time", "sundial_time_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_time_moon",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_time", "l_space", "w_moon_phase" },
}

ccb.content.define_widget {
    id = "w_place",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "i_place_text" },
}

ccb.content.define_widget {
    id = "w_sky",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_sky", "weather_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_wind",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_wind", "wind_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_light_sound",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_light", "i_light_sym", "l_space", "l_sound", "i_sound_graph" },
}

ccb.content.define_widget {
    id = "w_temp",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_temp", "env_temp_desc_no_label" },
}

ccb.content.define_widget {
    id = "a_surrounding",
    width = 23,
    style = "layout",
    arrange = "rows",
    widgets = { "w_place", "w_date", "w_time_moon", "w_sky", "w_wind", "w_light_sound", "w_temp" },
}

ccb.content.define_widget {
    id = "l_str",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("S:", "label_strength"),
}

ccb.content.define_widget {
    id = "l_dex",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("D:", "label_dexterity"),
}

ccb.content.define_widget {
    id = "l_int",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("I:", "label_intelligence"),
}

ccb.content.define_widget {
    id = "l_per",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("P:", "label_perception"),
}

ccb.content.define_widget {
    id = "t_stat",
    width = 2,
    text_align = "right",
    style = "number",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_cyan", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "i_str_num",
    copy_from = "t_stat",
    variable = "stat_str",
}

ccb.content.define_widget {
    id = "i_dex_num",
    copy_from = "t_stat",
    variable = "stat_dex",
}

ccb.content.define_widget {
    id = "i_int_num",
    copy_from = "t_stat",
    variable = "stat_int",
}

ccb.content.define_widget {
    id = "i_per_num",
    copy_from = "t_stat",
    variable = "stat_per",
}

ccb.content.define_widget {
    id = "l_bpower",
    width = 3,
    copy_from = "t_label",
    text = ccb.content.text("BP:"),
}
