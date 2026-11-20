local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_oxygen_bar_only_12_layout",
    style = "layout",
    label = ccb.content.text("Oxygen"),
    arrange = "rows",
    default_clause = { text = "" },
    clauses = {
        { when = reading.test("oxygen_not_full"), id = "content", widgets = "zenfs_oxygen_bar_only_12" },
    },
    flags = { "W_DISABLED_WHEN_EMPTY" },
}
