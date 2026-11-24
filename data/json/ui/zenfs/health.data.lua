local ccb = require("ccb")
local reading = ccb.content.widget_conditions
local predicate = ccb.content.dialogue_predicates

ccb.content.define_widget {
    id = "zenfs_mood_focus_speed_sound",
    style = "layout",
    arrange = "rows",
    width = 9,
    widgets = { "mood_desc_label", "focus_num", "speed_num", "sound_num" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus", "zenfs_malus_trans_bar" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus", "zenfs_malus_trans_bar_alt" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus_num",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus_trunc", "zenfs_malus_trans_num" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus_num_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus", "zenfs_malus_trans_num" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_bar_12" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_slim",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_bar_14" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_desc",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_desc_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_desc_F",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_label_F", "zenfs_sleepiness_desc_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_num",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_num_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_12",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_stamina_bar_label", "zenfs_stamina_bar_only_12" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_14",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_stamina_bar_label", "zenfs_stamina_bar_only_14" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_num",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_stamina_bar_label", "zenfs_stamina_num_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_template",
    copy_from = "stamina_widget",
    style = "graph",
    symbols = "·−=≡≣",
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_only_12",
    copy_from = "zenfs_stamina_bar_template",
    width = 12,
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_only_14",
    copy_from = "zenfs_stamina_bar_template",
    width = 14,
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_num_no_label",
    copy_from = "stamina_num_label",
    width = 5,
    text_align = "right",
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_oxygen_bar_only_12",
    copy_from = "oxygen_widget",
    label = ccb.content.text("Oxygen"),
    style = "graph",
    symbols = "·−=≡≣",
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    width = 12,
}

ccb.content.define_widget {
    id = "zenfs_oxygen_bar_only_12_layout",
    style = "layout",
    label = ccb.content.text("Oxygen"),
    arrange = "rows",
    default_clause = { text = "" },
    clauses = {
        { when = reading.test("oxygen_not_full"), id = "content", widgets = "zenfs_oxygen_bar_only_12" },
    },
    flags = { "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_bar_10",
    label = ccb.content.text("Weariness"),
    variable = "weariness_level",
    style = "graph",
    fill = "pool",
    width = 10,
    symbols = "·−=≡≣",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red", "i_red" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_bar_11",
    copy_from = "zenfs_weariness_bar_10",
    width = 11,
}

ccb.content.define_widget {
    id = "zenfs_weariness_num",
    label = ccb.content.text("Weary"),
    variable = "weariness_level",
    style = "number",
    width = 4,
    text_align = "right",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red", "i_red" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_template",
    variable = "sleepiness",
    style = "graph",
    symbols = "·−=≡≣",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_num_no_label",
    variable = "sleepiness",
    style = "number",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red" },
    text_align = "right",
    flags = { "W_NO_LABEL" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_12",
    copy_from = "zenfs_sleepiness_bar_template",
    width = 12,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_14",
    copy_from = "zenfs_sleepiness_bar_template",
    width = 14,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_desc_no_label",
    style = "text",
    text_align = "right",
    width = 11,
    clauses = {
        {
            id = "well_rested",
            text = ccb.content.text("Well Rested"),
            color = "blue",
            when = reading.compare("sleepiness", "<", 95),
        },
        {
            id = "rested",
            text = ccb.content.text("Rested"),
            color = "green",
            when = predicate.all { reading.compare("sleepiness", ">=", 95), reading.compare("sleepiness", "<", 191) },
        },
        {
            id = "tired",
            text = ccb.content.text("Tired"),
            color = "yellow",
            when = predicate.all { reading.compare("sleepiness", ">=", 191), reading.compare("sleepiness", "<", 383) },
        },
        {
            id = "dead_tired",
            text = ccb.content.text("Dead Tired"),
            color = "light_red",
            when = predicate.all { reading.compare("sleepiness", ">=", 383), reading.compare("sleepiness", "<", 575) },
        },
        {
            id = "exhausted",
            text = ccb.content.text("Exhausted"),
            color = "red",
            when = reading.compare("sleepiness", ">=", 575),
        },
    },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_label",
    style = "text",
    text = ccb.content.text("<color_cyan>Stamina</color>"),
    width = 7,
}

ccb.content.define_widget {
    id = "zenfs_stamina_num_label",
    style = "text",
    text = ccb.content.text("<color_cyan>Stam</color>"),
    width = 4,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_label_F",
    style = "text",
    text = ccb.content.text("F"),
    width = 1,
    padding = 0,
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_label",
    style = "text",
    text = ccb.content.text("Sleepiness"),
    width = 10,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_num_label",
    style = "text",
    text = ccb.content.text("Fatig"),
    width = 5,
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar_8",
    label = ccb.content.text("Malus"),
    variable = "weary_transition_level",
    style = "graph",
    fill = "pool",
    symbols = "≣≡=−·",
    width = 8,
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green", "c_dark_gray" },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar_9",
    copy_from = "zenfs_malus_trans_bar_8",
    width = 9,
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar",
    style = "layout",
    arrange = "rows",
    width = 8,
    widgets = { "zenfs_malus_trans_bar_8" },
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar_alt",
    style = "layout",
    arrange = "rows",
    width = 9,
    widgets = { "zenfs_malus_trans_bar_9" },
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_num",
    label = ccb.content.text("Malus"),
    variable = "weary_transition_level",
    style = "number",
    width = 5,
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green", "c_dark_gray" },
    text_align = "right",
    flags = { "W_LABEL_NONE" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_weary_malus",
    label = ccb.content.text("Malus"),
    style = "text",
    variable = "weary_malus_text",
    width = 11,
}

ccb.content.define_widget {
    id = "zenfs_weary_malus_trunc",
    label = "",
    style = "text",
    variable = "weary_malus_text",
    width = 5,
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_cardio_fit",
    style = "number",
    variable = "cardio_fit",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_cardio_acc",
    style = "number",
    variable = "cardio_acc",
    flags = { "W_LABEL_NONE" },
}
