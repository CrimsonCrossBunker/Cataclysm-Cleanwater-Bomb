local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local state = require("raid_state")
local missions = require("raid_missions")
local challenge = require("raid_challenge")
local merchant_map = require("merchant_map")
local M = {}

function M.dimension_shift(character)
    if state.number("skyisland_merchant_stall") == 1 then merchant_map.clear() end
    if not services.gameplay.mods.is_loaded("backrooms") then challenge.prepare(character) end
    services.gameplay.environment.clear_saved_dimension(state.string("sky_island_target_region_settings"))
    state.set("OM_HQ_origin", state.position(character))
    state.set("OM_HQ_origin_npc", state.position(character))
    state.copy("OM_HQ_origin", "OM_temp")
    state.copy("OM_HQ_origin_npc", "OM_npc_temp")
    for _, key in ipairs { "OM_temp", "OM_npc_temp" } do
        local point = state.point(key)
        state.set(key, services.coords.tripoint_abs_ms(point.x, point.y, -9))
    end
    local take_npcs = state.number("si_npcs_will_join_raid") == 1
    if take_npcs then
        for _, npc in ipairs(state.nearby_npcs(character)) do
            state.add_effect(npc, "effect_sky_island_momentary_flight", 1)
        end
        state.teleport_followers(character, "OM_npc_temp")
    end
    state.add_effect(character, "effect_sky_island_momentary_flight", 1)
    state.teleport(character, state.point("OM_temp"))
    state.checked(services.relocation.travel_to_dimension(
        state.string("sky_island_target_region_settings"),
        take_npcs and { npc_travel_radius = 10 } or nil))
end

local function landing(character)
    state.add_effect(character, "warpcloak", state.number("invistime", 60), 1)
    for _, effect in ipairs {
        { "landing_waterwalk", "effect_warped_waterwalking_hidden" },
        { "landing_flight", "effect_warped_flight" },
        { "landing_phase", "effect_warped_phasing" },
    } do
        if state.number(effect[1]) == 1 then
            state.add_effect(character, effect[2], state.number("invistime", 3), 1)
        end
    end
    if state.number("scoutingclairvoyancetime") >= 1 then
        state.add_effect(character, "effect_warped_super_clairvoyance",
            state.number("scoutingclairvoyancetime", 3), 1)
    end
    state.message(character, ccb.services.translate("You're still materializing and not fully visible yet.  In about <global_val:invistime> seconds, the world will be able to see you, so if you were warped into danger, now's your chance to get to cover."))
    state.message(character, ccb.services.translate("You've arrived!\nPress a key when ready and random missions will be generated for this expedition.  This may take another minute."), "neutral", true)
    state.add_trait(character, "awayfromhome")
    state.set("timeawayfromhome", -state.number("bonuspulses"))
    state.add_effect(character, "warpsickness", 1, 6, true)
    missions.slaughter(character)
    if state.has_trait(character, "mut_skyisland_temperature_adaptation") then
        state.checked(services.weather.refresh())
    end
    for _ = 1, math.modf(state.number("bonusmissions")) do missions.bonus(character) end
    for _ = 1, math.modf(state.number("bonusexits") + 1) do missions.extract(character) end
    if state.number("goingtolabs") == 1 then
        state.checked(services.inventory.consume(character, id("item", "warp_labs_catalyst"), 1, 0))
        state.set("goingtolabs", 0)
    end
end

ccb.runtime.handler("sky_raid_storm_due", function(payload)
    if services.gameplay.environment.dimension() == "default" then return end
    ccb.runtime.call_character("portal_storm_begin_early", payload.character)
    state.set("saved_portal_storms", state.number("saved_portal_storms") - 1)
end)

function M.arrive(character)
    for _, spell in ipairs { "island_hostile_eviction", "island_close_tear_and_portal" } do
        local result = services.spells.forget(character, id("spell", spell))
        if not result.ok and result.error.code ~= "not_known" then state.checked(result) end
    end
    state.copy("OM_missionspot", "OM_missionspot_npc")
    state.teleport_followers(character, "OM_missionspot_npc")
    state.teleport(character, state.point("OM_missionspot"), ccb.services.translate("You arrive on the raid."),
        ccb.services.translate("It seems the portal couldn't find a valid location."))
    landing(character)
    if state.number("saved_portal_storms") > 0 then
        ccb.tasks.after_character_turn(character,
            math.tointeger(math.modf(state.number("currentpulselength", 15 * 60))), "sky_raid_storm_due")
    end
end

return M
