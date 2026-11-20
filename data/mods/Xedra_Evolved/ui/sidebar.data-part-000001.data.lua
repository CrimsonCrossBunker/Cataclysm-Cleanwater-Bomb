local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates

ccb.content.define_widget {
    clauses = {
        { when = predicate.has_effect("speaker", "vampire_virus"), id = "content", widgets = "vampire_blood_levels" },
        { when = predicate.has_trait("speaker", "DHAMPIR_TRAIT"), id = "content", widgets = "vampire_blood_levels" },
        { when = predicate.has_trait("speaker", "LILIN_TRAITS"), id = "content", widgets = "ruach_counter_meter" },
    },
    default_clause = { widgets = "blood_ruach_blank_line" },
    flags = { "W_DISABLED_WHEN_EMPTY" },
    label = ccb.content.text("Blood/Ruach Descriptor"),
    id = "blood_ruach_descriptor",
    style = "layout",
}

ccb.content.define_widget {
    clauses = {
        { when = predicate.has_effect("speaker", "vampire_virus"), id = "content", widgets = "vampire_blood_levels_numbers" },
        { when = predicate.has_trait("speaker", "DHAMPIR_TRAIT"), id = "content", widgets = "vampire_blood_levels" },
        { when = predicate.has_trait("speaker", "LILIN_TRAITS"), id = "content", widgets = "ruach_counter_numbers" },
    },
    default_clause = { widgets = "blood_ruach_blank_line" },
    flags = { "W_DISABLED_WHEN_EMPTY" },
    label = ccb.content.text("Blood/Ruach Numbers"),
    id = "blood_ruach_numbers",
    style = "layout",
}

ccb.content.define_widget {
    clauses = {
        { when = predicate.has_effect("speaker", "vampire_virus"), id = "content", widgets = "vampire_blood_levels_graph" },
        { when = predicate.has_trait("speaker", "DHAMPIR_TRAIT"), id = "content", widgets = "vampire_blood_levels" },
        { when = predicate.has_trait("speaker", "LILIN_TRAITS"), id = "content", widgets = "ruach_counter_graph" },
    },
    default_clause = { widgets = "blood_ruach_blank_line" },
    flags = { "W_DISABLED_WHEN_EMPTY" },
    label = ccb.content.text("Blood/Ruach Graph"),
    id = "blood_ruach_graph",
    style = "layout",
}
