local ccb = require("ccb")

ccb.content.define_widget {
    id = "spacebar_last_scion_mana_bar_block",
    style = "layout",
    label = ccb.content.text("mana_bar"),
    arrange = "minimum_columns",
    widgets = { "spacebar_separator_2", "mana_for_last_scion" },
}
