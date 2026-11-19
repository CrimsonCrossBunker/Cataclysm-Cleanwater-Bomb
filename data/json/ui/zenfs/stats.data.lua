local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_main_stats",
    style = "layout",
    arrange = "rows",
    width = 8,
    widgets = { "zenfs_str", "zenfs_dex", "zenfs_int", "zenfs_per" },
}

ccb.content.define_widget {
    id = "zenfs_str",
    label = ccb.content.text("Str"),
    variable = "stat_str",
    width = 4,
    copy_from = "stat_number",
}

ccb.content.define_widget {
    id = "zenfs_dex",
    label = ccb.content.text("Dex"),
    variable = "stat_dex",
    width = 4,
    copy_from = "stat_number",
}

ccb.content.define_widget {
    id = "zenfs_int",
    label = ccb.content.text("Int"),
    variable = "stat_int",
    width = 4,
    copy_from = "stat_number",
}

ccb.content.define_widget {
    id = "zenfs_per",
    label = ccb.content.text("Per"),
    variable = "stat_per",
    width = 4,
    copy_from = "stat_number",
}
