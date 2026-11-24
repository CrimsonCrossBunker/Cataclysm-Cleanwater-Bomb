local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_sky_island_expedition_timer_46",
    style = "layout",
    width = 46,
    arrange = "minimum_columns",
    widgets = { "zenfs_blank_line_10", "zenfs_sky_island_expedition_timer", "zenfs_blank_line" },
}

ccb.content.define_widget {
    id = "zenfs_sky_island_expedition_timer_50",
    style = "layout",
    width = 50,
    arrange = "minimum_columns",
    widgets = { "zenfs_blank_line_12", "zenfs_sky_island_expedition_timer", "zenfs_blank_line" },
}

ccb.content.define_widget {
    id = "zenfs_sky_island_expedition_timer",
    style = "text",
    width = 20,
    clauses = {
        {
            id = "safe_at_home",
            text = ccb.content.text("     HOME SAFE"),
            color = "light_blue",
            when = predicate.all { predicate.any { reading.test("terrain_type", "sky_island_core"), reading.test("terrain_type", "sky_island_edge"), reading.test("terrain_type", "sky_island_corner") }, predicate.negate(predicate.has_trait("speaker", "awayfromhome")) },
        },
        {
            id = "nine_left",
            text = " +-+-+-+-+-+-+-+-+",
            color = "light_blue",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 0, "timeawayfromhome") },
        },
        {
            id = "eight_left",
            text = "  +-+-+-+-+-+-+-+",
            color = "green",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", ">=", 8, "readablepulsesleft") },
        },
        {
            id = "seven_left",
            text = "   +-+-+-+-+-+-+",
            color = "light_green",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 7, "readablepulsesleft") },
        },
        {
            id = "six_left",
            text = "    +-+-+-+-+-+",
            color = "light_green",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 6, "readablepulsesleft") },
        },
        {
            id = "five_left",
            text = "     +-+-+-+-+",
            color = "yellow",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 5, "readablepulsesleft") },
        },
        {
            id = "four_left",
            text = "      +-+-+-+",
            color = "yellow",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 4, "readablepulsesleft") },
        },
        {
            id = "three_left",
            text = "       +-+-+",
            color = "yellow",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 3, "readablepulsesleft") },
        },
        {
            id = "two_left",
            text = "        +-+",
            color = "light_red",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 2, "readablepulsesleft") },
        },
        {
            id = "one_left",
            text = "         +",
            color = "light_red",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 1, "readablepulsesleft") },
        },
        {
            id = "over_deadline",
            text = ccb.content.text("       DANGER"),
            color = "i_light_red",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 9, "timeawayfromhome") },
        },
        {
            id = "over_deadline_one",
            text = ccb.content.text("   SEVERE DANGER"),
            color = "i_light_red",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 10, "timeawayfromhome") },
        },
        {
            id = "over_deadline_two",
            text = ccb.content.text("   EXTREME DANGER"),
            color = "i_red",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 11, "timeawayfromhome") },
        },
        {
            id = "over_deadline_three",
            text = ccb.content.text("CATASTROPHIC DANGER"),
            color = "i_red",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), reading.compare("global_variable", "==", 12, "timeawayfromhome") },
        },
        {
            id = "over_deadline_four",
            text = ccb.content.text("   IMMINENT DEATH"),
            color = "i_red",
            when = predicate.all { predicate.has_trait("speaker", "awayfromhome"), predicate.has_effect("speaker", "warpdisintegration") },
        },
    },
}
