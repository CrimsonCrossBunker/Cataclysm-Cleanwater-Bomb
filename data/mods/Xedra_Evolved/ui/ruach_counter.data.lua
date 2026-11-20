local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "ruach_counter_meter",
    style = "text",
    label = ccb.content.text("Ruach"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    width = 56,
    clauses = {
        {
            id = "out_of_ruach",
            text = ccb.content.text("Starving"),
            color = "c_pink",
            when = predicate.all { predicate.has_trait("speaker", "LILIN_TRAITS"), reading.compare("vitamin", "==", 0, "lilin_ruach_vitamin") },
        },
        {
            id = "ruach_level_1",
            text = ccb.content.text("<color_red>Almost Spent</color>"),
            when = predicate.all { predicate.has_trait("speaker", "LILIN_TRAITS"), reading.compare("vitamin", ">=", 1, "lilin_ruach_vitamin"), reading.compare("vitamin", "<", 241, "lilin_ruach_vitamin") },
        },
        {
            id = "ruach_level_2",
            text = ccb.content.text("<color_light_red>Drained</color>"),
            when = predicate.all { predicate.has_trait("speaker", "LILIN_TRAITS"), reading.compare("vitamin", ">=", 241, "lilin_ruach_vitamin"), reading.compare("vitamin", "<", 481, "lilin_ruach_vitamin") },
        },
        {
            id = "ruach_level_3",
            text = ccb.content.text("<color_yellow>Refreshed</color>"),
            when = predicate.all { predicate.has_trait("speaker", "LILIN_TRAITS"), reading.compare("vitamin", ">=", 480, "lilin_ruach_vitamin"), reading.compare("vitamin", "<", 1201, "lilin_ruach_vitamin") },
        },
        {
            id = "ruach_level_4",
            text = ccb.content.text("<color_light_green>Satiated</color>"),
            when = predicate.all { predicate.has_trait("speaker", "LILIN_TRAITS"), reading.compare("vitamin", ">=", 1200, "lilin_ruach_vitamin"), reading.compare("vitamin", "<", 2401, "lilin_ruach_vitamin") },
        },
        {
            id = "ruach_level_5",
            text = ccb.content.text("<color_green>Suffused</color>"),
            when = predicate.all { predicate.has_trait("speaker", "LILIN_TRAITS"), predicate.has_trait("speaker", "LILIN_HOLD_MORE_RUACH"), reading.compare("vitamin", ">=", 2400, "lilin_ruach_vitamin") },
        },
    },
    padding = 1,
}

ccb.content.define_widget {
    id = "ruach_counter_numbers",
    style = "text",
    label = ccb.content.text("Ruach"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "ruach_numbers",
            text = ccb.content.text("<color_green><u_val:ruach_amount_for_graph></color>     Max: <color_green><u_val:ruach_max_amount_for_graph></color>     Days: <color_green><u_val:ruach_days_left></color>"),
            parse_tags = true,
            when = predicate.has_trait("speaker", "LILIN_TRAITS"),
        },
    },
    padding = 1,
}

ccb.content.define_widget {
    id = "ruach_counter_graph",
    label = ccb.content.text("Ruach"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    custom_handler = "sidebar_ruach",
    style = "graph",
    width = 40,
    symbols = ".יוא",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    padding = 1,
}
