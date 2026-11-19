local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_wielding_layout",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "wielding_simple_desc_no_label", "structured_mode_ammo_layout" },
}

ccb.content.define_widget {
    id = "structured_mode_ammo_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "structured_wielding_mode", "structured_ammo" },
}

ccb.content.define_widget {
    id = "structured_wielding_mode",
    copy_from = "wielding_mode_desc_no_label",
    text_align = "right",
}

ccb.content.define_widget {
    id = "structured_ammo",
    copy_from = "wielding_ammo_desc_no_label",
    text_align = "right",
}
