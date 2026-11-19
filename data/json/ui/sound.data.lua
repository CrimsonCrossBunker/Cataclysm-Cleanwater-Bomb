local ccb = require("ccb")

ccb.content.define_widget {
    id = "sound_num",
    label = ccb.content.text("Sound"),
    variable = "sound",
    style = "number",
}
