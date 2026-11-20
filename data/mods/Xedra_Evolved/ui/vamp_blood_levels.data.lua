local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "vampire_blood_levels",
    label = ccb.content.text("Blood"),
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "slumber",
            text = ccb.content.text("Eternal Slumber"),
            color = "dark_gray_red",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -1501, "human_blood_vitamin") },
        },
        {
            id = "near_death",
            text = ccb.content.text("Corpse-like"),
            color = "light_gray",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -751, "human_blood_vitamin"), reading.compare("vitamin", ">", -1500, "human_blood_vitamin") },
        },
        {
            id = "starving",
            text = ccb.content.text("Hypomia"),
            color = "yellow",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -301, "human_blood_vitamin"), reading.compare("vitamin", ">", -751, "human_blood_vitamin") },
        },
        {
            id = "hungry",
            text = ccb.content.text("Sallow"),
            color = "light_green",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), reading.compare("vitamin", "<=", -1, "human_blood_vitamin"), reading.compare("vitamin", ">", -301, "human_blood_vitamin") },
        },
        {
            id = "hungry",
            text = ccb.content.text("Enervated"),
            color = "yellow",
            when = predicate.all { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), reading.compare("vitamin", "<=", -1, "human_blood_vitamin") },
        },
        {
            id = "content",
            text = ccb.content.text("Content"),
            color = "green",
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, reading.compare("vitamin", "<=", 1800, "human_blood_vitamin"), reading.compare("vitamin", ">", -1, "human_blood_vitamin") },
        },
        {
            id = "flush",
            text = ccb.content.text("Flush"),
            color = "light_red",
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.negate(predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD")), reading.compare("vitamin", "<=", 2401, "human_blood_vitamin"), reading.compare("vitamin", ">", 1800, "human_blood_vitamin") },
        },
        {
            id = "engorged",
            text = ccb.content.text("Engorged"),
            color = "red",
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.negate(predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD")), reading.compare("vitamin", "<=", 4401, "human_blood_vitamin"), reading.compare("vitamin", ">", 2401, "human_blood_vitamin") },
        },
        {
            id = "swollen",
            text = ccb.content.text("Tick-like"),
            color = "red_cyan",
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.negate(predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD")), reading.compare("vitamin", ">", 4401, "human_blood_vitamin") },
        },
        {
            id = "flush",
            text = ccb.content.text("Satisfied"),
            color = "green",
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD"), reading.compare("vitamin", "<=", 2401, "human_blood_vitamin"), reading.compare("vitamin", ">", 1800, "human_blood_vitamin") },
        },
        {
            id = "engorged",
            text = ccb.content.text("Filled"),
            color = "green",
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD"), reading.compare("vitamin", "<=", 4401, "human_blood_vitamin"), reading.compare("vitamin", ">", 2401, "human_blood_vitamin") },
        },
        {
            id = "swollen",
            text = ccb.content.text("Saturated"),
            color = "green",
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD"), reading.compare("vitamin", ">", 4401, "human_blood_vitamin"), reading.compare("vitamin", "<", 8401, "human_blood_vitamin") },
        },
        {
            id = "sated",
            text = ccb.content.text("Sated"),
            color = "green",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD"), reading.compare("vitamin", ">=", 8401, "human_blood_vitamin"), reading.compare("vitamin", "<", 14401, "human_blood_vitamin") },
        },
        {
            id = "brimmed",
            text = ccb.content.text("Brimmed"),
            color = "green",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD"), reading.compare("vitamin", ">=", 14401, "human_blood_vitamin"), reading.compare("vitamin", "<", 24401, "human_blood_vitamin") },
        },
        {
            id = "overflowing",
            text = ccb.content.text("Overflowing"),
            color = "green",
            when = predicate.all { predicate.has_effect("speaker", "vampire_virus"), predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD"), reading.compare("vitamin", ">=", 24401, "human_blood_vitamin") },
        },
    },
}

ccb.content.define_widget {
    id = "vampire_blood_levels_numbers",
    style = "text",
    label = ccb.content.text("Blood"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "vampire_blood_levels_numbers_bad",
            text = ccb.content.text("<color_red><u_val:blood_amount_for_graph></color>     Max: <color_red><u_val:max_blood_amount_for_graph></color>"),
            parse_tags = true,
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, reading.compare("vitamin", "<", 1, "human_blood_vitamin") },
        },
        {
            id = "vampire_blood_levels_numbers_good",
            text = ccb.content.text("<color_green><u_val:blood_amount_for_graph></color>     Max: <color_green><u_val:max_blood_amount_for_graph></color>"),
            parse_tags = true,
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.negate(predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD")), reading.compare("vitamin", ">", 0, "human_blood_vitamin"), reading.compare("vitamin", "<", 1800, "human_blood_vitamin") },
        },
        {
            id = "vampire_blood_levels_numbers_excess",
            text = ccb.content.text("<color_red><u_val:blood_amount_for_graph></color>     Max: <color_red><u_val:max_blood_amount_for_graph></color>"),
            parse_tags = true,
            when = predicate.all { predicate.any { predicate.has_trait("speaker", "DHAMPIR_TRAIT"), predicate.has_effect("speaker", "vampire_virus") }, predicate.negate(predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD")), reading.compare("vitamin", ">", 1799, "human_blood_vitamin") },
        },
        {
            id = "vampire_blood_levels_numbers_stockpile",
            text = ccb.content.text("<color_green><u_val:blood_amount_for_graph></color>     Max: <color_green><u_val:max_blood_amount_for_graph></color>"),
            parse_tags = true,
            when = predicate.all { predicate.has_trait("speaker", "VAMPIRE_DISTILLATE_INNER_BLOOD"), reading.compare("vitamin", ">", 0, "human_blood_vitamin") },
        },
    },
    padding = 0,
}

ccb.content.define_widget {
    id = "vampire_blood_levels_graph",
    label = ccb.content.text("Blood"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    -- Distillate the Inner Blood ensures that the UI won't show the negatively high levels.
    custom_handler = "sidebar_blood",
    style = "graph",
    width = 40,
    symbols = ".oO0",
    fill = "pool",
    colors = { "c_green", "c_green", "c_yellow", "c_red" },
    padding = 0,
}
