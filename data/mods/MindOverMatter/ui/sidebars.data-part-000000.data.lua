local ccb = require("ccb")

ccb.content.define_widget {
    id = "sidebar_nether_attunement_block_narrow",
    style = "layout",
    label = ccb.content.text("Nether Attunement"),
    arrange = "minimum_columns",
    widgets = { "sidebar_nether_attunement_meter" },
}

ccb.content.define_widget {
    id = "sidebar_nether_attunement_block",
    style = "layout",
    label = ccb.content.text("Nether Attunement"),
    arrange = "minimum_columns",
    widgets = { "spacebar_nether_attunement_meter" },
}
