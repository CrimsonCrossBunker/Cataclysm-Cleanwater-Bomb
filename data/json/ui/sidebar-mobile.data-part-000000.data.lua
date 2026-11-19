local ccb = require("ccb")

ccb.content.define_widget {
    id = "t_border",
    width = 1,
    style = "symbol",
    colors = { "c_blue" },
    text = "",
}

-- NO_I18N
ccb.content.define_widget {
    id = "t_label",
    width = 1,
    style = "symbol",
    text = ccb.content.text_without_extraction(" "),
    colors = { "c_dark_gray" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_space",
    width = 1,
    copy_from = "t_label",
    text = ccb.content.text_without_extraction(" "),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_sw",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╰"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_nw",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╭"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_se",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╯"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_ne",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╮"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_sc_cl",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("┴"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_nc_cl",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("┬"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_hc",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("─"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_vc",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("│"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_div1",
    width = 41,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("═══════╧═══════════════════════╧═════════"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_div2",
    width = 41,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("═════════════════════════════════════════"),
}
