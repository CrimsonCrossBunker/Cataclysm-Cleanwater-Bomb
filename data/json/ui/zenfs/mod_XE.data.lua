local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_blood",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_blood_label", "zenfs_blood_level" },
}

ccb.content.define_widget {
    id = "zenfs_blood_B",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_blood_label_B", "zenfs_blood_level" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_blood_label",
    style = "text",
    width = 5,
    clauses = {
        {
            id = "not_infected",
            text = "     ",
            color = "black",
            when = predicate.negate(predicate.has_effect("speaker", "vampire_virus")),
        },
        {
            id = "slumber",
            text = ccb.content.text("Blood"),
            color = "light_gray",
            when = predicate.has_effect("speaker", "vampire_virus"),
        },
    },
    padding = 0,
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_blood_label_B",
    style = "text",
    width = 1,
    clauses = {
        {
            id = "not_infected",
            text = " ",
            color = "black",
            when = predicate.negate(predicate.has_effect("speaker", "vampire_virus")),
        },
        {
            id = "slumber",
            text = ccb.content.text("B"),
            color = "light_gray",
            when = predicate.has_effect("speaker", "vampire_virus"),
        },
    },
    padding = 0,
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_blood_level",
    style = "text",
    text_align = "right",
    width = 20,
    clauses = {
        {
            id = "not_infected",
            text = "                    ",
            color = "black",
            when = predicate.negate(predicate.has_effect("speaker", "vampire_virus")),
        },
        {
            id = "slumber",
            text = ccb.content.text("Eternal Slumber"),
            color = "dark_gray_red",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -11999, "human_blood_vitamin") },
        },
        {
            id = "near_death",
            text = ccb.content.text("Corpse-like"),
            color = "dark_gray",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -6401, "human_blood_vitamin"), reading.compare("vitamin", ">", -11999, "human_blood_vitamin") },
        },
        {
            id = "starving",
            text = ccb.content.text("Hypomia"),
            color = "yellow",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -5601, "human_blood_vitamin"), reading.compare("vitamin", ">", -6401, "human_blood_vitamin") },
        },
        {
            id = "hungry",
            text = ccb.content.text("Sallow"),
            color = "light_green",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -4800, "human_blood_vitamin"), reading.compare("vitamin", ">", -5601, "human_blood_vitamin") },
        },
        {
            id = "content",
            text = ccb.content.text("Content"),
            color = "green",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", 1800, "human_blood_vitamin"), reading.compare("vitamin", ">", -4800, "human_blood_vitamin") },
        },
        {
            id = "flush",
            text = ccb.content.text("Flush"),
            color = "light_red",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", 2401, "human_blood_vitamin"), reading.compare("vitamin", ">", 1800, "human_blood_vitamin") },
        },
        {
            id = "engorged",
            text = ccb.content.text("Engorged"),
            color = "red",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", 4401, "human_blood_vitamin"), reading.compare("vitamin", ">", 2401, "human_blood_vitamin") },
        },
        {
            id = "swollen",
            text = ccb.content.text("Tick-like"),
            color = "red_cyan",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", ">", 4401, "human_blood_vitamin") },
        },
    },
    padding = 0,
    flags = { "W_LABEL_NONE" },
}
