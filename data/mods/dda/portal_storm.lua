local ccb = require("ccb")
local services = ccb.services
local variables = services.variables
local random = services.random
local coords = services.coords
local state = require("portal_storm_state")
local dungeon = require("portal_storm_dungeon_exit")
local M = {}

local moods = {
    "PORTAL_STORM_DUNGEON_ANGRY", "PORTAL_STORM_DUNGEON_SCARED",
    "PORTAL_STORM_DUNGEON_CURIOUS", "PORTAL_STORM_DUNGEON_ALIEN",
    "PORTAL_STORM_DUNGEON_FUTURE", "PORTAL_STORM_DUNGEON_ENTICING",
}

local function current_weather()
    return services.weather.current().weather.value
end

local function storm_present()
    local weather = current_weather()
    return weather == "portal_storm" or weather == "early_portal_storm"
        or state.number("cause_portal_storm") == 1
        or state.number("cause_early_portal_storm") == 1
end

function M.worsen_default()
    local choice = random.weighted_index({ 1, 1, 3 })
    if choice == 1 then
        state.set("ps_base_str", math.min(state.number("ps_base_str") + 1, 8))
    elseif choice == 2 then
        state.set("ps_min_length", math.min(4 * 3600, state.number("ps_min_length", 2 * 3600) + 15 * 60))
        state.set("ps_max_length", math.min(6 * 3600, state.number("ps_max_length", 4 * 3600) + 15 * 60))
    elseif state.number("portal_storm_distance") ~= 0 then
        state.set("portal_storm_distant_distance", state.number("portal_storm_distant_distance") + 1)
        state.set("portal_storm_close_distance", state.number("portal_storm_close_distance") + 1)
        state.set("portal_storm_distance", state.number("portal_storm_distance") + 1)
    else
        state.set("portal_storm_distant_distance", 201)
        state.set("portal_storm_close_distance", 101)
        state.set("portal_storm_distance", 51)
    end
end

function M.worsen(character)
    ccb.runtime.call_character("portal_storm_worsen", character)
end

function M.start(character)
    if current_weather() == "portal_storm" or state.number("cause_portal_storm") == 1 then return end
    state.set("cause_early_portal_storm", 0)
    state.set("cause_portal_storm", 1)
    state.checked(services.weather.refresh())
    state.set("ps_str", state.number("ps_base_str") + 1)
    state.set("portal_storm_voice_mood", moods[random.native_int(0, #moods - 1) + 1])
    local minimum = math.modf(state.number("ps_min_length", 15 * 60))
    local maximum = math.modf(state.number("ps_max_length", 30 * 60))
    local delay = random.native_int(minimum, maximum)
    ccb.tasks.after_avatar_turn(delay, "portal_storm_end_due")
    if character then state.message(character, services.translate("Reality is breaking!"), "bad") end
end

function M.finish_early(character)
    state.set("cause_early_portal_storm", 1)
    state.checked(services.weather.refresh())
    ccb.tasks.after_avatar_turn(random.native_int(30, 60), "portal_storm_start_due")
    state.assign_mission(character, "MISSION_INVESTIGATE_PORTAL_STORM_CENTER")
    state.message(character, services.translate("You suddenly register a buzzing in your senses.  It's getting louder, and your head starts to throb.  Somewhere nearby, a tiny cataclysm has begun (check mission log for details)."), "bad", true)
end

function M.start_early_default(character)
    if storm_present() then return end
    local location = services.world.find_location(state.position(character), nil,
        { min_radius = 30, max_radius = 75 })
    if location.found then
        state.set("portal_storm_center", coords.tripoint_abs_ms(location.position.x, location.position.y, 0))
    end
    M.finish_early(character)
end

function M.start_early(character)
    ccb.runtime.call_character("portal_storm_begin_early", character)
end

function M.stop(character)
    if not storm_present() then return end
    state.set("cause_portal_storm", 0)
    state.set("cause_early_portal_storm", 0)
    state.set("portal_dungeon_slow_strength", 0)
    state.set("portal_dungeon_carry_strength", 0)
    state.set("portal_dungeon_reflect_strength", 0)
    state.checked(services.weather.refresh())
    state.message(character, services.translate("As suddenly as it began, the portal storm fades.  Reality returns to normal.  Hopefully the scarring is minimal…"), "good")
    random.native_int(0, 0)
    local witnessed = "global_portal_storms_u_witnessed_portal_storm"
    state.checked(variables.set(character, witnessed, "yes", { include_before = false }))
    services.native_events.emit("u_var_changed", { witnessed, "yes" })
    M.worsen(character)
    character = dungeon.exit(character)
    state.remove_mission(character, "MISSION_INVESTIGATE_PORTAL_DUNGEON")
    state.remove_mission(character, "MISSION_INVESTIGATE_PORTAL_STORM_CENTER")
    state.checked(services.world.reschedule_events("portal_dungeon_entrance", services.time.duration(0, "turn")))
    local counter_key = "counter_portal_storm_counter"
    local count = (state.checked(variables.get_number(character, counter_key)).value or 0) + 1
    state.checked(variables.set(character, counter_key, count, { include_before = false }))
    state.set("talked_to_storm", 0)
    services.native_events.emit("u_var_changed", { "portal_storm_counter", count })
end

ccb.runtime.handler("portal_storm_start_due", function(context)
    M.start(context.character)
end)
ccb.runtime.handler("portal_storm_finish_early", M.finish_early)
ccb.runtime.handler("portal_storm_end_due", function(context)
    M.stop(context.character)
end)
ccb.runtime.handler("portal_storm_debug_early", function(context)
    M.start_early(context.character)
end)
ccb.runtime.handler("portal_storm_debug_start", function(context)
    M.start(context.character)
end)
ccb.runtime.handler("portal_storm_debug_stop", function(context)
    M.stop(context.character)
end)

return M
