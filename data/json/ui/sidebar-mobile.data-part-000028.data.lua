local ccb = require("ccb")

ccb.content.define_widget {
    id = "a_hunger_thrist",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_hunger", "i_hunger_graph", "i_weight_sym", "i_thrist_graph", "l_thrist" },
}
