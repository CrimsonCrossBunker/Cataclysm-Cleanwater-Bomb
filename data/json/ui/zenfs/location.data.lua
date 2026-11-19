local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_place_desc",
    style = "layout",
    width = 0,
    arrange = "columns",
    widgets = { "place_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_place_desc_15",
    copy_from = "zenfs_place_desc",
    width = 15,
}

ccb.content.define_widget {
    id = "zenfs_place_desc_19",
    copy_from = "zenfs_place_desc",
    width = 19,
}

ccb.content.define_widget {
    id = "zenfs_omloc_desc",
    label = ccb.content.text("Location"),
    variable = "overmap_loc_text",
    style = "text",
    width = 24,
    text_align = "right",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_omloc_desc_23",
    label = ccb.content.text("Location"),
    variable = "overmap_loc_text",
    style = "text",
    width = 23,
    text_align = "right",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_overmap_11x7",
    label = ccb.content.text("Overmap"),
    variable = "overmap_text",
    style = "text",
    width = 11,
    height = 7,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_overmap",
    style = "layout",
    arrange = "rows",
    width = 11,
    widgets = { "zenfs_overmap_11x7" },
}

ccb.content.define_widget {
    id = "zenfs_overmap_divider",
    style = "layout",
    arrange = "rows",
    width = 1,
    widgets = {
        "zenfs_om_divider_l1",
        "zenfs_om_divider_l2",
        "zenfs_om_divider_l3",
        "zenfs_om_divider_l4",
        "zenfs_om_divider_l5",
        "zenfs_om_divider_l6",
        "zenfs_om_divider_l7",
    },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_om_divider_l1",
    style = "text",
    text = ccb.content.text_without_extraction("<color_dark_gray>╽</color>"),
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_om_divider_l2",
    style = "text",
    text = ccb.content.text_without_extraction("<color_dark_gray>┇</color>"),
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_om_divider_l3",
    style = "text",
    text = ccb.content.text_without_extraction("<color_dark_gray>┃</color>"),
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_om_divider_l4",
    style = "text",
    text = ccb.content.text_without_extraction("<color_dark_gray>┇</color>"),
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_om_divider_l5",
    style = "text",
    text = ccb.content.text_without_extraction("<color_dark_gray>┃</color>"),
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_om_divider_l6",
    style = "text",
    text = ccb.content.text_without_extraction("<color_dark_gray>┇</color>"),
    flags = { "W_LABEL_NONE" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_om_divider_l7",
    style = "text",
    text = ccb.content.text_without_extraction("<color_dark_gray>╿</color>"),
    flags = { "W_LABEL_NONE" },
}
