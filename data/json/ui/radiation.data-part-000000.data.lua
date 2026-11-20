local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "rad_badge_template",
    style = "clause",
    clauses = {
        {
            id = "rad_0",
            text = ccb.content.text(" green "),
            symbol = "-",
            color = "white_green",
            when = predicate.all { reading.compare("item_radiation", "<=", 0, "RAD_DETECT"), predicate.any { reading.test("worn_flag", "RAD_DETECT"), reading.test("wielded_flag", "RAD_DETECT") } },
        },
        {
            id = "rad_30",
            text = ccb.content.text(" blue "),
            symbol = "+",
            color = "h_white",
            when = predicate.all { reading.compare("item_radiation", "<=", 30, "RAD_DETECT"), reading.compare("item_radiation", ">", 0, "RAD_DETECT"), predicate.any { reading.test("worn_flag", "RAD_DETECT"), reading.test("wielded_flag", "RAD_DETECT") } },
        },
        {
            id = "rad_60",
            text = ccb.content.text(" yellow "),
            symbol = "!",
            color = "i_yellow",
            when = predicate.all { reading.compare("item_radiation", "<=", 60, "RAD_DETECT"), reading.compare("item_radiation", ">", 30, "RAD_DETECT"), predicate.any { reading.test("worn_flag", "RAD_DETECT"), reading.test("wielded_flag", "RAD_DETECT") } },
        },
        {
            id = "rad_120",
            text = ccb.content.text(" orange "),
            symbol = "‼",
            color = "red_yellow",
            when = predicate.all { reading.compare("item_radiation", "<=", 120, "RAD_DETECT"), reading.compare("item_radiation", ">", 60, "RAD_DETECT"), predicate.any { reading.test("worn_flag", "RAD_DETECT"), reading.test("wielded_flag", "RAD_DETECT") } },
        },
        {
            id = "rad_240",
            text = ccb.content.text(" red "),
            symbol = "X",
            color = "red_red",
            when = predicate.all { reading.compare("item_radiation", "<=", 240, "RAD_DETECT"), reading.compare("item_radiation", ">", 120, "RAD_DETECT"), predicate.any { reading.test("worn_flag", "RAD_DETECT"), reading.test("wielded_flag", "RAD_DETECT") } },
        },
        {
            id = "rad_500",
            text = ccb.content.text(" black "),
            symbol = "☼",
            color = "pink",
            when = predicate.all { reading.compare("item_radiation", ">", 240, "RAD_DETECT"), predicate.any { reading.test("worn_flag", "RAD_DETECT"), reading.test("wielded_flag", "RAD_DETECT") } },
        },
    },
}
