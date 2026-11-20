local ccb = require("ccb")

ccb.content.define_scenario {
    id = "medieval",
    name = "Challenge - Medieval Peasant",
    points = -8,
    description = "Som nigromancie hath brought yow hidder!  Ye have only the hoose on youre legges and the knyf at youre syde and youre prayeres to Marie moder of God.",
    start_name = "Wilderness",
    locations = { "sloc_forest", "sloc_field" },
    professions = { "churl" },
    forced_traits = { "ILLITERATE", "ANTIJUNK", "STRONGSTOMACH", "SPIRITUAL" },
    forbidden_traits = { "FASTREADER", "SLOWREADER" },
    requirement = "achievement_witnessed_portal_storm",
    reveal_locale = false,
    initial_visibility = 0,
    flags = { "CHALLENGE", "LONE_START" },
}

ccb.content.define_scenario {
    id = "lab_cargo_staff_1",
    name = "Challenge - Trans-Coast Logistics Concourse",
    points = -6,
    description = "You were deemed an essential employee and required to stay behind during the facility's evacuation.  You'd better find your lanyard with your badge before the automated defenses notice that you don't have one.",
    start_name = "Locked Lab",
    professions = { "security", "labtech", "medic" },
    locations = { "sloc_lab_concourse_area" },
    map_extra = "mx_lab_concourse_area",
    requirement = "achievement_reach_trans_coast_lab",
    flags = { "CHALLENGE", "LONE_START" },
}
