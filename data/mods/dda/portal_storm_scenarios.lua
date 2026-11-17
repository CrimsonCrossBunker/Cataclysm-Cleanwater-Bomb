local ccb = require("ccb")
local content = ccb.content
local state = require("portal_storm_state")
local storm = require("portal_storm")
local dependent = require("portal_dependent")

ccb.runtime.handler("portal_scenario_strong_due", function(payload)
    state.set("ps_base_str", 15)
    storm.start(payload.character)
    state.set("ps_base_str", 1)
end)

ccb.runtime.handler("portal_scenario_strength_due", function()
    state.set("ps_base_str", 10)
end)

ccb.runtime.handler("portal_scenario_frequency_due", function()
    state.set("ps_min_woc", 24 * 3600)
    state.set("ps_max_woc", 48 * 3600)
end)

ccb.runtime.handler("portal_scenario_dependent_due", function(payload)
    local character = payload.character
    dependent.messages_bad(character)
    dependent.focus_bad(character)
    dependent.damage_constant(character)
end)

ccb.runtime.handler("portal_scenario_strong_start", function(payload)
    ccb.tasks.after_character_turn(payload.character, 0, "portal_scenario_strong_due")
end)

ccb.runtime.handler("portal_scenario_strength_start", function(payload)
    ccb.tasks.after_character_turn(payload.character, 0, "portal_scenario_strength_due")
end)

ccb.runtime.handler("portal_scenario_frequency_start", function(payload)
    ccb.tasks.after_character_turn(payload.character, 0, "portal_scenario_frequency_due")
end)

ccb.runtime.handler("portal_scenario_dependent_start", function(payload)
    ccb.tasks.after_character_turn(payload.character, 0, "portal_scenario_strong_due")
    ccb.tasks.after_character_turn(payload.character, 0, "portal_scenario_dependent_due")
end)

content.upsert(content.Scenario {
    id = "strong_portal_storm",
    name = content.text("Challenge - Splintering Reality", "scenario_male"),
    female_name = content.text("Challenge - Splintering Reality", "scenario_female"),
    description = content.text("You found yourself alone in an open field when reality began to heave and crack all around you.  You need to find shelter, and fast.", "scen_desc_male"),
    female_description = content.text("You found yourself alone in an open field when reality began to heave and crack all around you.  You need to find shelter, and fast.", "scen_desc_female"),
    start_name = content.text("Field", "start_name"),
    points = -3,
    requirement = "achievement_witnessed_portal_storm",
    locations = { "sloc_field" },
    flags = { "CHALLENGE", "LONE_START" },
    on_start = "portal_scenario_strong_start",
})

content.upsert(content.Scenario {
    id = "strong_portal_storm_base",
    name = content.text("Challenge - Stronger Portal Storms", "scenario_male"),
    female_name = content.text("Challenge - Stronger Portal Storms", "scenario_female"),
    description = content.text("You've managed to get to a shelter, but reality has grown weaker than normal, and portal storms will be quite strong.", "scen_desc_male"),
    female_description = content.text("You've managed to get to a shelter, but reality has grown weaker than normal, and portal storms will be quite strong.", "scen_desc_female"),
    start_name = content.text("Evac Shelter", "start_name"),
    points = -4,
    requirement = "achievement_witnessed_portal_storm",
    locations = { "sloc_shelter_safe" },
    flags = { "CHALLENGE", "LONE_START" },
    on_start = "portal_scenario_strength_start",
})

content.upsert(content.Scenario {
    id = "quick_portal_storm_base",
    name = content.text("Challenge - Frequent Portal Storms", "scenario_male"),
    female_name = content.text("Challenge - Frequent Portal Storms", "scenario_female"),
    description = content.text("You've managed to get to a shelter, but reality has grown weaker than normal, and portal storms will be more frequent.", "scen_desc_male"),
    female_description = content.text("You've managed to get to a shelter, but reality has grown weaker than normal, and portal storms will be more frequent.", "scen_desc_female"),
    start_name = content.text("Evac Shelter", "start_name"),
    points = -4,
    requirement = "achievement_witnessed_portal_storm",
    locations = { "sloc_shelter_safe" },
    flags = { "CHALLENGE", "LONE_START" },
    on_start = "portal_scenario_frequency_start",
})

content.upsert(content.Scenario {
    id = "portal_dependent",
    inherits = "mutant",
    name = content.text("Challenge - Portal Dependent", "scenario_male"),
    female_name = content.text("Challenge - Portal Dependent", "scenario_female"),
    description = content.text("You were caught in a huge and unstable portal storm, and were utterly unprotected from the full force of its effects.  You're on the tail end of the storm now, and while you've survived, you feel… different.", "scen_desc_male"),
    female_description = content.text("You were caught in a huge and unstable portal storm, and were utterly unprotected from the full force of its effects.  You're on the tail end of the storm now, and while you've survived, you feel… different.", "scen_desc_female"),
    start_name = content.text("Field", "start_name"),
    points = -8,
    reveal_locale = false,
    distance_initial_visibility = 0,
    requirement = "achievement_reach_lab_finale",
    locations = { "sloc_field", "sloc_forest", "sloc_desert_island" },
    professions = { "portal_traveler", "churl", "true_foodperson", "unemployed", "naked", "mutant_patient", "mutant_volunteer", "labtech", "security", "medic", "paranormal_investigator" },
    forced_traits = { "PORTAL_DEPENDENT" },
    flags = { "CHALLENGE", "LONE_START" },
    on_start = "portal_scenario_dependent_start",
})

content.upsert(content.Scenario {
    id = "shattered_sky_start",
    name = content.text("Challenge - Shattered Sky", "scenario_male"),
    female_name = content.text("Challenge - Shattered Sky", "scenario_female"),
    description = content.text("From up here, you watched it all fall apart.  The sky cracked and indescribable alien shapes writhed in the clouds.  The horizon has returned to normal, but you still see shadows moving in the corner of your eye and feel them calling you.", "scen_desc_male"),
    female_description = content.text("From up here, you watched it all fall apart.  The sky cracked and indescribable alien shapes writhed in the clouds.  The horizon has returned to normal, but you still see shadows moving in the corner of your eye and feel them calling you.", "scen_desc_female"),
    start_name = content.text("Up Above", "start_name"),
    points = -5,
    requirement = "achievement_reach_mid_z_level",
    locations = { "sloc_apartments_rooftop", "sloc_apartments_rooftop2", "sloc_hotel_rooftop", "sloc_school_rooftop", "sloc_office_tower_rooftop", "sloc_apartment_complex_roof", "sloc_convention_center_rooftop" },
    forced_traits = { "SCHIZOPHRENIC" },
    flags = { "LONE_START", "CITY_START", "CHALLENGE" },
    on_start = "portal_scenario_strength_start",
})
