local ccb = require("ccb")

ccb.content.define_scenario {
    id = "evacuee",
    name = "Evacuee",
    points = 0,
    description = "You have survived the initial wave of panic, and have achieved (relative) safety in one of the many government evac shelters.",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    flags = { "CITY_START" },
}

ccb.content.define_scenario {
    id = "refugeecenter",
    name = "Refugee Center",
    points = 0,
    description = "You have survived the initial wave of panic, and have made your way to a refugee center.",
    locations = { "sloc_refugee_center" },
    start_name = "Refugee Center",
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    id = "exodiicastle",
    name = "Strange Castle",
    points = 0,
    description = "You have survived the initial wave of panic, and made your way to the wilderness.  You were expecting this area to be uninhabited, but instead you see a large castle guarded by strange robots.  At the entrance stands a sign, it reads \"Traders Come Well Avaunt\"",
    locations = { "sloc_exodii_castle" },
    start_name = "Strange Castle",
    flags = { "LONE_START" },
    requirement = "achievement_reach_exodii_base",
}
