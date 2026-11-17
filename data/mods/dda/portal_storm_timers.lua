local ccb = require("ccb")
local services = ccb.services
local tasks = ccb.tasks
local persistent = ccb.state.world
local state = require("portal_storm_state")

local function active()
    return state.number("cause_early_portal_storm") == 1
        or state.number("cause_portal_storm") == 1
end

local timers = {
    {
        handler = "portal_weather_check_due",
        key = "portal_weather_check_timer",
        minimum = 1,
        maximum = 5,
        effect = function()
            state.checked(services.weather.refresh())
        end,
    },
    {
        handler = "portal_weather_move_due",
        key = "portal_weather_move_timer",
        minimum = 45,
        maximum = 90,
        effect = function(character)
            local center = state.point("portal_storm_center")
            local stride = services.coords.tripoint_abs_omt(1, 1, 0):project_to("ms")
            local dx = services.random.native_int(-1, 1)
            local dy = services.random.native_int(-1, 1)
            state.set("portal_storm_center", services.coords.tripoint_abs_ms(
                center.x + dx * stride.x, center.y + dy * stride.y, center.z))
            state.remove_mission(character, "MISSION_INVESTIGATE_PORTAL_STORM_CENTER")
            state.assign_mission(character, "MISSION_INVESTIGATE_PORTAL_STORM_CENTER")
        end,
    },
}

local function schedule(timer)
    tasks.ensure_avatar_turn(services.random.native_int(timer.minimum, timer.maximum), timer.handler)
    persistent.set(timer.key, "scheduled")
end

for _, timer in ipairs(timers) do
    ccb.runtime.handler(timer.handler, function(payload)
        if not active() then
            persistent.set(timer.key, "dormant")
            return
        end
        timer.effect(payload.character)
        schedule(timer)
    end)
end

ccb.runtime.handler("portal_weather_timers_ready", function(event)
    if event.actors.character.subtype ~= "avatar" then return end
    for _, timer in ipairs(timers) do
        if tasks.has_avatar_turn(timer.handler) then
            persistent.set(timer.key, "scheduled")
        else
            local status = persistent.get(timer.key)
            if event.new_character or ((status == nil or status == "dormant") and active()) then
                schedule(timer)
            elseif status == nil then
                persistent.set(timer.key, "dormant")
            end
        end
    end
end)
ccb.runtime.on("character_ready", "portal_weather_timers_ready")

ccb.runtime.handler("portal_weather_timers_wake", function()
    if not active() then return end
    for _, timer in ipairs(timers) do
        if persistent.get(timer.key) == "dormant" then schedule(timer) end
    end
end)
ccb.runtime.hook("on_weather_changed", "portal_weather_timers_wake")
