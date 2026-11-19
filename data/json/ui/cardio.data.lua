local ccb = require("ccb")

ccb.content.define_widget {
    id = "cardio_fit_num",
    label = ccb.content.text("Cardio Fit"),
    variable = "cardio_fit",
    style = "number",
}

ccb.content.define_widget {
    id = "cardio_acc_num",
    label = ccb.content.text("Cardio Acc"),
    variable = "cardio_acc",
    style = "number",
}
