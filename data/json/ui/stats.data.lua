local ccb = require("ccb")

-- Base widget for stats
ccb.content.define_widget {
    id = "stat_number",
    style = "number",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_cyan", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "str_num",
    label = ccb.content.text("Str"),
    variable = "stat_str",
    copy_from = "stat_number",
}

ccb.content.define_widget {
    id = "str_num_no_label",
    copy_from = "str_num",
    text_align = "right",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "dex_num",
    label = ccb.content.text("Dex"),
    variable = "stat_dex",
    copy_from = "stat_number",
}

ccb.content.define_widget {
    id = "dex_num_no_label",
    copy_from = "dex_num",
    text_align = "right",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "int_num",
    label = ccb.content.text("Int"),
    variable = "stat_int",
    copy_from = "stat_number",
}

ccb.content.define_widget {
    id = "int_num_no_label",
    copy_from = "int_num",
    text_align = "right",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "per_num",
    label = ccb.content.text("Per"),
    variable = "stat_per",
    copy_from = "stat_number",
}

ccb.content.define_widget {
    id = "per_num_no_label",
    copy_from = "per_num",
    text_align = "right",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "stats_layout",
    style = "layout",
    label = ccb.content.text("Stats"),
    arrange = "columns",
    widgets = { "str_num", "dex_num", "int_num", "per_num" },
}

ccb.content.define_widget {
    id = "str_dex_layout",
    style = "layout",
    label = ccb.content.text("Str/Dex"),
    arrange = "columns",
    widgets = { "str_num", "dex_num" },
}

ccb.content.define_widget {
    id = "int_per_layout",
    style = "layout",
    label = ccb.content.text("Int/Per"),
    arrange = "columns",
    widgets = { "int_num", "per_num" },
}

ccb.content.define_widget {
    id = "stats_no_label_layout",
    style = "layout",
    label = ccb.content.text("Stats"),
    arrange = "columns",
    widgets = { "str_num_no_label", "dex_num_no_label", "int_num_no_label", "per_num_no_label" },
}
