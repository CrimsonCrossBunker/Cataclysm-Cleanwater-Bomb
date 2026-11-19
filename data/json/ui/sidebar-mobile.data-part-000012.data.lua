local ccb = require("ccb")

ccb.content.define_widget {
    id = "i_bp_LA_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "leg_r",
}
