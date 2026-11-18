local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local challenge = require("raid_challenge")
local merchant_map = require("merchant_map")
local id = services.types.id
local M = {}

local raid_missions = {
    "MISSION_REACH_REFUGEE_CENTER",
    "MISSION_REACH_EXTRACT",
    "MISSION_BONUS_TREASURE",
    "MISSION_BONUS_KILL_LIGHT",
    "MISSION_BONUS_KILL_HORDE",
    "MISSION_BONUS_KILL_MID",
    "MISSION_BONUS_KILL_MID_HORDE",
    "MISSION_BONUS_KILL_HARD",
    "MISSION_BONUS_KILL_ELITE",
    "MISSION_BONUS_KILL_BOSS",
    "MISSION_BONUS_KILL_BOSS_GROUP",
    "MISSION_BONUS_KILL_MIGO",
    "MISSION_BONUS_KILL_MIGO_ELITE",
    "MISSION_BONUS_KILL_BOSS_MULTI",
    "MISSION_BONUS_KILL_BOSS_HORDE",
    "MISSION_BONUS_SLAUGHTER_ZED1",
    "MISSION_BONUS_SLAUGHTER_ZED2",
    "MISSION_BONUS_SLAUGHTER_ZED3",
    "MISSION_BONUS_SLAUGHTER_MIGO",
    "MISSION_BONUS_SLAUGHTER_NETHER",
    "MISSION_BONUS_SLAUGHTER_BIRD",
    "MISSION_BONUS_SLAUGHTER_MAMMAL",
    "MISSION_BONUS_ASSASSIN1",
    "MISSION_BONUS_ASSASSIN2",
    "MISSION_BONUS_ASSASSIN3",
    "MISSION_BONUS_ASSASSIN4",
}

local function update_map(position, name)
    local target = state.checked(services.overmap.tile_token(position:project_to("omt")))
    local update = state.checked(services.mapgen.update_token(id("update_mapgen", name)))
    state.checked(services.mapgen.run_update(target, update))
end

function M.clear_missions(character)
    for _, name in ipairs(raid_missions) do
        local offset = 0
        repeat
            local page = services.missions.active(character, { offset = offset, limit = 256 })
            local removed = false
            for _, mission in ipairs(page.items) do
                if mission.id.value == name then
                    state.checked(services.missions.abandon(character, mission.token))
                    removed = true
                    break
                end
            end
            if removed then break end
            offset = offset + page.returned
        until not page.has_more
    end
end

function M.heal(character)
    local present = {}
    for _, part in ipairs(state.checked(services.characters.body_parts(character))) do
        present[part.value] = part
    end
    for _, name in ipairs { "torso", "head", "arm_l", "arm_r", "leg_l", "leg_r" } do
        local part = present[name]
        if part then
            local hp = state.checked(services.characters.hp(character, part))
            state.checked(services.characters.set_hp(character, part, math.max(hp, 15)))
        end
    end
end

local function progress(character)
    if state.number("islandrank") == 0 and state.number("raidswon") >= 10 then
        state.message(character, ccb.services.translate("You've proved you can survive a few excursions to the world below.  Something in the warp pulls at you, quickening your pulse and turning your vision red.  The sensation is indescribable.  You feel… powerful.\nThe Heart of the Island may have further use for you.\n\nHealing at the Heart of the Island is no longer free.  Be cautious in your future endeavors."), "neutral", true)
        state.set("islandrank", 1)
        state.checked(services.recipes.learn(character, id("recipe", "warpextender")))
    end
    if state.number("islandrank") == 2 and state.number("raidswon") >= 20 then
        state.message(character, ccb.services.translate("You've drank deep of the warpstream and survived to tell the tale, though your unique isolation makes finding ears to listen difficult.  The fragments of this reality have risen against you, and you have weathered the storm… for now.\nYou feel confident, powerful.  Your mouth tastes of blood.  As the familiar world takes shape around you once more, you understand the Heart of the Island will surely be interested in your continued growth."), "neutral", true)
        state.set("islandrank", 3)
    end
end

local function materials(character)
    if state.number("gettokens") ~= 1 then return end
    state.set("gettokens", 0)
    state.set("owed_material_tokens", state.number("lengthofthisraid") * 75 + 50)
    if state.number("challenge_mode_active") == 1 then
        state.set("owed_material_tokens", state.number("owed_material_tokens")
            * state.number("challenge_mode_reward_multiplier"))
    end
    state.message(character, ccb.services.translate("You've returned home safely using a designated exit point.  You have earned <global_val:owed_material_tokens> material tokens for your success."), "neutral", true)
    local count = math.tointeger(math.modf(state.number("owed_material_tokens", 50)))
    state.checked(services.inventory.receive_item(character, id("item", "warptoken_material"), count))
    if services.gameplay.mods.is_loaded("innawood") then
        ccb.runtime.call_character("innawood_material_reward", character)
    end
end

