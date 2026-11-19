local ccb = require("ccb")

ccb.content.define_widget {
    id = "i_bp_HD_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "leg_r",
}
