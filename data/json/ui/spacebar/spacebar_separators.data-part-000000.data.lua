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