local function merchants(character)
    if not (services.random.native_int(0, 6) == 0
        or state.checked(services.effects.has(character, id("effect", "effect_sky_island_merchant_attraction")))) then
        return
    end
    local choice = services.random.weighted_index { 1, 1, 1 }
    merchant_map.place(choice)
    state.message(character, ccb.services.translate("As you return to the island, you notice the trade stall in the north has an occupant."), "good")
    state.checked(services.effects.remove(character, id("effect", "effect_sky_island_merchant_attraction")))
end

local function return_room_items(character)
    if state.number("si_bring_items_from_raid") ~= 1 then return end
    state.set("si_bring_items_from_raid", 0)
    local anchor = state.position(character)
    local points = services.world.points_nearby(anchor, { min_radius = 0, max_radius = 2, limit = 1024 })
    for _, point in ipairs(points.items) do
        -- The native search leaves its coordinate at the last tested point even on failure.
        anchor = point.position
        if services.gameplay.environment.furniture_id(anchor) == "f_returnportal" then break end
    end
    local items = state.checked(services.items.on_map(anchor, 0, 4))
    for _, item in ipairs(items) do
        if item:is_valid() then
            state.checked(services.relocation.teleport_item(item, state.point("OM_HQ_origin")))
        end
    end
end

function M.home(character)
    ccb.runtime.call_character("portal_storm_cancel", character)
    challenge.finish(character)
    for _, npc in ipairs(state.nearby_npcs(character)) do
        state.add_effect(npc, "effect_sky_island_momentary_flight", 1)
    end
    state.add_effect(character, "effect_sky_island_momentary_flight", 1)
    update_map(state.point("OM_HQ_origin"), "raid_return_platform")
    return_room_items(character)
    state.teleport_followers(character, "OM_HQ_origin_npc")
    state.teleport(character, state.point("OM_HQ_origin"), ccb.services.translate("You arrive on the island."),
        ccb.services.translate("It seems the portal couldn't find a valid location."))
    state.checked(services.relocation.travel_to_dimension("default",
        { npc_travel_radius = 10, item_travel_radius = 10 }))
    for _, item in ipairs { "warphome", "warp_healing_salve", "warpextender" } do
        state.checked(services.inventory.remove_type(character, id("item", item)))
    end
    state.set("raidstotal", state.number("raidstotal") + 1)
    state.checked(services.mutations.erase(character, id("mutation", "awayfromhome")))
    state.checked(services.effects.remove(character, id("effect", "warpsickness")))
    state.checked(services.effects.remove(character, id("effect", "warpdisintegration")))
    for _ = 1, 5 do M.clear_missions(character) end
    progress(character)
    materials(character)
    M.heal(character)
    if state.number("skyisland_merchant_stall") == 1 then merchants(character) end
    state.set("timeawayfromhome", -state.number("bonuspulses"))
end

ccb.runtime.handler("sky_return_home", M.home)

ccb.runtime.handler("sky_return_obelisk", function(payload)
    local character = payload.character
    local mode = state.number("roomteleportselector")
    local whole_room, spend_token, question
    if mode == 0 then
        whole_room = true
        question = ccb.services.translate("This will teleport you back to your sky island.  Any items inside the room will be teleported home alongside you.  Are you ready to leave?")
    elseif mode == 1 then
        whole_room = state.checked(services.inventory.has_items(character, id("item", "warp_vortex_token"), 1, 0))
        spend_token = whole_room
        if whole_room then
            question = ccb.services.translate("This will teleport you back to your sky island.  You will spend your vortex token to return any items in the room home alongside you.  Are you ready to leave?")
        else
            question = ccb.services.translate("This will teleport you back to your sky island.  Any items not on your person WILL BE LOST.  Are you ready to leave?")
        end
    elseif mode == 2 then
        question = ccb.services.translate("This will teleport you back to your sky island.  Any items not on your person WILL BE LOST.  Are you ready to leave?")
    else
        return
    end
    if character.subtype ~= "avatar" or not services.interaction.confirm(state.text(character, question)) then return end
    state.set("raidswon", state.number("raidswon") + 1)
    state.set("gettokens", 1)
    if whole_room then state.set("si_bring_items_from_raid", 1) end
    if spend_token then
        state.checked(services.inventory.consume_by_type(character, id("item", "warp_vortex_token"), 1, 0))
    end
    M.home(character)
end)

local obelisk = ccb.content.Furniture {
    id = "f_returnportal",
    name = ccb.content.text("Return Obelisk"),
    description = ccb.content.text("A strange statue that will take you back home."),
    color = "dark_gray", symbol = "S", looks_like = "f_statue",
    move_cost_mod = -1, required_str = -1, coverage = 0, transparent = true,
}
obelisk:flag("NOCOLLIDE")
obelisk:flag("NO_PICKUP_ON_EXAMINE")
obelisk:flag("TRANSPARENT")
obelisk:on_examine("sky_return_obelisk")
ccb.content.add(obelisk)

return M
