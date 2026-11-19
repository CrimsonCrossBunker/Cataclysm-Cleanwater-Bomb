local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_overmap_compass_9x9_layout",
    style = "layout",
    label = ccb.content.text("Compass/Overmap 9x9"),
    description = ccb.content.text("<color_yellow>Compass</color> and wielded weapon, next to a <color_yellow>large overmap</color>.\n\nSee the other Compass widgets for alternatives."),
    arrange = "columns",
    widgets = { "structured_overmap_9x9_layout", "structured_weapon_compass_9x9_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "structured_overmap_compass_7x7_layout",
    style = "layout",
    label = ccb.content.text("Compass/Overmap 7x7"),
    description = ccb.content.text("<color_yellow>Compass</color> and wielded weapon, next to a <color_yellow>medium-sized overmap</color>.\n\nSee the other Compass widgets for alternatives."),
    arrange = "columns",
    widgets = { "structured_overmap_7x7_layout", "structured_weapon_compass_7x7_layout" },
}

ccb.content.define_widget {
    id = "structured_overmap_compass_5x5_layout",
    style = "layout",
    label = ccb.content.text("Compass/Overmap 5x5"),
    description = ccb.content.text("<color_yellow>Compass</color> and wielded weapon, next to a <color_yellow>small overmap</color>.\n\nSee the other Compass widgets for alternatives."),
    arrange = "columns",
    widgets = { "structured_overmap_5x5_layout", "structured_weapon_compass_5x5_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "structured_weapon_compass_layout",
    style = "layout",
    label = ccb.content.text("Compass"),
    description = ccb.content.text("<color_yellow>Compass</color> and wielded weapon, <color_yellow>without overmap</color>. For use with widget Health + Overmap.\n\nSee the other Compass widgets for alternatives."),
    arrange = "rows",
    widgets = { "structured_wielding_layout", "compass_all_danger_layout_alt" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "structured_weapon_compass_9x9_layout",
    style = "layout",
    width = 36,
    arrange = "rows",
    widgets = { "structured_wielding_layout", "structured_compass_9x9_layout" },
}

ccb.content.define_widget {
    id = "structured_weapon_compass_7x7_layout",
    style = "layout",
    width = 38,
    arrange = "rows",
    widgets = { "structured_wielding_layout", "structured_compass_7x7_layout" },
}

ccb.content.define_widget {
    id = "structured_weapon_compass_5x5_layout",
    style = "layout",
    width = 40,
    arrange = "rows",
    widgets = { "structured_wielding_layout", "structured_compass_5x5_layout" },
}

ccb.content.define_widget {
    id = "structured_compass_9x9_layout",
    copy_from = "compass_all_danger_layout_alt",
    width = 36,
}

ccb.content.define_widget {
    id = "structured_compass_7x7_layout",
    copy_from = "compass_all_danger_layout_alt",
    width = 38,
}

ccb.content.define_widget {
    id = "structured_compass_5x5_layout",
    copy_from = "compass_all_danger_layout_alt",
    width = 40,
}
