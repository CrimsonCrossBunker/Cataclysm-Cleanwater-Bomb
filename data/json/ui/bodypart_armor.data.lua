local ccb = require("ccb")

-- Base widget for showing body part outer armor layer; needs bodypart field defined in derived widget.
ccb.content.define_widget {
    id = "bodypart_armor_outer_text",
    style = "text",
    text_align = "left",
    variable = "bp_armor_outer_text",
}

ccb.content.define_widget {
    id = "bp_armor_outer_head_text",
    label = ccb.content.text("Head"),
    bodypart = "head",
    copy_from = "bodypart_armor_outer_text",
}

ccb.content.define_widget {
    id = "bp_armor_outer_torso_text",
    label = ccb.content.text("Torso"),
    bodypart = "torso",
    copy_from = "bodypart_armor_outer_text",
}

ccb.content.define_widget {
    id = "bp_armor_outer_arms_text",
    label = ccb.content.text("Arms"),
    bodypart = "arm_r",
    copy_from = "bodypart_armor_outer_text",
}

ccb.content.define_widget {
    id = "bp_armor_outer_hands_text",
    label = ccb.content.text("Hands"),
    bodypart = "hand_r",
    copy_from = "bodypart_armor_outer_text",
}

ccb.content.define_widget {
    id = "bp_armor_outer_legs_text",
    label = ccb.content.text("Legs"),
    bodypart = "leg_r",
    copy_from = "bodypart_armor_outer_text",
}

ccb.content.define_widget {
    id = "bp_armor_outer_feet_text",
    label = ccb.content.text("Feet"),
    bodypart = "foot_r",
    copy_from = "bodypart_armor_outer_text",
}

ccb.content.define_widget {
    id = "bodypart_armor_outer_layout",
    style = "layout",
    label = ccb.content.text("Armor"),
    arrange = "rows",
    widgets = {
        "bp_armor_outer_head_text",
        "bp_armor_outer_torso_text",
        "bp_armor_outer_arms_text",
        "bp_armor_outer_hands_text",
        "bp_armor_outer_legs_text",
        "bp_armor_outer_feet_text",
    },
}
