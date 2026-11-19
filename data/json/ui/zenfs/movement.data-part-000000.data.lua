local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_movement_block",
    style = "layout",
    arrange = "rows",
    width = 18,
    widgets = { "zenfs_move_mode", "zenfs_move_count_cost" },
}

ccb.content.define_widget {
    id = "zenfs_move_mode",
    style = "layout",
    arrange = "minimum_columns",
    width = 18,
    widgets = { "zenfs_move_label", "zenfs_move_desc" },
}

ccb.content.define_widget {
    id = "zenfs_move_count_cost",
    style = "layout",
    arrange = "minimum_columns",
    width = 18,
    widgets = { "zenfs_move_count", "zenfs_move_cost" },
}

ccb.content.define_widget {
    id = "zenfs_move_label",
    style = "text",
    text = ccb.content.text("<color_cyan>Movement</color>"),
    width = 8,
    flags = { "W_LABEL_NONE" },
}
