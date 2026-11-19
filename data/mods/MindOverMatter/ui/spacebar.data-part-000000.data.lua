local ccb = require("ccb")

ccb.content.define_widget {
    id = "spacebar_nether_attunement_block",
    style = "layout",
    label = ccb.content.text("Nether Attunement"),
    arrange = "minimum_columns",
    width = 58,
    widgets = { "spacebar_separator_2", "spacebar_nether_attunement_meter" },
}
