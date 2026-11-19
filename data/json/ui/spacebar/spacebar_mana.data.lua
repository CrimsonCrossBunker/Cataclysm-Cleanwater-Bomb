local ccb = require("ccb")

ccb.content.define_widget {
    id = "spacebar_mana_bar_block",
    style = "layout",
    label = ccb.content.text("mana_bar"),
    arrange = "minimum_columns",
    widgets = { "spacebar_separator_2", "spacebar_mana_graph" },
}

ccb.content.define_widget {
    id = "spacebar_mana_numbers_block",
    style = "layout",
    label = ccb.content.text("mana_number"),
    arrange = "minimum_columns",
    widgets = { "spacebar_separator_2", "spacebar_current_max_mana_nums_layout" },
}
