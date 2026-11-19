local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_spacer",
    style = "layout",
    label = ccb.content.text("(Spacer)"),
    description = ccb.content.text("One line of empty vertical space."),
    arrange = "rows",
    width = 1,
    widgets = {},
}

ccb.content.define_widget {
    id = "zenfs_spacer_disabled",
    copy_from = "zenfs_spacer",
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_blank_line",
    style = "text",
    text = "",
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_blank_space",
    style = "text",
    text = ccb.content.text_without_extraction(" "),
    flags = { "W_LABEL_NONE" },
    padding = 1,
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_blank_line_10",
    style = "text",
    text = ccb.content.text_without_extraction("          "),
    width = 10,
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_blank_line_12",
    style = "text",
    text = ccb.content.text_without_extraction("            "),
    width = 12,
    flags = { "W_LABEL_NONE" },
}
