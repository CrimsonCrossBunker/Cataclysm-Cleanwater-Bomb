local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "i_bpower",
    width = 5,
    -- TODO: change to nice 5 section indicator, something is wrong
    style = "text",
    colors = { "h_yellow" },
    clauses = {
        { id = "20%", color = "h_yellow", symbol = "1", when = reading.compare("power_percentage", ">", 19) },
        { id = "40%", color = "h_yellow", symbol = "2", when = reading.compare("power_percentage", ">", 39) },
        { id = "60%", color = "h_yellow", symbol = "3", when = reading.compare("power_percentage", ">", 59) },
        { id = "80%", color = "h_yellow", symbol = "4", when = reading.compare("power_percentage", ">", 79) },
        { id = "99%", color = "h_yellow", symbol = "5", when = reading.compare("power_percentage", ">", 99) },
    },
    default_clause = { text = "     " },
}
