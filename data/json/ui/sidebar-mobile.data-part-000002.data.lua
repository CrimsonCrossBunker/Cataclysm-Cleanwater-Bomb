local ccb = require("ccb")

ccb.content.define_widget {
    id = "t_vert_graph",
    width = 1,
    style = "graph",
    symbols = " ▁▂▃▄▅▆▇█",
    fill = "bucket",
}

ccb.content.define_widget {
    id = "t_horiz_graph",
    width = 5,
    style = "graph",
    symbols = " ▏▎▍▍▌▋▊▉█",
    fill = "bucket",
}

ccb.content.define_widget {
    id = "t_bp_wet_graph",
    width = 1,
    copy_from = "t_vert_graph",
    variable = "bp_wetness",
    colors = { "h_dark_gray", "h_cyan", "h_light_cyan" },
}

ccb.content.define_widget {
    id = "i_bp_HD_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "t_bp_enc_graph",
    width = 1,
    copy_from = "t_vert_graph",
    variable = "bp_encumb",
    symbols = " ▂▄▆▇▇▇██████",
    colors = { "h_dark_gray", "h_yellow", "h_light_red" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "i_splinted_sym",
    width = 1,
    style = "symbol",
    text = ccb.content.text_without_extraction("‡"),
    colors = { "h_white" },
}

ccb.content.define_widget {
    id = "i_bp_HD_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "arm_l",
}
