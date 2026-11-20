local ccb = require("ccb")

ccb.content.define_scenario {
    id = "mass_quarantine_start",
    name = "Mass Quarantine",
    points = -1,
    description = "When FEMA camps ran out of space the authorities used what was left of their manpower to round up people at gunpoint.  The stadiums they forced everyone into did nothing to slow down the madness and it spread like wildfire.  You managed to slip away from the worst violence but you are now surrounded and need to escape quickly!",
    start_name = "Stadium",
    locations = { "sloc_stadium" },
    initial_visibility = 0,
    map_extra = "mx_corpses",
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    id = "road_start",
    name = "Middle of Nowhere",
    points = 1,
    description = "During your escape you got lost and ended up at the wrong location.  Get your bearings and make a plan.  You'll need it.",
    start_name = "Middle of Nowhere",
    locations = { "sloc_middle_of_nowhere" },
    reveal_locale = false,
    initial_visibility = 0,
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    id = "sewer_start",
    name = "Challenge - Lost Underground",
    points = 1,
    description = "When the riots came to your home, you ran underground and hid.  Now days later you are lost and hear movement echoing in the dark.",
    start_name = "Underground",
    locations = { "sloc_sewer" },
    reveal_locale = false,
    initial_visibility = 0,
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    id = "last_stand_start",
    name = "Challenge - Last Stand",
    points = -1,
    description = "Together with some others you decided to take up arms against the horde.  Now you are reconsidering whether that was a wise choice.",
    start_name = "Intersection",
    locations = { "sloc_nesw_manhole" },
    requirement = "achievement_kill_10_monsters",
    map_extra = "mx_laststand",
    flags = { "CITY_START", "LONE_START" },
}
