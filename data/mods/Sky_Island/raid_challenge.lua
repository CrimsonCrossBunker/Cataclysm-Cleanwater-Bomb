local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local M = {}

local warnings = {
    { "horde", function() return services.translate("Something is different about this dimension.  It feels like everything is following you.") end },
    { "city", function() return services.translate("Something is different about this dimension.  The city appears to never end.") end },
    { "hot", function() return services.translate("Something is different about this dimension.  Everything feels hotter than it should be.") end },
    { "cold", function() return services.translate("Something is different about this dimension.  Everything feels colder than it should be.") end },
    { "short", function() return services.translate("Something is different about this dimension.  You feel that you have less time than normal.") end },
    { "slow", function() return services.translate("Something is different about this dimension.  You're moving slower than normal.") end },
}

for _, warning in ipairs(warnings) do
    local text = warning[2]
    ccb.runtime.handler("sky_raid_" .. warning[1] .. "_warning", function(payload)
        state.message(payload.character, text(), "neutral", true)
    end)
end

ccb.runtime.handler("sky_raid_horde_signal", function(payload)
    state.checked(services.hordes.broadcast_signal(state.position(payload.character), 5000))
    state.message(payload.character, services.translate("Your skin itches, you can feel them closing in."), "bad")
end)

function M.prepare(character)
    state.set("sky_island_target_region_settings", "dimension_sky_island_region")
    state.set("challenge_mode_reward_multiplier", 1.5)
    if state.number("challenge_mode_active") ~= 1 then return end
    local choice = services.random.weighted_index { 100, 100, 100, 100, 100, 100 }
    ccb.tasks.after_character_turn(character, 1, "sky_raid_" .. warnings[choice][1] .. "_warning")
    if choice == 1 then
        ccb.tasks.after_character_turn(character, 1, "sky_raid_horde_signal")
        state.add_trait(character, "CHALLENGE_MODE_HORDES")
        state.set("target_fields_weight", 0)
        state.set("target_forests_weight", 0)
        state.set("target_houses_weight", 100)
    elseif choice == 2 then
        state.set("sky_island_target_region_settings", "sky_island_raid_region_mega_city")
        state.set("target_forests_weight", 0)
    elseif choice == 3 then
        state.set("sky_island_target_region_settings", "sky_island_raid_region_hot")
    elseif choice == 4 then
        state.set("sky_island_target_region_settings", "sky_island_raid_region_cold")
    elseif choice == 5 then
        state.set("currentpulselength", state.number("currentpulselength") / 3)
    else
        state.add_effect(character, "challenge_mode_speed_reduction", 1, 0, true)
    end
end

return M
