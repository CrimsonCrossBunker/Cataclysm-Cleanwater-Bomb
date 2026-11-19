local ccb = require("ccb")

ccb.content.define_widget {
    id = "a_stat_row1",
    width = 9,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_str", "i_str_num", "l_space", "l_dex", "i_dex_num" },
}

ccb.content.define_widget {
    id = "a_stat_row2",
    width = 9,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_int", "i_int_num", "l_space", "l_per", "i_per_num" },
}

-- TODO: Add mana widgets
ccb.content.define_widget {
    id = "a_stat_row3",
    width = 9,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bpower", "l_space" },
}

ccb.content.define_widget {
    id = "w_stats",
    width = 9,
    style = "layout",
    arrange = "rows",
    widgets = { "a_stat_row1", "a_stat_row2", "a_stat_row3", "vehicle_acf_no_label_layout" },
}

ccb.content.define_widget {
    id = "l_hunger",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("H:"),
}
