local ccb = require("ccb")
local content = ccb.content

-- Native faction missions
do
local definition = content.FactionMission {
    id = "camp_gathering",
    name = "Gathering",
    desc = "Send a companion to gather materials for the next camp upgrade.",
    skill = "survival",
    difficulty = "",
    risk = "VERY_LOW",
    activity = "LIGHT_EXERCISE",
    time = "3 Hours, Repeated",
    positions = 3,
    items_label = "Gathering",
    footer = "",
}
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_collect_firewood",
    name = "Collect Firewood",
    desc = "Send a companion to gather light brush and stout branches.",
    skill = "",
    difficulty = "",
    risk = "LOW",
    activity = "LIGHT_EXERCISE",
    time = "3 Hours, Repeated",
    positions = 3,
    items_label = "Gathering",
    footer = "",
}
definition:add_items_possibility("stout branches")
definition:add_items_possibility("withered plants")
definition:add_items_possibility("splintered wood")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_menial",
    name = "Sorting",
    desc = "Send a companion to do low level chores and sort supplies.",
    skill = "fabrication",
    difficulty = "",
    risk = "NONE",
    activity = "",
    time = "3 Hours",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("Material left in the unsorted loot zone will be sorted into a defined loot zone.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_cut_logs",
    name = "Cut Logs",
    desc = "Send a companion to a nearby forest to cut logs.",
    skill = "fabrication",
    difficulty = "LOW",
    risk = "NONE",
    activity = "ACTIVE_EXERCISE",
    time = "6 Hours Base + Travel Time + Cutting Time",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("50% of trees/trunks at the forest position will be cut down.")
definition:add_effect("100% of total material will be brought back.")
definition:add_effect("Repeatable with diminishing returns.")
definition:add_effect("Will eventually turn forests into fields.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_clearcut",
    name = "Clear Cut",
    desc = "Send a companion to clear a nearby forest.",
    skill = "fabrication",
    difficulty = "VERY_LOW",
    risk = "NONE",
    activity = "ACTIVE_EXERCISE",
    time = "6 Hour Base + Travel Time + Cutting Time",
    positions = 1,
    items_label = "",
    footer = "Note that it's likely both forest and field roads look exactly the same after having been cleared.",
}
definition:add_effect("95% of trees/trunks at the forest position will be cut down.")
definition:add_effect("0% of total material will be brought back.")
definition:add_effect("Forest should become a field tile.")
definition:add_effect("Useful for clearing land for another faction camp.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_setup_hide_site",
    name = "Setup Hide Site",
    desc = "Send a companion to build an improvised shelter and stock it with equipment at a distant map location.",
    skill = "survival",
    difficulty = "MEDIUM",
    risk = "MEDIUM",
    activity = "LIGHT_EXERCISE",
    time = "6 Hour Construction + Travel",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("Good for setting up resupply or contingency points.")
definition:add_effect("Gear is left unattended and could be stolen.")
definition:add_effect("Time dependent on weight of equipment being sent forward.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_relay_hide_site",
    name = "Relay Hide Site",
    desc = "Push gear out to a hide site or bring gear back from one.",
    skill = "survival",
    difficulty = "VERY_LOW",
    risk = "MEDIUM",
    activity = "LIGHT_EXERCISE",
    time = "1 Hour Base + Travel",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("Good for returning equipment you left in the hide site shelter.")
definition:add_effect("Gear is left unattended and could be stolen.")
definition:add_effect("Time dependent on weight of equipment being sent forward or back.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_foraging",
    name = "Foraging",
    desc = "Send a companion to forage for edible plants.",
    skill = "survival",
    difficulty = "",
    risk = "VERY_LOW",
    activity = "LIGHT_EXERCISE",
    time = "4 Hours, Repeated",
    positions = 3,
    items_label = "Foraging",
    footer = "",
}
definition:add_items_possibility("wild vegetables")
definition:add_items_possibility("fruits and nuts depending on season")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_trapping",
    name = "Trapping",
    desc = "Send a companion to set traps for small game.",
    skill = "traps",
    difficulty = "",
    risk = "LOW",
    activity = "LIGHT_EXERCISE",
    time = "6 Hours, Repeated",
    positions = 2,
    items_label = "Trapping",
    footer = "WARNING: May produce less food than consumed!",
}
definition:add_items_possibility("small and tiny animal corpses")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_hunting",
    name = "Hunting",
    desc = "Send a companion to hunt large animals.",
    skill = "gun",
    difficulty = "",
    risk = "MEDIUM",
    activity = "MODERATE_EXERCISE",
    time = "6 Hours, Repeated",
    positions = 1,
    items_label = "Hunting",
    footer = "WARNING: May produce less food than consumed!",
}
definition:add_items_possibility("small, medium, or large animal corpses")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_scouting",
    name = "Scouting",
    desc = "Send a companion out into the great unknown.  High survival skills are needed to avoid combat but you should expect an encounter or two.",
    skill = "survival",
    difficulty = "MEDIUM",
    risk = "HIGH",
    activity = "BRISK_EXERCISE",
    time = "Travel",
    positions = 3,
    items_label = "",
    footer = "",
}
definition:add_effect("Select checkpoints to customize path.")
definition:add_effect("Reveals terrain around the path.")
definition:add_effect("Can bounce off hide sites to extend range.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_combat_patrol",
    name = "Combat Patrol",
    desc = "Send a companion to purge the wasteland.  Their goal is to kill anything hostile they encounter and return when their wounds are too great or the odds are stacked against them.",
    skill = "survival",
    difficulty = "HIGH",
    risk = "VERY_HIGH",
    activity = "BRISK_EXERCISE",
    time = "Travel",
    positions = 3,
    items_label = "",
    footer = "",
}
definition:add_effect("Pulls creatures encountered into combat instead of fleeing.")
definition:add_effect("Select checkpoints to customize path.")
definition:add_effect("Can bounce off hide sites to extend range.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_plow",
    name = "Plowing",
    desc = "Plow any spaces that have reverted to dirt or grass.",
    skill = "fabrication",
    difficulty = "",
    risk = "NONE",
    activity = "MODERATE_EXERCISE",
    time = "5 Min / Plot",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("Restores farm plots created in previous expansion upgrades.")
definition:add_effect("Does not damage existing crops.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_plant",
    name = "Planting",
    desc = "Plant designated seeds in the spaces that have already been tilled.",
    skill = "survival",
    difficulty = "",
    risk = "NONE",
    activity = "MODERATE_EXERCISE",
    time = "1 Min / Plot",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("Choose which seed type or all of your seeds.")
definition:add_effect("Stops when out of seeds or planting locations.")
definition:add_effect("Will plant in ALL dirt mounds in the expansion.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_harvest",
    name = "Harvest",
    desc = "Harvest any plants that are ripe and bring the produce back.",
    skill = "survival",
    difficulty = "",
    risk = "NONE",
    activity = "MODERATE_EXERCISE",
    time = "3 Min / Plot",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("Will dump all harvesting products onto your location.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_survey_field",
    name = "Survey Field",
    desc = "Nearby terrain can be turned into fields if it is completely cleared of terrain that isn't grass or dirt.  Doing so makes that terrain eligible for usage for standard base camp expansion.  Note that log cutting does this conversion automatically when the trees are depleted, but not all terrain can be logged.",
    skill = "",
    difficulty = "",
    risk = "NONE",
    activity = "MODERATE_EXERCISE",
    time = "Immediate",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("If the expansion direction selected is eligible for conversion into a field this mission will perform that conversion.  If it is not eligible you are told as much, and would have to make it suitable for conversion by removing everything that isn't grass or soil.  Mining zones are useful to remove pavement, for instance.  Note that removal of buildings is dangerous, laborious, and may still fail to get rid of everything if e.g. a basement or an opening to underground areas (such as a manhole) remains.")
content.add(definition)
end
do
local definition = content.FactionMission {
    id = "camp_survey_expansion",
    name = "Survey Expansion",
    desc = "Expansions open up new opportunities but can be expensive and time-consuming.  Pick them carefully, at most 8 can be built at each camp.",
    skill = "",
    difficulty = "",
    risk = "NONE",
    activity = "MODERATE_EXERCISE",
    time = "3 Hours",
    positions = 1,
    items_label = "",
    footer = "",
}
definition:add_effect("Choose any one of the available expansions.  Starting with a farm is always a solid choice since food is used to support companion missions and minimal investment is needed to get it going.  A forge is also a great idea, allowing you to refine resources for subsequent expansions, craft better gear and make charcoal.")
content.add(definition)
end
