local ccb = require("ccb")

ccb.content.define_widget {
    id = "a_bp_HD_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_HD_wet_graph",
        "i_bp_HD_enc_graph",
        "i_bp_HD_warmth_graph",
        "l_sc_cl",
        "i_bp_HD_status_sym",
        "i_stunned_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_CT_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_CT_wet_graph",
        "i_bp_CT_enc_graph",
        "i_bp_CT_warmth_graph",
        "l_sc_cl",
        "i_bp_CT_status_sym",
        "i_hypovolemia_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_LA_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_LA_wet_graph",
        "a_bp_LA_enc_splint",
        "i_bp_LA_warmth_graph",
        "l_sc_cl",
        "i_bp_LA_status_sym",
        "i_bp_LA_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_RA_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_RA_wet_graph",
        "a_bp_RA_enc_splint",
        "i_bp_RA_warmth_graph",
        "l_sc_cl",
        "i_bp_RA_status_sym",
        "i_bp_RA_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_LL_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_LL_wet_graph",
        "a_bp_LL_enc_splint",
        "i_bp_LL_warmth_graph",
        "l_sc_cl",
        "i_bp_LL_status_sym",
        "i_bp_LL_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_RL_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_RL_wet_graph",
        "a_bp_RL_enc_splint",
        "i_bp_RL_warmth_graph",
        "l_sc_cl",
        "i_bp_RL_status_sym",
        "i_bp_RL_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "w_bp_LA_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_LA_row1", "a_bp_LA_row2" },
}

ccb.content.define_widget {
    id = "w_bp_HD_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_HD_row1", "a_bp_HD_row2" },
}

ccb.content.define_widget {
    id = "w_bp_RA_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_RA_row1", "a_bp_RA_row2" },
}

ccb.content.define_widget {
    id = "w_bp_LL_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_LL_row1", "a_bp_LL_row2" },
}

ccb.content.define_widget {
    id = "w_bp_CT_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_CT_row1", "a_bp_CT_row2" },
}

ccb.content.define_widget {
    id = "w_bp_RL_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_RL_row1", "a_bp_RL_row2" },
}

ccb.content.define_widget {
    id = "a_vert_divider_7",
    width = 1,
    style = "layout",
    arrange = "rows",
    widgets = { "l_space" },
}

ccb.content.define_widget {
    id = "a_vert_divider_bp",
    width = 1,
    style = "layout",
    arrange = "rows",
    widgets = { "l_space", "l_space" },
}

ccb.content.define_widget {
    id = "w_overmap_7x7",
    width = 7,
    height = 7,
    style = "text",
    variable = "overmap_text",
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_moon_phase_left",
    width = 1,
    copy_from = "t_label",
    text = ccb.content.text_without_extraction("["),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_moon_phase_right",
    width = 1,
    copy_from = "t_label",
    text = ccb.content.text_without_extraction("]"),
}
