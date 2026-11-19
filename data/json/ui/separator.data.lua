local ccb = require("ccb")

ccb.content.define_widget {
    id = "separator",
    style = "layout",
    label = ccb.content.text("Separator"),
    description = ccb.content.text("One line of empty vertical space."),
    arrange = "rows",
    width = 1,
    widgets = {},
}

ccb.content.define_widget {
    id = "separator_disabled",
    copy_from = "separator",
    flags = { "W_DISABLED_BY_DEFAULT" },
}
