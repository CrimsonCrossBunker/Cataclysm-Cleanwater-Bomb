local ccb = require("ccb")

-- Base widget for showing body part status; needs bodypart field defined in derived widget.
-- NO_I18N
ccb.content.define_widget {
    id = "bodypart_status_text",
    style = "text",
    default_clause = { text = ccb.content.text_without_extraction("--") },
    copy_from = "bodypart_status_indicator_template",
}

-- Base widget for body part status symbols; needs bodypart field defined in derived widget.
ccb.content.define_widget {
    id = "bodypart_status_sym_text",
    style = "symbol",
    text_align = "left",
    copy_from = "bodypart_status_indicator_template",
}

ccb.content.define_widget {
    id = "bp_status_head_text",
    label = ccb.content.text("HEAD"),
    bodypart = "head",
    copy_from = "bodypart_status_text",
}

ccb.content.define_widget {
    id = "bp_status_torso_text",
    label = ccb.content.text("TORSO"),
    bodypart = "torso",
    copy_from = "bodypart_status_text",
}

ccb.content.define_widget {
    id = "bp_status_left_arm_text",
    label = ccb.content.text("L ARM"),
    bodypart = "arm_l",
    copy_from = "bodypart_status_text",
}

ccb.content.define_widget {
    id = "bp_status_right_arm_text",
    label = ccb.content.text("R ARM"),
    bodypart = "arm_r",
    copy_from = "bodypart_status_text",
}

ccb.content.define_widget {
    id = "bp_status_left_leg_text",
    label = ccb.content.text("L LEG"),
    bodypart = "leg_l",
    copy_from = "bodypart_status_text",
}

ccb.content.define_widget {
    id = "bp_status_right_leg_text",
    label = ccb.content.text("R LEG"),
    bodypart = "leg_r",
    copy_from = "bodypart_status_text",
}

ccb.content.define_widget {
    id = "bp_status_sym_head_text",
    label = ccb.content.text("HEAD"),
    bodypart = "head",
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "bp_status_sym_torso_text",
    label = ccb.content.text("TORSO"),
    bodypart = "torso",
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "bp_status_sym_left_arm_text",
    label = ccb.content.text("L ARM"),
    bodypart = "arm_l",
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "bp_status_sym_right_arm_text",
    label = ccb.content.text("R ARM"),
    bodypart = "arm_r",
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "bp_status_sym_left_leg_text",
    label = ccb.content.text("L LEG"),
    bodypart = "leg_l",
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "bp_status_sym_right_leg_text",
    label = ccb.content.text("R LEG"),
    bodypart = "leg_r",
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "bp_status_legend_text",
    label = ccb.content.text("Status Legend"),
    style = "legend",
    bodyparts = { "head", "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
    copy_from = "bodypart_status_indicator_template",
    width = 0,
    height = 3,
    text_align = "left",
    flags = { "W_LABEL_NONE", "W_DYNAMIC_HEIGHT" },
}

ccb.content.define_widget {
    id = "bodypart_status_top_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "bp_status_left_arm_text", "bp_status_head_text", "bp_status_right_arm_text" },
}

ccb.content.define_widget {
    id = "bodypart_status_bottom_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "bp_status_left_leg_text", "bp_status_torso_text", "bp_status_right_leg_text" },
}

ccb.content.define_widget {
    id = "bodypart_status_top_sym_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "bp_status_sym_left_arm_text", "bp_status_sym_head_text", "bp_status_sym_right_arm_text" },
}

ccb.content.define_widget {
    id = "bodypart_status_bottom_sym_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "bp_status_sym_left_leg_text", "bp_status_sym_torso_text", "bp_status_sym_right_leg_text" },
}

ccb.content.define_widget {
    id = "bodypart_status_layout",
    style = "layout",
    label = ccb.content.text("Body Part Status"),
    arrange = "rows",
    widgets = {
        "bp_status_head_text",
        "bp_status_torso_text",
        "bp_status_left_arm_text",
        "bp_status_right_arm_text",
        "bp_status_left_leg_text",
        "bp_status_right_leg_text",
    },
}

ccb.content.define_widget {
    id = "bodypart_status_sym_layout",
    style = "layout",
    label = ccb.content.text("Body Part Status Alt"),
    arrange = "rows",
    widgets = {
        "bodypart_status_top_sym_layout",
        "bodypart_status_bottom_sym_layout",
        "bp_status_legend_text",
    },
}
