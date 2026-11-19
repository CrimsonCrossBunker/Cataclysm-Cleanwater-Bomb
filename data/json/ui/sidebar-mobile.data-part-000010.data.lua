local ccb = require("ccb")

ccb.content.define_widget {
    id = "t_bp_warmth_graph",
    width = 1,
    copy_from = "t_vert_graph",
    variable = "bp_warmth",
    symbols = "▼∨∙∧▲",
    colors = { "h_light_cyan", "h_cyan", "h_dark_gray", "h_light_red", "h_red" },
}

ccb.content.define_widget {
    id = "i_bp_HD_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "t_bp_hp_graph",
    width = 7,
    copy_from = "t_horiz_graph",
    variable = "bp_hp",
    colors = { "h_red", "h_light_red", "h_yellow", "h_light_green", "h_green" },
}

ccb.content.define_widget {
    id = "i_bp_HD_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "leg_r",
}

-- NO_I18N
ccb.content.define_widget {
    id = "t_bp_broken_sym",
    width = 7,
    style = "symbol",
    colors = { "c_white_red" },
    text = ccb.content.text_without_extraction("══╾⠡╼══"),
}

ccb.content.define_widget {
    id = "i_bp_HD_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "head",
    text = ccb.content.text("d e a d"),
}

ccb.content.define_widget {
    id = "i_bp_CT_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "torso",
    text = ccb.content.text("d e a d"),
}

ccb.content.define_widget {
    id = "i_bp_LA_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "leg_r",
}
