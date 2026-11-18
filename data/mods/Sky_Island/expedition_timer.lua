local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local state = require("raid_state")
local text = content.text
local handler_id = "sky_island_expedition_timer_condition"
local home_terrain = { "sky_island_core", "sky_island_edge", "sky_island_corner" }

local function at_home(character)
    local position = state.position(character):project_to("omt")
    for _, terrain in ipairs(home_terrain) do
        if services.overmap.matches_location(position, terrain) then
            return not state.has_trait(character, "awayfromhome")
        end
    end
    return false
end

local conditions = {}
local timer = content.Widget {
    id = "sky_island_expedition_timer",
    label = text("Expedition Timer"),
    style = "text",
}

local function clause(id, label, color, condition)
    conditions[id] = condition
    timer:clause { id = id, text = label, color = color, condition = handler_id }
end

local function elapsed_is(expected)
    return function()
        return state.number("timeawayfromhome") == expected
    end
end

local function pulses_left_is(expected)
    return function()
        return state.number("readablepulsesleft") == expected
    end
end

clause("safe_at_home", text("HOME SAFE"), "light_blue", at_home)
clause("nine_left", ("+-"):rep(8) .. "+", "light_blue", elapsed_is(0))
clause("eight_left", ("+-"):rep(7) .. "+", "green", function()
    return state.number("readablepulsesleft") >= 8
end)
for _, row in ipairs {
    { "seven_left", 7, "light_green" },
    { "six_left", 6, "light_green" },
    { "five_left", 5, "yellow" },
    { "four_left", 4, "yellow" },
    { "three_left", 3, "yellow" },
    { "two_left", 2, "light_red" },
    { "one_left", 1, "light_red" },
} do
    local id, pulses, color = table.unpack(row)
    clause(id, ("+-"):rep(pulses - 1) .. "+", color, pulses_left_is(pulses))
end
clause("over_deadline", text("DANGER"), "i_light_red", elapsed_is(9))
clause("over_deadline_one", text("SEVERE DANGER"), "i_light_red", elapsed_is(10))
clause("over_deadline_two", text("EXTREME DANGER"), "i_red", elapsed_is(11))
clause("over_deadline_three", text("CATASTROPHIC DANGER"), "i_red", elapsed_is(12))
clause("over_deadline_four", text("IMMINENT DEATH"), "i_red", function(character)
    return state.checked(services.effects.has(character, services.types.id("effect", "warpdisintegration")))
end)

ccb.runtime.handler(handler_id, function(payload)
    local condition = conditions[payload.clause]
    if payload.clause == "safe_at_home" then
        return condition(payload.avatar)
    end
    return state.has_trait(payload.avatar, "awayfromhome") and condition(payload.avatar)
end)
content.add(timer)
