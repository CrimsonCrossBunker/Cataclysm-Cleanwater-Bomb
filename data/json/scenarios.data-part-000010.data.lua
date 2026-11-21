local ccb = require("ccb")

ccb.content.define_scenario {
    id = "a_moonlit_night_start",
    name = "A Moonlight Night",
    points = 0,
    description = "You've been holed up in your basement ever since the Cataclysm happened a little over a week ago, but now you've run out of food and have been forced to go on a supply run on this fateful moonlit night.  You see zombies all around you, but thankfully, most of them can't seem to see as well in moonlight as you do.",
    start_name = "In the Middle of Town",
    start_of_cataclysm = { hour = 0, day = 56, season = "spring", year = 1 },
    start_of_game = { hour = 23, day = 72, season = "spring", year = 1 },
    locations = { "sloc_town_in_the_open" },
    requirement = "achievement_survive_one_day",
    flags = { "CITY_START", "LONE_START", "SUR_START" },
    surround_groups = { { group = "GROUP_BLACK_ROAD", expected_points = 70.0 } },
}
