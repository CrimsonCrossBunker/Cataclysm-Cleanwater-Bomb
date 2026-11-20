local ccb = require("ccb")
local content = ccb.content
local runtime = ccb.runtime

-- Native end-screen definitions
local function has_trait(payload, id)
    return payload.traits ~= nil and payload.traits[id] == true
end

local function has_effect(payload, id)
    return payload.effects ~= nil and payload.effects[id] == true
end

runtime.handler("end_screen_boann_court_win", function(payload)
    return payload.alive == false
        and has_effect(payload, "a_winner_is_u")
        and has_effect(payload, "march_baron")
end)

do
local definition = content.EndScreen {
    id = "boann_court_win",
    priority = 200,
    picture = "ascii_portal_storm_win",
}
definition:condition("end_screen_boann_court_win")
definition:info(6, 6, "You <color_light_green>escaped</color>")
definition:info(8, 7, "<u_name> has trod the path to Arcadia.")
definition:info(4, 10, "...<u_name>, were they ever heard from again?")
definition:info(15, 11, "A story for another day.")
definition:info(9, 15, "<color_blue>Stories</color> are all thats <color_orange>left</color>.")
definition:info(4, 21, "Mortal striving lasted for: <time_survived>")
content.add(definition)
end

runtime.handler("end_screen_vampire_death", function(payload)
    return payload.alive == false and has_trait(payload, "VAMPIRE")
end)

do
local definition = content.EndScreen {
    id = "vampire_death",
    priority = 100,
    picture = "ascii_rip_vampire",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_vampire_death")
definition:info(25, 3, "The night is over for you: <color_light_red><u_name></color>")
definition:info(26, 4, "Survived: <time_survived>")
definition:info(27, 5, "Kills: <total_kills>")
content.add(definition)
end
