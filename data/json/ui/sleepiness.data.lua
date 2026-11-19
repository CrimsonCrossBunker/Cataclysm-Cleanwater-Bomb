local ccb = require("ccb")

ccb.content.define_widget {
    id = "sleepiness_num",
    label = ccb.content.text("Sleepiness"),
    variable = "sleepiness",
    style = "number",
}

ccb.content.define_widget {
    id = "sleepiness_graph",
    label = ccb.content.text("Fatig"),
    variable = "sleepiness",
    style = "graph",
    fill = "bucket",
    width = 5,
    symbols = "-fF",
    colors = { "c_green", "c_yellow", "c_red" },
}

ccb.content.define_widget {
    id = "sleepiness_desc_label",
    label = ccb.content.text("Rest"),
    style = "text",
    copy_from = "sleepiness_desc_template",
}

ccb.content.define_widget {
    id = "sleepiness_desc_no_label",
    copy_from = "sleepiness_desc_label",
    flags = { "W_LABEL_NONE" },
}
