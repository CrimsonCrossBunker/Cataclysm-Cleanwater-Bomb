local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "spacebar_separator",
    style = "text",
    label = ccb.content.text("separator"),
    clauses = {
        {
            id = "light",
            text = "]>=---=---=---=< >=---=----=<>=----=---=< >=---=---=---=<[",
            color = "yellow",
            when = predicate.all { reading.compare("pain", ">=", 3), reading.compare("pain", "<", 40) },
        },
        {
            id = "mid",
            text = "]>=---=---=<>=---=<<>>=----=<>=----=<<>>=---=<>=---=---=<[",
            color = "light_red",
            when = predicate.all { reading.compare("pain", ">=", 40), reading.compare("pain", "<", 60) },
        },
        {
            id = "haevy",
            text = "]>=---=---=<>=---=<<>>=---=<<>>=---=<<>>=---=<>=---=---=<[",
            color = "red",
            when = reading.compare("pain", ">=", 60),
        },
    },
    default_clause = { text = "]>=---=---=---=---=---=---=----=---=---=---=---=---=---=<[", color = "dark_gray" },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "spacebar_separator_42",
    style = "text",
    clauses = {
        {
            id = "light",
            text = "]>=---=---=---=---=<<>>=---=---=---=---=<[",
            color = "yellow",
            when = predicate.all { reading.compare("pain", ">=", 3), reading.compare("pain", "<", 40) },
        },
        {
            id = "mid",
            text = "]>=---=---=<<>>=----<>----=<<>>=---=---=<[",
            color = "light_red",
            when = predicate.all { reading.compare("pain", ">=", 40), reading.compare("pain", "<", 60) },
        },
        {
            id = "haevy",
            text = "]>=--=---=<<>>=---=<<>>=---=<<>>=---=--=<[",
            color = "red",
            when = reading.compare("pain", ">=", 60),
        },
    },
    default_clause = { text = "]>=---=---=---=---=----=---=---=---=---=<[", color = "dark_gray" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "spacebar_separator_2",
    style = "text",
    text = ccb.content.text_without_extraction("x"),
    width = 2,
    height = 1,
    colors = { "c_black" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "spacebar_separator_4",
    style = "text",
    text = ccb.content.text_without_extraction("x"),
    width = 4,
    height = 1,
    colors = { "c_black" },
}
