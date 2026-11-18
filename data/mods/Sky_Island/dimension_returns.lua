local ccb = require("ccb")
local services = ccb.services
local returning = require("raid_return")
local state = require("raid_state")
local environment = services.gameplay.environment
local id = services.types.id

ccb.runtime.handler("labyrinth_home_transport", function(character)
    returning.home(character)
end)

ccb.runtime.handler("void_spider_lair_exit_transport", function(character)
    returning.home(character)
end)

local function unanchored(character)
    return not state.checked(services.inventory.has_worn_flag(character, id("json_flag", "DIMENSIONAL_ANCHOR")))
end

local function can_leave(character)
    return unanchored(character) and not state.checked(services.characters.snapshot(character, 0)).movement.driving
end

local function schedule(character, dimension, minimum, maximum)
    local delay = maximum and services.random.native_int(minimum, maximum) or minimum
    ccb.tasks.after_character_turn(character, delay, "sky_portal_" .. dimension .. "_return_due")
end

local function push(character)
    state.message(character, services.translate("You feel a slight push in a direction you can't name, but soon it ceases.  You have a feeling it'll happen again later."))
end

ccb.runtime.handler("portal_highlands_return", function(character)
    if unanchored(character) then
        returning.home(character)
        state.checked(services.achievements.complete(id("achievement", "achievement_reach_highlands")))
    elseif environment.dimension() == "highlands" then
        state.message(character, services.translate("You feel a prickle at the edge of your senses."))
        schedule(character, "highlands", 36 * 3600, 60 * 3600)
    end
end)

ccb.runtime.handler("portal_radiosphere_return", function(character)
    if unanchored(character) and environment.dimension() == "radiosphere" then
        returning.home(character)
    elseif environment.dimension() == "radiosphere" then
        push(character)
        schedule(character, "radiosphere", 20 * 60, 2 * 3600)
    end
end)

ccb.runtime.handler("portal_cabins_return", function(character)
    if can_leave(character) and environment.dimension() == "cabins" then
        returning.home(character)
        state.checked(services.world.reschedule_events("cabin_daylight_cycle", services.time.duration(0, "turn")))
        environment.clear_saved_dimension("cabins")
    elseif environment.dimension() == "cabins" then
        push(character)
        schedule(character, "cabins", 6 * 3600, 12 * 3600)
    end
end)

ccb.runtime.handler("portal_string_dimension_return", function(character)
    if can_leave(character) and environment.dimension() == "string_dimension" then
        returning.home(character)
        state.checked(services.world.reschedule_events("string_dimension_lights_on", services.time.duration(0, "turn")))
        state.checked(services.achievements.complete(id("achievement", "achievement_reach_string_dimension")))
    elseif environment.dimension() == "string_dimension" then
        state.message(character, services.translate("You feel a prickle at the edge of your senses."))
        schedule(character, "string_dimension", 2 * 60)
    end
end)

for _, dimension in ipairs { "highlands", "radiosphere", "cabins", "string_dimension" } do
    ccb.runtime.handler("sky_portal_" .. dimension .. "_return_due", function(payload)
        ccb.runtime.call_character("portal_" .. dimension .. "_return", payload.character)
    end)
end
