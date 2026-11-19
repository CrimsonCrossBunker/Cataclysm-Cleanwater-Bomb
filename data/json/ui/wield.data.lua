local ccb = require("ccb")

ccb.content.define_widget {
    id = "wielding_desc",
    label = ccb.content.text("Wield"),
    style = "text",
    variable = "wielding_text",
}

ccb.content.define_widget {
    id = "wielding_desc_no_label",
    copy_from = "wielding_desc",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "wielding_simple_desc",
    label = ccb.content.text("Wield"),
    style = "text",
    variable = "wielding_simple_text",
}

ccb.content.define_widget {
    id = "wielding_simple_desc_no_label",
    copy_from = "wielding_simple_desc",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "wielding_mode_desc",
    label = ccb.content.text("Mode"),
    style = "text",
    variable = "wielding_mode_text",
}

ccb.content.define_widget {
    id = "wielding_mode_desc_no_label",
    copy_from = "wielding_mode_desc",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "wielding_ammo_desc",
    label = ccb.content.text("Ammo"),
    style = "text",
    variable = "wielding_ammo_text",
}

ccb.content.define_widget {
    id = "wielding_ammo_desc_no_label",
    copy_from = "wielding_ammo_desc",
    flags = { "W_LABEL_NONE" },
}
