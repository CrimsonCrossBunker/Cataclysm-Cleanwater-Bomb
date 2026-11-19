local ccb = require("ccb")

ccb.content.define_widget {
    id = "w_weight_body",
    width = 7,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_space", "l_space", "l_space", "l_sw", "i_weight_graph", "l_se" },
}

ccb.content.define_widget {
    id = "w_weight_hunger_thrist",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_hunger_thrist", "w_weight_body" },
}

ccb.content.define_widget {
    id = "l_mood",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("M:"),
}

ccb.content.define_widget {
    id = "i_mood_num",
    width = 4,
    variable = "morale_level",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "l_focus",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("F:"),
}

ccb.content.define_widget {
    id = "i_focus_num",
    width = 4,
    variable = "focus",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "a_mood_focus",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_mood", "i_mood_num", "l_space", "l_focus", "i_focus_num" },
}

ccb.content.define_widget {
    id = "w_pain_mood_focus",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_mood_focus", "pain_desc_no_label" },
}

ccb.content.define_widget {
    id = "i_speed_num",
    width = 3,
    variable = "speed",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "i_basemovecost_num",
    width = 4,
    style = "number",
    variable = "move_cost",
    colors = { "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red", "c_red_red" },
}

ccb.content.define_widget {
    id = "i_move_mode_text",
    width = 1,
    style = "symbol",
    copy_from = "move_mode_template",
}

ccb.content.define_widget {
    id = "i_move_counter",
    width = 3,
    variable = "move",
    style = "number",
}

ccb.content.define_widget {
    id = "w_speed_mbmc_move_mode",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "i_speed_num",
        "l_space",
        "i_move_mode_text",
        "i_basemovecost_num",
        "l_space",
        "i_move_counter",
    },
}

ccb.content.define_widget {
    id = "l_stamina",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("S:", "label_stamina"),
}

ccb.content.define_widget {
    id = "i_stamina_graph",
    width = 11,
    copy_from = "t_horiz_graph",
    variable = "stamina",
    colors = { "h_light_gray" },
}

ccb.content.define_widget {
    id = "w_stamina",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_stamina", "i_stamina_graph" },
}

ccb.content.define_widget {
    id = "w_movement_stamina",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_speed_mbmc_move_mode", "w_stamina" },
}

ccb.content.define_widget {
    id = "l_safe_mode",
    width = 10,
    copy_from = "t_label",
    text = ccb.content.text("Safe mode:"),
}

ccb.content.define_widget {
    id = "i_safe_mode_text",
    width = 3,
    style = "text",
    variable = "safe_mode_text",
}

ccb.content.define_widget {
    id = "w_safe_mode",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_safe_mode", "i_safe_mode_text" },
}

ccb.content.define_widget {
    id = "l_rest",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("R:"),
}

ccb.content.define_widget {
    id = "i_rest_graph",
    width = 4,
    copy_from = "t_horiz_graph",
    variable = "sleepiness",
    colors = { "h_light_gray", "h_light_red" },
}

ccb.content.define_widget {
    id = "w_rest",
    width = 6,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_rest", "i_rest_graph" },
}

ccb.content.define_widget {
    id = "l_activity",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("A:"),
}
