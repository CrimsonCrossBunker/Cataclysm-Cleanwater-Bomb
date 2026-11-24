local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    copy_from = "custom_sidebar",
    id = "custom_sidebar",
    extend = { widgets = { "martial_mastery" } },
}

-- Extend with the danger widget
ccb.content.define_widget {
    copy_from = "sidebar-mobile",
    id = "sidebar-mobile",
    extend = { widgets = { "martial_mastery" } },
}

ccb.content.define_widget {
    id = "martial_mastery",
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("Combat Style"),
    label_align = "right",
    text_align = "right",
    widgets = { "martial_mastery_title", "style_stats", "poise" },
}

ccb.content.define_widget {
    id = "martial_mastery_title",
    width = 8,
    style = "text",
    text = ccb.content.text("Combat Stats:"),
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "style_stats",
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("SHIELD"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    widgets = { "tempo", "momentum", "insight" },
}

ccb.content.define_widget {
    id = "tempo",
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "tempo_3",
            text = ccb.content.text(" Tempo (3)"),
            color = "white_red",
            when = reading.compare("effect_intensity", ">", 2, "mabuff:buff_perk_tempo"),
        },
        {
            id = "tempo_2",
            text = ccb.content.text(" Tempo (2)"),
            color = "light_gray",
            when = reading.compare("effect_intensity", ">", 1, "mabuff:buff_perk_tempo"),
        },
        {
            id = "tempo_1",
            text = ccb.content.text(" Tempo (1)"),
            color = "dark_gray",
            when = reading.compare("effect_intensity", ">", 0, "mabuff:buff_perk_tempo"),
        },
        {
            id = "tempo",
            text = ccb.content.text(" Tempo (0)"),
            color = "black",
            when = predicate.all { reading.compare("effect_intensity", "==", 0, "mabuff:buff_perk_tempo"), predicate.has_flag("speaker", "MELEE_PERK_TEMPO") },
        },
    },
}

ccb.content.define_widget {
    id = "momentum",
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "momentum_6",
            text = ccb.content.text(" Momentum "),
            color = "light_green",
            when = reading.compare("effect_intensity", ">", 4, "mabuff:buff_perk_momentum"),
        },
        {
            id = "momentum_4",
            text = ccb.content.text(" Momentum "),
            color = "light_cyan",
            when = reading.compare("effect_intensity", ">", 3, "mabuff:buff_perk_momentum"),
        },
        {
            id = "momentum_3",
            text = ccb.content.text(" Momentum "),
            color = "cyan",
            when = reading.compare("effect_intensity", ">", 2, "mabuff:buff_perk_momentum"),
        },
        {
            id = "momentum_2",
            text = ccb.content.text(" Momentum "),
            color = "light_blue",
            when = reading.compare("effect_intensity", ">", 1, "mabuff:buff_perk_momentum"),
        },
        {
            id = "momentum_1",
            text = ccb.content.text(" Momentum "),
            color = "white",
            when = reading.compare("effect_intensity", ">", 0, "mabuff:buff_perk_momentum"),
        },
        {
            id = "insight_0",
            text = ccb.content.text("  Momentum  "),
            color = "black",
            when = predicate.all { reading.compare("effect_intensity", "==", 0, "mabuff:buff_perk_momentum"), predicate.has_flag("speaker", "MELEE_PERK_MOMENTUM") },
        },
    },
}

ccb.content.define_widget {
    id = "insight",
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "insight_12",
            text = ccb.content.text(" ◉  △  ◉ "),
            color = "i_pink",
            when = reading.compare("effect_intensity", ">", 499, "perk_insight"),
        },
        {
            id = "insight_11",
            text = ccb.content.text(" ◉Insight◉ "),
            color = "i_pink",
            when = reading.compare("effect_intensity", ">", 199, "perk_insight"),
        },
        {
            id = "insight_10",
            text = ccb.content.text(" ◎Insight◎ "),
            color = "i_pink",
            when = reading.compare("effect_intensity", ">", 149, "perk_insight"),
        },
        {
            id = "insight_9",
            text = ccb.content.text(" ◯Insight◯ "),
            color = "i_pink",
            when = reading.compare("effect_intensity", ">", 99, "perk_insight"),
        },
        {
            id = "insight_8",
            text = ccb.content.text("  Insight  "),
            color = "i_pink",
            when = reading.compare("effect_intensity", ">", 79, "perk_insight"),
        },
        {
            id = "insight_7",
            text = ccb.content.text("  Insight  "),
            color = "i_magenta",
            when = reading.compare("effect_intensity", ">", 49, "perk_insight"),
        },
        {
            id = "insight_6",
            text = ccb.content.text("  Insight  "),
            color = "red",
            when = reading.compare("effect_intensity", ">", 29, "perk_insight"),
        },
        {
            id = "insight_5",
            text = ccb.content.text("  Insight  "),
            color = "pink",
            when = reading.compare("effect_intensity", ">", 19, "perk_insight"),
        },
        {
            id = "insight_4",
            text = ccb.content.text("  Insight  "),
            color = "light_cyan",
            when = reading.compare("effect_intensity", ">", 9, "perk_insight"),
        },
        {
            id = "insight_3",
            text = ccb.content.text("  Insight  "),
            color = "white",
            when = reading.compare("effect_intensity", ">", 5, "perk_insight"),
        },
        {
            id = "insight_2",
            text = ccb.content.text("  Insight  "),
            color = "light_gray",
            when = reading.compare("effect_intensity", ">", 1, "perk_insight"),
        },
        {
            id = "insight_1",
            text = ccb.content.text("  Insight  "),
            color = "dark_gray",
            when = reading.compare("effect_intensity", ">", 0, "perk_insight"),
        },
        {
            id = "insight_0",
            text = ccb.content.text("  Insight  "),
            color = "black",
            when = predicate.all { reading.compare("effect_intensity", "==", 0, "perk_insight"), predicate.has_flag("speaker", "MELEE_PERK_INSIGHT") },
        },
    },
}

ccb.content.define_widget {
    id = "poise",
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    label = ccb.content.text("Stance"),
    clauses = {
        {
            id = "poise_4",
            text = ccb.content.text("▇▇▇ ▇▇▇ ▇▇▇ ▇▇▇"),
            color = "light_green",
            when = reading.compare("character_variable", "==", 4, "poise"),
        },
        {
            id = "poise_3",
            text = ccb.content.text("▇▇▇ ▇▇▇ ▇▇▇    "),
            color = "light_cyan",
            when = reading.compare("character_variable", "==", 3, "poise"),
        },
        {
            id = "poise_2",
            text = ccb.content.text("▇▇▇ ▇▇▇            "),
            color = "cyan",
            when = reading.compare("character_variable", "==", 2, "poise"),
        },
        {
            id = "poise_1",
            text = ccb.content.text("▇▇▇                "),
            color = "white",
            when = reading.compare("character_variable", "==", 1, "poise"),
        },
        {
            id = "poise_0",
            text = ccb.content.text("    !BROKEN!    "),
            color = "red",
            when = predicate.all { reading.compare("character_variable", "==", 0, "poise"), predicate.has_flag("speaker", "MELEE_PERK_POISE") },
        },
    },
}
