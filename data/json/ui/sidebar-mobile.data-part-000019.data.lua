local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "i_light_sym",
    width = 5,
    style = "text",
    clauses = {
        { id = "bright", text = "☼☼☼☼☼", color = "c_white", when = reading.compare("fine_detail_vision_mod", "<=", 1) },
        { id = "cloudy", text = "☼☼☼☼", color = "c_yellow", when = reading.compare("fine_detail_vision_mod", "==", 2) },
        { id = "shady", text = "☼☼☼", color = "c_light_gray", when = reading.compare("fine_detail_vision_mod", "==", 3) },
        { id = "dark", text = "☼☼", color = "c_dark_gray", when = reading.compare("fine_detail_vision_mod", "==", 4) },
        { id = "very dark", text = "☼", color = "c_dark_gray", when = reading.compare("fine_detail_vision_mod", ">=", 5) },
    },
}
