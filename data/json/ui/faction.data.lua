local ccb = require("ccb")

ccb.content.define_widget {
    id = "territory_desc_label",
    label = ccb.content.text("Owner"),
    style = "text",
    variable = "faction_territory",
}
