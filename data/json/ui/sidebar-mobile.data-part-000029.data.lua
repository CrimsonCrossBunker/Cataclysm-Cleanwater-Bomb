local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "i_weight_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "sk", symbol = "ₒ", color = "c_red", when = reading.compare("bmi_permil", "<=", 1000) },
        {
            id = "e",
            symbol = "ₒ",
            color = "c_light_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "u_w",
            symbol = "ₒ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "n",
            symbol = "ₒ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "o_w",
            symbol = "ₒ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "o",
            symbol = "ₒ",
            color = "c_light_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "v_o",
            symbol = "ₒ",
            color = "c_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        { id = "m_o", symbol = "ₒ", color = "c_white", when = reading.compare("bmi_permil", ">", 20000) },
    },
}

ccb.content.define_widget {
    id = "i_weight_graph",
    width = 5,
    style = "symbol",
    clauses = {
        { id = "sk", symbol = "⎻⎺", color = "c_brown", when = reading.compare("bmi_permil", "<=", 1000) },
        { id = "sk", symbol = "ₗ", color = "c_yellow", when = reading.compare("bmi_permil", "<=", 1000) },
        { id = "sk", symbol = "  ", color = "c_brown", when = reading.compare("bmi_permil", "<=", 1000) },
        {
            id = "e",
            symbol = "∕ʻ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "e",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "e",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "unw",
            symbol = " ╱",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "unw",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "unw",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "nrm",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "nrm",
            symbol = "╿",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "nrm",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "ovw",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "ovw",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "ovw",
            symbol = "╲ ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "o",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "o",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "o",
            symbol = "ʽ∖",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "v_o",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        {
            id = "v_o",
            symbol = "ₕ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        {
            id = "v_o",
            symbol = "⎺⎻",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        { id = "m_o", symbol = "  ", color = "c_brown", when = reading.compare("bmi_permil", ">", 20000) },
        { id = "m_o", symbol = "ₕ", color = "c_red", when = reading.compare("bmi_permil", ">", 20000) },
        { id = "m_o", symbol = " ⎺", color = "c_brown", when = reading.compare("bmi_permil", ">", 20000) },
    },
}
