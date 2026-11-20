local ccb = require("ccb")

ccb.content.define_scenario {
    id = "vampire",
    name = "Vampire",
    points = 0,
    description = "You have become a vampire of various tiers.  Mid-autumn start.",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    professions = { "sct_vampire_late" },
    map_extra = "mx_sct_late",
    flags = { "CITY_START", "LONE_START" },
    start_of_cataclysm = { hour = 0, day = 56, season = "spring", year = 1 },
    start_of_game = { hour = 8, day = 45, season = "autumn", year = 1 },
}
