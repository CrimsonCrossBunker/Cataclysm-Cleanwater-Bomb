local ccb = require("ccb")
local services = ccb.services
local storm = require("portal_storm")
local state = require("portal_storm_state")

ccb.runtime.handler("portal_storm_begin_early", function(character)
    storm.start_early_default(character)
end)

ccb.runtime.handler("portal_storm_worsen", function()
    storm.worsen_default()
end)

ccb.runtime.handler("portal_storm_start", function(character)
    storm.start(character)
end)

ccb.runtime.handler("portal_storm_cancel", function(character)
    storm.stop(character)
end)

ccb.runtime.handler("portal_storm_cycle", function(character)
    if services.gameplay.environment.dimension() == "default" then
        storm.start_early(character)
    else
        storm.worsen(character)
    end
end)

ccb.runtime.handler("portal_storm_cycle_interval", function()
    local minimum = math.modf(state.number("ps_min_woc", 5 * 24 * 3600))
    local maximum = math.modf(state.number("ps_max_woc", 18 * 24 * 3600))
    return services.random.native_int(minimum, maximum)
end)

local function schedule()
    local turns = math.tointeger(ccb.runtime.call_number("portal_storm_cycle_interval"))
    if not turns then error("Portal storm interval must be an integer turn count") end
    ccb.tasks.after_avatar_turn(turns, "portal_storm_cycle_due")
end

ccb.runtime.handler("portal_storm_cycle_due", function(payload)
    ccb.runtime.call_character("portal_storm_cycle", payload.character)
    schedule()
end)

ccb.runtime.handler("portal_storm_cycle_ready", function(event)
    if event.actors.character.subtype == "avatar"
        and not ccb.tasks.has_avatar_turn("portal_storm_cycle_due") then
        schedule()
    end
end)
ccb.runtime.on("character_ready", "portal_storm_cycle_ready")
