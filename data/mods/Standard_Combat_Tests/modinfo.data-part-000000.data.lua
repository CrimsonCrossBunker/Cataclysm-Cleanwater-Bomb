local ccb = require("ccb")

ccb.content.define_scenario {
    id = "evacuee",
    name = "Evacuee",
    points = 0,
    description = "You have survived the initial wave of panic, and have achieved (relative) safety in one of the many government evac shelters.  You also took the time to cobble together some improvised weaponry!",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    professions = { "sct_day1" },
    map_extra = "mx_sct_day1",
    flags = { "CITY_START", "LONE_START" },
}

ccb.content.define_scenario {
    id = "scavenger",
    name = "Scavenger",
    points = 0,
    description = "You are getting by in the Apocalypse.  Your gear is still scavenged from the ruins of the old world, but you have gathered the skills to use it to good effect.  Midsummer start.",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    professions = { "sct_mid" },
    map_extra = "mx_sct_mid",
    flags = { "CITY_START", "LONE_START" },
    start_of_cataclysm = { hour = 0, day = 56, season = "spring", year = 1 },
    start_of_game = { hour = 8, day = 45, season = "summer", year = 1 },
}

ccb.content.define_scenario {
    id = "survivor",
    name = "Survivor",
    points = 0,
    description = "You are as close to thriving as anybody can be these days.  Your gear is handcrafted with the threats of the new world in mind, and your skills are honed to perfection.  Mid-autumn start.",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    professions = { "sct_late" },
    map_extra = "mx_sct_late",
    flags = { "CITY_START", "LONE_START" },
    start_of_cataclysm = { hour = 0, day = 56, season = "spring", year = 1 },
    start_of_game = { hour = 8, day = 45, season = "autumn", year = 1 },
}
