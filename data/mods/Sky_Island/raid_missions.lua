local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local M = {}

local function choose_mission(character, missions, weights)
    local selected = services.random.weighted_index(weights)
    if selected then state.assign_mission(character, missions[selected]) end
end

local function choose_location(character, extract)
    local terrain
    if services.gameplay.mods.is_loaded("backrooms") then
        terrain = "backfloorchamber"
    else
        local selected = services.random.weighted_index {
            math.tointeger(math.modf(state.number("target_fields_weight", 15))),
            math.tointeger(math.modf(state.number("target_forests_weight"))),
            math.tointeger(math.modf(state.number("target_houses_weight"))),
        }
        if selected then state.set("sky_island_target_terrain", ({ "field", "forest", "house" })[selected]) end
        terrain = state.string("sky_island_target_terrain")
    end
    state.set("sky_island_target_terrain", terrain)
    local prefix = extract and "exfil" or "mission"
    state.find_location(character, terrain, "contains", {
        search_range = state.number(prefix .. "distancemax", 30),
        min_distance = state.number(prefix .. "distancemin", 5),
        z = 0, random = true,
    }, state.number("scoutingdistancetargets"))
    if not extract then state.set("total_difficulty_bonus", state.number("lengthofthisraid")) end
end

function M.extract(character)
    choose_location(character, true)
    state.assign_mission(character, "MISSION_REACH_EXTRACT")
end

function M.slaughter(character)
    if state.number("slaughterunlocked") ~= 1 then return end
    choose_mission(character, {
        "MISSION_BONUS_SLAUGHTER_ZED1",
        "MISSION_BONUS_SLAUGHTER_ZED2",
        "MISSION_BONUS_SLAUGHTER_ZED3",
        "MISSION_BONUS_SLAUGHTER_MIGO",
        "MISSION_BONUS_SLAUGHTER_NETHER",
        "MISSION_BONUS_SLAUGHTER_BIRD",
        "MISSION_BONUS_SLAUGHTER_MAMMAL",
    }, {
        10,
        20,
        math.tointeger(math.modf(state.number("hardermissions"))),
        math.tointeger(math.modf(state.number("hardermissions"))),
        math.tointeger(math.modf(state.number("hardmissions"))),
        5,
        5,
    })
end

function M.bonus(character)
    choose_location(character, false)
    choose_mission(character, {
        "MISSION_BONUS_TREASURE",
        "MISSION_BONUS_KILL_LIGHT",
        "MISSION_BONUS_KILL_HORDE",
        "MISSION_BONUS_KILL_MID",
        "MISSION_BONUS_KILL_MID_HORDE",
        "MISSION_BONUS_KILL_HARD",
        "MISSION_BONUS_KILL_ELITE",
        "MISSION_BONUS_KILL_BOSS",
        "MISSION_BONUS_KILL_BOSS_GROUP",
        "MISSION_BONUS_KILL_BOSS_HORDE",
        "MISSION_BONUS_KILL_BOSS_MULTI",
        "MISSION_BONUS_KILL_MIGO",
        "MISSION_BONUS_KILL_MIGO_ELITE",
        "MISSION_BONUS_ASSASSIN1",
        "MISSION_BONUS_ASSASSIN2",
        "MISSION_BONUS_ASSASSIN3",
    }, {
        45,
        15,
        10,
        15,
        10,
        math.tointeger(math.modf(state.number("hardmissions"))),
        math.tointeger(math.modf(state.number("hardermissions"))),
        math.tointeger(math.modf(state.number("hardermissions"))),
        math.tointeger(math.modf(state.number("hardestmissions"))),
        math.tointeger(math.modf(state.number("hardestmissions"))),
        math.tointeger(math.modf(state.number("hardestmissions"))),
        math.tointeger(math.modf(state.number("hardermissions"))),
        math.tointeger(math.modf(state.number("hardestmissions"))),
        math.tointeger(math.modf(state.number("hardmissions"))),
        math.tointeger(math.modf(state.number("hardermissions"))),
        math.tointeger(math.modf(state.number("hardestmissions"))),
    })
end

return M
