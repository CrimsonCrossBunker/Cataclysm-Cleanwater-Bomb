local ccb = require("ccb")

-- Displays players martial art buffes/debufs by name
ccb.content.define_widget {
    id = "ma_buff_legend",
    style = "legend",
    copy_from = "ma_buff_indicator_template",
    width = 0,
    height = 4,
    text_align = "left",
    flags = { "W_LABEL_NONE", "W_DYNAMIC_HEIGHT" },
}
