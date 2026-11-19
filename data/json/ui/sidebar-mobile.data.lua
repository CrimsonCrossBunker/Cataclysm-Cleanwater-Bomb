local ccb = require("ccb")

ccb.content.define_widget {
    id = "w_activity",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_activity", "i_activity_text" },
}

ccb.content.define_widget {
    id = "l_wmalus",
    width = 8,
    copy_from = "t_label",
    text = ccb.content.text("W.Malus:"),
}

ccb.content.define_widget {
    id = "i_wmalus_text",
    width = 5,
    style = "text",
    variable = "weary_malus_text",
}

ccb.content.define_widget {
    id = "w_wmalus",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_wmalus", "i_wmalus_text" },
}

ccb.content.define_widget {
    id = "l_weary",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("W:", "label_weary"),
}

ccb.content.define_widget {
    id = "i_weary_graph",
    width = 4,
    copy_from = "t_horiz_graph",
    variable = "weariness_level",
    colors = { "h_yellow", "h_yellow", "h_light_red", "h_red", "h_red", "h_red", "h_red" },
}

ccb.content.define_widget {
    id = "w_weary",
    width = 6,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_weary", "i_weary_graph" },
}

ccb.content.define_widget {
    id = "l_wtrns",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("W:", "label_weary"),
}

ccb.content.define_widget {
    id = "i_wtrns_graph",
    width = 11,
    copy_from = "t_horiz_graph",
    variable = "weary_transition_level",
    colors = { "h_light_gray" },
}

ccb.content.define_widget {
    id = "w_wtrns",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_wtrns", "i_wtrns_graph" },
}

ccb.content.define_widget {
    id = "l_weight",
    width = 9,
    copy_from = "t_label",
    text = ccb.content.text("Weight : "),
}

ccb.content.define_widget {
    id = "i_weight",
    width = 3,
    text_align = "right",
    variable = "carry_weight_text",
    style = "text",
}

ccb.content.define_widget {
    id = "w_weight_carried",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_weight", "i_weight" },
}

ccb.content.define_widget {
    id = "w_act_safe",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_activity", "w_safe_mode" },
}

ccb.content.define_widget {
    id = "w_wgrph_rgrph",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_weary", "l_space", "w_rest" },
}

ccb.content.define_widget {
    id = "w_weight_wmalus",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_weight_carried", "w_wmalus" },
}

ccb.content.define_widget {
    id = "w_wtrns_wgrph_rgrph",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_wtrns", "w_wgrph_rgrph" },
}

ccb.content.define_widget {
    id = "a_wht_hd_pmf",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_weight_hunger_thrist",
        "a_vert_divider_bp",
        "w_bp_HD_status",
        "a_vert_divider_bp",
        "w_pain_mood_focus",
    },
}

ccb.content.define_widget {
    id = "a_la_ct_ra",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_bp_LA_status",
        "a_vert_divider_bp",
        "w_bp_CT_status",
        "a_vert_divider_bp",
        "w_bp_RA_status",
    },
}

ccb.content.define_widget {
    id = "a_ll_sms_rl",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_bp_LL_status",
        "a_vert_divider_bp",
        "w_movement_stamina",
        "a_vert_divider_bp",
        "w_bp_RL_status",
    },
}

ccb.content.define_widget {
    id = "a_rs_act_wt",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_act_safe",
        "a_vert_divider_bp",
        "w_wtrns_wgrph_rgrph",
        "a_vert_divider_bp",
        "w_weight_wmalus",
    },
}

ccb.content.define_widget {
    id = "a_wht_la_ll_rs",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_weight_hunger_thrist", "w_bp_LA_status", "w_bp_LL_status", "w_act_safe" },
}

ccb.content.define_widget {
    id = "a_hd_ct_sms_act",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_bp_HD_status", "w_bp_CT_status", "w_movement_stamina", "w_weight_wmalus" },
}

ccb.content.define_widget {
    id = "a_pmf_ra_rl_wt",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_pain_mood_focus", "w_bp_RA_status", "w_bp_RL_status", "w_wtrns_wgrph_rgrph" },
}

ccb.content.define_widget {
    id = "a_ma",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "style_desc_no_label", "ma_buff_legend" },
}

ccb.content.define_widget {
    id = "w_compass",
    width = 27,
    style = "layout",
    arrange = "rows",
    widgets = {
        "compass_top_danger_layout",
        "compass_middle_danger_layout",
        "compass_bottom_danger_layout",
        "compass_legend_text_alt",
    },
}

ccb.content.define_widget {
    id = "a_compass_ma",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_compass", "a_ma" },
}

ccb.content.define_widget {
    id = "r_1",
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("! Location info"),
    widgets = { "w_overmap_7x7", "a_vert_divider_7", "a_surrounding", "a_vert_divider_7", "w_stats" },
}

ccb.content.define_widget {
    id = "r_2",
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("! Player status"),
    widgets = { "a_wht_hd_pmf", "a_la_ct_ra", "a_ll_sms_rl", "a_rs_act_wt" },
}

ccb.content.define_widget {
    id = "r_2_alt",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("! Alt Player status"),
    widgets = { "a_wht_la_ll_rs", "a_hd_ct_sms_act", "a_pmf_ra_rl_wt" },
}

ccb.content.define_widget {
    id = "r_separator-top",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("separator-top"),
    widgets = { "l_div1" },
}

ccb.content.define_widget {
    id = "r_separator-bottom",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("separator-bottom"),
    widgets = { "l_div2" },
}

ccb.content.define_widget {
    id = "r_separator-space",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("separator-space"),
    widgets = { "l_space" },
}

ccb.content.define_widget {
    id = "r_3",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("! MA, buffs, compass"),
    widgets = { "wielding_desc_no_label", "a_compass_ma" },
}

ccb.content.define_widget {
    id = "sidebar-mobile",
    width = 43,
    style = "sidebar",
    description = ccb.content.text("This one intended for mobile use where every symbol counts. Fixed data takes 22 lines and 43 symbols width. "),
    separator = ": ",
    padding = 0,
    label = ccb.content.text("mobile", "UI sidebar"),
    widgets = { "r_1", "r_separator-space", "r_2", "r_separator-space", "r_3", "oxygen_classic_layout" },
}
