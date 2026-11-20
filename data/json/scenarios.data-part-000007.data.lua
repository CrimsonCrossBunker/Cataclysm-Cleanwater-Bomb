local ccb = require("ccb")

ccb.content.define_scenario {
    id = "infested_shelter_start",
    name = "Challenge - Compromised Shelter",
    points = -1,
    description = "You have survived the initial wave of panic, and have achieved (relative) safety in one of the many government evac shelters.  However, the people you came with started to turn and now they're out for your flesh!  You've holed up in the basement for now, but sooner or later you have to make for the door… and fast!",
    locations = { "sloc_shelter_under_infested" },
    start_name = "In an Infested Shelter",
    requirement = "achievement_survive_7_days",
    flags = { "CHALLENGE", "LONE_START" },
}

ccb.content.define_scenario {
    id = "aircraft_carrier_start",
    name = "Challenge - Aircraft Carrier",
    points = 4,
    description = "You were on a mission off the coast of North Korea when the aircraft carrier you were stationed on suddenly and inexplicably found itself in the middle of a lake.  You have no idea where you are or what's happened, but you have more important things to worry about: everyone else aboard seems to have become violently insane.  It might be time to abandon ship.",
    start_name = "Aircraft Carrier",
    locations = { "aircraft_carrier_berth", "aircraft_carrier_bridge" },
    professions = {
        "unemployed",
        "electrician",
        "chef",
        "sailor",
        "marine",
        "seal",
        "diver_navy",
        "medic",
        "mili_pilot",
        "mili_medic",
        "major-general",
        "nco",
        "combat-engineer",
    },
    requirement = "achievement_reach_aircraft_carrier",
    reveal_locale = false,
    initial_visibility = 0,
    flags = { "CHALLENGE", "LONE_START" },
}

ccb.content.define_scenario {
    id = "golden_years",
    name = "Golden Years",
    points = 0,
    description = "After a lifetime of hard work, you managed to settle down in a posh retirement community.  You saw the riots on the news but assumed they would have no reason to attack some harmless old folks.  That assumption was proven wrong by a group of lunatics breaking in, leaving you no choice but to deal with them personally.  Welcome to your golden years.",
    locations = { "sloc_retirement_community" },
    start_name = "Retirement Community",
    professions = { "senior", "old_vet" },
    flags = { "CITY_START", "LONE_START" },
}

ccb.content.define_scenario {
    id = "nuclear_plant_start",
    name = "Challenge - Emergency Shutdown",
    points = 1,
    description = "When the Cataclysm happened, you were working in a nuclear power plant.  Now you're trapped inside, surrounded by the shambling bodies of what used to be your coworkers.  The reactor's shut down, but you don't know if there's been a radiation leak and you need to get away from here fast before you find out the hard way.",
    start_name = "Nuclear Power Plant",
    locations = { "nuclear_plant" },
    professions = { "electrician", "labtech", "medic" },
    requirement = "achievement_reach_nuclear_plant",
    flags = { "CHALLENGE", "LONE_START" },
}
